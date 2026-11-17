package com.adobe.Quivus.events.patientProfile
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class LoadPatientProfileMergeEvent extends CairngormEvent
	{
		public var UserID:int;
		public var PatientID:int;
		public var ClinicBranchID:int;
		public var isAllSelected:Boolean;
		public var ShowAll:Boolean;
		public var UserTypeID:int;
		public var isTemplateVisit:Boolean;
		public var fileName:String;
		public var SectionNumber:int;
		
		public function LoadPatientProfileMergeEvent(_UserID:int, _PatientID:int, _ClinicBranchID:int, _isAllSelected:Boolean, _ShowAll:Boolean, _UserTypeID:int, _isTemplateVisit:Boolean, _fileName:String, _SectionNumber:int)
		{
			super(AppController.LOAD_PATIENT_PROFILE_MERGE_EVENT);
			
			this.UserID			= _UserID;
			this.PatientID		= _PatientID;
			this.ClinicBranchID = _ClinicBranchID;
			this.isAllSelected	= _isAllSelected;
			this.ShowAll		= _ShowAll;
			this.UserTypeID		= _UserTypeID;
			this.isTemplateVisit= _isTemplateVisit;
			this.fileName		= _fileName;
			this.SectionNumber	= _SectionNumber;
		}
	}
}