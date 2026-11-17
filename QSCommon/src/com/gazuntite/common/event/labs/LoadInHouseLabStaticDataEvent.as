package com.gazuntite.common.event.labs
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.appController.QSCommonController;
	
	public class LoadInHouseLabStaticDataEvent extends CairngormEvent
	{
		public var searchValue:String ;
		public var model:Object;
		public var func:Function;
		
		public function LoadInHouseLabStaticDataEvent(_searchTerm:String, _model:Object, _func:Function = null)
		{
			super (QSCommonController.LOAD_IN_HOUSE_LAB_STATIC_DATA_EVENT);
			
			searchValue = _searchTerm ;
			model = _model;
			func = _func;
		}
	}
}