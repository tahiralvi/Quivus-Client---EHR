package com.adobe.Quivus.events.visit {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.PageDTO;
	import valueObjects.RegistrationDTO;

	public class LoadPatientVisitsByProviderIDEvent extends CairngormEvent {
		
		public var Page : PageDTO;
		public var strUserId : String;
		public var strclinicBranchId : String;
		public var strshowAll : String;

		public function LoadPatientVisitsByProviderIDEvent(_Page:PageDTO, _strUserId : String, _strclinicBranchId : String, _strshowAll : String) 
		{
			super( AppController.LOAD_PATIENT_VISITS_BY_PROVIDER_ID_EVENT);
			this.Page 				= _Page;
			this.strUserId 			= _strUserId;
			this.strclinicBranchId 	= _strclinicBranchId;
			this.strshowAll 		= _strshowAll;
			
			}
		}
	}