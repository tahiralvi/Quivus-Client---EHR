package com.gazuntite.provider.live.services.administration.command.userManagement
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.delegate.userManagement.LoadAllUserTypeDelegate;
	import com.gazuntite.provider.live.services.administration.event.userManagement.LoadAllUserTypeEvent;
	import com.gazuntite.provider.live.services.administration.model.AdminAppModelLocator;
	import com.gazuntite.provider.live.services.administration.util.AdminConstant;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;
	
	public class LoadAllUserTypeCommand implements Command
	{
		private var model : AdminAppModelLocator = AdminAppModelLocator.getInstance();
		private var responder:Responder;
		private var delegate:LoadAllUserTypeDelegate;
		private var LE:LoadAllUserTypeEvent;
		
		public function execute(event:CairngormEvent):void
		{
			responder = new Responder(result, fault);				
			delegate  = new LoadAllUserTypeDelegate( responder );			
			
			var LE:LoadAllUserTypeEvent = event as LoadAllUserTypeEvent;
			delegate.LoadAllUserType();
		}
		
		private function result( event : ResultEvent ) : void 
		{
			var re:ResultEvent = event as ResultEvent;
			
			var op:ObjectProxy = (re.result as ObjectProxy);
			if(op!=null)
			{
				if(op.ArrayOfUserTypeDTO)
				{
					model.userTypeList = op.ArrayOfUserTypeDTO.UserTypeDTO; 
				}
			}
		}
		
		private function fault( rpcEvent : FaultEvent ) : void 
		{
			Alert.show("Fault occured in LoadAllUserTypeCommand.\n"+rpcEvent.toString(), AdminConstant.ERROR, 4, FlexGlobals.topLevelApplication.mainContainer );
		}
	}
}