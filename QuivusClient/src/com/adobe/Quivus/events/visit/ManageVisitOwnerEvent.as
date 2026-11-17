package com.adobe.Quivus.events.visit {
	
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;
	
	public class ManageVisitOwnerEvent extends CairngormEvent 
	{
		//{OwnerUserID}/{OwnerUserTypeID}/{VisitOwnerTypeID}/{VisitID}/{modified_by}
		public var OwnerUserID : String;
		public var OwnerUserTypeID : String;
		public var VisitOwnerTypeID : String;
		public var VisitID : String;
		public var modified_by : String;
		
		public var functionName 	: Function;
		
		public function ManageVisitOwnerEvent(_OwnerUserID : String, _OwnerUserTypeID:String, _VisitOwnerTypeID:String, _VisitID:String, _modified_by:String , _functionName : Function = null) 
		{
			super( AppController.MANAGE_VISIT_OWNER_EVENT);
			this.OwnerUserID 		= _OwnerUserID;
			this.OwnerUserTypeID 	= _OwnerUserTypeID;
			this.VisitOwnerTypeID 	= _VisitOwnerTypeID;
			this.VisitID 			= _VisitID;
			this.modified_by		= _modified_by;
			this.functionName 		= _functionName;
			
		}
	}
}