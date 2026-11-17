package com.adobe.Quivus.customDTO.PatientLoad
{
	public class PatientLanguageAbilityModeDTO
	{
		
		private var _LanguageAbilityModeId:int;
		private var _LangaugeAbilityModeDescription:String;
		
			
		public function PatientLanguageAbilityModeDTO()
		{
		}
		
		public function FromXml(x:XML):void
		{
			LanguageAbilityModeId = x.@LanguageAbilityModeId;
			LangaugeAbilityModeDescription = x.@LangaugeAbilityModeDescription;
		}

		public function get LangaugeAbilityModeDescription():String
		{
			return _LangaugeAbilityModeDescription;
		}

		public function set LangaugeAbilityModeDescription(value:String):void
		{
			_LangaugeAbilityModeDescription = value;
		}

		public function get LanguageAbilityModeId():int
		{
			return _LanguageAbilityModeId;
		}

		public function set LanguageAbilityModeId(value:int):void
		{
			_LanguageAbilityModeId = value;
		}

	}
}