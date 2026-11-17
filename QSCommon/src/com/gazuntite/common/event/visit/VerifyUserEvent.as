package com.gazuntite.common.event.visit
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.appController.QSCommonController;

	public class VerifyUserEvent extends CairngormEvent
	{
		public var LoggedInUserId 				: int;
		public var LoggedInUserSessionID		: String;
		public var LoggedInUserProviderTypeId	: int;
		public var LoggedInUserProviderId		: int;
		public var password 					: String;
		public var visitId 						: int;
		
		public var functionName 				: Function;
		
		public var originName		:String; // calling function name ---- Constants.VIEW_BACKGROUND_MODULE_NAME
		public var actionName		:String; //
		
		public function VerifyUserEvent( _LoggedInUserId:int, _LoggedInUserSessionID:String, _LoggedInUserProviderTypeId:int, _LoggedInUserProviderId:int, _password:String, _visitId:int, _functionName:Function, _originName:String = null, _actionName:String = null ) 
		{
			super( QSCommonController.VERIFY_USER_EVENT);
			
			this.LoggedInUserId 			= _LoggedInUserId;
			this.LoggedInUserSessionID 		= _LoggedInUserSessionID;
			this.LoggedInUserProviderTypeId	= _LoggedInUserProviderTypeId;
			this.LoggedInUserProviderId		= _LoggedInUserProviderId;
			this.visitId 					= _visitId;
			this.password					= _password;
			this.functionName 				= _functionName;
			this.originName 				= _originName;
			this.actionName 				= _actionName;
		}
	}
}