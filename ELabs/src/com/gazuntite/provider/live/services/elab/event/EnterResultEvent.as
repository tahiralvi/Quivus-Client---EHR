package com.gazuntite.provider.live.services.elab.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.elab.appController.ELabsController;
	import com.gazuntite.provider.live.services.elab.dto.LabDTO;
	
	public class EnterResultEvent extends CairngormEvent
	{
		public var Lab:LabDTO;
		public var ResultRanage:String;
		public var callBack:Function;
		
		public function EnterResultEvent(lab:LabDTO, resultRanage:String, callBack:Function)
		{
			super(ELabsController.ENTER_LAB_RESULT, true, false);
			this.Lab = lab;
			this.ResultRanage = resultRanage;
			this.callBack = callBack;
		}
	}
}