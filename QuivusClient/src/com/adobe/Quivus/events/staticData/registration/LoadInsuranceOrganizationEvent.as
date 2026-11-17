package com.adobe.Quivus.events.staticData.registration
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;
	
	public class LoadInsuranceOrganizationEvent extends CairngormEvent
	{
		public var dataToLoad:ArrayCollection;
		
		public function LoadInsuranceOrganizationEvent(dataToLoad:ArrayCollection)
		{
			super( AppController.LOAD_INSURANCE_ORGANIZATION_EVENT);
			this.dataToLoad = dataToLoad;
		}
	}
}