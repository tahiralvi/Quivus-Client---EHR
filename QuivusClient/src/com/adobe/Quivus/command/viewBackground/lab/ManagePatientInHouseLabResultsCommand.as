package com.adobe.Quivus.command.viewBackground.lab
{
	import com.adobe.Quivus.delegate.viewBackground.lab.ManagePatientInHouseLabResultsDelegate;
	import com.adobe.Quivus.events.viewBackground.lab.ManagePatientInHouseLabResultsEvent;
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

	
	public class ManagePatientInHouseLabResultsCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : ManagePatientInHouseLabResultsDelegate = new ManagePatientInHouseLabResultsDelegate( this );
				
				var LE:ManagePatientInHouseLabResultsEvent = cgEvent as ManagePatientInHouseLabResultsEvent;
				
				delegate.ManagePatientInHouseLabResults(LE.patientInHouseLabTestID,
														LE.testResult,
														LE.resultAttachment,
														model.loggedInUserDTO.UserId,
														new Date(),
														model.sessionDTO);
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:PatientInHouseLabResponse  = re.result as PatientInHouseLabResponse ;
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
							
					}
					else
					{
						model.errorStatus = resp.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						
						/*if(valid)
							Alert.show("ManagePatientInHouseLabResults"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);*/
					}
				}
				else
				{
					Alert.show("ManagePatientInHouseLabResults"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in ManagePatientInHouseLabResultsCommand.";
			//	Alert.show("Fault occured in ManagePatientInHouseLabResultsCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in ManagePatientInHouseLabResultsCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}