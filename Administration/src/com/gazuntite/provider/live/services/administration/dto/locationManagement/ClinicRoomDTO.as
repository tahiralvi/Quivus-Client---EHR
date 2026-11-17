package com.gazuntite.provider.live.services.administration.dto.locationManagement
{
	import com.gazuntite.common.util.xml.XmlConstants;
	import com.gazuntite.common.util.xml.XmlUtils;

	[Bindable]
	public class ClinicRoomDTO
	{
		public function ClinicRoomDTO()
		{
		}
		
		private var m_sTagName:String;
		
		private var m_sIsDeleted:String;
		private var m_sIsDirty:String;
		
		private var m_sClinicRoomId:String;
		private var m_sStationID:String;
		private var m_sRoomTitle:String;
		private var m_sRoomtype:String;
		private var m_sRoomStatus:String;
		private var m_sRoomCode:String;
		private var m_sCreatedAt:String;
		private var m_sCreatedBy:String;
		private var m_sModifiedAt:String;
		private var m_sModifiedBy:String;
		
		public function FromXML(x:XML):void
		{
			TagName							= x.localName();
			
			IsDeleted						= x.@[XmlConstants.IS_DELETED];
			IsDirty							= x.@[XmlConstants.IS_DIRTY];
			
			ClinicRoomId					= x.@[XmlConstants.CLINICBRANCHID];
			StationID 						= x.@[XmlConstants.STATION_ID];
			RoomTitle						= x.@['RoomTitle'];	
			Roomtype						= x.@['Roomtype'];	
			RoomStatus						= x.@['RoomStatus'];	
			RoomCode						= x.@['RoomCode'];	
			CreatedAt 						= x.@[XmlConstants.CREATEDAT] ;		
			CreatedBy						= x.@[XmlConstants.CREATEDBY] ;		
			ModifiedAt 						= x.@[XmlConstants.MODIFIED_AT] ;		
			ModifiedBy						= x.@[XmlConstants.MODIFIEDBY] ;		
		}
		
		public function ToXML():XML
		{
			var xml:XML = XmlUtils.getNodeByTagName( 'ClinicRoomDTO' );
			
			xml.@[XmlConstants.IS_DELETED]				= IsDeleted;
			xml.@[XmlConstants.IS_DIRTY]				= IsDirty;
			
			xml.@['ClinicRoomId']						= ClinicRoomId;
			xml.@[XmlConstants.STATION_ID]				= StationID;
			xml.@['RoomTitle']							= RoomTitle;
			xml.@['Roomtype']							= Roomtype;
			xml.@['RoomStatus']							= RoomStatus;
			xml.@['RoomCode']							= RoomCode;
			xml.@[XmlConstants.CREATEDAT] 				= CreatedAt;
			xml.@[XmlConstants.CREATEDBY] 				= CreatedBy;
			xml.@[XmlConstants.MODIFIED_AT] 			= ModifiedAt;
			xml.@[XmlConstants.MODIFIEDBY] 				= ModifiedBy;
			
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

		public function get ClinicRoomId():String
		{
			return m_sClinicRoomId;
		}

		public function set ClinicRoomId(value:String):void
		{
			m_sClinicRoomId = value;
		}

		public function get RoomTitle():String
		{
			return m_sRoomTitle;
		}

		public function set RoomTitle(value:String):void
		{
			m_sRoomTitle = value;
		}

		public function get Roomtype():String
		{
			return m_sRoomtype;
		}

		public function set Roomtype(value:String):void
		{
			m_sRoomtype = value;
		}

		public function get RoomStatus():String
		{
			return m_sRoomStatus;
		}

		public function set RoomStatus(value:String):void
		{
			m_sRoomStatus = value;
		}

		public function get RoomCode():String
		{
			return m_sRoomCode;
		}

		public function set RoomCode(value:String):void
		{
			m_sRoomCode = value;
		}


	}
}