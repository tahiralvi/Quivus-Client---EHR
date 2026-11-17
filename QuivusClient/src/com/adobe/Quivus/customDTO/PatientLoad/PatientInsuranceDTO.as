package com.adobe.Quivus.customDTO.PatientLoad
{
	import com.gazuntite.utils.UtilityFunctions;

	public class PatientInsuranceDTO
	{
		
		private var _IsDeleted : Boolean;
		private var _IsDirty : Boolean;
		private var _CrossoverClaim : Boolean;
		private var _AssignmentOfBenefits : Boolean;
		
		
		private var _EndDate : Date;
		private var _InsuredPersonDOB : Date;
		private var _StartDate : Date;
		
		private var _GroupNumber : String;
		private var _InsuranceCoPay : String;
		private var _InsuredPersonName : String;
		private var _IsEligible : String;
		private var _PolicyNumber : String;
		private var _StrEndDate : String;
		private var _StrInsuredPersonDOB : String;
		private var _StrStartDate : String;
		private var _Copay : String;
		
		private var _PatientId : int;
		private var _PatientInsuranceId : int;
		
		// Need to complete them , when given xml is fixed
		
		/*private var _InsuranceImage : valueObjects.ImageDTO;
		private var _InsuranceNature : valueObjects.InsuranceNatureDTO;
		private var _InsuranceOrganization : valueObjects.InsuranceOrganizationDTO;
		private var _InsurancePlan : String;
		private var _InsuranceStatus : valueObjects.StatusTypeDTO;
		private var _InsuranceType : valueObjects.InsuranceTypeDTO;
		private var _InsuredPersonGender : valueObjects.GenderTypeDTO;
	*/
		
	
		
		
		public function PatientInsuranceDTO()
		{
		}

		public function FromXml(x:XML):void
		{
			IsDeleted						=UtilityFunctions.StringToBoolean( x.@IsDeleted);
			IsDirty							=UtilityFunctions.StringToBoolean( x.@IsDirty);
			CrossoverClaim					=UtilityFunctions.StringToBoolean( x.@CrossoverClaim);
			AssignmentOfBenefits			=UtilityFunctions.StringToBoolean( x.@AssignmentOfBenefits);
			
			
			EndDate							= new Date(x.@EndDate);
			InsuredPersonDOB				= new Date(x.@InsuredPersonDOB);
			StartDate						= new Date(x.@StartDate);
			
			GroupNumber						= x.@GroupNumber;
			InsuranceCoPay					= x.@InsuranceCoPay;
			InsuredPersonName				= x.@InsuredPersonName;
			IsEligible						= x.@IsEligible;
			PolicyNumber					= x.@PolicyNumber;
			StrEndDate						= x.@StrEndDate;
			StrInsuredPersonDOB				= x.@StrInsuredPersonDOB;
			StrStartDate					= x.@StrStartDate;
			Copay							= x.@Copay;
			
			PatientId						= x.@PatientId;
			PatientInsuranceId				= x.@PatientInsuranceId;
		}
		
		public function get StrStartDate():String
		{
			return _StrStartDate;
		}

		public function set StrStartDate(value:String):void
		{
			_StrStartDate = value;
		}

		public function get StrInsuredPersonDOB():String
		{
			return _StrInsuredPersonDOB;
		}

		public function set StrInsuredPersonDOB(value:String):void
		{
			_StrInsuredPersonDOB = value;
		}

		public function get StrEndDate():String
		{
			return _StrEndDate;
		}

		public function set StrEndDate(value:String):void
		{
			_StrEndDate = value;
		}

		public function get StartDate():Date
		{
			return _StartDate;
		}

		public function set StartDate(value:Date):void
		{
			_StartDate = value;
		}

		public function get PolicyNumber():String
		{
			return _PolicyNumber;
		}

		public function set PolicyNumber(value:String):void
		{
			_PolicyNumber = value;
		}

		public function get PatientInsuranceId():int
		{
			return _PatientInsuranceId;
		}

		public function set PatientInsuranceId(value:int):void
		{
			_PatientInsuranceId = value;
		}

		public function get PatientId():int
		{
			return _PatientId;
		}

		public function set PatientId(value:int):void
		{
			_PatientId = value;
		}

		public function get IsEligible():String
		{
			return _IsEligible;
		}

		public function set IsEligible(value:String):void
		{
			_IsEligible = value;
		}

		public function get InsuredPersonName():String
		{
			return _InsuredPersonName;
		}

		public function set InsuredPersonName(value:String):void
		{
			_InsuredPersonName = value;
		}

		public function get InsuredPersonGender():valueObjects.GenderTypeDTO
		{
			return _InsuredPersonGender;
		}

		public function set InsuredPersonGender(value:GenderTypeDTO):void
		{
			_InsuredPersonGender = value;
		}

		public function get InsuredPersonDOB():Date
		{
			return _InsuredPersonDOB;
		}

		public function set InsuredPersonDOB(value:Date):void
		{
			_InsuredPersonDOB = value;
		}

		public function get InsuranceType():valueObjects.InsuranceTypeDTO
		{
			return _InsuranceType;
		}

		public function set InsuranceType(value:InsuranceTypeDTO):void
		{
			_InsuranceType = value;
		}

		public function get InsuranceStatus():valueObjects.StatusTypeDTO
		{
			return _InsuranceStatus;
		}

		public function set InsuranceStatus(value:StatusTypeDTO):void
		{
			_InsuranceStatus = value;
		}

		public function get InsurancePlan():String
		{
			return _InsurancePlan;
		}

		public function set InsurancePlan(value:String):void
		{
			_InsurancePlan = value;
		}

		public function get InsuranceOrganization():valueObjects.InsuranceOrganizationDTO
		{
			return _InsuranceOrganization;
		}

		public function set InsuranceOrganization(value:InsuranceOrganizationDTO):void
		{
			_InsuranceOrganization = value;
		}

		public function get InsuranceNature():valueObjects.InsuranceNatureDTO
		{
			return _InsuranceNature;
		}

		public function set InsuranceNature(value:InsuranceNatureDTO):void
		{
			_InsuranceNature = value;
		}

		public function get InsuranceImage():valueObjects.ImageDTO
		{
			return _InsuranceImage;
		}

		public function set InsuranceImage(value:ImageDTO):void
		{
			_InsuranceImage = value;
		}

		public function get InsuranceCoPay():String
		{
			return _InsuranceCoPay;
		}

		public function set InsuranceCoPay(value:String):void
		{
			_InsuranceCoPay = value;
		}

		public function get GroupNumber():String
		{
			return _GroupNumber;
		}

		public function set GroupNumber(value:String):void
		{
			_GroupNumber = value;
		}

		public function get EndDate():Date
		{
			return _EndDate;
		}

		public function set EndDate(value:Date):void
		{
			_EndDate = value;
		}

		public function get CrossoverClaim():Boolean
		{
			return _CrossoverClaim;
		}

		public function set CrossoverClaim(value:Boolean):void
		{
			_CrossoverClaim = value;
		}

		public function get Copay():String
		{
			return _Copay;
		}

		public function set Copay(value:String):void
		{
			_Copay = value;
		}

		public function get AssignmentOfBenefits():Boolean
		{
			return _AssignmentOfBenefits;
		}

		public function set AssignmentOfBenefits(value:Boolean):void
		{
			_AssignmentOfBenefits = value;
		}

		public function get IsDirty():Boolean
		{
			return _IsDirty;
		}

		public function set IsDirty(value:Boolean):void
		{
			_IsDirty = value;
		}

		public function get IsDeleted():Boolean
		{
			return _IsDeleted;
		}

		public function set IsDeleted(value:Boolean):void
		{
			_IsDeleted = value;
		}

	}
}