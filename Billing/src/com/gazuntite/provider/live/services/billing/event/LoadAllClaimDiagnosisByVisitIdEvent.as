package com.gazuntite.provider.live.services.billing.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;

	public class LoadAllClaimDiagnosisByVisitIdEvent extends CairngormEvent
	{
		public var visitId 			: int;
		public var callBack			: Function;
		
		public function LoadAllClaimDiagnosisByVisitIdEvent(visitId:int, callback:Function = null)
		{
			super( BillingController.LOAD_ALL_CLAIM_DIAGNOSIS_BY_VISIT_ID_EVENT );
			
			this.visitId 		= visitId;int
			this.callBack 		= callback;
		}
	}
}