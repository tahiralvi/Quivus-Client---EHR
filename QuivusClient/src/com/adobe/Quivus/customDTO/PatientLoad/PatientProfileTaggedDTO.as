package com.adobe.Quivus.customDTO.PatientLoad
{
	public class PatientProfileTaggedDTO
	{
		private var _PatientId:int;
		private var _ProfileBasicInfo:PatientProfileBasicInfoDataDTO;
		
		public function PatientProfileTaggedDTO()
		{
			ProfileBasicInfo = new PatientProfileBasicInfoDataDTO();
		}

		public function FromXml(x:XML):void
		{
			PatientId   =x.@PatientId;
			ProfileBasicInfo.FromXml(x.PatientProfileBasicInfoData[0]);
		}
		
		public function get ProfileBasicInfo():PatientProfileBasicInfoDataDTO
		{
			return _ProfileBasicInfo;
		}

		public function set ProfileBasicInfo(value:PatientProfileBasicInfoDataDTO):void
		{
			_ProfileBasicInfo = value;
		}

		public function get PatientId():int
		{
			return _PatientId;
		}

		public function set PatientId(value:int):void
		{
			_PatientId = value;
		}

	}
}