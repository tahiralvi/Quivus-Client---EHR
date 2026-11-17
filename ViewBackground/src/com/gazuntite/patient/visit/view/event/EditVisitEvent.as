package com.gazuntite.patient.visit.view.event
{
	import flash.events.Event;
	
	public class EditVisitEvent extends Event
	{
		public static const EDIT_VISIT_EVENT:String = "EditVisitEvent";
		
		public var visitId:int; 
		public var loadStaticData:Boolean;
		public var patientID:int;
		public var ClinicBranchIdSeq:int;
		public var VisitDate:Date;
		public var canCoSign:Boolean;
		public var PlaceOfServiceTypeID:int;
		public var PlaceOfServiceTypeName:String;
		public var LoggedInUserSelectedStationID:int;
		public var EncounterTypeName:String;
		public var isEditMode:Boolean;
		public var UserId:int;
		
		public function EditVisitEvent(_visitId:int, _loadStaticData:Boolean, _patientID:int, _ClinicBranchIdSeq:int, _VisitDate:Date,
									   _canCoSign:Boolean, _PlaceOfServiceTypeID:int, _PlaceOfServiceTypeName:String, _LoggedInUserSelectedStationID:int, 
									   _EncounterTypeName:String, _isEditMode:Boolean, _UserId:int)
		{
			super(EDIT_VISIT_EVENT, true, false);
			
			this.visitId 							= _visitId;
			this.loadStaticData 					= _loadStaticData;
			this.patientID 							= _patientID;
			this.ClinicBranchIdSeq 					= _ClinicBranchIdSeq;
			this.VisitDate 							= _VisitDate;
			this.canCoSign 							= _canCoSign;
			this.PlaceOfServiceTypeID 				= _PlaceOfServiceTypeID;
			this.PlaceOfServiceTypeName 			= _PlaceOfServiceTypeName;
			this.LoggedInUserSelectedStationID 		= _LoggedInUserSelectedStationID;
			this.EncounterTypeName 					= _EncounterTypeName;
			this.isEditMode 						= _isEditMode;
			this.UserId 							= _UserId;
		}
	}
}