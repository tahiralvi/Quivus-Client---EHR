package com.adobe.Quivus.events.staticData.followUp {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadInstructionDurationTypeEvent extends CairngormEvent {
		
		

		public function LoadInstructionDurationTypeEvent( ) {
			super( AppController.LOAD_INSTRUCTION_DURATION_TYPE_EVENT);
			
			}
		}
	}