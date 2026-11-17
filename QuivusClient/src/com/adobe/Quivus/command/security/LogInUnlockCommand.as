package com.adobe.Quivus.command.security
{
	import com.adobe.Quivus.delegate.security.LogInUnlockDelegate;
	import com.adobe.Quivus.events.security.LogInUnlockEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.LoginDTO;
	import valueObjects.LoginResponse;
	
	public class LogInUnlockCommand implements Command, IResponder
	{
		[Bindable]
		private var model : AppModelLocator = AppModelLocator.getInstance();
		private var CE:LogInUnlockEvent
		public var callBack    : Function;
		
		public function execute(event:CairngormEvent):void
		{
			var delegate : LogInUnlockDelegate = new LogInUnlockDelegate( this );
			CE = event as LogInUnlockEvent;
			
			var username:String = CE.userName;
			var password:String = CE.passwd;
			if(username!=null && username.length>0 && password!=null && password.length>0)
			{
				this.callBack = CE.callBack;
				delegate.LogInUnlock(username, password, false);
			}
		}
		
		public function result(rpcEvent:Object):void
		{
			var re:ResultEvent = rpcEvent as ResultEvent;
			
			var loginResponceDTO:LoginResponse = re.result as LoginResponse;
			if(loginResponceDTO!=null)
			{
				if(loginResponceDTO.ResponseStatus && loginResponceDTO.ResponseData.isValidUser && !loginResponceDTO.ResponseData.isLocked)
				{
					var loginDTO:LoginDTO  = loginResponceDTO.ResponseData as LoginDTO;
					if(loginDTO!=null)
					{
						model.hideSessionInActivityWindow = true;
					}
				}
			}
			if(this.callBack  != null)
			{
				this.callBack();
			}
		}
		
		public function fault(rpcEvent:Object):void
		{
			model.errorStatus = "Fault occured in LogInUnlockCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
		}
	}
}