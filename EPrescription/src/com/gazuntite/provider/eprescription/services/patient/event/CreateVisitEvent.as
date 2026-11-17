package com.gazuntite.provider.eprescription.services.patient.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.eprescription.services.patient.appController.EPrescriptionController;
	

	public class CreateVisitEvent extends CairngormEvent
	{
		public var functionName : Function;
		
		public var userId		: String;
	
		public function CreateVisitEvent(userId : String, functionName : Function = null)
		{
			super( EPrescriptionController.CREATE_VISIT);
			this.functionName = functionName;
			this.userId = userId;
			
		}
	}
}