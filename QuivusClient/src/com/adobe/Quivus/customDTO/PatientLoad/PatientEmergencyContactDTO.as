package com.adobe.Quivus.customDTO.PatientLoad
{
	import com.adobe.Quivus.customDTO.CommonDTO.GeneralTypeDTO;

	public class PatientEmergencyContactDTO
	{
	
		private var _IsDeleted:Boolean;
		private var _IsDirty:Boolean;
		private var _PatientId:int;
		private var _FirstName:String;
		private var _EmergencyContactId:int;
		private var _RecGuid:String;
		private var _AllowCommunication:Boolean;
		private var _EmergencyEmail:String;
		
		private var RelationShipType:GeneralTypeDTO;
		
		public function PatientEmergencyContactDTO()
		{
			
		}
		
		
		public function FromXml(x:XML):void
		{
			IsDeleted   			= StringToBoolean(x.@IsDeleted);
			IsDirty   				= StringToBoolean(x.@IsDirty);
			PatientId   			= x.@PatientId;
			FirstName   			= x.@FirstName;
			EmergencyContactId  	= x.@EmergencyContactId;
			RecGuid   			 	= x.@RecGuid;
			AllowCommunication   	= StringToBoolean(x.@AllowCommunication);
			EmergencyEmail   		= x.@EmergencyEmail;
			
			RelationShipType.FromXML(x.RelationShipType[0]);
		}
		
		public function StringToBoolean(val:String):Boolean
		{
			if(val == "false")
				return false;
				
			else if(val =="true")
				return true;
			
			return true;
		}
		
			
		public function get EmergencyEmail():String
		{
			return _EmergencyEmail;
		}

		public function set EmergencyEmail(value:String):void
		{
			_EmergencyEmail = value;
		}

		public function get AllowCommunication():Boolean
		{
			return _AllowCommunication;
		}

		public function set AllowCommunication(value:Boolean):void
		{
			_AllowCommunication = value;
		}

		public function get RecGuid():String
		{
			return _RecGuid;
		}

		public function set RecGuid(value:String):void
		{
			_RecGuid = value;
		}

		public function get EmergencyContactId():int
		{
			return _EmergencyContactId;
		}

		public function set EmergencyContactId(value:int):void
		{
			_EmergencyContactId = value;
		}

		public function get FirstName():String
		{
			return _FirstName;
		}

		public function set FirstName(value:String):void
		{
			_FirstName = value;
		}

		public function get PatientId():int
		{
			return _PatientId;
		}

		public function set PatientId(value:int):void
		{
			_PatientId = value;
		}

		public function get IsDirty():Boolean
		{
			return _IsDirty;
		}

		public function set IsDirty(value:Boolean):void
		{
			_IsDirty = value;
		}

		public function get IsDeleted():Boolean
		{
			return _IsDeleted;
		}

		public function set IsDeleted(value:Boolean):void
		{
			_IsDeleted = value;
		}

		
	}
}