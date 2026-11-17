package com.gazuntite.provider.live.services.billing.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;
	
	public class LoadAllClaimbyProviderIdEvent extends CairngormEvent
	{
		
		public var pageNo 			: int;
		public var clinicBranchId 	: int;
		public var providerId 		: int;
		public var callBack			: Function;
		
		public function LoadAllClaimbyProviderIdEvent( providerId:int, clinicBranchId:int, pageNo:int, callback:Function = null )
		{
			super( BillingController.LOAD_ALL_CLAIM_BY_PROVIDER_ID_EVENT );
			this.clinicBranchId 	= clinicBranchId;
			this.pageNo 		    = pageNo;int
			this.providerId 		= providerId;int
			this.callBack 		    = callback;
		}
	}
}