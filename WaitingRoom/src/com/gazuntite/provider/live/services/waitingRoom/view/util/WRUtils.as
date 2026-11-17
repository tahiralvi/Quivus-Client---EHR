package com.gazuntite.provider.live.services.waitingRoom.view.util
{
	import com.gazuntite.provider.live.services.waitingRoom.model.WRModelLocator;
	
	import mx.collections.ArrayCollection;

	public class WRUtils
	{
		
		[Bindable]
		private var model:WRModelLocator = WRModelLocator.getInstance();
		
		private var arr:Array;
		
		public function WRUtils()
		{
			arr = new Array();
		}
		
		//************************* Set next Action and status Action Handler **********************************************************************		
		public function getNextAction(currentStatus:String):Object
		{
			var obj:Object = new Object();
			
			switch(currentStatus)
			{
				case 'Scheduled':
					obj.ID = 2;
					obj.Name = 'Arrived';
					obj.NextAction = 'Room-In';
					break;
				case 'Arrived':
					obj.ID = 3;
					obj.Name = 'BeingSeen';
					obj.NextAction = 'Check-Out';
					break;
				case 'BeingSeen':
				case 'Being Seen':
					obj.ID = 7;
					obj.Name = 'Confirmed';
					obj.NextAction = 'Completed'; 
					break;
				case 'Confirmed':
					obj.ID = 1;
					obj.Name = 'Consultation Completed';
					obj.NextAction = '';
					break;
				default:
					break;
			}
			return obj;
		}
		
		//************* filter room on base of station id **********************
		public function getRoomsList(stationID:int):void
		{
			if(model.ClinicRoomList == null)
				return;
			
			if(model.SelectedRoomList)
			{
				model.SelectedRoomList.removeAll();
				model.SelectedRoomList = null;
			}
			model.SelectedRoomList = new ArrayCollection();
			
			if(model.ClinicRoomList.length > 0)
			{
				for(var i:uint =0; i< model.ClinicRoomList.length; i++)
				{
					if(String(stationID) == model.ClinicRoomList[i].Station)
					{
						model.SelectedRoomList.addItem(model.ClinicRoomList[i]);
					}
				}
			}
		}
	}
}