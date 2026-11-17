package com.adobe.Quivus.customDTO.PatientLoad
{
	public class PatientProfileSettingDTO
	{
		private var _IsDeleted:Boolean;
		private var _IsDirty:Boolean;
		private var _UserUserProfileCategoryID:int;
		private var _UserID:int;
		private var _ClinicBranchID:int;
		private var _SectionNo:int;
		private var _UserProfileCategoryID:int;
		private var _CreatedBy:int;
		private var _CreatedAt:Date;
		private var _ModifiedBy:int;
		private var _IsSetAsDefault:Boolean;
		
			
		public function PatientProfileSettingDTO()
		{
			
		}
		
		public function get IsSetAsDefault():Boolean
		{
			return _IsSetAsDefault;
		}

		public function set IsSetAsDefault(value:Boolean):void
		{
			_IsSetAsDefault = value;
		}

		public function get ModifiedBy():int
		{
			return _ModifiedBy;
		}

		public function set ModifiedBy(value:int):void
		{
			_ModifiedBy = value;
		}

		public function get CreatedAt():Date
		{
			return _CreatedAt;
		}

		public function set CreatedAt(value:Date):void
		{
			_CreatedAt = value;
		}

		public function get CreatedBy():int
		{
			return _CreatedBy;
		}

		public function set CreatedBy(value:int):void
		{
			_CreatedBy = value;
		}

		public function get UserProfileCategoryID():int
		{
			return _UserProfileCategoryID;
		}

		public function set UserProfileCategoryID(value:int):void
		{
			_UserProfileCategoryID = value;
		}

		public function get SectionNo():int
		{
			return _SectionNo;
		}

		public function set SectionNo(value:int):void
		{
			_SectionNo = value;
		}

		public function get ClinicBranchID():int
		{
			return _ClinicBranchID;
		}

		public function set ClinicBranchID(value:int):void
		{
			_ClinicBranchID = value;
		}

		public function get UserID():int
		{
			return _UserID;
		}

		public function set UserID(value:int):void
		{
			_UserID = value;
		}

		public function get UserUserProfileCategoryID():int
		{
			return _UserUserProfileCategoryID;
		}

		public function set UserUserProfileCategoryID(value:int):void
		{
			_UserUserProfileCategoryID = value;
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

		public function FromXml(x:XML):void
		{
			IsDeleted						= StringToBoolean( x.@IsDeleted);
			IsDirty							= StringToBoolean( x.@IsDirty );
			UserUserProfileCategoryID		= x.@IsDirty;
			UserID							= x.@UserID;
			ClinicBranchID					= x.@ClinicBranchID;
			SectionNo						= x.@SectionNo;
			UserProfileCategoryID			= x.@UserProfileCategoryID;
			CreatedBy						= x.@CreatedBy;
			CreatedAt						= new Date( x.@CreatedAt);
			ModifiedBy						= x.@ModifiedBy;
			IsSetAsDefault					= StringToBoolean( x.@IsSetAsDefault );
		}
		
		public function StringToBoolean(val:String):Boolean
		{
			if(val == "false")
				return false;
				
			else if(val =="true")
				return true;
			
			return true;
		}
	}
}
