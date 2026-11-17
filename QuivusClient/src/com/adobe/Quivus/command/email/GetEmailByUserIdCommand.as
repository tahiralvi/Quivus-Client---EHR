package com.adobe.Quivus.command.email
{
	import com.adobe.Quivus.delegate.email.GetEmailByUserIdDelegate;
	import com.adobe.Quivus.events.email.GetEmailByUserIdEvent;
	import com.adobe.Quivus.model.AppModelLocator;
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

	
	public class GetEmailByUserIdCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		public var resultHandlerFunction:Function;
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : GetEmailByUserIdDelegate = new GetEmailByUserIdDelegate( this );
				var LE:GetEmailByUserIdEvent = cgEvent as GetEmailByUserIdEvent;
				this.resultHandlerFunction = LE.resultHandlerFunction;
				model.userEmail = "";
				if(LE.userId>0)
				{
					delegate.GetEmailByUserId(LE.userId,model.sessionDTO);
				}
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var emailResponse:EmailResponse = re.result as EmailResponse;
				
				if(emailResponse!=null)
				{
					if(emailResponse.ResponseStatus)
					{
						if(emailResponse.UserEmail!=null && emailResponse.UserEmail.length>0)
						{
							model.userEmail =  emailResponse.UserEmail;
							this.resultHandlerFunction( emailResponse.UserEmail );
						}
					}
					else
					{
						model.errorStatus = emailResponse.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(emailResponse.ResponseCode);
						if(valid)
						{
							//	Alert.show("GetEmailByUserId"+"\n"+emailResponse.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
						}
					}
				}
				else
				{
					Alert.show("GetEmailByUserId"+"\n"+Messages.SERVICE_DIDNOT_RESPOND ,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		private function clinicBranchLabel(item: Object): String
		{
		
			var clinicBranch:UserClinicBranchDTO = item as UserClinicBranchDTO;
			return clinicBranch.ClinicBranch.ClinicBranchName;
		
		}
		
		private function roleLabel(item: Object): String
		{
			
			var role:UserClinicRoleDTO = item as UserClinicRoleDTO;
			return role.UserTypeRole.UserTypeName;
			
		}
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in GetEmailByUserIdCommand.";
				//Alert.show("Fault occured in GetEmailByUserIdCommand.\n"+rpcEvent.toString());*/
			//}
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(rpcEvent.toString(),"Fault occured in GetEmailByUserIdCommand ","",model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert); */
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( "Fault occured in GetEmailByUserIdCommand", rpcEvent.toString(), userId); 
			
		}
	}
}