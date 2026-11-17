package com.gazuntite.provider.live.services.administration.dto.locationManagement
{
	import com.gazuntite.common.util.xml.XmlConstants;
	import com.gazuntite.common.util.xml.XmlUtils;

	[Bindable]
	public class AdminStationDTO
	{
		public function AdminStationDTO()
		{
			
		}
		
		private var m_sTagName:String;
		
		private var m_sIsDeleted:String;
		private var m_sIsDirty:String;
		private var m_sStationID:String;
		private var m_sStationName:String;
		private var m_sClinicBranchID:String;
		private var m_sCreatedAt:String;
		private var m_sCreatedBy:String;
		private var m_sModifiedAt:String;
		private var m_sModifiedBy:String;
		private var m_sIsDefault:String;
		private var m_sAddress:String;
		private var m_sCity:String;
		private var m_sPhoneNumber:String;
		private var m_sFaxNumber:String;
		
		public function FromXML(x:XML):void
		{
			TagName							= x.localName();
			
			IsDeleted						= x.@[XmlConstants.IS_DELETED];
			IsDirty							= x.@[XmlConstants.IS_DIRTY];
			StationID 						= x.@[XmlConstants.STATION_ID];
			StationName 					= x.@[XmlConstants.STATION_NAME];
			ClinicBranchID 					= x.@[XmlConstants.CLINICBRANCHID];
			CreatedAt 						= x.@[XmlConstants.CREATEDAT];	
			CreatedBy						= x.@[XmlConstants.CREATEDBY];
			ModifiedAt 						= x.@[XmlConstants.MODIFIED_AT];		
			ModifiedBy						= x.@[XmlConstants.MODIFIEDBY];	
			IsDefault						= x.@[XmlConstants.IS_DEFAULT];
			Address							= x.@[XmlConstants.ADDRESS];		
			City							= x.@[XmlConstants.CITY];	
			PhoneNumber						= x.@[XmlConstants.PHONE_NUMBER];		
			FaxNumber						= x.@[XmlConstants.FAX_NUMBER];
		}
		
		public function ToXML():XML
		{
			var xml:XML = XmlUtils.getNodeByTagName( 'StationDTO' );
			
			xml.@[XmlConstants.IS_DELETED]				= IsDeleted;
			xml.@[XmlConstants.IS_DIRTY]				= IsDirty;
			xml.@[XmlConstants.STATION_ID]				= StationID;
			xml.@[XmlConstants.STATION_NAME]			= StationName;
			xml.@[XmlConstants.CLINICBRANCHID] 			= ClinicBranchID;
			xml.@[XmlConstants.CREATEDAT] 				= CreatedAt;
			xml.@[XmlConstants.CREATEDBY] 				= CreatedBy;
			xml.@[XmlConstants.MODIFIED_AT]				= ModifiedAt;
			xml.@[XmlConstants.MODIFIEDBY] 				= ModifiedBy;
			xml.@[XmlConstants.IS_DEFAULT]				= IsDefault;
			xml.@[XmlConstants.ADDRESS] 				= Address;
			xml.@[XmlConstants.CITY]					= City;
			xml.@[XmlConstants.PHONE_NUMBER] 			= PhoneNumber;
			xml.@[XmlConstants.FAX_NUMBER] 				= FaxNumber;
			
			return xml;
		}
		
		
		// **************  Getter and setter ******************************

		public function get IsDeleted():String
		{
			return m_sIsDeleted;
		}

		public function set IsDeleted(value:String):void
		{
			m_sIsDeleted = value;
		}

		public function get StationID():String
		{
			return m_sStationID;
		}

		public function set StationID(value:String):void
		{
			m_sStationID = value;
		}

		public function get StationName():String
		{
			return m_sStationName;
		}

		public function set StationName(value:String):void
		{
			m_sStationName = value;
		}

		public function get ClinicBranchID():String
		{
			return m_sClinicBranchID;
		}

		public function set ClinicBranchID(value:String):void
		{
			m_sClinicBranchID = value;
		}

		public function get CreatedAt():String
		{
			return m_sCreatedAt;
		}

		public function set CreatedAt(value:String):void
		{
			m_sCreatedAt = value;
		}

		public function get CreatedBy():String
		{
			return m_sCreatedBy;
		}

		public function set CreatedBy(value:String):void
		{
			m_sCreatedBy = value;
		}

		public function get ModifiedAt():String
		{
			return m_sModifiedAt;
		}

		public function set ModifiedAt(value:String):void
		{
			m_sModifiedAt = value;
		}

		public function get ModifiedBy():String
		{
			return m_sModifiedBy;
		}

		public function set ModifiedBy(value:String):void
		{
			m_sModifiedBy = value;
		}

		public function get IsDefault():String
		{
			return m_sIsDefault;
		}

		public function set IsDefault(value:String):void
		{
			m_sIsDefault = value;
		}

		public function get Address():String
		{
			return m_sAddress;
		}

		public function set Address(value:String):void
		{
			m_sAddress = value;
		}

		public function get City():String
		{
			return m_sCity;
		}

		public function set City(value:String):void
		{
			m_sCity = value;
		}

		public function get PhoneNumber():String
		{
			return m_sPhoneNumber;
		}

		public function set PhoneNumber(value:String):void
		{
			m_sPhoneNumber = value;
		}

		public function get FaxNumber():String
		{
			return m_sFaxNumber;
		}

		public function set FaxNumber(value:String):void
		{
			m_sFaxNumber = value;
		}

		public function get TagName():String
		{
			return m_sTagName;
		}

		public function set TagName(value:String):void
		{
			m_sTagName = value;
		}

		public function get IsDirty():String
		{
			return m_sIsDirty;
		}

		public function set IsDirty(value:String):void
		{
			m_sIsDirty = value;
		}

		
		
		
		
	}
}