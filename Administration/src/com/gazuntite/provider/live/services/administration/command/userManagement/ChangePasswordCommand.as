package com.gazuntite.provider.live.services.administration.command.userManagement
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.delegate.userManagement.ChangePasswordDelegate;
	import com.gazuntite.provider.live.services.administration.event.userManagement.ChangePasswordEvent;
	import com.gazuntite.provider.live.services.administration.model.AdminAppModelLocator;
	import com.gazuntite.provider.live.services.administration.util.AdminConstant;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;
	
	public class ChangePasswordCommand  implements Command 
	{
		private var model : AdminAppModelLocator = AdminAppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:ChangePasswordDelegate;
		private var LE:ChangePasswordEvent;
		
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(result, fault);				
			delegate  = new ChangePasswordDelegate( responder );			
			
			var LE:ChangePasswordEvent = cgEvent as ChangePasswordEvent;
			
			callBack = LE.resultHandlerFunction;
			
			var d:Date = new Date();
			delegate.ChangePassword(LE.data);
		}
		
		
		public function result( rpcEvent : ResultEvent ) : void 
		{
			var re:ResultEvent = rpcEvent as ResultEvent;
			var result:ObjectProxy = re.result as ObjectProxy;
			
			if(result!=null)
			{
				model.securityProxyObject = result.UserPasswordChangedDTO;
			}
			
			if(model.securityProxyObject.isPasswordChanged && model.securityProxyObject.ValidationType =='Validated')
			{
				Alert.show('Password changed successfully' ,AdminConstant.INFO, 4, FlexGlobals.topLevelApplication.mainContainer);
			}
			else //if(model.securityProxyObject.ValidationType =='InValidAt8')
			{
				Alert.show(model.securityProxyObject.PasswordValidationError,AdminConstant.ERROR, 4, FlexGlobals.topLevelApplication.mainContainer);
			}
			
			
			if( null != callBack )
			callBack(new XML(rpcEvent.message.body.toString()));
		}
		
		public function fault( rpcEvent : Object ) : void
		{
			Alert.show("Fault occured in ChangePasswordCommand.\n"+rpcEvent.toString(), AdminConstant.ERROR, 4, FlexGlobals.topLevelApplication.mainContainer);
		}
	}
}