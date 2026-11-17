package com.adobe.Quivus.customDTO.PatientLoad
{
	public class CountryDTO
	{
		private var _IsDeleted:Boolean;
		private var _IsDirty:Boolean;
		private var _CountryID:int;
			
		public function CountryDTO()
		{
		}

		public function FromXml(x:XML):void
		{
			IsDeleted = x.@IsDeleted;
			IsDirty = x.@IsDirty;
			CountryID =x.@CountryID;
		}
		
		public function get CountryID():int
		{
			return _CountryID;
		}

		public function set CountryID(value:int):void
		{
			_CountryID = value;
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