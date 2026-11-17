package com.adobe.Quivus.events.registration
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;

	public class SavePatientImageEvent extends CairngormEvent 
	{
		public var functionName : Function;
		public var purpose		: String;
		
		public function SavePatientImageEvent(purpose : String,functionName : Function = null)
		{
			super( AppController.SAVE_PATIENT_IMAGE_EVENT);
			this.functionName = functionName;
			this.purpose = purpose;
		}
	}
}