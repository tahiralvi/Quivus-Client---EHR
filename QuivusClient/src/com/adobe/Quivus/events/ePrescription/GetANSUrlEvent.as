package com.adobe.Quivus.events.ePrescription {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class GetANSUrlEvent extends CairngormEvent {
		
		public var practiceName:String;

		public function GetANSUrlEvent( practiceName:String ) {
			super( AppController.GET_ANS_URL_EVENT);
			this.practiceName = practiceName;
			}
		}
	}