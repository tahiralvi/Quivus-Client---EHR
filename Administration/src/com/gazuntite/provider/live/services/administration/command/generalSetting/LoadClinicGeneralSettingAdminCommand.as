package com.gazuntite.provider.live.services.administration.command.generalSetting
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.provider.live.services.administration.delegate.generalSetting.LoadGeneralSettingDelegate;
	import com.gazuntite.provider.live.services.administration.model.AdminAppModelLocator;
	import com.gazuntite.provider.live.services.administration.util.AdminConstant;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.CursorManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;

	public class LoadClinicGeneralSettingAdminCommand implements Command
	{
		private var model:AdminAppModelLocator = AdminAppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadGeneralSettingDelegate;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadGeneralSettingDelegate( responder );			
			
			delegate.LoadGeneralSetting(model.loggedInUserSelectedBranchId);
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			var re:ResultEvent = event as ResultEvent;
			var op:ObjectProxy = (re.result as ObjectProxy);
			var responce:ObjectProxy  =  op.GeneralSettingResponce ;
			
			if(responce!=null)
			{
				if(responce.ResponseStatus)
				{
					model.GeneralSetting = responce.GeneralSetting;
				}
				else
				{
					Alert.show("LoadGeneralSetting"+"\n"+responce.ResponseMessage, AdminConstant.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
			CursorManager.removeBusyCursor();
		}
		
		private function onError(event:FaultEvent):void
		{
			CursorManager.removeBusyCursor();
			//Alert.show("Received In LoadGeneralSettingCommand.\n" + event.toString(), AdminConstant.ERROR, 4, FlexGlobals.topLevelApplication.mainContainer );
			var errorStatus:String = "Fault occured in LoadGeneralSettingCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserId )? -1:model.loggedInUserId;
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, event.toString(), userId);
		}
	}
}