package com.gazuntite.provider.live.services.administration.event.userManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;

	public class ManageProviderInsuranceEvent extends CairngormEvent
	{
		public var xmlData   :	XML;
		public var callBack	 :  Function;
		
		public function ManageProviderInsuranceEvent(xmlData:XML, callBack:Function = null)
		{
			super(AdminController.MANAGE_PROVIDER_INSURANCE_EVENT);
			
			this.xmlData   = xmlData;
			this.callBack  = callBack;
		}
	}
}