package com.adobe.Quivus.command.email
{
	import com.adobe.Quivus.delegate.email.SendEmailDelegate;
	import com.adobe.Quivus.events.email.SendEmailEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class SendEmailCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		public var functionName : Function;
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : SendEmailDelegate = new SendEmailDelegate( this );
				
				var LE:SendEmailEvent = cgEvent as SendEmailEvent;
				this.functionName = LE.functionName;
					
				var emailDTO:EmailDTO = new EmailDTO();
				emailDTO.AttachedFileName		= LE.attatchedFileName;
				emailDTO.Attachment 			= LE.attatchment;
				emailDTO.ClinicBranchID 		= model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq;
				emailDTO.Message 				= LE.message;
				emailDTO.RecipientEmail 		= LE.receiptEmail;
				emailDTO.Subject 				= LE.subject;
				emailDTO.UserId 				= model.loggedInUserDTO.UserId;
				
				delegate.SendEmail(emailDTO,model.sessionDTO);
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var res:int = re.result as int;
				if(res > 0)
				{
					Alert.show(Messages.EMAIL_SUCCESSFULL, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
				
				if(this.functionName!=null)
				{
					functionName();
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in SendEmailCommand.";
				//Alert.show("Fault occured in SendEmailCommand.\n"+rpcEvent.toString());*/
			//}
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(rpcEvent.toString(),"Fault occured in GetEmailByUserIdCommand ","",model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert); */
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( "Fault occured in SendEmailCommand", rpcEvent.toString(), userId); 
			
		}
	}
}