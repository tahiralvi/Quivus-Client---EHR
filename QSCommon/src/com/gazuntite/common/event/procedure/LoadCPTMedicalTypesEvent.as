package com.gazuntite.common.event.procedure
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.appController.QSCommonController;
	
	public class LoadCPTMedicalTypesEvent extends CairngormEvent 
	{	
		public var cptName:String;
		public var model:Object;
		public var func:Function;
		
		public function LoadCPTMedicalTypesEvent(_cptName:String, _model:Object, _func:Function = null) 
		{
			super(QSCommonController.LOAD_CPT_MEDICAL_TYPES_EVENT);
			this.cptName = _cptName;
			this.model = _model;
			this.func = _func;
		}
	}
}