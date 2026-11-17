package com.gazuntite.provider.live.services.waitingRoom.dto
{
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class StaticDataDTO
	{
		private var m_acWaitingRoomAppoinments:ArrayCollection;
		private var m_acStationsByClinicIDList:ArrayCollection;
		
		public function StaticDataDTO()
		{
			m_acWaitingRoomAppoinments  = new ArrayCollection();
			
		}
		
		//  XML Parser Methods that parse service result and assign to appropiate DTO's
		public function FromXML( x:XML ):void
		{
			if( x.localName() == "Appointments")
			{	
				var xAppointmentList:XMLList = x.Appointment;
				if( xAppointmentList.length() > 0 )
				{
					WaitingRoomAppoinments.removeAll();
					for( var s:int = 0; s < xAppointmentList.length(); s++ )
					{
						var apponitmentDTO:AppointmentDTO = new AppointmentDTO();
						apponitmentDTO.FromXML( xAppointmentList[s] );
						WaitingRoomAppoinments.addItem( apponitmentDTO );
					}
				}
			}else if('Stations')
			{
				var xStationClinicIDList:XMLList = x.Station;
				if( xStationClinicIDList.length() > 0 )StationsByClinicIDList = new ArrayCollection();
				
				for( var n:int = 0; n < xStationClinicIDList.length(); n++ )
				{
					var aSationsList:StationsDTO = new StationsDTO();
					aSationsList.FromXML( xStationClinicIDList[n] );
					StationsByClinicIDList.addItem( aSationsList );
				}
			}
		}
		
		// ############################## Getter + Setter #####################################################		
		
		
		public function get WaitingRoomAppoinments():ArrayCollection
		{
			return m_acWaitingRoomAppoinments;
		}
		
		public function set WaitingRoomAppoinments(value:ArrayCollection):void
		{
			m_acWaitingRoomAppoinments = value;
		}

		public function get StationsByClinicIDList():ArrayCollection
		{
			return m_acStationsByClinicIDList;
		}

		public function set StationsByClinicIDList(value:ArrayCollection):void
		{
			m_acStationsByClinicIDList = value;
		}

		
	}
}