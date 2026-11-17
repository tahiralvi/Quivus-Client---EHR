package com.gazuntite.common.event.labs
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.appController.QSCommonController;
	
	public class LoadLIONICLabTestTypeEvent extends CairngormEvent
	{
		public var labTestCodeOrName:String;
		public var labtestTypeID:int;
		public var model:Object;
		
		public function LoadLIONICLabTestTypeEvent(_labTestCodeOrName:String, _labtestTypeID:int, _model:Object)
		{
			super (QSCommonController.LOAD_LIONIC_LAB_TEST_TYPE_EVENT);
			
			this.labTestCodeOrName = _labTestCodeOrName;
			this.labtestTypeID = _labtestTypeID;
			this.model = _model;
		}
	}
}