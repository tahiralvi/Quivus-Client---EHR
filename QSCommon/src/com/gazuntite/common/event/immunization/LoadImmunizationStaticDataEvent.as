package com.gazuntite.common.event.immunization
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.appController.QSCommonController;
	
	public class LoadImmunizationStaticDataEvent extends CairngormEvent
	{
		public var searchCritera:String;
		public var subSectionName:String;
		public var moduleName:String;
		public var model:Object;
		public function LoadImmunizationStaticDataEvent(searchCritera_arg:String, subSectionName_arg:String, moduleName_arg:String, model_arg:Object)
		{
			super(QSCommonController.LOAD_IMMUNIZATION_STATIC_DATA);
			
			this.searchCritera = searchCritera_arg;
			this.subSectionName = subSectionName_arg;
			this.moduleName = moduleName_arg;
			this.model = model_arg;
		}
	}
}