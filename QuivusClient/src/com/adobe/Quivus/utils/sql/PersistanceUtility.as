package com.adobe.Quivus.utils.sql
{
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.DiseaseTypeDTO;
	import valueObjects.DurationTypeDTO;
	import valueObjects.EncounterTypeDTO;
	import valueObjects.EthinicityTypeDTO;
	import valueObjects.FamilyHistoryTypeDTO;
	import valueObjects.FollowUpMethodTypeDTO;
	import valueObjects.GenderTypeDTO;
	import valueObjects.HPITypeDTO;
	import valueObjects.ImageTypeDTO;
	import valueObjects.ImmunizationTypeDTO;
	import valueObjects.InstructionAgeTypeDTO;
	import valueObjects.InstructionAgeValueTypeDTO;
	import valueObjects.InstructionDurationTypeDTO;
	import valueObjects.InsuranceNatureDTO;
	import valueObjects.InsuranceOrganizationDTO;
	import valueObjects.InsuranceTypeDTO;
	import valueObjects.LabNatureTypeDTO;
	import valueObjects.LabTestOrderMethodTypeDTO;
	import valueObjects.LabTestPriorityTypeDTO;
	import valueObjects.LabTestSpecimenTypeDTO;
	import valueObjects.LabTestTypeDTO;
	import valueObjects.LabTypeDTO;
	import valueObjects.LanguageAbilityModeDTO;
	import valueObjects.LanguageTypeDTO;
	import valueObjects.MaritalStatusTypeDTO;
	import valueObjects.MedicalHistoryTypeDTO;
	import valueObjects.MethodTypeDTO;
	import valueObjects.OccupationTypeDTO;
	import valueObjects.PlanTypeDTO;
	import valueObjects.PrefixTypeDTO;
	import valueObjects.RaceTypeDTO;
	import valueObjects.RelationshipTypeDTO;
	import valueObjects.SmokingTypeDTO;
	import valueObjects.SocialHistoryAddictionTypeDTO;
	import valueObjects.SocialHistoryMediumTypeDTO;
	import valueObjects.SocialHistoryUsageAmountTypeDTO;
	import valueObjects.StatusTypeDTO;
	import valueObjects.UserTypeDTO;

	public class PersistanceUtility
	{	
			private var model : AppModelLocator = AppModelLocator.getInstance();
			// sqlc is a variable we need to define the connection to our database
			private var sqlc:SQLConnection;
			// sqlc is an SQLStatment which we need to execute our sql commands
			private var sqls:SQLStatement;
			private var registrationDB:File;
			// after we set the file for our database we need to open it with our SQLConnection.
			// open database,If the file doesn't exist yet, it will be created
			private var quickInputDB:File;			
			private var compHistoryDB:File;
			
			
			public function PersistanceUtility()
			{
				registrationDB 		= File.applicationStorageDirectory.resolvePath("temp/" + model.appVersion + "/" + Constants.REGISTERATION_STATIC_DATA_DB_NAME);
				quickInputDB 		= File.applicationStorageDirectory.resolvePath("temp/" + model.appVersion + "/" + Constants.QUICKINPUT_STATIC_DATA_DB_NAME);
				compHistoryDB	 	= File.applicationStorageDirectory.resolvePath("temp/" + model.appVersion + "/" + Constants.COMP_HISTORY_STATIC_DATA_DB_NAME)
				
				sqlc 				= new SQLConnection();
				sqls 				= new SQLStatement();
					
				sqlc.addEventListener(SQLErrorEvent.ERROR, error);			
				sqls.addEventListener(SQLErrorEvent.ERROR, error);
			}
			
			private function error(e:SQLErrorEvent):void
			{
				//M Alert.show(e.toString());
			}
			
			/********************* REGISTERATION  START ***********************************/
			
			public function isRegisterationLocalDBAvaliable():Boolean
			{
				var flag:Boolean = false;
				
				if(registrationDB != null && registrationDB.exists)
				{
					return true;
				}
				
				return flag;
			}			
			
			public function loadRegisterationData():void
			{
				if(!sqlc.connected)
					sqlc.open(registrationDB);
				
				sqls.sqlConnection = sqlc;
				
				loadGenderTypes();
				loadEthinicityTypes();
				loadImageTypes();
				loadLanguageTypes();
				loadMaritalStatusTypes();
				loadOccupationTypes();
				loadPrefixTypes();
				loadRaceTypes();
				loadRelationshipTypes();
				loadBloodRelationshipTypes();
				loadInsuranceOrganizations();
				loadInsuranceTypes();
				loadUserTypes();
				loadInsuranceNatureTypes();
				loadStatusTypes();
				loadLanguageAbilityModes();
				loadSmokingTypes();
				
				sqlc.close();
			}
			
			public function loadSpecifiedRegisterationData(dataToLoad:ArrayCollection):void
			{		
				if(!sqlc.connected)
					sqlc.open(registrationDB);
				
				sqls.sqlConnection = sqlc;
				
				if(dataToLoad.contains(Constants.PREFIX_TYPE_REGISTERATION_STATIC_DATA))
				{
					loadPrefixTypes();
				}
				else if(dataToLoad.contains(Constants.GENDER_TYPE_REGISTERATION_STATIC_DATA))
				{
					loadGenderTypes();
				}
				else if(dataToLoad.contains(Constants.MARITAL_STATUS_TYPE_REGISTERATION_STATIC_DATA))
				{
					loadMaritalStatusTypes();
				}
				else if(dataToLoad.contains(Constants.LANGUAGE_ABILITY_MODE_TYPE_REGISTERATION_STATIC_DATA))
				{
					loadLanguageAbilityModes();
				}
				else if(dataToLoad.contains(Constants.INSURANCE_NATURE_TYPE_REGISTERATION_STATIC_DATA))
				{
					loadInsuranceNatureTypes();
				}
				else if(dataToLoad.contains(Constants.INSURANCE_ORGANIZATION_TYPE_REGISTERATION_STATIC_DATA))
				{
					loadInsuranceOrganizations();
				}
				else if(dataToLoad.contains(Constants.SMOKING_TYPE_REGISTERATION_STATIC_DATA))
				{
					loadSmokingTypes();
				}
				else if(dataToLoad.contains(Constants.INSURANCE_TYPE_REGISTERATION_STATIC_DATA))
				{
					loadInsuranceTypes();
				}
				else if(dataToLoad.contains(Constants.STATUS_TYPE_REGISTERATION_STATIC_DATA))
				{
					loadStatusTypes();
				}
				else if(dataToLoad.contains(Constants.USER_TYPE_REGISTERATION_STATIC_DATA))
				{
					loadUserTypes();
				}
				else if(dataToLoad.contains(Constants.ETHINICITY_TYPE_REGISTERATION_STATIC_DATA))
				{
					loadEthinicityTypes();
				}
				else if(dataToLoad.contains(Constants.RELATIONSHIP_TYPE_REGISTERATION_STATIC_DATA))
				{
					loadRelationshipTypes();
				}
				else if(dataToLoad.contains(Constants.BLOOD_RELATIONSHIP_TYPE_REGISTERATION_STATIC_DATA))
				{
					loadBloodRelationshipTypes();
				}
				else if(dataToLoad.contains(Constants.RACE_TYPE_REGISTERATION_STATIC_DATA))
				{
					loadRaceTypes();
				}					
				else if(dataToLoad.contains(Constants.OCCUPATION_TYPE_REGISTERATION_STATIC_DATA))
				{
					loadOccupationTypes();
				}
				else if(dataToLoad.contains(Constants.LANGUAGE_TYPE_REGISTERATION_STATIC_DATA))
				{
					loadLanguageTypes();
				}
				
				sqlc.close();
			}
			
			public function initializeRegisterationDB():void
			{	
				//if(!sqlc.connected)
				
				sqlc.open(registrationDB);
				
				
				// when the database is opened we need to link the SQLStatment to our SQLConnection, so that sql statments for the right database.
				// if you don't set this connection you will get an error when you execute sql statment.
				sqls.sqlConnection = sqlc;
				
				sqls.text = "CREATE TABLE IF NOT EXISTS GenderTypes (GenderId INTEGER, GenderName TEXT, GenderCode TEXT);";
				sqls.execute();
				
				sqls.text = "DELETE FROM GenderTypes;";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS EthinicityTypes (EthinicityId INTEGER, EthinicityName TEXT, EthinicityCode TEXT);";
				sqls.execute();
				
				sqls.text = "DELETE FROM EthinicityTypes;";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS ImageTypes (ImageTypeId INTEGER, TypeName TEXT, TypeDescription TEXT);";
				sqls.execute();
				
				sqls.text = "DELETE FROM ImageTypes;";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS LanguageTypes (LanguageID INTEGER, LanguageName TEXT, LanguageCode TEXT);";
				sqls.execute();
				
				sqls.text = "DELETE FROM LanguageTypes;";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS MaritalStatusTypes (MaritalStatusId INTEGER, MaritalStatusName TEXT, MaritalStatusCode TEXT);";				
				sqls.execute();
				
				sqls.text = "DELETE FROM MaritalStatusTypes;";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS OccupationTypes (OccupationId INTEGER, OccupationName TEXT, OccupationCode TEXT);";
				sqls.execute();
				
				sqls.text = "DELETE FROM OccupationTypes;";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS PrefixTypes (PrefixId INTEGER, PrefixName TEXT, PrefixCode TEXT);";
				sqls.execute();
				
				sqls.text = "DELETE FROM PrefixTypes;";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS RaceTypes (RaceId INTEGER, RaceName TEXT, RaceCode TEXT);";
				sqls.execute();
				
				sqls.text = "DELETE FROM RaceTypes;";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS RelationshipTypes (RelationshipId INTEGER, RelationshipName TEXT, RelationshipCode TEXT);";
				sqls.execute();
				
				sqls.text = "DELETE FROM RelationshipTypes;";
				sqls.execute();

				sqls.text = "CREATE TABLE IF NOT EXISTS BloodRelationshipTypes (RelationshipId INTEGER, RelationshipName TEXT, RelationshipCode TEXT);";
				sqls.execute();
				
				sqls.text = "DELETE FROM BloodRelationshipTypes;";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS InsuranceOrganizations (InsuranceOrganizationID INTEGER, InsuranceOrganizationName TEXT, Address TEXT, City TEXT, State TEXT, ZIPCode TEXT, StateCode TEXT, Phone TEXT, AlternatePhone TEXT, FAX TEXT, Email TEXT, ContactPerson TEXT, IDNumber TEXT, Status TEXT);";
				sqls.execute();
				
				sqls.text = "DELETE FROM InsuranceOrganizations;";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS InsuranceTypes (InsuranceTypeId INTEGER, InsuranceTypeName TEXT);";
				sqls.execute();
				
				sqls.text = "DELETE FROM InsuranceTypes;";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS UserTypes (UserTypeId INTEGER, UserTypeName TEXT);";				
				sqls.execute();
				
				sqls.text = "DELETE FROM UserTypes;";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS InsuranceNatureTypes (InsuranceNatureId INTEGER, Code TEXT, Description TEXT);";
				sqls.execute();
				
				sqls.text = "DELETE FROM InsuranceNatureTypes;";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS StatusTypes (StatusID INTEGER, StatusName TEXT);";
				sqls.execute();
				
				sqls.text = "DELETE FROM StatusTypes;";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS LanguageAbilityModes (LanguageAbilityModeId INTEGER, LanguageAbilityModeCode TEXT, LangaugeAbilityModeDescription TEXT);";
				sqls.execute();
				
				sqls.text = "DELETE FROM LanguageAbilityModes;";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS SmokingTypes (SmokingTypeId INTEGER, SmokingTypeCode TEXT, SmokingTypeName TEXT);";
				sqls.execute();
				
				sqls.text = "DELETE FROM SmokingTypes;";
				sqls.execute();
				
				addGenderTypes();
				addEthinicityTypes();
				addImageTypes();
				addLanguageTypes();
				addMaritalStatusTypes();
				addOccupationTypes();
				addPrefixTypes();
				addRaceTypes();
				addRelationshipTypes();
				addBloodRelationshipTypes();
				addInsuranceOrganizations();
				addInsuranceTypes();
				addUserTypes();
				addInsuranceNatureTypes();
				addStatusTypes();
				addLanguageAbilityModes();
				addSmokingTypes();
				
				sqlc.close();
				
			}
			
			
			// function to add item to our database
			private function addGenderTypes():void
			{	
				trace("Calling addGenderTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.registrationStaticDataDTO.GenderTypes != null && i < model.registrationStaticDataDTO.GenderTypes.length; i++)
					{	
						var dto:GenderTypeDTO = model.registrationStaticDataDTO.GenderTypes.getItemAt(i) as GenderTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO GenderTypes (GenderId , GenderName , GenderCode) VALUES('" + dto.GenderId + "','"+ dto.GenderName +"','"+ dto.GenderCode +"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addEthinicityTypes():void
			{	
				trace("Calling addEthinicityTypes... ");
				
				var i:int;
				
				try
				{
					for(i = 0; model.registrationStaticDataDTO.EthinicityTypes != null && i < model.registrationStaticDataDTO.EthinicityTypes.length; i++)
					{	
						var dto:EthinicityTypeDTO = model.registrationStaticDataDTO.EthinicityTypes.getItemAt(i) as EthinicityTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO EthinicityTypes (EthinicityId , EthinicityName , EthinicityCode) VALUES('" + dto.EthinicityId + "','"+ dto.EthinicityName +"','"+ dto.EthinicityCode +"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addImageTypes():void
			{	
				trace("Calling addImageTypes... ");
				
				var i:int;
				
				try
				{
					for(i = 0; model.registrationStaticDataDTO.ImageTypes != null && i < model.registrationStaticDataDTO.ImageTypes.length; i++)
					{	
						var dto:ImageTypeDTO = model.registrationStaticDataDTO.ImageTypes.getItemAt(i) as ImageTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO ImageTypes (EthinicityId , TypeName , TypeDescription) VALUES('" + dto.ImageTypeId + "','"+ dto.TypeName +"','"+ dto.TypeDescription +"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addLanguageTypes():void
			{	
				trace("Calling addLanguageTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.registrationStaticDataDTO.LanguageTypes != null && i < model.registrationStaticDataDTO.LanguageTypes.length; i++)
					{	
						var dto:LanguageTypeDTO = model.registrationStaticDataDTO.LanguageTypes.getItemAt(i) as LanguageTypeDTO ; 
						
						dto.LanguageName = QSUtilityFunctions.normalizeQueryString(dto.LanguageName);
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO LanguageTypes (LanguageID , LanguageName , LanguageCode) VALUES('" + dto.LanguageID + "','"+ dto.LanguageName +"','"+ dto.LanguageCode +"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addMaritalStatusTypes():void
			{	
				trace("Calling addMaritalStatusTypes... ");
				
				var i:int;
				try
				{
					for(i = 0;  model.registrationStaticDataDTO.MaritalStatusTypes != null && i < model.registrationStaticDataDTO.MaritalStatusTypes.length; i++)
					{	
						var dto:MaritalStatusTypeDTO = model.registrationStaticDataDTO.MaritalStatusTypes.getItemAt(i) as MaritalStatusTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO MaritalStatusTypes (MaritalStatusId , MaritalStatusName , MaritalStatusCode) VALUES('" + dto.MaritalStatusId + "','"+ dto.MaritalStatusName +"','"+ dto.MaritalStatusCode +"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
						
			// function to add item to our database
			private function loadGenderTypes():void
			{
				trace("Calling loadGenderTypes... ");
				try
				{
					sqls.text = "SELECT * FROM GenderTypes"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.registrationStaticDataDTO.GenderTypes = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:GenderTypeDTO = new GenderTypeDTO();
						
						dto.GenderId = data[i].GenderId;
						dto.GenderName = data[i].GenderName;
						dto.GenderCode = data[i].GenderCode;
						
						model.registrationStaticDataDTO.GenderTypes.addItem(dto);
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadEthinicityTypes():void
			{
				trace("Calling loadEthinicityTypes... ");
				try
				{
					sqls.text = "SELECT * FROM EthinicityTypes"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.registrationStaticDataDTO.EthinicityTypes = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:EthinicityTypeDTO = new EthinicityTypeDTO();
						
						dto.EthinicityId = data[i].EthinicityId;
						dto.EthinicityName = data[i].EthinicityName;
						dto.EthinicityCode = data[i].EthinicityCode;
						
						model.registrationStaticDataDTO.EthinicityTypes.addItem(dto);
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadImageTypes():void
			{
				trace("Calling loadImageTypes... ");
				try
				{
					sqls.text = "SELECT * FROM ImageTypes"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.registrationStaticDataDTO.ImageTypes = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:ImageTypeDTO = new ImageTypeDTO();
						
						dto.ImageTypeId = data[i].ImageTypeId;
						dto.TypeName = data[i].TypeName;
						dto.TypeDescription = data[i].TypeDescription;
						
						model.registrationStaticDataDTO.ImageTypes.addItem(dto);
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadLanguageTypes():void
			{
				trace("Calling loadLanguageTypes... ");
				try
				{
					sqls.text = "SELECT * FROM LanguageTypes"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.registrationStaticDataDTO.LanguageTypes = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:LanguageTypeDTO = new LanguageTypeDTO();
						
						dto.LanguageID = data[i].LanguageID;
						dto.LanguageName = data[i].LanguageName;
						dto.LanguageCode = data[i].LanguageCode;
						
						model.registrationStaticDataDTO.LanguageTypes.addItem(dto);
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadMaritalStatusTypes():void
			{
				trace("Calling loadMaritalStatusTypes... ");
				try
				{
					sqls.text = "SELECT * FROM MaritalStatusTypes"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.registrationStaticDataDTO.MaritalStatusTypes = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:MaritalStatusTypeDTO = new MaritalStatusTypeDTO();
						
						dto.MaritalStatusId = data[i].MaritalStatusId;
						dto.MaritalStatusName = data[i].MaritalStatusName;
						dto.MaritalStatusCode = data[i].MaritalStatusCode;
						
						model.registrationStaticDataDTO.MaritalStatusTypes.addItem(dto);
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addOccupationTypes():void
			{	
				trace("Calling addOccupationTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.registrationStaticDataDTO.OccupationTypes != null && i < model.registrationStaticDataDTO.OccupationTypes.length; i++)
					{	
						var dto:OccupationTypeDTO = model.registrationStaticDataDTO.OccupationTypes.getItemAt(i) as OccupationTypeDTO ;
						
						dto.OccupationName = QSUtilityFunctions.normalizeQueryString(dto.OccupationName);
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO OccupationTypes (OccupationId , OccupationName , OccupationCode) VALUES('" + dto.OccupationId + "','"+ dto.OccupationName +"','"+ dto.OccupationCode +"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadOccupationTypes():void
			{
				trace("Calling loadOccupationTypes... ");
				try
				{
					sqls.text = "SELECT * FROM OccupationTypes"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.registrationStaticDataDTO.OccupationTypes = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:OccupationTypeDTO = new OccupationTypeDTO();
						
						dto.OccupationId = data[i].OccupationId;
						dto.OccupationName = data[i].OccupationName;
						dto.OccupationCode = data[i].OccupationCode;
						
						model.registrationStaticDataDTO.OccupationTypes.addItem(dto);
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addPrefixTypes():void
			{	
				trace("Calling addPrefixTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.registrationStaticDataDTO.PrefixTypes != null && i < model.registrationStaticDataDTO.PrefixTypes.length; i++)
					{	
						var dto:PrefixTypeDTO = model.registrationStaticDataDTO.PrefixTypes.getItemAt(i) as PrefixTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO PrefixTypes (PrefixId , PrefixName , PrefixCode) VALUES('" + dto.PrefixId + "','"+ dto.PrefixName +"','"+ dto.PrefixCode +"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadPrefixTypes():void
			{
				trace("Calling loadPrefixTypes... ");
				try
				{
					sqls.text = "SELECT * FROM PrefixTypes"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.registrationStaticDataDTO.PrefixTypes = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:PrefixTypeDTO = new PrefixTypeDTO();
						
						dto.PrefixId = data[i].PrefixId;
						dto.PrefixName = data[i].PrefixName;
						dto.PrefixCode = data[i].PrefixCode;
						
						model.registrationStaticDataDTO.PrefixTypes.addItem(dto);
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addRaceTypes():void
			{	
				trace("Calling addRaceTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.registrationStaticDataDTO.RaceTypes != null && i < model.registrationStaticDataDTO.RaceTypes.length; i++)
					{	
						var dto:RaceTypeDTO = model.registrationStaticDataDTO.RaceTypes.getItemAt(i) as RaceTypeDTO ; 
						
						dto.RaceName = QSUtilityFunctions.normalizeQueryString(dto.RaceName);
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO RaceTypes (RaceId , RaceName , RaceCode) VALUES('" + dto.RaceId + "','"+ dto.RaceName +"','"+ dto.RaceCode +"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadRaceTypes():void
			{
				trace("Calling loadRaceTypes... ");
				try
				{
					sqls.text = "SELECT * FROM RaceTypes"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.registrationStaticDataDTO.RaceTypes = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:RaceTypeDTO = new RaceTypeDTO();
						
						dto.RaceId = data[i].RaceId;
						dto.RaceName = data[i].RaceName;
						dto.RaceCode = data[i].RaceCode;
						
						model.registrationStaticDataDTO.RaceTypes.addItem(dto);
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addRelationshipTypes():void
			{	
				trace("Calling addRelationshipTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.registrationStaticDataDTO.RelationshipTypes != null && i < model.registrationStaticDataDTO.RelationshipTypes.length; i++)
					{	
						var dto:RelationshipTypeDTO = model.registrationStaticDataDTO.RelationshipTypes.getItemAt(i) as RelationshipTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO RelationshipTypes (RelationshipId , RelationshipName , RelationshipCode) VALUES('" + dto.RelationshipId + "','"+ dto.RelationshipName +"','"+ dto.RelationshipCode +"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addBloodRelationshipTypes():void
			{	
				trace("Calling addBloodRelationshipTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.registrationStaticDataDTO.BloodRelationshipTypes != null && i < model.registrationStaticDataDTO.BloodRelationshipTypes.length; i++)
					{	
						var dto:RelationshipTypeDTO = model.registrationStaticDataDTO.BloodRelationshipTypes.getItemAt(i) as RelationshipTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO BloodRelationshipTypes (RelationshipId , RelationshipName , RelationshipCode) VALUES('" + dto.RelationshipId + "','"+ dto.RelationshipName +"','"+ dto.RelationshipCode +"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadRelationshipTypes():void
			{
				trace("Calling loadRelationshipTypes... ");
				try
				{
					sqls.text = "SELECT * FROM RelationshipTypes"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.registrationStaticDataDTO.RelationshipTypes = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:RelationshipTypeDTO = new RelationshipTypeDTO();
						
						dto.RelationshipId = data[i].RelationshipId;
						dto.RelationshipName = data[i].RelationshipName;
						dto.RelationshipCode = data[i].RelationshipCode;
						
						model.registrationStaticDataDTO.RelationshipTypes.addItem(dto);
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			private function loadBloodRelationshipTypes():void
			{
				trace("Calling loadBloodRelationshipTypes... ");
				try
				{
					sqls.text = "SELECT * FROM BloodRelationshipTypes"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.registrationStaticDataDTO.BloodRelationshipTypes = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:RelationshipTypeDTO = new RelationshipTypeDTO();
						
						dto.RelationshipId = data[i].RelationshipId;
						dto.RelationshipName = data[i].RelationshipName;
						dto.RelationshipCode = data[i].RelationshipCode;
						
						model.registrationStaticDataDTO.RelationshipTypes.addItem(dto);
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addInsuranceTypes():void
			{	
				trace("Calling addInsuranceTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.registrationStaticDataDTO.InsuranceTypes != null && i < model.registrationStaticDataDTO.InsuranceTypes.length; i++)
					{	
						var dto:InsuranceTypeDTO = model.registrationStaticDataDTO.InsuranceTypes.getItemAt(i) as InsuranceTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO InsuranceTypes (InsuranceTypeId , InsuranceTypeName ) VALUES('" + dto.InsuranceTypeId + "','"+ dto.InsuranceTypeName + "');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadInsuranceTypes():void
			{
				trace("Calling loadInsuranceTypes... ");
				try
				{
					sqls.text = "SELECT * FROM InsuranceTypes"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.registrationStaticDataDTO.InsuranceTypes = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:InsuranceTypeDTO = new InsuranceTypeDTO();
						
						dto.InsuranceTypeId = data[i].InsuranceTypeId;
						dto.InsuranceTypeName = data[i].InsuranceTypeName;					
						
						model.registrationStaticDataDTO.InsuranceTypes.addItem(dto);
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addUserTypes():void
			{	
				trace("Calling addUserTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.registrationStaticDataDTO.UserTypes != null && i < model.registrationStaticDataDTO.UserTypes.length; i++)
					{	
						var dto:UserTypeDTO = model.registrationStaticDataDTO.UserTypes.getItemAt(i) as UserTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO UserTypes (UserTypeId , UserTypeName) VALUES('" + dto.UserTypeId + "','"+ dto.UserTypeName + "');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadUserTypes():void
			{
				trace("Calling loadUserTypes... ");
				try
				{
					sqls.text = "SELECT * FROM UserTypes"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.registrationStaticDataDTO.UserTypes = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:UserTypeDTO = new UserTypeDTO();
						
						dto.UserTypeId = data[i].UserTypeId;
						dto.UserTypeName = data[i].UserTypeName;					
						
						model.registrationStaticDataDTO.UserTypes.addItem(dto);
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addInsuranceNatureTypes():void
			{	
				trace("Calling addInsuranceNatureTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.registrationStaticDataDTO.InsuranceNatureTypes != null && i < model.registrationStaticDataDTO.InsuranceNatureTypes.length; i++)
					{	
						var dto:InsuranceNatureDTO = model.registrationStaticDataDTO.InsuranceNatureTypes.getItemAt(i) as InsuranceNatureDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO InsuranceNatureTypes (InsuranceNatureId , Code, Description ) VALUES('" + dto.InsuranceNatureId + "','"+ dto.Code + "','"+dto.Description+"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadInsuranceNatureTypes():void
			{
				trace("Calling loadInsuranceNatureTypes... ");
				try
				{
					sqls.text = "SELECT * FROM InsuranceNatureTypes"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.registrationStaticDataDTO.InsuranceNatureTypes = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:InsuranceNatureDTO = new InsuranceNatureDTO();
						
						dto.InsuranceNatureId = data[i].InsuranceNatureId;
						dto.Code = data[i].Code;					
						dto.Description = data[i].Description;
						
						model.registrationStaticDataDTO.InsuranceNatureTypes.addItem(dto);
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addStatusTypes():void
			{	
				trace("Calling addStatusTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.registrationStaticDataDTO.AllStatusTypeList != null && i < model.registrationStaticDataDTO.AllStatusTypeList.length; i++)
					{	
						var dto:StatusTypeDTO = model.registrationStaticDataDTO.AllStatusTypeList.getItemAt(i) as StatusTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO StatusTypes (StatusID , StatusName ) VALUES('" + dto.StatusID + "','"+ dto.StatusName + "');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadStatusTypes():void
			{
				trace("Calling loadStatusTypes... ");
				try
				{
					sqls.text = "SELECT * FROM StatusTypes"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.registrationStaticDataDTO.AllStatusTypeList = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:StatusTypeDTO = new StatusTypeDTO();
						
						dto.StatusID = data[i].StatusID;
						dto.StatusName = data[i].StatusName;
						
						model.registrationStaticDataDTO.AllStatusTypeList.addItem(dto);
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addLanguageAbilityModes():void
			{	
				trace("Calling addLanguageAbilityModes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.registrationStaticDataDTO.LanguageAbilityModeDTOList != null && i < model.registrationStaticDataDTO.LanguageAbilityModeDTOList.length; i++)
					{	
						var dto:LanguageAbilityModeDTO = model.registrationStaticDataDTO.LanguageAbilityModeDTOList.getItemAt(i) as LanguageAbilityModeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO LanguageAbilityModes (LanguageAbilityModeId , LanguageAbilityModeCode , LangaugeAbilityModeDescription ) VALUES('" + dto.LanguageAbilityModeId + "','"+ dto.LanguageAbilityModeCode +"','"+ dto.LangaugeAbilityModeDescription + "');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadLanguageAbilityModes():void
			{
				trace("Calling loadLanguageAbilityModes... ");
				try
				{
					sqls.text = "SELECT * FROM LanguageAbilityModes"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.registrationStaticDataDTO.LanguageAbilityModeDTOList = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:LanguageAbilityModeDTO = new LanguageAbilityModeDTO();
						
						dto.LanguageAbilityModeId = data[i].LanguageAbilityModeId;
						dto.LanguageAbilityModeCode = data[i].LanguageAbilityModeCode;					
						dto.LangaugeAbilityModeDescription = data[i].LangaugeAbilityModeDescription;
						
						model.registrationStaticDataDTO.LanguageAbilityModeDTOList.addItem(dto);
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addSmokingTypes():void
			{	
				trace("Calling addSmokingTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.registrationStaticDataDTO.SmokingTyeDTOList != null && i < model.registrationStaticDataDTO.SmokingTyeDTOList.length; i++)
					{	
						var dto:SmokingTypeDTO = model.registrationStaticDataDTO.SmokingTyeDTOList.getItemAt(i) as SmokingTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO SmokingTypes (SmokingTypeId , SmokingTypeCode , SmokingTypeName ) VALUES('" + dto.SmokingTypeId + "','"+ dto.SmokingTypeCode +"','"+ dto.SmokingTypeName + "');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadSmokingTypes():void
			{
				trace("Calling loadSmokingTyes... ");
				try
				{
					sqls.text = "SELECT * FROM SmokingTypes"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.registrationStaticDataDTO.SmokingTyeDTOList = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:SmokingTypeDTO = new SmokingTypeDTO();
						
						dto.SmokingTypeId = data[i].SmokingTypeId;
						dto.SmokingTypeCode = data[i].SmokingTypeCode;					
						dto.SmokingTypeName = data[i].SmokingTypeName;
						
						model.registrationStaticDataDTO.SmokingTyeDTOList.addItem(dto);
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addInsuranceOrganizations():void
			{	
				trace("Calling addInsuranceOrganizations... ");
				
				var i:int;
				try
				{
					for(i = 0; model.registrationStaticDataDTO.InsuranceOrganizations != null && i < model.registrationStaticDataDTO.InsuranceOrganizations.length; i++)
					{	
						var dto:InsuranceOrganizationDTO = model.registrationStaticDataDTO.InsuranceOrganizations.getItemAt(i) as InsuranceOrganizationDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO InsuranceOrganizations (InsuranceOrganizationID, InsuranceOrganizationName, Address, City, State, ZIPCode, StateCode, Phone, AlternatePhone, FAX, Email, ContactPerson, IDNumber, Status) VALUES('"+dto.InsuranceOrganizationID+"','"+ dto.InsuranceOrganizationName+"','"+ dto.Address+"','"+ dto.City+"','"+ dto.State+"','"+ dto.ZIPCode+"','"+ dto.StateCode+"','"+ dto.Phone+"','"+ dto.AlternatePhone+"','"+ dto.FAX+"','"+ dto.Email+"','"+ dto.ContactPerson+"','"+ dto.IDNumber+"','"+ dto.Status+"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadInsuranceOrganizations():void
			{
				trace("Calling loadInsuranceOrganizations... ");
				try
				{
					sqls.text = "SELECT * FROM InsuranceOrganizations"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.registrationStaticDataDTO.InsuranceOrganizations = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:InsuranceOrganizationDTO = new InsuranceOrganizationDTO();
						
						dto.InsuranceOrganizationID = data[i].InsuranceOrganizationID;
						dto.InsuranceOrganizationName = data[i].InsuranceOrganizationName;					
						dto.Address = data[i].Address;
						dto.City = data[i].City;
						dto.State = data[i].State;
						dto.ZIPCode = data[i].ZIPCode;
						dto.StateCode = data[i].StateCode;
						dto.Phone = data[i].Phone;
						dto.AlternatePhone = data[i].AlternatePhone;					
						dto.FAX = data[i].FAX;
						dto.Email = data[i].Email;
						dto.ContactPerson = data[i].ContactPerson;
						dto.IDNumber = data[i].IDNumber;
						dto.Status = data[i].Status;
						
						model.registrationStaticDataDTO.InsuranceOrganizations.addItem(dto);
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
	
			/********************* REGISTERATION  END ***********************************/
			
			
			/********************* QUICKINPUT START ***********************************/
			
			public function isQuickInputLocalDBAvaliable():Boolean
			{
				var flag:Boolean = false;
				
				if(quickInputDB != null && quickInputDB.exists)
				{
					return true;
				}
				
				return flag;
			}
			
			public function loadSpecifiedQuickInputData(dataToLoad:String):void
			{
				//if(!sqlc.connected)
				sqlc.open(quickInputDB);
				
				sqls.sqlConnection = sqlc;
				
				if(dataToLoad == Constants.LAB_TEST_NATURE_TYPE_QUICKINPUT_STATIC_DATA)
				{
					loadLabTestNatureTypes();
				}				
				else if(dataToLoad == Constants.LAB_TEST_PRIORITY_TYPE_QUICKINPUT_STATIC_DATA)
				{
					loadLabTestPriorityTypes();
				}
				else if(dataToLoad == Constants.TEST_SPECIMEN_TYPE_QUICKINPUT_STATIC_DATA)
				{
					loadTestSpecimenTypes();
				}
				else if(dataToLoad == Constants.LAB_TEST_TYPE_QUICKINPUT_STATIC_DATA)
				{
					loadLabTestTypes();
				}
				else if(dataToLoad == Constants.LAB_TYPE_QUICKINPUT_STATIC_DATA)
				{								
					loadLabTypes();
				}
				else if(dataToLoad == Constants.LAB_TEST_ORDERMETHOD_TYPE_QUICKINPUT_STATIC_DATA)
				{	
					loadLabTestOrderMethodTypes();
				}
				else if(dataToLoad == Constants.INSTRUCTION_DURATION_TYPE_QUICKINPUT_STATIC_DATA)
				{
					loadInstructionDurationTypes();
				}
				else if(dataToLoad == Constants.INSTRUCTIONAGE_TYPE_QUICKINPUT_STATIC_DATA)
				{
					loadInstructionAgeTypes();	
				}
				else if(dataToLoad == Constants.INSTRUCTIONAGE_VALUE_TYPE_QUICKINPUT_STATIC_DATA)
				{
					loadInstructionAgeValueTypes();	
				}
				else if(dataToLoad == Constants.ENCOUNTER_TYPE_QUICKINPUT_STATIC_DATA)
				{
					loadEncounterTypes();		
				}
				else if(dataToLoad == Constants.IMMUNIZATION_TYPE_QUICKINPUT_STATIC_DATA)
				{
					loadImmunizationTypes();	
				}
				else if(dataToLoad == Constants.HPI_TYPE_QUICKINPUT_STATIC_DATA)
				{
					loadHPITypes();	
				}
				else if(dataToLoad == Constants.PLAN_TYPE_QUICKINPUT_STATIC_DATA)
				{
					loadPlanTypes();
				}
				else if(dataToLoad == Constants.DURATION_TYPE_QUICKINPUT_STATIC_DATA)
				{
					loadDurationTypes();
				}
				else if(dataToLoad == Constants.METHOD_TYPE_QUICKINPUT_STATIC_DATA)
				{
					loadMethodTypes();		
				}
				else if(dataToLoad == Constants.FOLLOWUP_METHOD_TYPE_QUICKINPUT_STATIC_DATA)
				{
					loadFollowUpMethodTypes();
				}
				
				sqlc.close();
			}
			
			private function loadQuickInputData():void
			{
				//if(!sqlc.connected)
					sqlc.open(quickInputDB);
				
				sqls.sqlConnection = sqlc;
				
				loadLabTestNatureTypes();
				loadLabTestPriorityTypes();
				loadTestSpecimenTypes();
				loadLabTestTypes();
				loadLabTypes();
				loadLabTestOrderMethodTypes();
				loadInstructionDurationTypes();
				loadInstructionAgeTypes();				
				loadInstructionAgeValueTypes();				
				loadEncounterTypes();				
				loadImmunizationTypes();				
				loadHPITypes();				
				loadPlanTypes();				
				loadDurationTypes();				
				loadMethodTypes();				
				loadFollowUpMethodTypes();
				
				sqlc.close();
			}
			
			
			public function initializeSpecifiedQuickInputDB(dataToSave:String):void
			{	
				//if(!sqlc.connected)
				
				sqlc.open(quickInputDB);
				
				
				// when the database is opened we need to link the SQLStatment to our SQLConnection, so that sql statments for the right database.
				// if you don't set this connection you will get an error when you execute sql statment.
				sqls.sqlConnection = sqlc;
				
				
				sqls.text = "CREATE TABLE IF NOT EXISTS LabTestNatureType (LabTestNatureTypeID INTEGER, LabTestNatureName TEXT, Description TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS LabTestPriorityType (LabTestPriorityTypeID INTEGER, PriorityName TEXT, Description TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS TestSpecimenType (LabTestSpecimenTypeID INTEGER, SpecimenName TEXT, Description TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS TestSpecimenType (LabTestSpecimenTypeID INTEGER, SpecimenName TEXT, Description TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS LabTestType (LabTestTypeID INTEGER, Code TEXT, TestTypeName TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS LabType (LabTypeID INTEGER, LabName TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS LabTestOrderMethodType (LabTestOrderMethodTypeID INTEGER, OrderMethodTypeName TEXT, Description TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS SocialHistoryUsageAmountType (SocialHistoryUsageAmountID INTEGER, UsageAmountName TEXT, Code TEXT,  Description TEXT, SocialHistoryAddictionTypeID INTEGER, AddictionName TEXT, IsPresentApplicable INTEGER, IsPastApplicable INTEGER);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS SocialHistoryMediumType (SocialHistoryMediumID INTEGER, MediumName TEXT, Description TEXT, SocialHistoryAddictionTypeID INTEGER, AddictionName TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS InstructionDurationType (DurationTypeID INTEGER, DurationTypeName TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS InstructionAgeType (InstructionAgeTypeID INTEGER, AgeTypeName TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS InstructionAgeValueType (InstructionAgeValueTypeID INTEGER, AgeValueTypeName TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS EncounterType (VisitEncounterTypeID INTEGER, EncounterTypeName TEXT, Code TEXT, Description TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS ImmunizationType (ImmunizationTypeId INTEGER, ImmunizationTypeName TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS HPIType (HPIDataControlTypeID INTEGER, DataControlName TEXT, Description TEXT);";
				sqls.execute();				
				
				sqls.text = "CREATE TABLE IF NOT EXISTS PlanType (RecommendationPlanTypeID INTEGER, PlanName TEXT, Description TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS DurationType (RecommendationDurationTypeID INTEGER, DurationName TEXT, Description TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS MethodType (RecommendationMethodTypeID INTEGER, MethodName TEXT, Description TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS FollowUpMethodType (FollowUpMethodTypeID INTEGER, MethodName TEXT, Description TEXT);";
				sqls.execute();
				
				if(dataToSave == Constants.LAB_TEST_NATURE_TYPE_QUICKINPUT_STATIC_DATA)
				{				
					addLabTestNatureTypes();
				}
				else if(dataToSave == Constants.LAB_TEST_PRIORITY_TYPE_QUICKINPUT_STATIC_DATA)
				{
					addLabTestPriorityTypes();
				}
				else if(dataToSave == Constants.TEST_SPECIMEN_TYPE_QUICKINPUT_STATIC_DATA)
				{
					addTestSpecimenTypes();
				}
				else if(dataToSave == Constants.LAB_TEST_TYPE_QUICKINPUT_STATIC_DATA)
				{
					addLabTestTypes();
				}
				else if(dataToSave == Constants.LAB_TYPE_QUICKINPUT_STATIC_DATA)
				{
					addLabTypes();
				}
				else if(dataToSave == Constants.LAB_TEST_ORDERMETHOD_TYPE_QUICKINPUT_STATIC_DATA)
				{
					addLabTestOrderMethodTypes();
				}
				else if(dataToSave == Constants.INSTRUCTION_DURATION_TYPE_QUICKINPUT_STATIC_DATA)
				{
					addInstructionDurationTypes();
				}
				else if(dataToSave == Constants.INSTRUCTIONAGE_TYPE_QUICKINPUT_STATIC_DATA)
				{
					addInstructionAgeTypes();
				}
				else if(dataToSave == Constants.INSTRUCTIONAGE_VALUE_TYPE_QUICKINPUT_STATIC_DATA)
				{
					addInstructionAgeValueTypes();
				}
				else if(dataToSave == Constants.ENCOUNTER_TYPE_QUICKINPUT_STATIC_DATA)
				{
					addEncounterTypes();
				}
				else if(dataToSave == Constants.IMMUNIZATION_TYPE_QUICKINPUT_STATIC_DATA)
				{
					addImmunizationTypes();
				}
				else if(dataToSave == Constants.HPI_TYPE_QUICKINPUT_STATIC_DATA)
				{
					addHPITypes();
				}
				else if(dataToSave == Constants.PLAN_TYPE_QUICKINPUT_STATIC_DATA)
				{
					addPlanTypes();
				}
				else if(dataToSave == Constants.DURATION_TYPE_QUICKINPUT_STATIC_DATA)
				{
					addDurationTypes();
				}
				else if(dataToSave == Constants.METHOD_TYPE_QUICKINPUT_STATIC_DATA)
				{
					addMethodTypes();
				}
				else if(dataToSave == Constants.FOLLOWUP_METHOD_TYPE_QUICKINPUT_STATIC_DATA)
				{
					addFollowUpMethodTypes();
				}
				
				
				sqlc.close();
			}
			
			private function initializeQuickInputDB():void
			{	
				//if(!sqlc.connected)
				
				sqlc.open(quickInputDB);
				
				
				// when the database is opened we need to link the SQLStatment to our SQLConnection, so that sql statments for the right database.
				// if you don't set this connection you will get an error when you execute sql statment.
				sqls.sqlConnection = sqlc;
				
				sqls.text = "CREATE TABLE IF NOT EXISTS LabTestNatureType (LabTestNatureTypeID INTEGER, LabTestNatureName TEXT, Description TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS LabTestPriorityType (LabTestPriorityTypeID INTEGER, PriorityName TEXT, Description TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS TestSpecimenType (LabTestSpecimenTypeID INTEGER, SpecimenName TEXT, Description TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS TestSpecimenType (LabTestSpecimenTypeID INTEGER, SpecimenName TEXT, Description TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS LabTestType (LabTestTypeID INTEGER, Code TEXT, TestTypeName TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS LabType (LabTypeID INTEGER, LabName TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS LabTestOrderMethodType (LabTestOrderMethodTypeID INTEGER, OrderMethodTypeName TEXT, Description TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS SocialHistoryUsageAmountType (SocialHistoryUsageAmountID INTEGER, UsageAmountName TEXT, Code TEXT,  Description TEXT, SocialHistoryAddictionTypeID INTEGER, AddictionName TEXT, IsPresentApplicable INTEGER, IsPastApplicable INTEGER);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS SocialHistoryMediumType (SocialHistoryMediumID INTEGER, MediumName TEXT, Description TEXT, SocialHistoryAddictionTypeID INTEGER, AddictionName TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS InstructionDurationType (DurationTypeID INTEGER, DurationTypeName TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS InstructionAgeType (InstructionAgeTypeID INTEGER, AgeTypeName TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS InstructionAgeValueType (InstructionAgeValueTypeID INTEGER, AgeValueTypeName TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS EncounterType (VisitEncounterTypeID INTEGER, EncounterTypeName TEXT, Code TEXT, Description TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS ImmunizationType (ImmunizationTypeId INTEGER, ImmunizationTypeName TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS HPIType (HPIDataControlTypeID INTEGER, DataControlName TEXT, Description TEXT);";
				sqls.execute();				
				
				sqls.text = "CREATE TABLE IF NOT EXISTS PlanType (RecommendationPlanTypeID INTEGER, PlanName TEXT, Description TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS DurationType (RecommendationDurationTypeID INTEGER, DurationName TEXT, Description TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS MethodType (RecommendationMethodTypeID INTEGER, MethodName TEXT, Description TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS FollowUpMethodType (FollowUpMethodTypeID INTEGER, MethodName TEXT, Description TEXT);";
				sqls.execute();
				
				
				addLabTestNatureTypes();
				addLabTestPriorityTypes();
				addTestSpecimenTypes();
				addLabTestTypes();
				addLabTypes();
				addLabTestOrderMethodTypes();
				addInstructionDurationTypes();
				addInstructionAgeTypes();				
				addInstructionAgeValueTypes();				
				addEncounterTypes();				
				addImmunizationTypes();				
				addHPITypes();				
				addPlanTypes();				
				addDurationTypes();				
				addMethodTypes();				
				addFollowUpMethodTypes();
				
				
				sqlc.close();
			}
			
			
			private function addLabTestNatureTypes():void
			{	
				trace("Calling addLabTestNatureTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.labNatureTypeDTOList != null && i < model.labNatureTypeDTOList.length; i++)
					{	
						var dto:LabNatureTypeDTO = model.labNatureTypeDTOList.getItemAt(i) as LabNatureTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO  LabTestNatureType (LabTestNatureTypeID, LabTestNatureName, Description) VALUES('"+dto.LabTestNatureTypeID+"','"+ dto.LabTestNatureName+"','"+ dto.Description+"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadLabTestNatureTypes():void
			{	
				trace("Calling loadLabTestNatureTypes... ");
				try
				{
					sqls.text = "SELECT * FROM LabTestNatureType"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.labNatureTypeDTOList = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:LabNatureTypeDTO = new LabNatureTypeDTO();
						
						dto.LabTestNatureTypeID = data[i].LabTestNatureTypeID;
						dto.LabTestNatureName = data[i].LabTestNatureName;					
						dto.Description = data[i].Description;						
						
						model.labNatureTypeDTOList.addItem(dto);
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
	
			private function addLabTestPriorityTypes():void
			{	
				trace("Calling addLabTestPriorityTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.labTestPriorityTypeDTOList != null && i < model.labTestPriorityTypeDTOList.length; i++)
					{	
						var dto:LabTestPriorityTypeDTO = model.labTestPriorityTypeDTOList.getItemAt(i) as LabTestPriorityTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO  LabTestPriorityType (LabTestPriorityTypeID, PriorityName, Description) VALUES('"+dto.LabTestPriorityTypeID+"','"+ dto.PriorityName+"','"+ dto.Description+"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadLabTestPriorityTypes():void
			{	
				trace("Calling loadLabTestPriorityTypes... ");
				try
				{
					sqls.text = "SELECT * FROM LabTestPriorityType"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.labTestPriorityTypeDTOList = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:LabTestPriorityTypeDTO = new LabTestPriorityTypeDTO();
						
						dto.LabTestPriorityTypeID = data[i].LabTestPriorityTypeID;
						dto.PriorityName = data[i].PriorityName;					
						dto.Description = data[i].Description;						
						
						model.labTestPriorityTypeDTOList.addItem(dto);
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
						
			private function addTestSpecimenTypes():void
			{	
				trace("Calling addTestSpecimenTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.labTestSpecimenTypeDTOList != null && i < model.labTestSpecimenTypeDTOList.length; i++)
					{	
						var dto:LabTestSpecimenTypeDTO = model.labTestSpecimenTypeDTOList.getItemAt(i) as LabTestSpecimenTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO  TestSpecimenType (LabTestSpecimenTypeID, SpecimenName, Description) VALUES('"+dto.LabTestSpecimenTypeID+"','"+ dto.SpecimenName+"','"+ dto.Description+"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadTestSpecimenTypes():void
			{	
				trace("Calling loadTestSpecimenTypes... ");
				try
				{
					sqls.text = "SELECT * FROM TestSpecimenType"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.labTestSpecimenTypeDTOList = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:LabTestSpecimenTypeDTO = new LabTestSpecimenTypeDTO();
						
						dto.LabTestSpecimenTypeID = data[i].LabTestSpecimenTypeID;
						dto.SpecimenName = data[i].SpecimenName;					
						dto.Description = data[i].Description;						
						
						model.labTestSpecimenTypeDTOList.addItem(dto);
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addLabTestTypes():void
			{	
				trace("Calling addLabTestTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.labTestTypeDTOList != null && i < model.labTestTypeDTOList.length; i++)
					{	
						var dto:LabTestTypeDTO = model.labTestTypeDTOList.getItemAt(i) as LabTestTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO  LabTestType (LabTestTypeID, Code, TestTypeName) VALUES('"+dto.LabTestTypeID+"','"+ dto.Code+"','"+ dto.TestTypeName+"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadLabTestTypes():void
			{	
				trace("Calling loadLabTestTypes... ");
				try
				{
					sqls.text = "SELECT * FROM LabTestType"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.labTestTypeDTOList = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:LabTestTypeDTO = new LabTestTypeDTO();
						
						dto.LabTestTypeID = data[i].LabTestTypeID;
						dto.Code = data[i].Code;					
						dto.TestTypeName = data[i].TestTypeName;						
						
						model.labTestTypeDTOList.addItem(dto);
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addLabTypes():void
			{	
				trace("Calling addLabTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.labTypeDTOList != null && i < model.labTypeDTOList.length; i++)
					{	
						var dto:LabTypeDTO = model.labTypeDTOList.getItemAt(i) as LabTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO  LabType (LabTypeID, LabName) VALUES('"+dto.LabTypeID+"','"+ dto.LabName+"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadLabTypes():void
			{	
				trace("Calling loadLabTypes... ");
				try
				{
					sqls.text = "SELECT * FROM LabType"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.labTypeDTOList = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:LabTypeDTO = new LabTypeDTO();
						
						dto.LabTypeID = data[i].LabTypeID;
						dto.LabName = data[i].LabName;
						
						model.labTypeDTOList.addItem(dto);
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addLabTestOrderMethodTypes():void
			{	
				trace("Calling addLabTestOrderMethodTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.labTestOrderMethodTypeDTOList != null && i < model.labTestOrderMethodTypeDTOList.length; i++)
					{	
						var dto:LabTestOrderMethodTypeDTO = model.labTestOrderMethodTypeDTOList.getItemAt(i) as LabTestOrderMethodTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO  LabTestOrderMethodType (LabTestOrderMethodTypeID, OrderMethodTypeName , Description) VALUES('"+dto.LabTestOrderMethodTypeID+"','"+ dto.OrderMethodTypeName+"','"+dto.Description+"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadLabTestOrderMethodTypes():void
			{	
				trace("Calling loadLabTestOrderMethodTypes... ");
				try
				{
					sqls.text = "SELECT * FROM LabTestOrderMethodType"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.labTestOrderMethodTypeDTOList = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:LabTestOrderMethodTypeDTO = new LabTestOrderMethodTypeDTO();
						
						dto.LabTestOrderMethodTypeID = data[i].LabTestOrderMethodTypeID;
						dto.OrderMethodTypeName = data[i].OrderMethodTypeName;
						dto.Description = data[i].Description;
						
						model.labTestOrderMethodTypeDTOList.addItem(dto);
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			//M TODO
			/*
			private function addSocialHistoryUsageAmountTypes():void
			{	
				trace("Calling addSocialHistoryUsageAmountTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.usageAmountDTOData != null && i < model.usageAmountDTOData.length; i++)
					{	
						var dto:SocialHistoryUsageAmountTypeDTO = model.usageAmountDTOData.getItemAt(i) as SocialHistoryUsageAmountTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO  SocialHistoryUsageAmountType (SocialHistoryUsageAmountID, UsageAmountName , Code, Description, SocialHistoryAddictionTypeID, AddictionName, IsPresentApplicable, IsPastApplicable) VALUES('"+dto.SocialHistoryUsageAmountID+"','"+dto.UsageAmountName+"','"+dto.Code+"','"+dto.Description+"','"+dto.SocialHistoryAddictionTypeID+"','"+dto.AddictionName+"','"+dto.IsPresentApplicable+"','"+dto.IsPastApplicable+"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadSocialHistoryUsageAmountTypes():void
			{	
				trace("Calling loadSocialHistoryUsageAmountTypes... ");
				try
				{
					sqls.text = "SELECT * FROM SocialHistoryUsageAmountType"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.usageAmountDTOData = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:SocialHistoryUsageAmountTypeDTO = new SocialHistoryUsageAmountTypeDTO();
						
						dto.SocialHistoryUsageAmountID = data[i].SocialHistoryUsageAmountID;
						dto.UsageAmountName = data[i].UsageAmountName;
						dto.Code = data[i].Code;
						dto.Description = data[i].Description;
						dto.SocialHistoryAddictionTypeID = data[i].SocialHistoryAddictionTypeID;
						dto.AddictionName = data[i].AddictionName;
						dto.IsPresentApplicable = data[i].IsPresentApplicable;
						dto.IsPastApplicable = data[i].IsPastApplicable;
						
						model.usageAmountDTOData.addItem(dto);
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			*/
			
			//M TODO
			/*
			private function addSocialHistoryMediumTypes():void
			{	
				trace("Calling addSocialHistoryMediumTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.historyMediumTypesDTOData != null && i < model.historyMediumTypesDTOData.length; i++)
					{	
						var dto:SocialHistoryMediumTypeDTO = model.historyMediumTypesDTOData.getItemAt(i) as SocialHistoryMediumTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO  SocialHistoryMediumType (SocialHistoryMediumID, MediumName , Description, SocialHistoryAddictionTypeID, AddictionName) VALUES('"+dto.SocialHistoryMediumID+"','"+ dto.MediumName+"','"+dto.Description+"','"+dto.SocialHistoryAddictionTypeID+"','"+dto.AddictionName+"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadSocialHistoryMediumTypes():void
			{	
				trace("Calling loadSocialHistoryMediumTypes... ");
				try
				{
					sqls.text = "SELECT * FROM SocialHistoryMediumType"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.historyMediumTypesDTOData = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:SocialHistoryMediumTypeDTO = new SocialHistoryMediumTypeDTO();
						
						dto.SocialHistoryMediumID = data[i].SocialHistoryMediumID;
						dto.MediumName = data[i].MediumName;
						dto.Description = data[i].Description;
						dto.SocialHistoryAddictionTypeID = data[i].SocialHistoryAddictionTypeID;
						dto.AddictionName = data[i].AddictionName;
						
						model.historyMediumTypesDTOData.addItem(dto);
					}
				}
				catch(error:Error)
				{
					//trace("Error: "+ error.getStackTrace());
				}
			}
			*/
			
			private function addInstructionDurationTypes():void
			{	
				trace("Calling addInstructionDurationTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.instructionDurationTypeDTOList != null && i < model.instructionDurationTypeDTOList.length; i++)
					{	
						var dto:InstructionDurationTypeDTO = model.instructionDurationTypeDTOList.getItemAt(i) as InstructionDurationTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO  InstructionDurationType (DurationTypeID, DurationTypeName) VALUES ('"+dto.DurationTypeID+"','"+ dto.DurationTypeName+"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadInstructionDurationTypes():void
			{	
				trace("Calling loadInstructionDurationTypes... ");
				try
				{
					sqls.text = "SELECT * FROM InstructionDurationType"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.instructionDurationTypeDTOList = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:InstructionDurationTypeDTO = new InstructionDurationTypeDTO();
						
						dto.DurationTypeID = data[i].DurationTypeID;
						dto.DurationTypeName = data[i].DurationTypeName;						
						
						model.instructionDurationTypeDTOList.addItem(dto);
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addInstructionAgeTypes():void
			{	
				trace("Calling addInstructionAgeTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.instructionAgeTypeDTOList != null && i < model.instructionAgeTypeDTOList.length; i++)
					{	
						var dto:InstructionAgeTypeDTO = model.instructionAgeTypeDTOList.getItemAt(i) as InstructionAgeTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO  InstructionAgeType (InstructionAgeTypeID, AgeTypeName) VALUES ('"+dto.InstructionAgeTypeID+"','"+ dto.AgeTypeName+"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadInstructionAgeTypes():void
			{	
				trace("Calling loadInstructionAgeTypes... ");
				try
				{
					sqls.text = "SELECT * FROM InstructionAgeType"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.instructionAgeTypeDTOList = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:InstructionAgeTypeDTO = new InstructionAgeTypeDTO();
						
						dto.InstructionAgeTypeID = data[i].InstructionAgeTypeID;
						dto.AgeTypeName = data[i].AgeTypeName;						
						
						model.instructionAgeTypeDTOList.addItem(dto);
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addInstructionAgeValueTypes():void
			{	
				trace("Calling addInstructionAgeValueTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.instructionAgeValueTypeDTOList != null && i < model.instructionAgeValueTypeDTOList.length; i++)
					{	
						var dto:InstructionAgeValueTypeDTO = model.instructionAgeValueTypeDTOList.getItemAt(i) as InstructionAgeValueTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO InstructionAgeValueType (InstructionAgeValueTypeID, AgeValueTypeName) VALUES ('"+dto.InstructionAgeValueTypeID+"','"+ dto.AgeValueTypeName+"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadInstructionAgeValueTypes():void
			{	
				trace("Calling loadInstructionAgeValueTypes... ");
				try
				{
					sqls.text = "SELECT * FROM InstructionAgeValueType"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.instructionAgeValueTypeDTOList = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:InstructionAgeValueTypeDTO = new InstructionAgeValueTypeDTO();
						
						dto.InstructionAgeValueTypeID = data[i].InstructionAgeValueTypeID;
						dto.AgeValueTypeName = data[i].AgeValueTypeName;						
						
						model.instructionAgeValueTypeDTOList.addItem(dto);
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addEncounterTypes():void
			{	
				trace("Calling addEncounterTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.encounterTypeDTOList != null && i < model.encounterTypeDTOList.length; i++)
					{	
						var dto:EncounterTypeDTO = model.encounterTypeDTOList.getItemAt(i) as EncounterTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO EncounterType (VisitEncounterTypeID, EncounterTypeName, Code, Description) VALUES ('"+dto.VisitEncounterTypeID+"','"+dto.EncounterTypeName+"','"+dto.Code+"','"+dto.Description+"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadEncounterTypes():void
			{	
				trace("Calling loadEncounterTypes... ");
				try
				{
					sqls.text = "SELECT * FROM EncounterType"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.encounterTypeDTOList = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:EncounterTypeDTO = new EncounterTypeDTO();
						
						dto.VisitEncounterTypeID = data[i].VisitEncounterTypeID;
						dto.EncounterTypeName = data[i].EncounterTypeName;		
						dto.Code = data[i].Code;
						dto.Description = data[i].Description;
						
						model.encounterTypeDTOList.addItem(dto);
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addImmunizationTypes():void
			{	
				trace("Calling addImmunizationTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.immunizationTypeDTOList != null && i < model.immunizationTypeDTOList.length; i++)
					{	
						var dto:ImmunizationTypeDTO = model.immunizationTypeDTOList.getItemAt(i) as ImmunizationTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO ImmunizationType (ImmunizationTypeId, ImmunizationTypeName) VALUES ('"+dto.ImmunizationTypeId+"','"+dto.ImmunizationTypeName+"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadImmunizationTypes():void
			{	
				trace("Calling loadImmunizationTypes... ");
				try
				{
					sqls.text = "SELECT * FROM ImmunizationType"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.immunizationTypeDTOList = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:ImmunizationTypeDTO = new ImmunizationTypeDTO();
						
						dto.ImmunizationTypeId = data[i].ImmunizationTypeId;
						dto.ImmunizationTypeName = data[i].ImmunizationTypeName;
						
						model.immunizationTypeDTOList.addItem(dto);
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addHPITypes():void
			{	
				trace("Calling addHPITypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.hpiDetailTypesList != null && i < model.hpiDetailTypesList.length; i++)
					{	
						var dto:HPITypeDTO = model.hpiDetailTypesList.getItemAt(i) as HPITypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO HPIType (HPIDataControlTypeID, DataControlName, Description) VALUES ('"+dto.HPIDataControlTypeID+"','"+dto.DataControlName+"','"+dto.Description+"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadHPITypes():void
			{	
				trace("Calling loadHPITypes... ");
				try
				{
					sqls.text = "SELECT * FROM HPIType"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.hpiDetailTypesList = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:HPITypeDTO = new HPITypeDTO();
						
						dto.HPIDataControlTypeID = data[i].HPIDataControlTypeID;
						dto.DataControlName = data[i].DataControlName;						
						dto.Description = data[i].Description;
						
						model.hpiDetailTypesList.addItem(dto);
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addPlanTypes():void
			{	
				trace("Calling addPlanTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.planTypesList != null && i < model.planTypesList.length; i++)
					{	
						var dto:PlanTypeDTO = model.planTypesList.getItemAt(i) as PlanTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO PlanType (RecommendationPlanTypeID, PlanName, Description) VALUES ('"+dto.RecommendationPlanTypeID+"','"+dto.PlanName+"','"+dto.Description+"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadPlanTypes():void
			{	
				trace("Calling loadPlanTypes... ");
				try
				{
					sqls.text = "SELECT * FROM PlanType"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.planTypesList = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:PlanTypeDTO = new PlanTypeDTO();
						
						dto.RecommendationPlanTypeID = data[i].RecommendationPlanTypeID;
						dto.PlanName = data[i].PlanName;						
						dto.Description = data[i].Description;
						
						model.planTypesList.addItem(dto);
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
		
			private function addDurationTypes():void
			{	
				trace("Calling addDurationTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.durationTypesList != null && i < model.durationTypesList.length; i++)
					{	
						var dto:DurationTypeDTO = model.durationTypesList.getItemAt(i) as DurationTypeDTO; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO DurationType (RecommendationDurationTypeID, DurationName, Description) VALUES ('"+dto.RecommendationDurationTypeID+"','"+dto.DurationName+"','"+dto.Description+"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadDurationTypes():void
			{	
				trace("Calling loadDurationTypes... ");
				try
				{
					sqls.text = "SELECT * FROM DurationType"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.durationTypesList = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:DurationTypeDTO = new DurationTypeDTO();
						
						dto.RecommendationDurationTypeID = data[i].RecommendationDurationTypeID;
						dto.DurationName = data[i].DurationName;						
						dto.Description = data[i].Description;
						
						model.durationTypesList.addItem(dto);
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addMethodTypes():void
			{	
				trace("Calling addMethodTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.methodTypesList != null && i < model.methodTypesList.length; i++)
					{	
						var dto:MethodTypeDTO = model.methodTypesList.getItemAt(i) as MethodTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO MethodType (RecommendationMethodTypeID, MethodName, Description) VALUES ('"+dto.RecommendationMethodTypeID+"','"+dto.MethodName+"','"+dto.Description+"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadMethodTypes():void
			{	
				trace("Calling loadMethodTypes... ");
				try
				{
					sqls.text = "SELECT * FROM MethodType"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.methodTypesList = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:MethodTypeDTO = new MethodTypeDTO();
						
						dto.RecommendationMethodTypeID = data[i].RecommendationMethodTypeID;
						dto.MethodName = data[i].MethodName;						
						dto.Description = data[i].Description;
						
						model.methodTypesList.addItem(dto);
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addFollowUpMethodTypes():void
			{	
				trace("Calling addFollowUpMethodTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.followUpMethodTypeList != null && i < model.followUpMethodTypeList.length; i++)
					{	
						var dto:FollowUpMethodTypeDTO = model.followUpMethodTypeList.getItemAt(i) as FollowUpMethodTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO FollowUpMethodType (FollowUpMethodTypeID, MethodName, Description) VALUES ('"+dto.FollowUpMethodTypeID+"','"+dto.MethodName+"','"+dto.Description+"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadFollowUpMethodTypes():void
			{	
				trace("Calling loadFollowUpMethodTypes... ");
				try
				{
					sqls.text = "SELECT * FROM FollowUpMethodType"
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.followUpMethodTypeList = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:FollowUpMethodTypeDTO = new FollowUpMethodTypeDTO();
						
						dto.FollowUpMethodTypeID = data[i].FollowUpMethodTypeID;
						dto.MethodName = data[i].MethodName;						
						dto.Description = data[i].Description;
						
						model.followUpMethodTypeList.addItem(dto);
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			
			/********************* QUICKINPUT END ***********************************/		
			
			
			/********************* COMPREHENSIVE HISTORY START ***********************************/
			
			public function isCompHistoryLocalDBAvaliable():Boolean
			{
				var flag:Boolean = false;
				
				if(compHistoryDB != null && compHistoryDB.exists)
				{
					return true;
				}
				
				return flag;
			}
			
			public function loadSpecifiedCompHistoryData(dataToLoad:String):void
			{
				//if(!sqlc.connected)
				sqlc.open(compHistoryDB);
				
				sqls.sqlConnection = sqlc;
				
				if(dataToLoad == Constants.CH_SECTION_GENERAL)
				{
					loadCHMedicalTypes();
				}	
				else if(dataToLoad == Constants.CH_SECTION_SOCIAL)
				{
					loadCHSocialTypes();
				}
				else if(dataToLoad == Constants.CH_SECTION_FAMILY)
				{
					loadCHFamilyTypes();
				}
				else if(dataToLoad == Constants.FAMILY_CANCER_MODULE_NAME) // diseases
				{
					loadCHFamily_CancerTypes();
				}
				else if(dataToLoad == Constants.FAMILY_DIABETES_MODULE_NAME)
				{
					loadCHFamily_DiabetesTypes();
				}
				else if(dataToLoad == Constants.FAMILY_HEART_DISEASE_MODULE_NAME)
				{
					loadCHFamily_HeartTypes();
				}
				else if(dataToLoad == Constants.FAMILY_HYPERTENSION_MODULE_NAME)
				{
					loadCHFamily_HypertensionTypes();
				}
				else if(dataToLoad == Constants.FAMILY_OTHER_MODULE_NAME)
				{
					loadCHFamily_OtherTypes();
				}
				
				
				sqlc.close();
			}
			
			public function initializeSpecifiedCompHistoryDB(dataToSave:String):void
			{	
				//if(!sqlc.connected)
				
				sqlc.open(compHistoryDB);
				
				
				// when the database is opened we need to link the SQLStatment to our SQLConnection, so that sql statments for the right database.
				// if you don't set this connection you will get an error when you execute sql statment.
				sqls.sqlConnection = sqlc;
				
				
				sqls.text = "CREATE TABLE IF NOT EXISTS MedicalHistoryTypes (MedicalHistoryTypeID INTEGER, MedicalHistoryTypeName TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS SocialHistoryAddictionTypes(SocialHistoryAddictionTypeID INTEGER, AddictionName TEXT, Description TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS FamilyHistoryTypes(FamilyHistoryTypeID INTEGER, FamilyHistoryTypeName TEXT, Description TEXT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS FamilyHistoryDiseaseTypes_Cancer(FamilyHistoryTypeId INTEGER, DiseaseTypeID TEXT, Description TEXT, DiseaseTypeCode TEXT, IsSystemSpecified BOOLEAN, UserID INT, UserTypeID INT, ClinicBranchID INT);";
				sqls.execute();				
				
				sqls.text = "CREATE TABLE IF NOT EXISTS FamilyHistoryDiseaseTypes_Diabetec(FamilyHistoryTypeId INTEGER, DiseaseTypeID TEXT, Description TEXT, DiseaseTypeCode TEXT, IsSystemSpecified BOOLEAN, UserID INT, UserTypeID INT, ClinicBranchID INT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS FamilyHistoryDiseaseTypes_Heart(FamilyHistoryTypeId INTEGER, DiseaseTypeID TEXT, Description TEXT, DiseaseTypeCode TEXT, IsSystemSpecified BOOLEAN, UserID INT, UserTypeID INT, ClinicBranchID INT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS FamilyHistoryDiseaseTypes_Hypertension(FamilyHistoryTypeId INTEGER, DiseaseTypeID TEXT, Description TEXT, DiseaseTypeCode TEXT, IsSystemSpecified BOOLEAN, UserID INT, UserTypeID INT, ClinicBranchID INT);";
				sqls.execute();
				
				sqls.text = "CREATE TABLE IF NOT EXISTS FamilyHistoryDiseaseTypes_Other(FamilyHistoryTypeId INTEGER, DiseaseTypeID TEXT, Description TEXT, DiseaseTypeCode TEXT, IsSystemSpecified BOOLEAN, UserID INT, UserTypeID INT, ClinicBranchID INT);";
				sqls.execute();
				
				if(dataToSave == Constants.CH_SECTION_GENERAL)
				{				
					addCHMedicalTypes();
				}		
				else if(dataToSave == Constants.CH_SECTION_SOCIAL)
				{
					addCHSocialTypes();
				}
				else if(dataToSave == Constants.CH_SECTION_FAMILY)
				{
					addCHFamilyTypes();
				}
				else if(dataToSave == Constants.FAMILY_CANCER_MODULE_NAME) // diseases
				{
					addCHFamily_CancerTypes();
				}
				else if(dataToSave == Constants.FAMILY_DIABETES_MODULE_NAME)
				{
					addCHFamily_DiabetesTypes();
				}
				else if(dataToSave == Constants.FAMILY_HEART_DISEASE_MODULE_NAME)
				{
					addCHFamily_HeartTypes();
				}
				else if(dataToSave == Constants.FAMILY_HYPERTENSION_MODULE_NAME)
				{
					addCHFamily_HypertensionTypes();
				}
				else if(dataToSave == Constants.FAMILY_OTHER_MODULE_NAME)
				{
					addCHFamily_OtherTypes();
				}
				
				sqlc.close();
			}
			
			
			private function addCHMedicalTypes():void
			{	
				trace("Calling addCHMedicalTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.allGeneralHistoryTypeDTOList != null && i < model.allGeneralHistoryTypeDTOList.length; i++)
					{	
						var dto:MedicalHistoryTypeDTO = model.allGeneralHistoryTypeDTOList.getItemAt(i) as MedicalHistoryTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO MedicalHistoryTypes (MedicalHistoryTypeID,MedicalHistoryTypeName) VALUES ('"+dto.MedicalHistoryTypeID+"','"+dto.MedicalHistoryTypeName+"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadCHMedicalTypes():void
			{	
				trace("Calling loadCHMedicalTypes... ");
				try
				{
					sqls.text = "SELECT * FROM MedicalHistoryTypes";
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.allGeneralHistoryTypeDTOList = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:MedicalHistoryTypeDTO = new MedicalHistoryTypeDTO();
						
						dto.MedicalHistoryTypeID = data[i].MedicalHistoryTypeID;
						dto.MedicalHistoryTypeName = data[i].MedicalHistoryTypeName;
						
						model.allGeneralHistoryTypeDTOList.addItem(dto);
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addCHSocialTypes():void
			{	
				trace("Calling addCHSocialTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.allSocialHistoryAddictionTypeDTOList != null && i < model.allSocialHistoryAddictionTypeDTOList.length; i++)
					{	
						var dto:SocialHistoryAddictionTypeDTO = model.allSocialHistoryAddictionTypeDTOList.getItemAt(i) as SocialHistoryAddictionTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO SocialHistoryAddictionTypes (SocialHistoryAddictionTypeID, AddictionName, Description) VALUES ('"+dto.SocialHistoryAddictionTypeID+"','"+dto.AddictionName+"','"+dto.Description +"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadCHSocialTypes():void
			{	
				trace("Calling loadCHSocialTypes... ");
				try
				{
					sqls.text = "SELECT * FROM SocialHistoryAddictionTypes";
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.allSocialHistoryAddictionTypeDTOList = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:SocialHistoryAddictionTypeDTO = new SocialHistoryAddictionTypeDTO();
						
						dto.SocialHistoryAddictionTypeID = data[i].SocialHistoryAddictionTypeID;
						dto.AddictionName = data[i].AddictionName;
						dto.Description = data[i].Description;
						
						model.allSocialHistoryAddictionTypeDTOList.addItem(dto);
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			
			private function addCHFamilyTypes():void
			{	
				trace("Calling addCHFamilyTypes... ");
				
				var i:int;
				try
				{
					for(i = 0; model.allFamilyHistoryTypeDTOList != null && i < model.allFamilyHistoryTypeDTOList.length; i++)
					{	
						var dto:FamilyHistoryTypeDTO = model.allFamilyHistoryTypeDTOList.getItemAt(i) as FamilyHistoryTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO FamilyHistoryTypes (FamilyHistoryTypeID, FamilyHistoryTypeName, Description) VALUES ('"+dto.FamilyHistoryTypeID+"','"+dto.FamilyHistoryTypeName+"','"+dto.Description +"');";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadCHFamilyTypes():void
			{	
				trace("Calling loadCHFamilyTypes... ");
				try
				{
					sqls.text = "SELECT * FROM FamilyHistoryTypes";
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.allFamilyHistoryTypeDTOList = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:FamilyHistoryTypeDTO = new FamilyHistoryTypeDTO();
						
						dto.FamilyHistoryTypeID = data[i].FamilyHistoryTypeID;
						dto.FamilyHistoryTypeName = data[i].FamilyHistoryTypeName;
						dto.Description = data[i].Description;
						
						model.allFamilyHistoryTypeDTOList.addItem(dto);
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addCHFamily_CancerTypes():void
			{	
				trace("Calling addCHFamily_CancerTypes ... ");
				
				var i:int;
				try
				{
					for(i = 0; model.cancerDiseaseTypesDTOList != null && i < model.cancerDiseaseTypesDTOList.length; i++)
					{	
						var dto:DiseaseTypeDTO = model.cancerDiseaseTypesDTOList.getItemAt(i) as DiseaseTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO FamilyHistoryDiseaseTypes_Cancer(FamilyHistoryTypeId, DiseaseTypeID, Description, DiseaseTypeCode, IsSystemSpecified, UserID, UserTypeID, ClinicBranchID) VALUES ('"+dto.FamilyHistoryTypeId+"','"+dto.DiseaseTypeID+"','"+dto.Description+"','"+dto.DiseaseTypeCode+"','"+dto.IsSystemSpecified+"','"+dto.UserID+"','"+dto.UserTypeID+"','"+dto.ClinicBranchID+"')";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadCHFamily_CancerTypes():void
			{	
				trace("Calling loadCHFamily_CancerTypes... ");
				try
				{
					sqls.text = "SELECT * FROM FamilyHistoryDiseaseTypes_Cancer";
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.cancerDiseaseTypesDTOList = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:DiseaseTypeDTO = new DiseaseTypeDTO();
						
						dto.FamilyHistoryTypeId = data[i].FamilyHistoryTypeId;
						dto.DiseaseTypeID = data[i].DiseaseTypeID;						
						dto.DiseaseTypeName = data[i].DiseaseTypeName;
						dto.Description = data[i].Description;
						dto.DiseaseTypeCode = data[i].DiseaseTypeCode;
						dto.IsSystemSpecified = data[i].IsSystemSpecified;
						dto.UserID = data[i].UserID;						
						dto.UserTypeID = data[i].UserTypeID;
						dto.ClinicBranchID = data[i].ClinicBranchID;
						
						model.cancerDiseaseTypesDTOList.addItem(dto);
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addCHFamily_DiabetesTypes():void
			{	
				trace("Calling addCHFamily_DiabetecTypes ... ");
				
				var i:int;
				try
				{
					for(i = 0; model.diabetesDiseaseTypesDTOList != null && i < model.diabetesDiseaseTypesDTOList.length; i++)
					{	
						var dto:DiseaseTypeDTO = model.diabetesDiseaseTypesDTOList.getItemAt(i) as DiseaseTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO FamilyHistoryDiseaseTypes_Diabetec(FamilyHistoryTypeId, DiseaseTypeID, Description, DiseaseTypeCode, IsSystemSpecified, UserID, UserTypeID, ClinicBranchID) VALUES ('"+dto.FamilyHistoryTypeId+"','"+dto.DiseaseTypeID+"','"+dto.Description+"','"+dto.DiseaseTypeCode+"','"+dto.IsSystemSpecified+"','"+dto.UserID+"','"+dto.UserTypeID+"','"+dto.ClinicBranchID+"')";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadCHFamily_DiabetesTypes():void
			{	
				trace("Calling loadCHFamily_DiabetecTypes... ");
				try
				{
					sqls.text = "SELECT * FROM FamilyHistoryDiseaseTypes_Diabetec";
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.diabetesDiseaseTypesDTOList = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:DiseaseTypeDTO = new DiseaseTypeDTO();
						
						dto.FamilyHistoryTypeId = data[i].FamilyHistoryTypeId;
						dto.DiseaseTypeID = data[i].DiseaseTypeID;						
						dto.DiseaseTypeName = data[i].DiseaseTypeName;
						dto.Description = data[i].Description;
						dto.DiseaseTypeCode = data[i].DiseaseTypeCode;
						dto.IsSystemSpecified = data[i].IsSystemSpecified;
						dto.UserID = data[i].UserID;						
						dto.UserTypeID = data[i].UserTypeID;
						dto.ClinicBranchID = data[i].ClinicBranchID;
						
						model.diabetesDiseaseTypesDTOList.addItem(dto);
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addCHFamily_HeartTypes():void
			{	
				trace("Calling addCHFamily_HeartTypes ... ");
				
				var i:int;
				try
				{
					for(i = 0; model.heartDiseaseDiseaseTypesDTOList != null && i < model.heartDiseaseDiseaseTypesDTOList.length; i++)
					{	
						var dto:DiseaseTypeDTO = model.heartDiseaseDiseaseTypesDTOList.getItemAt(i) as DiseaseTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO FamilyHistoryDiseaseTypes_Heart(FamilyHistoryTypeId, DiseaseTypeID, Description, DiseaseTypeCode, IsSystemSpecified, UserID, UserTypeID, ClinicBranchID) VALUES ('"+dto.FamilyHistoryTypeId+"','"+dto.DiseaseTypeID+"','"+dto.Description+"','"+dto.DiseaseTypeCode+"','"+dto.IsSystemSpecified+"','"+dto.UserID+"','"+dto.UserTypeID+"','"+dto.ClinicBranchID+"')";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadCHFamily_HeartTypes():void
			{	
				trace("Calling loadCHFamily_HeartTypes... ");
				try
				{
					sqls.text = "SELECT * FROM FamilyHistoryDiseaseTypes_Heart";
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.heartDiseaseDiseaseTypesDTOList = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:DiseaseTypeDTO = new DiseaseTypeDTO();
						
						dto.FamilyHistoryTypeId = data[i].FamilyHistoryTypeId;
						dto.DiseaseTypeID = data[i].DiseaseTypeID;						
						dto.DiseaseTypeName = data[i].DiseaseTypeName;
						dto.Description = data[i].Description;
						dto.DiseaseTypeCode = data[i].DiseaseTypeCode;
						dto.IsSystemSpecified = data[i].IsSystemSpecified;
						dto.UserID = data[i].UserID;						
						dto.UserTypeID = data[i].UserTypeID;
						dto.ClinicBranchID = data[i].ClinicBranchID;
						
						model.heartDiseaseDiseaseTypesDTOList.addItem(dto);
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addCHFamily_HypertensionTypes():void
			{	
				trace("Calling addCHFamily_HypertensionTypes ... ");
				
				var i:int;
				try
				{
					for(i = 0; model.hypertensionDiseaseTypesDTOList != null && i < model.hypertensionDiseaseTypesDTOList.length; i++)
					{	
						var dto:DiseaseTypeDTO = model.hypertensionDiseaseTypesDTOList.getItemAt(i) as DiseaseTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO FamilyHistoryDiseaseTypes_Hypertension(FamilyHistoryTypeId, DiseaseTypeID, Description, DiseaseTypeCode, IsSystemSpecified, UserID, UserTypeID, ClinicBranchID) VALUES ('"+dto.FamilyHistoryTypeId+"','"+dto.DiseaseTypeID+"','"+dto.Description+"','"+dto.DiseaseTypeCode+"','"+dto.IsSystemSpecified+"','"+dto.UserID+"','"+dto.UserTypeID+"','"+dto.ClinicBranchID+"')";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadCHFamily_HypertensionTypes():void
			{	
				trace("Calling loadCHFamily_HypertensionTypes... ");
				try
				{
					sqls.text = "SELECT * FROM FamilyHistoryDiseaseTypes_Hypertension";
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.hypertensionDiseaseTypesDTOList = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:DiseaseTypeDTO = new DiseaseTypeDTO();
						
						dto.FamilyHistoryTypeId = data[i].FamilyHistoryTypeId;
						dto.DiseaseTypeID = data[i].DiseaseTypeID;						
						dto.DiseaseTypeName = data[i].DiseaseTypeName;
						dto.Description = data[i].Description;
						dto.DiseaseTypeCode = data[i].DiseaseTypeCode;
						dto.IsSystemSpecified = data[i].IsSystemSpecified;
						dto.UserID = data[i].UserID;						
						dto.UserTypeID = data[i].UserTypeID;
						dto.ClinicBranchID = data[i].ClinicBranchID;
						
						model.hypertensionDiseaseTypesDTOList.addItem(dto);
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function addCHFamily_OtherTypes():void
			{	
				trace("Calling addCHFamily_OtherTypes ... ");
				
				var i:int;
				try
				{
					for(i = 0; model.otherDiseaseTypesDTOList != null && i < model.otherDiseaseTypesDTOList.length; i++)
					{	
						var dto:DiseaseTypeDTO = model.otherDiseaseTypesDTOList.getItemAt(i) as DiseaseTypeDTO ; 
						
						// in this sql statment we add item at the end of our table with values first_name.text in column first_name and last_name.text for column last_name
						sqls.text = "INSERT INTO FamilyHistoryDiseaseTypes_Other(FamilyHistoryTypeId, DiseaseTypeID, Description, DiseaseTypeCode, IsSystemSpecified, UserID, UserTypeID, ClinicBranchID) VALUES ('"+dto.FamilyHistoryTypeId+"','"+dto.DiseaseTypeID+"','"+dto.Description.replace("'","") +"','"+dto.DiseaseTypeCode+"','"+dto.IsSystemSpecified+"','"+dto.UserID+"','"+dto.UserTypeID+"','"+dto.ClinicBranchID+"')";
						sqls.execute();
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			private function loadCHFamily_OtherTypes():void
			{	
				trace("Calling loadCHFamily_OtherTypes... ");
				try
				{
					sqls.text = "SELECT * FROM FamilyHistoryDiseaseTypes_Other";
					sqls.execute();
					
					var data:Array = sqls.getResult().data;			
					var i:int;
					
					model.otherDiseaseTypesDTOList = new ArrayCollection();
					
					for(i = 0; data != null && i < data.length; i++)
					{
						var dto:DiseaseTypeDTO = new DiseaseTypeDTO();
						
						dto.FamilyHistoryTypeId = data[i].FamilyHistoryTypeId;
						dto.DiseaseTypeID = data[i].DiseaseTypeID;						
						dto.DiseaseTypeName = data[i].DiseaseTypeName;
						dto.Description = data[i].Description;
						dto.DiseaseTypeCode = data[i].DiseaseTypeCode;
						dto.IsSystemSpecified = data[i].IsSystemSpecified;
						dto.UserID = data[i].UserID;						
						dto.UserTypeID = data[i].UserTypeID;
						dto.ClinicBranchID = data[i].ClinicBranchID;
						
						model.otherDiseaseTypesDTOList.addItem(dto);
					}
				}
				catch(error:Error)
				{
					trace("Error: "+ error.getStackTrace());
				}
			}
			
			/********************* COMPREHENSIVE HISTORY END ***********************************/
			
			
			
			
			
			
			
	}
}