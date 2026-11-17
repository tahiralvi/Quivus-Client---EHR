package com.adobe.Quivus.customDTO.PatientLoad
{
	import com.adobe.Quivus.customDTO.CommonDTO.GeneralTypeDTO;

	public class PatientDTO
	{

		private var _QuivusId:String;
		private var _MotherMaidenName:String;
		private var _FatherName:String;
		private var _AlcoholStatusData:String;
		private var _DrugStatusData:String;
		private var _EmployerName:String;
		private var _RecGuid:String;
		private var _DateOfBirth:String;
		private var _SmokingStatusData:String;
		
		
		private var _DrugStatus:Boolean;
		private var _SmokingStatus:Boolean;
		private var _SignatureOnFile:Boolean;		
		private var _PregnancyIndicator:Boolean;
		private var _EPSDT:Boolean;
		private var _FamilyPlanning:Boolean;	
		private var _Emergency:Boolean;
		private var _IsReportingExempt:Boolean;
		private var _AllowEmailCommunication:Boolean;
		private var _IsProfileComplete:Boolean;
		private var _AlcoholStatus:Boolean;
		
		private var _CMSSecondaryTypeID:int;
		private var _ExceptionCodeTypeID:int;
		private var _DelayReasonCodeTypeID:int;
		private var _AcceptAssignmentTypeID:int;
		private var _FileId:int;
		private var _UserId:int;
		private var _MedicareNumber:int;
		private var _IVR_PINCODE:int;
		private var _PatientId:int;
		
		
		private var _RaceType:GeneralTypeDTO;
		private var _EthinicityType:GeneralTypeDTO;
		private var _OccupationType:GeneralTypeDTO;
		private var _MaritalStatusType:GeneralTypeDTO;
		private var _StatusType:GeneralTypeDTO;
		private var _SmokingType:GeneralTypeDTO;
		
		
		
			
		public function PatientDTO()
		{
			RaceType 			= new GeneralTypeDTO();
			EthinicityType		= new GeneralTypeDTO();
			OccupationType		= new GeneralTypeDTO();
			MaritalStatusType	= new GeneralTypeDTO();
			StatusType			= new GeneralTypeDTO();
			SmokingType			= new GeneralTypeDTO();
		}
				
			
		
		public function FromXml(x:XML):void
		{
			PatientId					= x.@PatientId;
			QuivusId					= x.@QuivusId;
			IVR_PINCODE					= x.@IVR_PINCODE;
			IsReportingExempt			= x.@IsReportingExempt;
			AllowEmailCommunication		= x.@AllowEmailCommunication;
			MotherMaidenName			= x.@MotherMaidenName;
			FatherName					= x.@FatherName;
			MedicareNumber				= x.@MedicareNumber;
			IsProfileComplete			= x.@IsProfileComplete;
			AlcoholStatus				= x.@AlcoholStatus;
			AlcoholStatusData			= x.@AlcoholStatusData;
			DrugStatus					= x.@DrugStatus;
			DrugStatusData				= x.@DrugStatusData;
			EmployerName				= x.@EmployerName;
			RecGuid						= x.@RecGuid;
			DateOfBirth					= x.@DateOfBirth;
			FileId						= x.@FileId;
			UserId						= x.@UserId;
			SmokingStatus				= x.@SmokingStatus;
			SmokingStatusData			= x.@SmokingStatusData;
			AcceptAssignmentTypeID		= x.@AcceptAssignmentTypeID;
			SignatureOnFile				= x.@SignatureOnFile;
			DelayReasonCodeTypeID		= x.@DelayReasonCodeTypeID;
			PregnancyIndicator			= x.@PregnancyIndicator;
			EPSDT						= x.@EPSDT;
			FamilyPlanning				= x.@FamilyPlanning;
			ExceptionCodeTypeID			= x.@ExceptionCodeTypeID;
			Emergency					= x.@Emergency;
			CMSSecondaryTypeID			= x.@CMSSecondaryTypeID;
			
			RaceType.FromXML(x.RaceType[0]); 			
			EthinicityType.FromXML(x.EthinicityType[0]); 
			OccupationType.FromXML(x.OccupationType[0]); 		
			MaritalStatusType.FromXML(x.MaritalStatusType[0]); 	
			StatusType.FromXML(x.StatusType[0]); 			
			SmokingType.FromXML(x.SmokingType[0]); 			
		}
		
		
		public function get SmokingType():GeneralTypeDTO
		{
			return _SmokingType;
		}

		public function set SmokingType(value:GeneralTypeDTO):void
		{
			_SmokingType = value;
		}

		public function get StatusType():GeneralTypeDTO
		{
			return _StatusType;
		}

		public function set StatusType(value:GeneralTypeDTO):void
		{
			_StatusType = value;
		}

		public function get MaritalStatusType():GeneralTypeDTO
		{
			return _MaritalStatusType;
		}

		public function set MaritalStatusType(value:GeneralTypeDTO):void
		{
			_MaritalStatusType = value;
		}

		public function get OccupationType():GeneralTypeDTO
		{
			return _OccupationType;
		}

		public function set OccupationType(value:GeneralTypeDTO):void
		{
			_OccupationType = value;
		}

		public function get EthinicityType():GeneralTypeDTO
		{
			return _EthinicityType;
		}

		public function set EthinicityType(value:GeneralTypeDTO):void
		{
			_EthinicityType = value;
		}

		public function get RaceType():GeneralTypeDTO
		{
			return _RaceType;
		}

		public function set RaceType(value:GeneralTypeDTO):void
		{
			_RaceType = value;
		}

		public function get PatientId():int
		{
			return _PatientId;
		}

		public function set PatientId(value:int):void
		{
			_PatientId = value;
		}

		public function get IVR_PINCODE():int
		{
			return _IVR_PINCODE;
		}

		public function set IVR_PINCODE(value:int):void
		{
			_IVR_PINCODE = value;
		}

		public function get MedicareNumber():int
		{
			return _MedicareNumber;
		}

		public function set MedicareNumber(value:int):void
		{
			_MedicareNumber = value;
		}

		public function get UserId():int
		{
			return _UserId;
		}

		public function set UserId(value:int):void
		{
			_UserId = value;
		}

		public function get FileId():int
		{
			return _FileId;
		}

		public function set FileId(value:int):void
		{
			_FileId = value;
		}

		public function get AcceptAssignmentTypeID():int
		{
			return _AcceptAssignmentTypeID;
		}

		public function set AcceptAssignmentTypeID(value:int):void
		{
			_AcceptAssignmentTypeID = value;
		}

		public function get DelayReasonCodeTypeID():int
		{
			return _DelayReasonCodeTypeID;
		}

		public function set DelayReasonCodeTypeID(value:int):void
		{
			_DelayReasonCodeTypeID = value;
		}

		public function get ExceptionCodeTypeID():int
		{
			return _ExceptionCodeTypeID;
		}

		public function set ExceptionCodeTypeID(value:int):void
		{
			_ExceptionCodeTypeID = value;
		}

		public function get CMSSecondaryTypeID():int
		{
			return _CMSSecondaryTypeID;
		}

		public function set CMSSecondaryTypeID(value:int):void
		{
			_CMSSecondaryTypeID = value;
		}

		public function get AlcoholStatus():Boolean
		{
			return _AlcoholStatus;
		}

		public function set AlcoholStatus(value:Boolean):void
		{
			_AlcoholStatus = value;
		}

		public function get IsProfileComplete():Boolean
		{
			return _IsProfileComplete;
		}

		public function set IsProfileComplete(value:Boolean):void
		{
			_IsProfileComplete = value;
		}

		public function get AllowEmailCommunication():Boolean
		{
			return _AllowEmailCommunication;
		}

		public function set AllowEmailCommunication(value:Boolean):void
		{
			_AllowEmailCommunication = value;
		}

		public function get IsReportingExempt():Boolean
		{
			return _IsReportingExempt;
		}

		public function set IsReportingExempt(value:Boolean):void
		{
			_IsReportingExempt = value;
		}

		public function get Emergency():Boolean
		{
			return _Emergency;
		}

		public function set Emergency(value:Boolean):void
		{
			_Emergency = value;
		}

		public function get FamilyPlanning():Boolean
		{
			return _FamilyPlanning;
		}

		public function set FamilyPlanning(value:Boolean):void
		{
			_FamilyPlanning = value;
		}

		public function get EPSDT():Boolean
		{
			return _EPSDT;
		}

		public function set EPSDT(value:Boolean):void
		{
			_EPSDT = value;
		}

		public function get PregnancyIndicator():Boolean
		{
			return _PregnancyIndicator;
		}

		public function set PregnancyIndicator(value:Boolean):void
		{
			_PregnancyIndicator = value;
		}

		public function get SignatureOnFile():Boolean
		{
			return _SignatureOnFile;
		}

		public function set SignatureOnFile(value:Boolean):void
		{
			_SignatureOnFile = value;
		}

		public function get SmokingStatus():Boolean
		{
			return _SmokingStatus;
		}

		public function set SmokingStatus(value:Boolean):void
		{
			_SmokingStatus = value;
		}

		public function get DrugStatus():Boolean
		{
			return _DrugStatus;
		}

		public function set DrugStatus(value:Boolean):void
		{
			_DrugStatus = value;
		}

		public function get SmokingStatusData():String
		{
			return _SmokingStatusData;
		}

		public function set SmokingStatusData(value:String):void
		{
			_SmokingStatusData = value;
		}

		public function get DateOfBirth():String
		{
			return _DateOfBirth;
		}

		public function set DateOfBirth(value:String):void
		{
			_DateOfBirth = value;
		}

		public function get RecGuid():String
		{
			return _RecGuid;
		}

		public function set RecGuid(value:String):void
		{
			_RecGuid = value;
		}

		public function get EmployerName():String
		{
			return _EmployerName;
		}

		public function set EmployerName(value:String):void
		{
			_EmployerName = value;
		}

		public function get DrugStatusData():String
		{
			return _DrugStatusData;
		}

		public function set DrugStatusData(value:String):void
		{
			_DrugStatusData = value;
		}

		public function get AlcoholStatusData():String
		{
			return _AlcoholStatusData;
		}

		public function set AlcoholStatusData(value:String):void
		{
			_AlcoholStatusData = value;
		}

		public function get FatherName():String
		{
			return _FatherName;
		}

		public function set FatherName(value:String):void
		{
			_FatherName = value;
		}

		public function get MotherMaidenName():String
		{
			return _MotherMaidenName;
		}

		public function set MotherMaidenName(value:String):void
		{
			_MotherMaidenName = value;
		}

		public function get QuivusId():String
		{
			return _QuivusId;
		}

		public function set QuivusId(value:String):void
		{
			_QuivusId = value;
		}

	}
}