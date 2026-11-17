package com.gazuntite.common.event.immunization
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.appController.QSCommonController;
	
	import mx.collections.ArrayCollection;

	public class ManagePatientImmunizationEvent extends CairngormEvent
	{
		public var model:Object;
		public var callBack:Function;
		
		public function ManagePatientImmunizationEvent(_model:Object, _callBack:Function = null)
		{
			super(QSCommonController.MANAGE_PATIENT_IMMUNIZATION_EVENT);
			
			model = _model;
			callBack = _callBack;
		}
	}
}