package com.gazuntite.common.event.visit
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.appController.QSCommonController;

	public class SignVisitEvent extends CairngormEvent
	{
		public var visitId 							: int;
		public var LoggedInUserId 					: int;
		public var LoggedInUserProviderTypeId 		: int;
		public var LoggedInUserSessionID 			: String;
		
		public var functionName 	: Function;
		
		public function SignVisitEvent(_visitId:int, _LoggedInUserId:int, _LoggedInUserProviderTypeId:int, _LoggedInUserSessionID:String ,_functionName:Function) 
		{
			super( QSCommonController.SIGN_VISIT_EVENT);
			
			this.visitId 					= _visitId;
			this.LoggedInUserId 			= _LoggedInUserId;
			this.LoggedInUserProviderTypeId = _LoggedInUserProviderTypeId;
			this.LoggedInUserSessionID 		= _LoggedInUserSessionID;
			this.functionName 				= _functionName;
			
		}
	}
}