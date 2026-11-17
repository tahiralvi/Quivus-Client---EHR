package com.gazuntite.provider.live.services.elab.dto
{
	import com.gazuntite.common.dto.baseDTO.LiveProviderBaseTypeDTO;
	import com.gazuntite.common.util.xml.XmlConstants;
	import com.gazuntite.common.util.xml.XmlUtils;

	public class SearchFieldsDTO  extends LiveProviderBaseTypeDTO
	{
		private var m_sID:String,
		m_sName:String;
		
		public function SearchFieldsDTO()
		{
		}
		
		public function get ID():String
		{
			return m_sID;
		}
		
		public function set ID(value:String):void
		{
			m_sID = value;
		}
		
		public function get label():String
		{
			return m_sName;
		}
		
		public function get Name():String
		{
			return m_sName;
		}
		
		public function set Name(value:String):void
		{
			m_sName = value;
		}

		public function FromXML(x:XML):void
		{
			ID 		= x.@[XmlConstants.ID];
			Name 	= x.@[XmlConstants.NAME];
			
		}
		
		public function ToXML():XML
		{
			var xml:XML = XmlUtils.getNodeByTagName( "SearchField" );
			xml.@[XmlConstants.ID]		= ID;
			xml.@[XmlConstants.NAME]	= Name;
			
			
			return xml;
		}
	}
}