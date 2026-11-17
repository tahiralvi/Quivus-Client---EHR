package com.adobe.Quivus.command.staticData.patientsData
{
	import com.adobe.Quivus.customDTO.SyncDTO;
	import com.adobe.Quivus.customDTO.SyncInfo;
	import com.adobe.Quivus.delegate.staticData.patientsData.LoadPatientsByPracticeIdDelegate;
	import com.adobe.Quivus.events.staticData.patientsData.LoadPatientsByPracticeIdEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.dto.PatientDTO;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.common.util.exceptionAlert.QSExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.managers.CursorManager;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class LoadPatientsByPracticeIdCommand  implements Command 
	{
		[Bindable] private var model : AppModelLocator = AppModelLocator.getInstance();
		private var responder:Responder;
		private var delegate:LoadPatientsByPracticeIdDelegate;
		private var func			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadPatientsByPracticeIdDelegate( responder );	
			
			if(model.UserLoggedIn || model.SyncingApplication )
			{
				var LE:LoadPatientsByPracticeIdEvent = cgEvent as LoadPatientsByPracticeIdEvent;
				
				if(LE.func != null)
					func = LE.func;
				var clinicBranchId:int = model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq;
				
				delegate.LoadPatientsByPracticeId(clinicBranchId, LE.pageNo, LE.lastSynTime, LE.isLoadAll);
			}
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			var xPatients:XML 			= event.result.Patients[0];
			var total:int 				= int(event.result.@['TotalRecord']);
			if( total != model.totalPatientsInDB )
				model.totalPatientsInDB 	= total;
			model.lastRecordNumberInDB 	= int(event.result.@['LastRecordNumber']);
			model.pageNumberInDB 		= int(event.result.@['PageNumber']);
			model.totalPatientsList 	= new ArrayCollection();
			
			/*model.SyncSyncedCount 		= model.lastRecordNumberInDB;
			model.SyncTotalToSyncCount 	= model.totalPatientsInDB*/
			
			/*var syncDto:SyncDTO 	= model.syncInfo.getContentByType( SyncInfo.PATIENT_DATA );
			syncDto.message			= "Synchronizing patient Data...";
			syncDto.showProgress 	= true;
			syncDto.ProgressValue 	= model.lastRecordNumberInDB;
			syncDto.ProgressTotal 	= model.totalPatientsInDB;
			*/
			model.SyncingApplicationStatus = "TotalRecord:" + model.totalPatientsInDB + ", LastRecordNumber:" + model.lastRecordNumberInDB + ", PageNumber:" + model.pageNumberInDB;
			
			if(xPatients.Patient.length() >0)
			{
				for(var i:uint=0; i < xPatients.Patient.length(); i++)
				{
					var aPatient:XML = xPatients.Patient[i];
					var patientDto:PatientDTO  = new PatientDTO();
					patientDto.FromXML(aPatient);
					model.totalPatientsList.addItem(patientDto);
				}
				
			}
			
			if(null != func)
				func();
		}
		
		private function onError(event:FaultEvent):void
		{
			CursorManager.removeBusyCursor();
			
			/*Alert.show(event.toString(),"LoadPatientsByPracticeIdCommand");*/
			model.errorStatus = "error in LoadPatientsByPracticeIdCommand";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, event.toString(), userId); 
			
			
			////////////////////
			
			syncFail();
			
		}
		
		private function syncFail():void
		{
			/*var syncDto:SyncDTO 	= model.syncInfo.getContentByType( SyncInfo.PATIENT_DATA );
			syncDto.message			= "Patient data synchronization failed.";
			syncDto.showProgress 	= false;
			syncDto.status			= "fail";*/
			
			model.totalPatientsInDB = 0;
			if(null != func)
				func();
		}
	}
}