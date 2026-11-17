package com.adobe.Quivus.customDTO.PatientLoad
{
	public class RecentPatientDTO
	{
		private var _TotalRecords:int;
		private var _FirstRecord:int;
		private var _LastRecord:int;
		
		public function RecentPatientDTO()
		{
		}

		public function FromXml( x : XML):void
		{
			TotalRecords   	=x.@TotalRecords;
			FirstRecord   	=x.@TotalRecords;
			LastRecord   	=x.@LastRecord;
		}
		
		public function get LastRecord():int
		{
			return _LastRecord;
		}

		public function set LastRecord(value:int):void
		{
			_LastRecord = value;
		}

		public function get FirstRecord():int
		{
			return _FirstRecord;
		}

		public function set FirstRecord(value:int):void
		{
			_FirstRecord = value;
		}

		public function get TotalRecords():int
		{
			return _TotalRecords;
		}

		public function set TotalRecords(value:int):void
		{
			_TotalRecords = value;
		}

	}
}