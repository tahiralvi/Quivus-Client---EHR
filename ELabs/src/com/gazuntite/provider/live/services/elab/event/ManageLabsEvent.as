package com.gazuntite.provider.live.services.elab.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.elab.appController.ELabsController;
	import com.gazuntite.provider.live.services.elab.dto.LabDTO;
	
	public class ManageLabsEvent extends CairngormEvent
	{
		public var Lab:LabDTO;
		
		public function ManageLabsEvent(lab:LabDTO)
		{
			super(ELabsController.Manage_ELabs, true, false);
			this.Lab = lab;
		}
	}
}