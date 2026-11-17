package com.adobe.Quivus.customDTO.PatientLoad
{
	import mx.collections.ArrayCollection;

	public class PatientVisitDTO
	{
		private var _PatientModuleDIctation:ArrayCollection;
		private var _PatientModuleNotes:ArrayCollection;
		private var _PatientEncounter:PatientEncounterResDTO;
		
		public function PatientVisitDTO()
		{
			PatientModuleDIctation	= new ArrayCollection();
			PatientModuleNotes  	= new ArrayCollection();
		}
		
		public function FromXML(x:XML):void
		{
			PatientModuleDIctation.removeAll();
			var moduleDication:XML = x.PatientModuleDIctation.ModuleDictationDTO;
			for each(var child:XML in moduleDication)
			{
				var Dictation:ModuleDictationDTO;				
				Dictation.FromXml(child);				
				PatientModuleDIctation.addItem(Dictation);
			}
			
			PatientModuleNotes.removeAll();
			var moduleNotes:XML = x.PatientModuleNotes.ModuleNoteDTO;
			for each(var child:XML in moduleNotes)
			{
				var Note:ModuleNoteDTO;				
				Note.FromXml(child);				
				PatientModuleNotes.addItem(Note);
			}
			
			PatientEncounter.FromXml(x.PatientEncounterRes);
		}
		
		public function get PatientEncounter():PatientEncounterResDTO
		{
			return _PatientEncounter;
		}

		public function set PatientEncounter(value:PatientEncounterResDTO):void
		{
			_PatientEncounter = value;
		}

		public function get PatientModuleNotes():ArrayCollection
		{
			return _PatientModuleNotes;
		}

		public function set PatientModuleNotes(value:ArrayCollection):void
		{
			_PatientModuleNotes = value;
		}

		public function get PatientModuleDIctation():ArrayCollection
		{
			return _PatientModuleDIctation;
		}

		public function set PatientModuleDIctation(value:ArrayCollection):void
		{
			_PatientModuleDIctation = value;
		}

		
		
	}
}