package com.adobe.Quivus.customDTO.PatientLoad
{
	import mx.collections.ArrayCollection;

	public class PatientEncounterResDTO
	{
		private var _TotalRecords:int;
		private var _PatientEncounterList:ArrayCollection;
		
		public function PatientEncounterResDTO()
		{
			PatientEncounterList= new ArrayCollection();
		}

		public function FromXml(x:XML):void
		{
			TotalRecords = x.@TotalRecords;
			
			PatientEncounterList.removeAll();
			var EncounterList:XMLList = x.PatientEncounterList.PatientEncounter;
			for each(var child:XML in EncounterList)
			{
				var EncounterDTO:PatientEncounterDTO;				
				EncounterDTO.FromXml(child);				
				PatientEncounterList.addItem(EncounterDTO);
			}
			
		}
		
		public function get PatientEncounterList():ArrayCollection
		{
			return _PatientEncounterList;
		}

		public function set PatientEncounterList(value:ArrayCollection):void
		{
			_PatientEncounterList = value;
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