package com.gazuntite.provider.live.services.billing.event.ClaimManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;

	public class ChangeClaimStatusEvent extends CairngormEvent
	{
		public var IDsXml:XML;		
		public var statusTypeIdFrom:int;
		public var statusTypeIdTo:int;
		public var mediaTypeIdFrom:int;
		public var mediaTypeIdTo:int;
		public var insuranceTypeId:int;
		public var managedByUserId:int;
		public var callBack:Function;
		
		public function ChangeClaimStatusEvent(IDsXml:XML, statusTypeIdFrom:int, statusTypeIdTo:int, mediaTypeIdFrom:int, mediaTypeIdTo:int, insuranceTypeId:int, managedByUserId:int, callBack:Function = null)
		{
			super(BillingController.CHANGE_CLAIM_STATUS_EVENT);
			
			this.IDsXml = IDsXml;
			this.statusTypeIdFrom = statusTypeIdFrom;
			this.statusTypeIdTo = statusTypeIdTo;
			this.mediaTypeIdFrom = mediaTypeIdFrom;
			this.mediaTypeIdTo = mediaTypeIdTo;
			this.insuranceTypeId = insuranceTypeId;
			this.managedByUserId = managedByUserId;
			this.callBack = callBack;
			
		}
	}
}