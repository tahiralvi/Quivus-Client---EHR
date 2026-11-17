package com.gazuntite.provider.live.services.administration.event.userManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;

	public class GetProviderInsuranceEvent extends CairngormEvent
	{
		public var userId			: int;
		public var clinicBranchId	: int;
		public var callBack			: Function;
		
		public function GetProviderInsuranceEvent(userId: int, clinicBranchId: int, callBack:Function = null)
		{
			super(AdminController.GET_PROVIDER_INSURANCE_EVENT);
			
			this.userId 			= userId;
			this.clinicBranchId 	= clinicBranchId;
			this.callBack			= callBack;
		}
	}
}