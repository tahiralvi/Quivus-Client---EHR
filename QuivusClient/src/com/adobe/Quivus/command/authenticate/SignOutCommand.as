package com.adobe.Quivus.command.authenticate
{
	import com.adobe.Quivus.delegate.authenticate.SignOutDelegate;
	import com.adobe.Quivus.events.authenticate.SignOutEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.rpc.IResponder;
	
	public class SignOutCommand implements com.adobe.cairngorm.commands.Command, IResponder 
	{
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			
			//if(model.UserLoggedIn)
			{
				var delegate : SignOutDelegate = new SignOutDelegate( this );
				
				var LE:SignOutEvent = cgEvent as SignOutEvent;
				
				delegate.SignOut(LE.sessionDTO);
			}
		}
		
		public function result( rpcEvent : Object ) : void {
			if(model!=null && model.UserLoggedIn)
			{	
				
			}
		}
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in SignOutCommand.";
			//	Alert.show("Fault occured in SignOutCommand.\n"+rpcEvent.toString());*/
			//}
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(rpcEvent.toString(),"Fault occured in SignOutCommand ","",model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert); */
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( "Fault occured in SignOutCommand", rpcEvent.toString(), userId); 
				
		}
		
	}
	
}