package com.adobe.Quivus.command.security
{
	import com.adobe.Quivus.delegate.security.LoadClinicGeneralSettingMainDelegate;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;
	
	import valueObjects.*;
	
	public class LoadClinicGeneralSettingMainCommand  implements com.adobe.cairngorm.commands.Command, IResponder
	{
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			
			var delegate : LoadClinicGeneralSettingMainDelegate = new LoadClinicGeneralSettingMainDelegate( this ); 
			delegate.LoadGeneralSetting(model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq);
		}
		
		public function result( rpcEvent : Object ) : void 
		{
			var re:ResultEvent = rpcEvent as ResultEvent;
			
			var op:ObjectProxy = re.result as ObjectProxy;
			
			var responce:ObjectProxy  =  op.GeneralSettingResponce ;
			
			if(responce!=null)
			{
				if(responce.ResponseStatus)
				{
					model.generalSetttingProxyObject = responce.GeneralSetting;
					
					//Tahir Alvi - Show Confidentiality Text @ login
					if(model.generalSetttingProxyObject.ConfidentialityNotificationRule && model.isUserLoginSuccessfully)
					{
						model.isConfidentialityNotificationRule = true;
						model.confidentialitText = model.generalSetttingProxyObject.ConfidentialityText;
					}

					if(model.generalSetttingProxyObject.SessionInActivityLockRule)
					{
						model.isSessionInActivityLockRule 	= true;
						model.isInActivityLockRuleEnable    = model.generalSetttingProxyObject.LockSessionAfter;
						//model.isSessionInActivityTime 		= model.generalSetttingProxyObject.LockSessionAfter;
					}
					else
					{
						model.isSessionInActivityLockRule 	= false;
						model.isSessionInActivityTime 		= model.generalSetttingProxyObject.LockSessionAfter;
					}
				}
			}
		}
		
		public function fault( rpcEvent : Object ) : void {
			model.errorStatus = "Fault occured in LoadUserAccessRightCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}