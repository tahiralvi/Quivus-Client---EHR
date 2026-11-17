package com.gazuntite.provider.eprescription.services.patient.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.eprescription.services.patient.appController.EPrescriptionController;
	
	public class GetSpecialityEvent extends CairngormEvent
	{
		
		public var resultHandlerFunction:Function;
		
		public function GetSpecialityEvent(resultHandlerFunction:Function)
		{
			super(EPrescriptionController.GET_SPECIALITY);
			this.resultHandlerFunction = resultHandlerFunction;			
		}
	}
}