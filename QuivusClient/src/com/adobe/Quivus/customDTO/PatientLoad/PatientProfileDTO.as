package com.adobe.Quivus.customDTO.PatientLoad
{
	import mx.collections.ArrayCollection;

	public class PatientProfileDTO
	{
		
		private var _User:UserDTO;
		private var _Patient:PatientDTO;
		private var _PatientLanguageList:ArrayCollection;
		private var _PatientEmergencyContactList:ArrayCollection;
		private var _PatientMedicalHistoryList:ArrayCollection;
		
		private var PatientGurantor:ArrayCollection; // need to right converation
		private var PatientAllergyList:ArrayCollection; // need to right converation
		private var PatientInsuranceList:ArrayCollection; // need to right converation
		
		private var _IsDeleted:Boolean;
		private var _IsDirty:Boolean;
		private var _PatientId:int;
		private var _InsuranceBalance:int;
		private var _RejectedClaims:int;
		private var _PatientBalance:int;
		private var _ClaimsOverDue:int;
		private var _IsChronicDiagnosis:Boolean;

		public function PatientProfileDTO()
		{
			User = new User();
			Patient = new PatientDTO();
			PatientLanguageList = new ArrayCollection();
			PatientEmergencyContactList = new ArrayCollection();
			PatientMedicalHistoryList = new ArrayCollection();
		}

		
		public function FromXml(x:XML):void
		{
			IsDeleted 				= x.@IsDeleted;
			IsDirty 				= x.@IsDirty;
			PatientId 				= x.@PatientId;
			InsuranceBalance 		= x.@InsuranceBalance;
			RejectedClaims 			= x.@RejectedClaims;
			PatientBalance 			= x.@PatientBalance;
			ClaimsOverDue 			= x.@ClaimsOverDue;
			IsChronicDiagnosis 		= x.@IsChronicDiagnosis;
			
			
			User.FromXml(x.UserDTO[0]);
			Patient.FromXml(x.PatientDTO[0]);
			
			PatientLanguageList.removeAll();
			PatientEmergencyContactList.removeAll();
			PatientMedicalHistoryList.removeAll();
			
			var LanguageList:XMLList = x.PatientLanguageList.PatientLanguageDTO;
			for each(var child:XML in LanguageList)
			{
				var languageDTO:PatientLanguageDTO;
				languageDTO.FromXml(child);
				PatientLanguageList.addItem(languageDTO);
			}
			
			
			var EmergencyContactList:XMLList = x.PatientEmergencyContactList.PatientEmergencyContactDTO;
			for each(var child:XML in LanguageList)
			{
				var EmergencyDTO:PatientEmergencyContactDTO;				
				EmergencyDTO.FromXml(child);				
				PatientEmergencyContactList.addItem(EmergencyDTO);
			}
			
			
			
			var MedicalHistoryList:XMLList = x.PatientMedicalHistoryList.PatientMedicalHistoryDTO;
			for each(var child:XML in LanguageList)
			{
				var MedicalHistoryDTO:PatientMedicalHistoryDTO;				
				MedicalHistoryDTO.FromXml(child);				
				PatientEmergencyContactList.addItem(MedicalHistoryDTO);
			}	
			
		}
		
		public function get IsChronicDiagnosis():Boolean
		{
			return _IsChronicDiagnosis;
		}

		public function set IsChronicDiagnosis(value:Boolean):void
		{
			_IsChronicDiagnosis = value;
		}

		public function get ClaimsOverDue():int
		{
			return _ClaimsOverDue;
		}

		public function set ClaimsOverDue(value:int):void
		{
			_ClaimsOverDue = value;
		}

		public function get PatientBalance():int
		{
			return _PatientBalance;
		}

		public function set PatientBalance(value:int):void
		{
			_PatientBalance = value;
		}

		public function get RejectedClaims():int
		{
			return _RejectedClaims;
		}

		public function set RejectedClaims(value:int):void
		{
			_RejectedClaims = value;
		}

		public function get InsuranceBalance():int
		{
			return _InsuranceBalance;
		}

		public function set InsuranceBalance(value:int):void
		{
			_InsuranceBalance = value;
		}

		public function get PatientId():int
		{
			return _PatientId;
		}

		public function set PatientId(value:int):void
		{
			_PatientId = value;
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

		public function get PatientMedicalHistoryList():ArrayCollection
		{
			return _PatientMedicalHistoryList;
		}

		public function set PatientMedicalHistoryList(value:ArrayCollection):void
		{
			_PatientMedicalHistoryList = value;
		}

		public function get PatientEmergencyContactList():ArrayCollection
		{
			return _PatientEmergencyContactList;
		}

		public function set PatientEmergencyContactList(value:ArrayCollection):void
		{
			_PatientEmergencyContactList = value;
		}

		public function get PatientLanguageList():ArrayCollection
		{
			return _PatientLanguageList;
		}

		public function set PatientLanguageList(value:ArrayCollection):void
		{
			_PatientLanguageList = value;
		}

		public function get Patient():PatientDTO
		{
			return _Patient;
		}

		public function set Patient(value:PatientDTO):void
		{
			_Patient = value;
		}

		public function get User():UserDTO
		{
			return _User;
		}

		public function set User(value:UserDTO):void
		{
			_User = value;
		}

	}
}