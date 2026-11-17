package com.gazuntite.provider.live.services.billing.event.accountsAndReceiveables
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;

	public class LoadPatientStatementEvent extends CairngormEvent
	{
		public var searchType 		    : int;
		public var searchString 		: String;
		public var clinicBranchId 		: int;
		public var pageNo		 		: int;
		public var callBack				: Function;
		
		public function LoadPatientStatementEvent(searchType:int, searchString:String, clinicBranchId:int, pageNo:int, callBack:Function = null)
		{
			super(BillingController.LOAD_PATIENT_STATEMENT_EVENT);
			
			this.searchType			=	searchType;
			this.searchString		=	searchString;
			this.clinicBranchId		=	clinicBranchId;
			this.pageNo				=	pageNo;
			this.callBack			=	callBack;
		}
	}
}