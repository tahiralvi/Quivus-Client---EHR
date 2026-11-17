package com.gazuntite.provider.live.services.administration.event.userManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;

	/*import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;*/
	
	public class GetClinicUserDetailsEvent extends CairngormEvent
	{
		
		public var userId : int;
		public var branchId : int;
		public var resultHandlerFunction:Function;
		
		public function GetClinicUserDetailsEvent(userId : int,branchId:int ,resultHandlerFunction:Function)
		{
			super(AdminController.LOAD_USER_BASIC_INFO_EVENT);
			//super(AppController.LOAD_CLINIC_USER_BASIC_INFO);
			this.userId = userId;
			this.branchId = branchId;
			this.resultHandlerFunction = resultHandlerFunction;
		}
	}
}