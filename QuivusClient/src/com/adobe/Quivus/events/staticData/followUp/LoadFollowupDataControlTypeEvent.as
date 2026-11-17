package com.adobe.Quivus.events.staticData.followUp {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadFollowupDataControlTypeEvent extends CairngormEvent {
		
		

		public function LoadFollowupDataControlTypeEvent( ) {
			super( AppController.LOAD_FOLLOW_UP_DATE_CONTROL_TYPE_EVENT);
			
			}
		}
	}