package com.gazuntite.provider.live.services.administration.event.userManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;

	/*import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;*/
	
	public class GetPharmacyEvent extends CairngormEvent
	{
		
		/*public var userId : int;
		public var branchId : int;*/
		
		public var pageNo : int = 0;
		public var npcid:String;
		public var pharmacyName:String;
		public var address:String;
		public var zipcode:String;
		public var state:String;
		public var city:String;
		public var serviceLevel:int;
		public var phone:String;
		public var status:String;
		
		
		
		public var resultHandlerFunction:Function;
		
		public function GetPharmacyEvent(pageNo:int, npcid:String, pharmacyName:String, address:String, zipcode:String, state:String, city:String, serviceLevel:int, phone:String, status:String, resultHandlerFunction:Function)
		{
			super(AdminController.LOAD_PHARMACY_INFO_EVENT);		
			
			this.pageNo 		= pageNo;
			this.npcid 			= npcid;
			this.pharmacyName 	= pharmacyName;
			this.address 		= address;
			this.zipcode 		= zipcode;
			this.state 			= state;
			this.city 			= city;
			this.serviceLevel 	= serviceLevel;
			this.phone			= phone;
			this.status 		= status;
			
			this.resultHandlerFunction = resultHandlerFunction;
		}
	}
}