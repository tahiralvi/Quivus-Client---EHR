package com.adobe.Quivus.events.patientProfileCustomization {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadPatientProfileCustomizedSettingEvent extends CairngormEvent {
		
		public var patientId 			: int;
		public var overrideTemp			: Boolean;
		
		public function LoadPatientProfileCustomizedSettingEvent( patientId : int ,overrideTemp	: Boolean) {
			super( AppController.LOAD_PATIENT_PROFILE_CUSTOMIZED_SETTING_EVENT);
			this.patientId 		= patientId;
			this.overrideTemp	= overrideTemp
		}
	
	}
}