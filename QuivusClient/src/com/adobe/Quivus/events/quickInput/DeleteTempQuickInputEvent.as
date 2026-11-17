package com.adobe.Quivus.events.quickInput {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.RegistrationDTO;

	
	public class DeleteTempQuickInputEvent extends CairngormEvent {
		
		public var fileName:String;

		public function DeleteTempQuickInputEvent(fileName:String ) {
			super( AppController.DELETE_TEMP_QUICKINPUT_EVENT);
			 this.fileName = fileName;
			}
		}
	}