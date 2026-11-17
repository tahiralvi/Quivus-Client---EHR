package com.adobe.Quivus.command.viewBackground.vital
{
	import com.adobe.Quivus.delegate.viewBackground.vital.LoadPatientMostRecentVitalsDelegate;
	import com.adobe.Quivus.events.viewBackground.vital.LoadPatientMostRecentVitalsEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.common.util.exceptionAlert.QSExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class LoadPatientMostRecentVitalsCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadPatientMostRecentVitalsDelegate = new LoadPatientMostRecentVitalsDelegate( this );
				var LE:LoadPatientMostRecentVitalsEvent = cgEvent as LoadPatientMostRecentVitalsEvent;
				
				delegate.LoadPatientMostRecentVitals(model.loadedPatientId,model.sessionDTO);		
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var patientVitalResponse:PatientVitalResponse  = re.result as PatientVitalResponse ;
				if(patientVitalResponse!=null)
				{
					if(patientVitalResponse.ResponseStatus)
					{
						if(patientVitalResponse.ResponseRecentList!=null)
						{
							model.patientPreviousVitalsList = patientVitalResponse.ResponseRecentList;
							model.quickInputVitalsDataLoaded = true;
							
						}
						else
						{
							Alert.show("LoadPatientMostRecentVitals"+"\n"+Messages.NO_DATA_RETURNED_FROM_SERVICE, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
						}		
					}
					else
					{
						model.errorStatus = patientVitalResponse.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(patientVitalResponse.ResponseCode);
						if(valid)
							Alert.show("LoadPatientMostRecentVitals"+"\n"+patientVitalResponse.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadPatientMostRecentVitals"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadPatientMostRecentVitalsCommand.";
			//	Alert.show("Fault occured in LoadPatientMostRecentVitalsCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadPatientMostRecentVitalsCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}