package com.gazuntite.provider.live.services.billing.event.ClaimManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;
	

	public class LoadClaimByCriteriaEvent extends CairngormEvent
	{
		public var searchDetail 	: XML;
		public var callBack			: Function;
		
		public function LoadClaimByCriteriaEvent(searchDetail: XML, callBack: Function = null )
		{
			super(BillingController.LOAD_CLAIM_BY_CRITERIA_EVENT);
			
			this.searchDetail = searchDetail;
			this.callBack     = callBack;
		}
	}
}