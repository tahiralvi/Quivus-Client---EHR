package com.adobe.Quivus.command.authenticate
{
	import com.adobe.Quivus.delegate.authenticate.UpdateUserSessionStatusDelegate;
	import com.adobe.Quivus.events.authenticate.UpdateUserSessionStatusEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;
	
	import valueObjects.UserSessionDTO;

	public class UpdateUserSessionStatusCommand implements com.adobe.cairngorm.commands.Command, IResponder
	{
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			
			var delegate : UpdateUserSessionStatusDelegate = new UpdateUserSessionStatusDelegate( this );
			
			var LE:UpdateUserSessionStatusEvent = cgEvent as UpdateUserSessionStatusEvent;
			
			//delegate.UpdateUserSession(LE.sessionDTO);
			delegate.UpdateUserSessionRestService(LE.sessionDTO);
			
		}
		
		public function result( rpcEvent : Object ) : void 
		{
			
			var re:ResultEvent = rpcEvent as ResultEvent;
			
			var proxy:ObjectProxy = re.result as ObjectProxy;
			var res:UserSessionDTO = proxy.UserSessionDTO as UserSessionDTO;
			
		}
		
		
		public function fault( rpcEvent : Object ) : void 
		{
			//if(model.isUserManagerServiceOnline){
			model.errorStatus = "Fault occured in UpdateUserSessionCommand.";
			//Alert.show("Fault occured in UpdateUserSessionCommand.\n"+rpcEvent.toString());*/
			//}
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(rpcEvent.toString(),"Fault occured in UpdateUserSessionCommand ","",model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert); */
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( "Fault occured in UpdateUserSessionCommand", rpcEvent.toString(), userId); 
			
		}
	}
}