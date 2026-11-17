package com.adobe.Quivus.customDTO.PatientLoad
{
	public class PatientLanguageDTO
	{
		
		private var _IsDeleted:Boolean;
		private var _IsDirty:Boolean;
		private var _IsPreffered:Boolean;
		
		private var _LanguageName:String;
	
		private var _LanguageID:int;
		private var _PatientLanguageId:int;
		private var _PatientId:int;
		
		private var _PatientLanguageAbilityMode:PatientLanguageAbilityModeDTO;
		private var _Country:CountryDTO;
		
		public function FromXml(x:XML):void
		{
			IsDeleted						= StringToBoolean(x.@IsDeleted);
			IsDirty							= StringToBoolean(x.@IsDirty);
			IsPreffered						= StringToBoolean(x.@IsPreffered);			
			LanguageName					= x.@LanguageName;		
			LanguageID						= x.@LanguageID;
			PatientLanguageId				= x.@PatientLanguageId;
			PatientId						= x.@PatientId;
			
			PatientLanguageAbilityMode.FromXml(x.PatientLanguageAbilityMode[0]);
			Country.FromXml(x.Country[0]);
		}
			
		public function StringToBoolean(val:String):Boolean
		{
			if(val == "false")
				return false;
				
			else if(val =="true")
				return true;
			
			return true;
		}
		
		public function PatientLanguageDTO()
		{
			
		}

		public function get Country():CountryDTO
		{
			return _Country;
		}

		public function set Country(value:CountryDTO):void
		{
			_Country = value;
		}

		public function get PatientLanguageAbilityMode():PatientLanguageAbilityModeDTO
		{
			return _PatientLanguageAbilityMode;
		}

		public function set PatientLanguageAbilityMode(value:PatientLanguageAbilityModeDTO):void
		{
			_PatientLanguageAbilityMode = value;
		}

		public function get PatientId():int
		{
			return _PatientId;
		}

		public function set PatientId(value:int):void
		{
			_PatientId = value;
		}

		public function get PatientLanguageId():int
		{
			return _PatientLanguageId;
		}

		public function set PatientLanguageId(value:int):void
		{
			_PatientLanguageId = value;
		}

		public function get LanguageID():int
		{
			return _LanguageID;
		}

		public function set LanguageID(value:int):void
		{
			_LanguageID = value;
		}

		public function get LanguageName():String
		{
			return _LanguageName;
		}

		public function set LanguageName(value:String):void
		{
			_LanguageName = value;
		}

		public function get IsPreffered():Boolean
		{
			return _IsPreffered;
		}

		public function set IsPreffered(value:Boolean):void
		{
			_IsPreffered = value;
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