package com.adobe.Quivus.command.ePrescription
{
	import com.adobe.Quivus.delegate.ePrescription.GetUrlForEditMedicationDelegate;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class GetUrlForEditMedicationCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				model.ePrescriptionANSURL = Constants.EMPTY_STRING;
				
				var delegate : GetUrlForEditMedicationDelegate = new GetUrlForEditMedicationDelegate( this );
				
				//var LE:GetANSUrlEvent = cgEvent as GetANSUrlEvent;
				
				delegate.GetUrlForEditMedication(model.loggedInUserDTO.UserId.toString(),model.loadedPatientId.toString(),
												model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchName,
												model.loggedInUserDTO.UserEmail,
												model.sessionDTO);
				
			}
			
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:UrlResponse = re.result as UrlResponse;
				
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						 model.ePrescriptionEditMedicationURL = resp.MedicationUrl;
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("GetUrlForEditMedication"+"\n"+resp.ResponseMessage,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("GetUrlForEditMedication"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in GetUrlForEditMedicationCommand.";
				//Alert.show("Fault occured in GetUrlForEditMedicationCommand.\n"+rpcEvent.toString());*/
			//}
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(rpcEvent.toString(),"Fault occured in GetUrlForEditMedicationCommand ","",model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert); */
				
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}