package com.adobe.Quivus.events.staticData.followUp {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadInstructionAgeTypeEvent extends CairngormEvent {
		
		

		public function LoadInstructionAgeTypeEvent( ) {
			
			super( AppController.LOAD_INSTRUCTION_AGE_TYPE_EVENT);
			
			}
		}
	}