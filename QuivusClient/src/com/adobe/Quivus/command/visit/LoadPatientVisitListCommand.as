package com.adobe.Quivus.command.visit
{
	import com.adobe.Quivus.delegate.visit.LoadPatientVisitListDelegate;
	import com.adobe.Quivus.events.visit.LoadPatientVisitListEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.common.util.exceptionAlert.QSExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class LoadPatientVisitListCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadPatientVisitListDelegate = new LoadPatientVisitListDelegate( this );
				var LE:LoadPatientVisitListEvent = cgEvent as LoadPatientVisitListEvent;
				
				var patientId:int = LE.patientId;
				var showAll:Boolean = LE.showAll;
				
				if(patientId>0)
				{
					delegate.LoadPatientVisitList(patientId,
												  model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq,
												  showAll,model.sessionDTO);
				}
			}
			
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var patientEncountersResponse:PatientEncountersResponse  = re.result as PatientEncountersResponse ;
				
				if(patientEncountersResponse.ResponseStatus)
				{
					if(patientEncountersResponse.EncounterResult!=null)
					{
						model.patientEncounterResult 	= patientEncountersResponse.EncounterResult;
						model.totalRecords_PE			= patientEncountersResponse.EncounterResult.TotalRecords;
						//Tahir Alvi - for associative combo's show 
						// add only those dates with un-signed visits.
						model.unSignedVisitDates        = new ArrayCollection();
						for(var i:uint = 0; i < model.totalRecords_PE; i++)
						{
							var patientEncounterDTO:PatientEncounterDTO = model.patientEncounterResult.PatientEncounterList[i] as PatientEncounterDTO; 
								if(patientEncounterDTO.VisitStatus == 'Un-Signed')
									model.unSignedVisitDates.addItem(patientEncounterDTO);
								else
									continue;
						}
					}
					else
					{
						Alert.show("LoadPatientVisitList"+"\n"+Messages.NO_DATA_RETURNED_FROM_SERVICE, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
							
				}
				else
				{
					model.errorStatus = patientEncountersResponse.ResponseMessage.toString() ;
					var valid:Boolean = QSUtilityFunctions.checkSession(patientEncountersResponse.ResponseCode);
					if(valid)
						Alert.show("LoadPatientVisitList"+"\n"+patientEncountersResponse.ResponseMessage.toString(), Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadPatientVisitListCommand.";
				//Alert.show("Fault occured in LoadPatientVisitListCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadPatientVisitListCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}