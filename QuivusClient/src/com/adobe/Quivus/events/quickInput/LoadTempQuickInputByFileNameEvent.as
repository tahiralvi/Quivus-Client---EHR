package com.adobe.Quivus.events.quickInput {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.RegistrationDTO;

	
	public class LoadTempQuickInputByFileNameEvent extends CairngormEvent {
		
		public var fileName:String;
		public var func:Function;

		public function LoadTempQuickInputByFileNameEvent(fileName:String,func:Function) {
			super( AppController.LOAD_TEMP_QUICKINPUT_BYFILENAME_EVENT);
			 this.fileName = fileName;
			 this.func = func;
			}
		}
	}