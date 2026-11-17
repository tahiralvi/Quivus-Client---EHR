package com.gazuntite.common.event.ccHpi
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.appController.QSCommonController;
	
	public class LoadAllHPIDetailTypesEvent extends CairngormEvent 
	{
		public var model:Object;
		
		public function LoadAllHPIDetailTypesEvent(_model:Object) 
		{
			super( QSCommonController.LOAD_ALL_HPI_DETAIL_TYPES_EVENT);
			
			model = _model;
		}
	}
}