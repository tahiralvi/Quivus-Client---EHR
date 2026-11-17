package com.gazuntite.provider.live.services.waitingRoom.dto
{
	import com.gazuntite.provider.live.services.waitingRoom.util.WRXmlConstants;
	import com.gazuntite.provider.live.services.waitingRoom.util.WRXmlUtils;

	[Bindable]
	public class ActionDTO
	{
		private var m_sID:String;
		private var m_sName:String;
		private var m_sNextAction:String;
		
		public function FromXML( x:XML ):void
		{
			ID					= x.@[WRXmlConstants.ID];
			Name				= x.@[WRXmlConstants.NAME];
			NextAction			= x.@[WRXmlConstants.NEXTACTION];
		}
		
		public function ToXML(obj:Object):XML
		{
			var xml:XML = WRXmlUtils.getNodeByTagName( "Action" );
			xml.@[WRXmlConstants.ID]					= obj.Action.ID;
			xml.@[WRXmlConstants.NAME]					= obj.Action.Name;
			xml.@[WRXmlConstants.NEXTACTION]			= obj.Action.NextAction;
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

		public function get NextAction():String
		{
			return m_sNextAction;
		}

		public function set NextAction(value:String):void
		{
			m_sNextAction = value;
		}


	}
}