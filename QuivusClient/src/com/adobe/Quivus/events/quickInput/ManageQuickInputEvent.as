package com.adobe.Quivus.events.quickInput {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.RegistrationDTO;

	
	public class ManageQuickInputEvent extends CairngormEvent {
		
		public var clearQuickInput:Boolean;
		public var functionName : Function;
		
		//Mansoor
		//public var tabToSave : String;
		
		public function ManageQuickInputEvent( clearQuickInput:Boolean, functionName:Function=null) {
			super( AppController.MANAGE_QUICK_INPUT_EVENT);
			 this.clearQuickInput = clearQuickInput;
			 this.functionName = functionName;
			 
			 //this.tabToSave = tabToSave;
			}
		}
	}