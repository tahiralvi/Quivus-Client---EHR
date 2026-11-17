package com.gazuntite.common.event.labs
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.appController.QSCommonController;
	
	public class LoadLabTestTypeStaticDataEvent extends CairngormEvent
	{
		public var model:Object;
		
		public function LoadLabTestTypeStaticDataEvent(_model:Object)
		{
			super (QSCommonController.LOAD_LAB_TEST_TYPE_STATIC_DATA_EVENT);
			
			model = _model;
		}
	}
}