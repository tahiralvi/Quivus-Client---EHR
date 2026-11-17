package com.gazuntite.common.event.ccHpi
{	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.appController.QSCommonController;
	import com.gazuntite.common.util.QSAppUtils;
	
	public class LoadHPIStaticDataEvent extends CairngormEvent 
	{
		public var sectionId:int;
		public var sectionName:String;
		public var searchString:String;
		public var model:Object;
		
		public function LoadHPIStaticDataEvent(sectionName:String, searchString:String, _model:Object) 
		{
			super (QSCommonController.LOAD_HPI_STATIC_DATA_EVENT);
			this.sectionId = QSAppUtils.getHPIDetailTypeIdByName(sectionName, _model);
			this.sectionName = sectionName;
			this.searchString = searchString;
			this.model = _model;
		}
	}
}