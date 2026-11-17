package com.adobe.Quivus.events.visit 
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;
	
	public class LoadVisitPhysiciansbyClinicBranchIDEvent extends CairngormEvent 
	{
		//int ClinicBranchID, int VisitID, int PatientID, bool isEditMode, int loggedinUserID
		public var ClinicBranchID : int;
		public var VisitID : int;
		public var PatientID : int;
		public var isEditMode : Boolean;
		public var loggedinUserID : int;
		
		//public var functionName 	: Function;
		
		public function LoadVisitPhysiciansbyClinicBranchIDEvent(_ClinicBranchID:int, _VisitID:int, _PatientID:int, _isEditMode:Boolean, _loggedinUserID:int)//, _functionName : Function = null) 
		{
			super( AppController.LOAD_VISIT_PHYSICIANS_BY_CLINIC_BRANCH_ID_EVENT);
			this.ClinicBranchID = _ClinicBranchID;
			this.VisitID 		= _VisitID;
			this.PatientID 		= _PatientID;
			this.isEditMode 	= _isEditMode;
			this.loggedinUserID = _loggedinUserID;
			//this.functionName 	= _functionName;
			
		}
	}
}