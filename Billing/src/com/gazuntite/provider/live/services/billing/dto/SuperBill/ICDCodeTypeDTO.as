package com.gazuntite.provider.live.services.billing.dto.SuperBill
{
	import com.gazuntite.common.util.xml.XmlConstants;

	public class ICDCodeTypeDTO
	{
		private var m_sICDCodeID:String;
		private var m_sICDCodeName:String;
		private var m_sICDCodeDescription:String;
		
		public function ICDCodeTypeDTO()
		{
		}
		
		public function get ICDCodeID():String
		{
			return m_sICDCodeID;
		}
		
		public function set ICDCodeID(value:String):void
		{
			m_sICDCodeID = value;
		}
		
		public function get ICDCodeName():String
		{
			return m_sICDCodeName;
		}
		
		public function set ICDCodeName(value:String):void
		{
			m_sICDCodeName = value;
		}
		
		public function get ICDCodeDescription():String
		{
			return m_sICDCodeDescription;
		}
		
		public function set ICDCodeDescription(value:String):void
		{		
			m_sICDCodeDescription = value;
		}
		
		public function FromXML( x:XML ):void
		{
			ICDCodeID 							= x.@[XmlConstants.ICDCODEID];
			ICDCodeName 						= x.@[XmlConstants.ICDCODENAME];
			ICDCodeDescription 					= x.@[XmlConstants.ICDCODEDESCRIPTION];			
		}
	}
}