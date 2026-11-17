package com.adobe.Quivus.events.security {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadClinicGeneralSettingMainEvent extends CairngormEvent {
		
		
		public function LoadClinicGeneralSettingMainEvent(  ) {
			super( AppController.LOAD_CLINIC_GENERAL_SETTING_MAIN_EVENT);
			
			
			}
		}
	}