package com.gazuntite.provider.live.services.administration.command.generalSetting
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.provider.live.services.administration.delegate.generalSetting.ManageGeneralSettingDelegate;
	import com.gazuntite.provider.live.services.administration.event.generalSetting.ManageGeneralSettingEvent;
	import com.gazuntite.provider.live.services.administration.model.AdminAppModelLocator;
	import com.gazuntite.provider.live.services.administration.util.AdminConstant;
	import com.gazuntite.provider.live.services.administration.util.AdminUtils;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.CursorManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;

	public class ManageGeneralSettingCommand implements Command
	{
		private var model:AdminAppModelLocator = AdminAppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:ManageGeneralSettingDelegate;
		private var func:Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new ManageGeneralSettingDelegate( responder );			
			
			var LE:ManageGeneralSettingEvent = cgEvent as ManageGeneralSettingEvent;
			func = LE.func;
			
			var xml:XML = AdminUtils.ConvertToGeneralSettingXML(model.GeneralSetting);
			
			delegate.ManageGeneralSetting(xml);
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			var re:ResultEvent = event as ResultEvent;
			if(this.func != null)
			{
				this.func();
			}
			
			CursorManager.removeBusyCursor();
			Alert.show("General Setting Updated successfully.",  AdminConstant.INFO, 4, FlexGlobals.topLevelApplication.mainContainer);
		}
		
		private function onError(event:FaultEvent):void
		{
			var errorStatus:String = "Fault occured in ManageGeneralSettingCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserId )? -1:model.loggedInUserId;
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, event.toString(), userId); 
		}
	}
}