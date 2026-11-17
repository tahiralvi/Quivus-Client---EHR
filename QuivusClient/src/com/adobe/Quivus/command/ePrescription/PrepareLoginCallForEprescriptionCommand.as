package com.adobe.Quivus.command.ePrescription
{
	import com.adobe.Quivus.delegate.ePrescription.PrepareLoginCallForEprescriptionDelegate;
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

	
	public class PrepareLoginCallForEprescriptionCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				model.ePrescriptionURL = Constants.EMPTY_STRING;
				
				var delegate : PrepareLoginCallForEprescriptionDelegate = new PrepareLoginCallForEprescriptionDelegate( this );
				
				var id:String = model.loggedInUserDTO.UserId.toString();
				delegate.PrepareLoginCallForEprescription(id,model.loadedPatientId,model.sessionDTO);
				
			}
			
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:LoginCallResponse = re.result as LoginCallResponse;
				
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						 model.ePrescriptionURL = resp.ResponseData;
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("PrepareLoginCallForEprescription"+"\n"+resp.ResponseMessage,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("PrepareLoginCallForEprescription"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in PrepareLoginCallForEprescriptionCommand.";
			//Alert.show("Fault occured in PrepareLoginCallForEprescriptionCommand.\n"+rpcEvent.toString());*/
			//}
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(rpcEvent.toString(),"Fault occured in PrepareLoginCallForEprescriptionCommand ","",model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert);*/ 
				
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}