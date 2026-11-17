package com.adobe.Quivus.events.quickInput {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.RegistrationDTO;

	
	public class VerifyTempQuickInputEvent extends CairngormEvent {
		
		public var fileName:String;
		public var func:Function;
		
		public function VerifyTempQuickInputEvent(fileName:String,func:Function ) {
			super( AppController.VERIFY_TEMP_QUICKINPUT_EVENT);
			 this.fileName = fileName;
			 this.func = func;
			}
		}
	}