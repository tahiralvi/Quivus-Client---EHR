package com.gazuntite.common.event.visit
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.appController.QSCommonController;

	public class CoSignVisitEvent extends CairngormEvent
	{
		public var visitId 						: int;
		public var LoggedInUserProviderId 		: int;
		public var LoggedInUserId 				: int;
		public var LoggedInUserProviderTypeId 	: int;
		public var functionName 				: Function;
		
		public function CoSignVisitEvent(_visitId : int, _LoggedInUserProviderId:int, _LoggedInUserId:int, _LoggedInUserProviderTypeId:int, _functionName 	: Function) 
		{
			super( QSCommonController.CO_SIGN_VISIT_EVENT);
			
			this.visitId 						= _visitId;
			this.LoggedInUserProviderId 		= _LoggedInUserProviderId;
			this.LoggedInUserId 				= _LoggedInUserId;
			this.LoggedInUserProviderTypeId 	= _LoggedInUserProviderTypeId;
			this.functionName 					= _functionName;
		}
	}
}