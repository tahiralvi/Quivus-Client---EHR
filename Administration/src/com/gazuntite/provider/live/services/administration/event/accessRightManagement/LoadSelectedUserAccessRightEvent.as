package com.gazuntite.provider.live.services.administration.event.accessRightManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;
	
	public class LoadSelectedUserAccessRightEvent extends CairngormEvent
	{
		public var userTypeId 		: int;
		public var userId 		: int;
		
		
		public function LoadSelectedUserAccessRightEvent(userTypeId:int, userId:int)
		{
			super( AdminController.LOAD_SELECTED_USER_ACCESS_RIGHT_EVENT);
			
			this.userTypeId = userTypeId;
			this.userId = userId;
		}
	}
}