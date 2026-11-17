package com.gazuntite.provider.live.services.administration.dto.locationManagement
{
	import com.gazuntite.common.util.xml.XmlConstants;
	import com.gazuntite.common.util.xml.XmlUtils;
	
	[Bindable]
	public class SpecialityTypeDTO
	{
		public function SpecialityTypeDTO()
		{
		}
		
		private var m_sTagName:String;
		
		private var m_sID:String;
		private var m_sName:String;
		
		public function get TagName():String
		{
			return m_sTagName;
		}
		
		public function set TagName(value:String):void
		{
			m_sTagName = value;
		}
		
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
		
		public function FromXML(x:XML):void
		{
			TagName							= x.localName();
			
			ID								= x.@[XmlConstants.ID];
			Name							= x.@[XmlConstants.NAME];
		}
		
		public function ToXML():XML
		{
			var xml:XML = XmlUtils.getNodeByTagName( 'SpecialityType' );
			
			xml.@[XmlConstants.ID] 					= ID;
			xml.@[XmlConstants.NAME] 				= Name;
			
			return xml;
		}
		
	}
}