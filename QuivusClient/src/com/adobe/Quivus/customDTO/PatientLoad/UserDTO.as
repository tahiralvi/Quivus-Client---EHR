package com.adobe.Quivus.customDTO.PatientLoad
{
	import com.adobe.Quivus.customDTO.CommonDTO.BaseDTO;
	import com.adobe.Quivus.customDTO.CommonDTO.GeneralTypeDTO;

	public class UserDTO extends BaseDTO
	{
		
		private var _IsActive:Boolean;
		private var _IsLockedOut:Boolean;
		private var _UserId:int;
		private var _FirstName:String;
		private var _LastName:String;
		private var _MiddleName:String;
		private var _UserEmail:String;
		private var _SSN:String;
		private var _label:String;
		private var _ActiveUserTypeLabel:String;
		private var _ClinicBranhId:int;
		private var _OtherID:int
		private var _IsSSNSelected:Boolean;
		
		private var _Prefix:GeneralTypeDTO;
		private var _Gender:GeneralTypeDTO;
		private var _AccountStatus:GeneralTypeDTO;
			
		public function UserDTO()
		{
			this.Prefix = new GeneralTypeDTO;
			this.Gender = new GeneralTypeDTO;
			this.AccountStatus = new GeneralTypeDTO;
		}

		
		public function FromXml(x:XML):void
		{
			super.FromXML(x);
			this.IsActive     			= StringToBoolean(x.@IsActive);
			this.IsLockedOut 			=StringToBoolean(x.@IsLockedOut);
			this.IsSSNSelected			=StringToBoolean(	x.@IsSSNSelected);
			
			this.UserId 				= x.@UserId ;
			this.FirstName 				= x.@FirstName ;
			this.LastName 				= x.@LastName ;
			this.MiddleName 			= x.@MiddleName ;
			this.UserEmail 				= x.@UserEmail ;
			this.SSN 					= x.@SSN ;
			this.label					= x.@label ;
			this.ActiveUserTypeLabel 	= x.@ActiveUserTypeLabel ;
			this.ClinicBranhId 			= x.@ClinicBranhId ;
			this.OtherID 				= x.@OtherID ;
			
			this.Prefix.FromXML(x.Prefix[0]);
			this.Gender.FromXML(x.Gender[0]);
			this.AccountStatus.FromXML(x.AccountStatus[0]);
			
			
			
		}
		
		
		public function get AccountStatus():GeneralTypeDTO
		{
			return _AccountStatus;
		}

		public function set AccountStatus(value:GeneralTypeDTO):void
		{
			_AccountStatus = value;
		}

		public function get Gender():GeneralTypeDTO
		{
			return _Gender;
		}

		public function set Gender(value:GeneralTypeDTO):void
		{
			_Gender = value;
		}

		public function get Prefix():GeneralTypeDTO
		{
			return _Prefix;
		}

		public function set Prefix(value:GeneralTypeDTO):void
		{
			_Prefix = value;
		}

		public function get IsSSNSelected():Boolean
		{
			return _IsSSNSelected;
		}

		public function set IsSSNSelected(value:Boolean):void
		{
			_IsSSNSelected = value;
		}

		public function get OtherID():int
		{
			return _OtherID;
		}

		public function set OtherID(value:int):void
		{
			_OtherID = value;
		}

		public function get ClinicBranhId():int
		{
			return _ClinicBranhId;
		}

		public function set ClinicBranhId(value:int):void
		{
			_ClinicBranhId = value;
		}

		public function get ActiveUserTypeLabel():String
		{
			return _ActiveUserTypeLabel;
		}

		public function set ActiveUserTypeLabel(value:String):void
		{
			_ActiveUserTypeLabel = value;
		}

		public function get label():String
		{
			return _label;
		}

		public function set label(value:String):void
		{
			_label = value;
		}

		public function get SSN():String
		{
			return _SSN;
		}

		public function set SSN(value:String):void
		{
			_SSN = value;
		}

		public function get UserEmail():String
		{
			return _UserEmail;
		}

		public function set UserEmail(value:String):void
		{
			_UserEmail = value;
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

		public function get UserId():int
		{
			return _UserId;
		}

		public function set UserId(value:int):void
		{
			_UserId = value;
		}

		public function get IsLockedOut():Boolean
		{
			return _IsLockedOut;
		}

		public function set IsLockedOut(value:Boolean):void
		{
			_IsLockedOut = value;
		}

		public function get IsActive():Boolean
		{
			return _IsActive;
		}

		public function set IsActive(value:Boolean):void
		{
			_IsActive = value;
		}

	}
}