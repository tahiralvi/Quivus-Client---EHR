package com.gazuntite.provider.live.services.waitingRoom.dto
{
	import com.gazuntite.provider.live.services.waitingRoom.util.WRXmlConstants;
	import com.gazuntite.provider.live.services.waitingRoom.util.WRXmlUtils;

	[Bindable]
	public class RoomDTO
	{
		private var m_sID:String;
		private var m_sStation:String;
		private var m_sTitle:String;
		
		public function FromXML( x:XML ):void
		{
			ID            = x.@[WRXmlConstants.ID];
			Station       = x.@[WRXmlConstants.STATION];
			Title         = x.@[WRXmlConstants.TITLE];
		}    
		
		public function ToXML(data:Object):XML
		{
			var xml:XML = WRXmlUtils.getNodeByTagName( "Room" );
			xml.@[WRXmlConstants.ID]					= data.Room.ID;
			xml.@[WRXmlConstants.FIRSTNAME]			= data.Room.Station;
			xml.@[WRXmlConstants.LASTNAME]				= data.Room.Title;
			return xml;
		}
		
		//############## Start Getter & Setter #####################	
		public function get ID():String
		{
			return m_sID;
		}

		public function set ID(value:String):void
		{
			m_sID = value;
		}

		public function get Title():String
		{
			return m_sTitle;
		}

		public function set Title(value:String):void
		{
			m_sTitle = value;
		}

		public function get Station():String
		{
			return m_sStation;
		}

		public function set Station(value:String):void
		{
			m_sStation = value;
		}


	}
}