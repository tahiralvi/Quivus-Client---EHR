package com.gazuntite.common.event.compHistory
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.appController.QSCommonController;
	
	public class LoadAllBloodRelationShipTypeDTOEvent extends CairngormEvent
	{
		public var model:Object;
		
		public function LoadAllBloodRelationShipTypeDTOEvent(_model:Object)
		{
			super(QSCommonController.LOAD_ALL_BLOOD_RELATIONSHIP_TYPE_DTO_EVENT);
			
			this.model = _model;
		}
	}
}