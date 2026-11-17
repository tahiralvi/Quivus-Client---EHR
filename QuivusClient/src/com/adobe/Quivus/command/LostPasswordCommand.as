package com.adobe.Quivus.command
{
	
	import com.adobe.Quivus.delegate.authenticate.LostPasswordDelegate;
	import com.adobe.Quivus.events.authenticate.LostPasswordEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.controls.custom.calendar.views.NullCalendarDescriptor;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.XMLListCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class LostPasswordCommand implements Command
	{
		
		private var model   : AppModelLocator = AppModelLocator.getInstance();
		private var func    :  Function ;
		private var userName: String;
		
		private var responder:Responder;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);
			var delegate :LostPasswordDelegate  = new LostPasswordDelegate (responder);
			var LE:LostPasswordEvent = cgEvent as LostPasswordEvent ;
			
			if(LE.email.length > 0)
			{
				this.func = LE.func;
				this.userName =LE.email
				//Tahir - clear Message
				model.lostPasswordResult = 'false';
				model.errorMessageResult = '';
				delegate.LostPassword(LE.email);
			}
			
		}
		private function  onSuccess(event:ResultEvent): void 
		{
			var xml:XML = event.result as XML ;	
			
			if(xml.ResponseData[0] != null)
			{
				model.lostPasswordResult =  xml.ResponseData[0].isUpdated;
				model.lostPasswordIsLockedResult=xml.ResponseData[0].isLocked;
				model.lostPasswordIsActiveResult=xml.ResponseData[0].isActive;
				model.lostPasswordIsValidResult=xml.ResponseData[0].isValid;
			}else
			{
				model.errorMessageResult = xml.@Message;
			}
			
			if(this.func != null)
			{
				this.func () ;
			}
		}
		
		private function  onError(event:FaultEvent): void 
		{
			model.errorStatus = "Received In LostPasswordCommand";
			//Alert.show(event.toString(), "Received In LostPasswordCommand");
			
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, event.toString(), userId); 
			
		}
	}
}