package com.adobe.Quivus.events.staticData.followUp {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadFollowUpMethodTypeEvent extends CairngormEvent {
		
		

		public function LoadFollowUpMethodTypeEvent( ) {
			super( AppController.LOAD_FOLLOW_UP_METHOD_TYPE_EVENT);
			
			}
		}
	}