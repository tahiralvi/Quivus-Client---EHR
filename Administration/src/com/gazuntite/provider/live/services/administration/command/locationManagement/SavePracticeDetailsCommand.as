package com.gazuntite.provider.live.services.administration.command.locationManagement
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.provider.live.services.administration.delegate.locationManagement.SavePracticeDetailsDelegate;
	import com.gazuntite.provider.live.services.administration.dto.locationManagement.ClinicRoomDTO;
	import com.gazuntite.provider.live.services.administration.event.locationManagement.SavePracticeDetailsEvent;
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
	
	public class SavePracticeDetailsCommand implements Command
	{
		private var model:AdminAppModelLocator = AdminAppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:SavePracticeDetailsDelegate;
		private var func:Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new SavePracticeDetailsDelegate( responder );	
			
			var LE:SavePracticeDetailsEvent = cgEvent as SavePracticeDetailsEvent;
			this.func = LE.func;
			
			var xml:XML = AdminUtils.ConvertToPrescribeXML(model.practiceDetailProxyObj);
			delegate.SavePracticeDetails(xml);
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			var result:String = event.result.boolean;
			CursorManager.removeBusyCursor();
			
			if(result == 'true')
			{
				Alert.show('Practice details are saved successfully.', AdminConstant.INFO,  4, FlexGlobals.topLevelApplication.mainContainer);
				
				if(this.func != null)
				{
					this.func();
				}
			}
		}
		
		private function onError(event:FaultEvent):void
		{
			CursorManager.removeBusyCursor();
			var errorStatus:String = "Fault occured in SavePracticeDetailsCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserId )? -1:model.loggedInUserId;
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, event.toString(), userId);
		}
	}
}