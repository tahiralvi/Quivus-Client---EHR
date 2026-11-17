package com.gazuntite.provider.live.services.waitingRoom.dto
{
	import com.gazuntite.provider.live.services.waitingRoom.util.WRXmlConstants;
	import com.gazuntite.provider.live.services.waitingRoom.util.WRXmlUtils;

	[Bindable]
	public class TypeDTO
	{
		private var m_sID:String;
		private var m_sName:String;

		public function FromXML( x:XML ):void
		{
			ID					= x.@[WRXmlConstants.ID];
			Name				= x.@[WRXmlConstants.NAME];
		}
		
		public function ToXML(obj:Object):XML
		{
			var xml:XML = WRXmlUtils.getNodeByTagName( "Type" );
			xml.@[WRXmlConstants.ID]					= obj.Type.ID;
			xml.@[WRXmlConstants.NAME]					= obj.Type.Name;
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

		public function get Name():String
		{
			return m_sName;
		}

		public function set Name(value:String):void
		{
			m_sName = value;
		}


	}
}