package com.adobe.Quivus.events.staticData.comprehensiveHistory {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.FamilyHistoryTypeDTO;

	public class LoadFamilyDiseaseStaticDataEvent extends CairngormEvent {
		
		public var familyHistoryTypeDTO:FamilyHistoryTypeDTO;
		
		public function LoadFamilyDiseaseStaticDataEvent(familyHistoryTypeDTO:FamilyHistoryTypeDTO ) 
		{
			super( AppController.LOAD_FAMILY_DISEASE_STATIC_DATA_EVENT);
			this.familyHistoryTypeDTO = familyHistoryTypeDTO;
		}
	}
}
