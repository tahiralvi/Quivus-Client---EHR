package com.gazuntite.provider.live.services.waitingRoom.dto
{
	import com.gazuntite.provider.live.services.waitingRoom.util.WRXmlConstants;
	import com.gazuntite.provider.live.services.waitingRoom.util.WRXmlUtils;
	
	import mx.utils.StringUtil;

	[Bindable]
	public class PatientDTO
	{
		private var m_sID:String;
		private var m_sFirstName:String;
		private var m_sLastName:String;
		private var m_sMiddleName:String;
		
		private var m_PatientName:String;
		
		public function FromXML( x:XML ):void
		{
			ID				= x.@[WRXmlConstants.ID];
			FirstName		= x.@[WRXmlConstants.FIRSTNAME];
			LastName		= x.@[WRXmlConstants.LASTNAME];
			MiddleName		= x.@[WRXmlConstants.MIDDLENAME];
			
			PatientName = StringUtil.trim(FirstName)+' '+ StringUtil.trim(MiddleName) +' '+ StringUtil.trim(LastName);
		}
		public function ToXML(obj:Object):XML
		{
			var xml:XML = WRXmlUtils.getNodeByTagName( "Patient" );
			xml.@[WRXmlConstants.ID]					= obj.Patient.ID;
			xml.@[WRXmlConstants.FIRSTNAME]			= obj.Patient.FirstName;
			xml.@[WRXmlConstants.LASTNAME]				= obj.Patient.LastName;
			xml.@[WRXmlConstants.MIDDLENAME]			= obj.Patient.MiddleName;
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

		public function get FirstName():String
		{
			return m_sFirstName;
		}

		public function set FirstName(value:String):void
		{
			m_sFirstName = value;
		}

		public function get LastName():String
		{
			return m_sLastName;
		}

		public function set LastName(value:String):void
		{
			m_sLastName = value;
		}

		public function get MiddleName():String
		{
			return m_sMiddleName;
		}

		public function set MiddleName(value:String):void
		{
			m_sMiddleName = value;
		}

		public function get PatientName():String
		{
			return m_PatientName;
		}

		public function set PatientName(value:String):void
		{
			m_PatientName = value;
		}


	}
}