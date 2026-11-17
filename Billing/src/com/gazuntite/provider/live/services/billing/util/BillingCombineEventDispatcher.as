package com.gazuntite.provider.live.services.billing.util
{
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;

	public class BillingCombineEventDispatcher
	{
		public function BillingCombineEventDispatcher()
		{
		}
		
		
		public static function LoadDMStaticData():void
		{
			
			var model : BillingModelLocator = BillingModelLocator.getInstance();
			
			/*if(model.LabOrdersListDto == null)
			{
				var eve:LoadDocumentTypeStaticDataEvent = new LoadDocumentTypeStaticDataEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( eve );
				
			}*/
			
		}
			
		
		/*public static function LoadLabOrdersByClinicList(pageNo:int):void
		{
			var ll:sear = new LoadPatientLabOrdersByClinicIdEvent( pageNo );
			CairngormEventDispatcher.getInstance().dispatchEvent( ll );
		}*/
		
	}
}