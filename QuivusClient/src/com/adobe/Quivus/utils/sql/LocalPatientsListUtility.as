package com.adobe.Quivus.utils.sql
{
	import com.adobe.Quivus.events.staticData.patientsData.LoadPatientsByPracticeIdEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.dto.PatientDTO;
	
	import flash.data.SQLConnection;
	import flash.data.SQLMode;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import flash.net.Responder;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	
	public class LocalPatientsListUtility
	{
		[Bindable]
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		private var sqlc:SQLConnection = new SQLConnection();
		private var sqls:SQLStatement = new SQLStatement();
		private var isFirstTime:Boolean = false;
		private var patientsDB:File = File.applicationStorageDirectory.resolvePath("temp/" + model.appVersion + "/" + Constants.LOCAL_PATIENTS_LIST);
		private var today:Date = new Date();
		
		private var callBack:Function = null ;
		
		public function LocalPatientsListUtility()
		{	
			sqlc.addEventListener(SQLErrorEvent.ERROR, errorConnction);			
			sqls.addEventListener(SQLErrorEvent.ERROR, errorStaement);
		}
		//On SQL Error Event
		private function errorConnction(e:SQLErrorEvent):void
		{
			Alert.show(e.toString(),'Error in Patient List Local DB Connection');
		}
		private function errorStaement(e:SQLErrorEvent):void
		{
			Alert.show(e.toString(),'Error in Patient List Local DB Statement');
		}
		
		//Check that if patientsDB available
		public function isPatientsDBAvaliable():Boolean
		{
			var flag:Boolean = false;
			
			if(patientsDB != null && patientsDB.exists)
			{
				return true;
			}
			
			return flag;
		}
		
		//Create Table for storing patient information
		public function initializePatientsDB(callBack:Function = null ):void
		{	
			if(!sqlc.connected)
				sqlc.open(patientsDB);
			
			sqls.sqlConnection = sqlc;
			
			sqls.text="CREATE TABLE IF NOT EXISTS PatientList(ID TEXT, UserID TEXT, FirstName TEXT, MiddleName TEXT, LastName TEXT, DOB TEXT, SSN TEXT, QuivusID TEXT);";
			sqls.execute();
			
			sqls.text="CREATE TABLE IF NOT EXISTS PatientSyncDate(SyncDate TEXT);";
			sqls.execute();
			
			//	sqlc.close();
			isFirstTime = true;
			callForPatientsList(Constants.NULL_DATE, true, callBack );//First Time only
		}
		//Start calling service after user login successfully
		// call untill all available patients load in Local DB
		public function callForPatientsList(syncDate:Date, isLoadAll:Boolean, callBack:Function = null ):void
		{
			var lpEvent : LoadPatientsByPracticeIdEvent = new LoadPatientsByPracticeIdEvent(model.pageNumberInDB, syncDate.toDateString(), isLoadAll, loadData);
			CairngormEventDispatcher.getInstance().dispatchEvent( lpEvent );
			
			this.callBack = callBack;
		}
		
		//Call back method of LoadPatientsByPracticeIdEvent;
		public  function loadData(val:* = null):void
		{
			if(model.totalPatientsList.length > 0)
			{
				if(!sqlc.connected)
					sqlc.open(patientsDB);
				
				sqls.sqlConnection = sqlc;
				
				sqls.text="CREATE TABLE IF NOT EXISTS PatientList(ID TEXT, UserID TEXT, FirstName TEXT, MiddleName TEXT, LastName TEXT, DOB TEXT, SSN TEXT, QuivusID TEXT);";
				sqls.execute();
				
				addPatientsListToDB();
				
				sqlc.close();
			}
			
			model.pageNumberInDB++;
			
			if(isFirstTime)//If first time 
			{
				if(model.lastRecordNumberInDB < model.totalPatientsInDB)// id patient list remaining sync to Local DB
				{
					callForPatientsList(Constants.NULL_DATE, true);
					//addSynchDate(Constants.NULL_DATE);
				}else//if all patients sync
				{
					addSynchDate(today);//Add sync date to DB
				}
				
			}else// If DB is created already
			{
				if(model.totalPatientsInDB > 0){
					
					if(model.lastRecordNumberInDB < model.totalPatientsInDB)// id patient list remaining sync to Local DB
					{
						callForPatientsList(getSyncTime(), false);
						//addSynchDate(getSyncTime());
					}else//if all patients sync
					{
						addSynchDate(today);
					}
				}else{
					addSynchDate(today);
				}
			}
			
			if( null != callBack )
			{
				//aplication doesn't update the UI, delay calling untill next screen update
				FlexGlobals.topLevelApplication.callLater( function():void {
					callBack();
				} );
			}
		}
		//Adding date and time of the syncing Loacl DB after feaching records 
		private function addSynchDate(_date:Date):void
		{
			if(!sqlc.connected)
				sqlc.open(patientsDB);
			
			sqls.sqlConnection = sqlc;
			//Add curren date and time in Local DB @ Synch Date(1901, 01, 01, 12, 0, 0);
			var date:Date = new Date(_date.getFullYear(), _date.getMonth(), _date.getDate(), _date.getHours(), _date.getMinutes(), _date.getSeconds());
			
			sqls.text = "DELETE FROM PatientSyncDate;";
			sqls.execute();
			
			sqls.text = "INSERT INTO PatientSyncDate (SyncDate) VALUES('"+ date.toDateString() +"');";
			sqls.execute();
			
			//Alert.show(date.toString(), 'addSynchDate');
			
			sqlc.close();
		}
		//return sync Time of previous Local DB
		public function getSyncTime():Date
		{
			if(!sqlc.connected)
				sqlc.open(patientsDB);
			
			sqls.sqlConnection = sqlc;
			
			sqls.text = "SELECT * FROM PatientSyncDate"
			sqls.execute();
			var data:Array = sqls.getResult().data;
			
			var tempDate:Date = new Date(data[data.length - 1].SyncDate);
			
			//Alert.show(tempDate.toString(), 'getSyncTime');
			
			sqlc.close();
			
			return tempDate;
		}
		//Adding patients list in LOcal DB
		public function addPatientsListToDB():void
		{	
			try
			{
				trace('Model Total Patient List :>>> ', model.totalPatientsList.length)
				for(var i:uint = 0;  i < model.totalPatientsList.length; i++)
				{	
					var dto:PatientDTO = model.totalPatientsList.getItemAt(i) as PatientDTO ; 
					
					sqls.text = "INSERT INTO PatientList (ID, UserID, FirstName , MiddleName , LastName, DOB, SSN, QuivusID) VALUES('" + 
						dto.ID + "','"+ dto.UserID + "','"+ dto.FirstName + "','"+ dto.MiddleName +"','"+ dto.LastName + "','"+ dto.DOB + "','"+ dto.SSN+"','"+ dto.QuivusID +"');";
					sqls.execute();
				}
			}
			catch(error:Error)
			{
				trace('Error while inserting records in Patient Local-DB: ',error.getStackTrace())
				//Alert.show("Error: "+ error.getStackTrace(), 'Error while inserting records in Patient Local-DB');
			}
		}
		
		public function loadPatientsListData(searchTerm:String, Qcase:int):void
		{
			model.localSearchList = new ArrayCollection();
			
			var qryText:String = "SELECT ID, UserID, FirstName,LastName,MiddleName, DOB, SSN, QuivusID FROM PatientList ";
			
			/*if(!sqlc.connected)
			sqlc.open(patientsDB);
			
			sqls.sqlConnection = sqlc;*/
			
			executeQuery(Qcase, qryText, searchTerm)
			
			/*var arrResult:Arrays = sqls.getResult().data;
			
			if( arrResult )
			{
			if(arrResult.length > 0)
			{
			for(var i:uint =0; i <arrResult.length; i++)
			{
			var tempData:PatientDTO = new PatientDTO();
			tempData.FirstName  	= arrResult[i].FirstName;
			tempData.MiddleName 	= arrResult[i].MiddleName;
			tempData.LastName  		= arrResult[i].LastName;
			tempData.SSN  			= arrResult[i].SSN;
			tempData.DOB  			= arrResult[i].DOB;
			tempData.QuivusID  		= arrResult[i].QuivusID;
			
			model.localSearchList.addItem(tempData);
			}
			}
			}*/
			
		}
		private function executeQuery(Qcase:uint, qryText:String, searchTerm:String):void
		{
			if(!sqlc.connected)
				sqlc.open(patientsDB);
			
			sqls.sqlConnection = sqlc;
			switch(Qcase)
			{
				case 1: //Free search
					qryText = qryText + "WHERE FirstName LIKE '%" + searchTerm +"%' OR LastName LIKE '%"+searchTerm +"%' OR MiddleName LIKE '%"+searchTerm+"%'";
					break;
				case 2: //LastName, FirstName
					var searchTerms:Array = new Array();
					searchTerms = searchTerm.split(",",searchTerm.length);
					if(searchTerms.length > 1)
						qryText = qryText + "WHERE LastName LIKE '%" + searchTerms[0] +"%' OR FirstName LIKE '%"+searchTerms[1]+"%'";
					else
						qryText = qryText + "WHERE LastName LIKE '%" + searchTerms[0] +"%'";
					break;
				case 3: //FirstName MiddleName LastName
					var searchTerms:Array = new Array();
					searchTerms = searchTerm.split(" ",searchTerm.length);
					if(searchTerms.length > 2)
						qryText = qryText + "WHERE FirstName LIKE '%" + searchTerms[0] +"%' OR MiddleName LIKE '%"+searchTerms[1]+"%' OR LastName LIKE '%"+searchTerms[2]+"%'";
					else if(searchTerms.length > 1)
						qryText = qryText + "WHERE FirstName LIKE '%" + searchTerms[0] +"%' OR MiddleName LIKE '%"+searchTerms[1]+"%'";
					else
						qryText = qryText + "WHERE FirstName LIKE '%" + searchTerms[0] +"%'";
					break;
				case 4://SSN
					qryText = qryText + "WHERE SSN LIKE '%" + searchTerm +"%'";
					break;
				case 5://DOB
					qryText = qryText + "WHERE DOB LIKE '%" + searchTerm +"%'";
					break;
				case 6://QuivusID
					qryText = qryText + "WHERE QuivusID LIKE '%" + searchTerm +"%'";
					break;
				
			}
			
			sqls.text = qryText;
			sqls.execute();
			
			var res:SQLResult = sqls.getResult();
			var data:Array = res.data;
			
			Alert.show(data.length.toString(), 'No of patients');
			
			sqlc.close();
		}
	}
}