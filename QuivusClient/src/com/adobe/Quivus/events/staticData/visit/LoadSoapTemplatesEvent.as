package com.adobe.Quivus.events.staticData.visit {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;

	public class LoadSoapTemplatesEvent extends CairngormEvent {
		
		

		public function LoadSoapTemplatesEvent(  ) {
			super( AppController.LOAD_SOAP_TEMPLATES_EVENT);
			
			}
		}
	}