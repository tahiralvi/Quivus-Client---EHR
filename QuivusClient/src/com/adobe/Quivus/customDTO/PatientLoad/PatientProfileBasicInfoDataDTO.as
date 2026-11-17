package com.adobe.Quivus.customDTO.PatientLoad
{
	public class PatientProfileBasicInfoDataDTO
	{
		private var _IsDeleted:Boolean;
		private var _IsDirty:Boolean;
		private var _FirstName:String;
		private var _LastName:String;
		private var _MiddleName:String;
		private var _DateOfBirth:Date;
		private var _QuivusID:String;
		private var _RecGuid:String;
		
		public function FromXml(x:XML):void
		{
			IsDeleted    	=StringToBoolean(x.@IsDeleted);
			IsDirty     	=StringToBoolean(x.@IsDirty);
			FirstName    	=x.@FirstName;
			LastName     	=x.@LastName;
			MiddleName     	=x.@MiddleName;
			DateOfBirth     =new Date(x.@DateOfBirth);
			QuivusID     	=x.@QuivusID;
			RecGuid	     	=x.@RecGuid;
		}
		
		public function StringToBoolean(val:String):Boolean  
		{
			if(val == "false")
				return false;
				
			else if(val =="true")
				return true;
			
			return true;
		}
		
		
		public function PatientProfileBasicInfoDataDTO()
		{
		}
		
		public function get RecGuid():String
		{
			return _RecGuid;
		}

		public function set RecGuid(value:String):void
		{
			_RecGuid = value;
		}

		public function get QuivusID():String
		{
			return _QuivusID;
		}

		public function set QuivusID(value:String):void
		{
			_QuivusID = value;
		}

		public function get DateOfBirth():Date
		{
			return _DateOfBirth;
		}

		public function set DateOfBirth(value:Date):void
		{
			_DateOfBirth = value;
		}

		public function get MiddleName():String
		{
			return _MiddleName;
		}

		public function set MiddleName(value:String):void
		{
			_MiddleName = value;
		}

		public function get LastName():String
		{
			return _LastName;
		}

		public function set LastName(value:String):void
		{
			_LastName = value;
		}

		public function get FirstName():String
		{
			return _FirstName;
		}

		public function set FirstName(value:String):void
		{
			_FirstName = value;
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

