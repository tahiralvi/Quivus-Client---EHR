package com.adobe.Quivus.events.quickInput.soapNote
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.UserSessionDTO;

	public class GenerateSoapNotePreviewMainEvent extends CairngormEvent
	{
		public var 	VisitID:int, 
					userSession:UserSessionDTO, 
					clinicbranchId:int, 
					stationIds:ArrayCollection, 
					isAllSelected:Boolean,
					isPatientMale:Boolean,
					isTemp:Boolean,
					callback:Function = null ;
		
		public function GenerateSoapNotePreviewMainEvent( VisitID:int, userSession:UserSessionDTO, clinicbranchId:int, 
													  stationIds:ArrayCollection, isAllSelected:Boolean, 
													  isPatientMale:Boolean, isTemp:Boolean, callback:Function = null )
		{
			super( AppController.GENERATE_SOAP_NOTE_PREVIEW_MAIN_EVENT );
			this.VisitID 				= VisitID; 
			this.userSession			= userSession; 
			this.clinicbranchId			= clinicbranchId;
			this.stationIds				= stationIds;
			this.isAllSelected			= isAllSelected;
			this.isTemp					= isTemp;
			this.callback				= callback ;
		}
	}
}