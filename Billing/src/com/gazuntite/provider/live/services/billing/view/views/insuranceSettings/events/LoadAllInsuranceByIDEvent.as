package com.gazuntite.provider.live.services.billing.view.views.insuranceSettings.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;
	
	public class LoadAllInsuranceByIDEvent extends CairngormEvent
	{
		public var index	:	int 		;
		public var SearchString		: 	String 		;
		public var callbackFunction :	Function	;
		public var pageNumber		:	int			;
		
		
		public function LoadAllInsuranceByIDEvent(index:int,SearchString:String,pageNumber:int,callbackFunction:Function)
		{
			super(BillingController.LOAD_ALL_INSURANCE_BY_ID_EVENT);
			this.index				= 	index		;
			this.SearchString		= 	SearchString		;
			this.pageNumber			=	pageNumber			;
			this.callbackFunction	=	callbackFunction	;
				
		}
	}
}