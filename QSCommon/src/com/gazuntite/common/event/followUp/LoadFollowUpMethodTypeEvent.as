package com.gazuntite.common.event.followUp
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.appController.QSCommonController;
	
	public class LoadFollowUpMethodTypeEvent extends CairngormEvent
	{
		public var model:Object;
		
		public function LoadFollowUpMethodTypeEvent(_model:Object)
		{
			super(QSCommonController.LOAD_FOLLOW_UP_METHOD_TYPE_EVENT);
			
			model = _model;
		}
	}
}