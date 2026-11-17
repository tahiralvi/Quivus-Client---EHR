package com.gazuntite.common.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.appController.QSCommonController;
	
	public class LoadICDCodeEvent extends CairngormEvent
	{
		public var icdCode:String;
		public var func:Function;
		public var model:Object;
		
		public function LoadICDCodeEvent(icdCode:String, _model:Object,  _func:Function = null)
		{
			super (QSCommonController.LOAD_ICD_CODE_EVENT);
			
			this.icdCode = icdCode;
			this.model = _model;
			this.func = _func;
		}
	}
}