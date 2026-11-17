package com.gazuntite.patient.visit.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.patient.visit.controller.VBController;
	
	public class LoadPatientVisitsByPatientIdAndClinicIdEvent extends CairngormEvent
	{
		public var patientID:int;
		public var clinicBranchId:int;
		public var isShowAll:Boolean;
		public var userID:int;
		public var userTypeID:int;
		public var sessionID:String;
			
		public function LoadPatientVisitsByPatientIdAndClinicIdEvent(_patientID:int, _clinicBranchId:int, _isShowAll:Boolean, _userID:int, _userTypeID:int, _sessionID:String)
		{
			super(VBController.LOAD_PATIENT_VISITS_BY_PATIENTID_AND_CLINICID_EVENT);
			
			this.patientID 		= _patientID;
			this.clinicBranchId = _clinicBranchId;
			this.isShowAll 		= _isShowAll;
			this.userID 		= _userID;
			this.userTypeID		= _userTypeID;
			this.sessionID 		= _sessionID;
		}
	}
}