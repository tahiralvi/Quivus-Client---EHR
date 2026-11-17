package com.adobe.Quivus.events.quickInput {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.RegistrationDTO;

	
	public class SaveTempQuickInputEvent extends CairngormEvent {
		
		public var fileName:String;

		public function SaveTempQuickInputEvent(fileName:String ) {
			super( AppController.SAVE_TEMP_QUICKINPUT_EVENT);
			 this.fileName = fileName;
			}
		}
	}