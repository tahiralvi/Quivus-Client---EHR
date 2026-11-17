package com.gazuntite.provider.live.services.billing.event.ClaimManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;

	public class ManageClaimCarrierEvent extends CairngormEvent
	{
		public var claimCarrier:XML;
		public var claimNote:String;
		public var saveCarriers:String;
		public var callBack:Function;
		
		public function ManageClaimCarrierEvent(claimCarrier:XML,claimNote:String = "0", saveCarriers:String = "true",  callBack:Function = null)
		{
			super( BillingController.MANAGE_CLAIM_CARRIER_EVENT );
			
			this.claimCarrier  = claimCarrier;XML
			this.claimNote = claimNote;
			this.saveCarriers = saveCarriers;
			this.callBack        = callBack
		}
	}
}