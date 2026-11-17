package com.adobe.Quivus.command.staticData.patientsData
{
	import com.adobe.Quivus.delegate.staticData.patientsData.LoadCurrentDayAddedPatientsDelegate;
	import com.adobe.Quivus.events.staticData.patientsData.LoadCurrentDayAddedPatientsEvent;
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
	
	public class LoadCurrentDayAddedPatientsCommand  implements Command 
	{
		[Bindable] private var model : AppModelLocator = AppModelLocator.getInstance();
		private var delegate:LoadCurrentDayAddedPatientsDelegate;
		private var responder:Responder;
		private var func			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadCurrentDayAddedPatientsDelegate( responder );	
			
			if(model.UserLoggedIn)
			{
				var LE:LoadCurrentDayAddedPatientsEvent = cgEvent as LoadCurrentDayAddedPatientsEvent;
				
				if(LE.func != null)
					func = LE.func;
				var clinicBranchId:int = model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq;
				
				delegate.LoadCurrentDayAddedPatients(clinicBranchId, LE.pageNo);
			}
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			model.totalRecords_CDP = event.result.@['TotalRecord'];
			var xPatients:XML = event.result.Patients[0];
			model.currentDayPatientsList = new ArrayCollection();
			
			if(xPatients.Patient.length() >0)
			{
				for(var i:uint=0; i < xPatients.Patient.length(); i++)
				{
					var aPatient:XML = xPatients.Patient[i];
					var patientDto:PatientDTO  = new PatientDTO();
					patientDto.FromXML(aPatient);
					model.currentDayPatientsList.addItem(patientDto);
				}
				if(null != func)
					func();
			}
			
			
		}
		
		private function onError(event:FaultEvent):void
		{
			CursorManager.removeBusyCursor();
			model.errorStatus = "error in LoadCurrentDayAddedPatientsCommand";
			/*Alert.show(event.toString(),"LoadCurrentDayAddedPatientsCommand");*/
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, event.toString(), userId); 
			
		}
	}
}