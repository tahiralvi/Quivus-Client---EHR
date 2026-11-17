package com.gazuntite.provider.live.services.administration.command.userManagement
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.delegate.userManagement.SaveGaxenIdDelegate;
	import com.gazuntite.provider.live.services.administration.event.userManagement.SaveGaxenIdEvent;
	import com.gazuntite.provider.live.services.administration.model.AdminAppModelLocator;
	import com.gazuntite.provider.live.services.administration.util.AdminConstant;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.ResultEvent;
	
	public class SaveGaxenIdCommand  implements com.adobe.cairngorm.commands.Command, IResponder
	{
		private var model : AdminAppModelLocator = AdminAppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:SaveGaxenIdDelegate;
		private var LE:SaveGaxenIdEvent;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(result, fault);				
			delegate  = new SaveGaxenIdDelegate( responder );			
			
			var LE:SaveGaxenIdEvent = cgEvent as SaveGaxenIdEvent;
			
			var d:Date = new Date();
			delegate.SaveGaxenId(LE.userId, LE.gaxenId, d);
		}
		
		public function result( rpcEvent : Object ) : void 
		{
			
		}
		
		public function fault( rpcEvent : Object ) : void 
		{
			Alert.show("Fault occured in SaveGaxenIdCommand.\n"+rpcEvent.toString(), AdminConstant.ERROR, 4, FlexGlobals.topLevelApplication.mainContainer );
			
		}
	}
}