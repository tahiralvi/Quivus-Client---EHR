package com.adobe.Quivus.events.quickInput.soapNote
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.UserSessionDTO;
	
	public class GenerateSoapNoteByVisitIDEvent extends CairngormEvent
	{
		public var 	VisitID:int , 
					userSession:UserSessionDTO , 
					clinicbranchId:int , 
					stationIds:ArrayCollection, 
					isAllSelected:Boolean , 
					callback:Function = null ;
		
		public function GenerateSoapNoteByVisitIDEvent( VisitID:int , userSession:UserSessionDTO , clinicbranchId:int , stationIds:ArrayCollection, isAllSelected:Boolean , callback:Function = null )
		{
			super( AppController.LOAD_SOAP_NOTE_BY_VISIT_ID_EVENT);
			this.VisitID 				= VisitID; 
			this.userSession			= userSession; 
			this.clinicbranchId			= clinicbranchId
			this.stationIds				= stationIds
			this.isAllSelected			= isAllSelected
			this.callback				= callback ;
		}
	}
}