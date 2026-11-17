package com.adobe.Quivus.events.staticData.followUp {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadInstructionAgeValueTypeEvent extends CairngormEvent {
		
		

		public function LoadInstructionAgeValueTypeEvent( ) {
			super( AppController.LOAD_INSTRUCTION_AGE_VALUE_TYPE_EVENT);
			
			}
		}
	}