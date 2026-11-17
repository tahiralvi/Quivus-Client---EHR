package com.adobe.Quivus.utils
{
	import com.adobe.Quivus.model.AppModelLocator;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.AddressBookDTO;
	import valueObjects.AddressDTO;
	import valueObjects.AssessmentDTO;
	import valueObjects.BaseUserDTO;
	import valueObjects.ClinicBranchDTO;
	import valueObjects.ComprehensiveHistoryDTO;
	import valueObjects.PMHDTO;
	import valueObjects.PatientAllergyDTO;
	import valueObjects.PatientDTO;
	import valueObjects.PatientEmergencyContactDTO;
	import valueObjects.PatientFollowUpDTO;
	import valueObjects.PatientGuarantorDTO;
	import valueObjects.PatientHealthDTO;
	import valueObjects.PatientInsuranceDTO;
	import valueObjects.PatientLanguageDTO;
	import valueObjects.PatientProfileDTO;
	import valueObjects.PatientProfileSettingResponse;
	import valueObjects.PatientProfileTaggedDTO;
	import valueObjects.PhoneDTO;
	import valueObjects.PhysicalDTO;
	import valueObjects.QuickInputDTO;
	import valueObjects.SocialHistoryDTO;
	import valueObjects.StatusTypeDTO;
	import valueObjects.UserTypeDTO;
	import valueObjects.VisitDTO;
	import valueObjects.VitalDTO;
	
	public class DTOInitializationUtility
	{
		
		
		public function DTOInitializationUtility()
		{
		}
		
		
		
		
		public static function setQuickInputDTOsToNullIfNoData( ) : void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			try{
				if( model.quickInputDTO.Physical.Vitals.Height 		== "0" &&
					model.quickInputDTO.Physical.Vitals.Weight 		== "0" &&
					model.quickInputDTO.Physical.Vitals.Temperature == "0" &&
					model.quickInputDTO.Physical.Vitals.Pulse 		== "0" &&
					model.quickInputDTO.Physical.Vitals.Respiration == "0" &&
					model.quickInputDTO.Physical.Vitals.BPSys 		== "0" &&
					model.quickInputDTO.Physical.Vitals.BPDys 		== "0" 
				)
				{
					model.quickInputDTO.Physical.Vitals = null;
				}
			}catch(error:Error){trace("Error: "+ error.getStackTrace());}
			
			try{
				if( model.socialHistoryDTO.SocialHistoryAddictionList.length  == 0 &&
					model.socialHistoryDTO.IsOtherYesSelected == null &&
					model.socialHistoryDTO.IsWorkStatusYesSelected == null &&
					model.socialHistoryDTO.MaritalStatusID == 0 &&
					model.socialHistoryDTO.WorkStatusNotes ==null &&
					model.socialHistoryDTO.OtherNotes == null
				)
				{
					model.quickInputDTO.PMH.ComprehensiveHistory.SocialHistory = new ArrayCollection();
					
				}
			}catch(error:Error){trace("Error: "+ error.getStackTrace());}
			
			
			
		}
		/// Hassan - updated
		/// Date 14 MAr 2011
		/// Ojects initalizes
		public static function initializeQuickInputDTO( ) : void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			model.quickInputDTO = new QuickInputDTO();
			
			//M 
			model.quickInputDTO.SignedDate = Constants.NULL_DATE;			
			
			//VISIT
			model.quickInputDTO.Visit 					= new VisitDTO();
			model.quickInputDTO.Visit.RecGuid 			= Constants.GUID_FORMAT;
			model.quickInputDTO.Visit.VisitDate 		= model.createdVisitDate;
			//model.quickInputDTO.Visit.VisitId 			= model.visitDTO.VisitId;
			model.quickInputDTO.Visit.ClinicBranch 		= new ClinicBranchDTO();
			model.quickInputDTO.Visit.UserType 			= new UserTypeDTO();
			model.quickInputDTO.Visit.SignedByUserType 	= new UserTypeDTO();
			model.quickInputDTO.Visit.DictationID 		= Constants.GUID_FORMAT;
			model.quickInputDTO.Visit.ModifiedDate 		= Constants.NULL_DATE;							
			model.quickInputDTO.Visit.SignedDate 		= Constants.NULL_DATE;
			model.quickInputDTO.Visit.CoSignedDate		= Constants.NULL_DATE;
			model.quickInputDTO.Visit.CreatedBy 		= model.loggedInUserDTO.UserId;
			model.quickInputDTO.Visit.ModifiedBy		= model.loggedInUserDTO.UserId;
			model.quickInputDTO.Visit.VisitDate			= model.createdVisitDate;
			model.quickInputDTO.Visit.CreatedAt 		= new Date();
			model.quickInputDTO.Visit.ModifiedAt 		= Constants.NULL_DATE;
			
			model.quickInputDTO.ClinicBranchId			= model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq;
			
			//model.quickInputDTO.VisitId 				= model.visitDTO.VisitId;
			model.quickInputDTO.ActionDate 				= new Date();
			
			model.quickInputDTO.PatientId 				= model.loadedPatientId;
			
			//PMH
			model.quickInputDTO.PMH 					= new PMHDTO();
			model.quickInputDTO.PMH.Allergy				= new ArrayCollection();
			model.quickInputDTO.PMH.ChiefComplaint 		= new ArrayCollection();
			model.quickInputDTO.PMH.ChronicDiagnosis 	= new ArrayCollection();
			model.quickInputDTO.PMH.ChronicMedication 	= new ArrayCollection();
			model.quickInputDTO.PMH.ComprehensiveHistory = new ComprehensiveHistoryDTO;
			model.quickInputDTO.PMH.ComprehensiveHistory.MedicalHistory= new ArrayCollection();
			
			//M 24 Mar 2011
			model.quickInputDTO.PMH.ComprehensiveHistory.FamilyHistory= new ArrayCollection();
			
			//M 19 Mar 2011
			model.quickInputDTO.PMH.ComprehensiveHistory.SocialHistory = new ArrayCollection();
			
			model.quickInputDTO.PMH.Immunization 		= new ArrayCollection();
			
			//model.quickInputDTO.PMH.ComprehensiveHistory.MedicalHistory.
			//Physical
			model.quickInputDTO.Physical 				= new PhysicalDTO();
			model.quickInputDTO.Physical.Vitals 		= new VitalDTO();			
			model.quickInputDTO.Physical.Vitals.IsMetricDisplaySelected = true;
			//INIT the null values
			if(model.quickInputDTO.Physical.Vitals.Height == null)
			{
				//model.quickInputDTO.Physical.Vitals.VisitID 		= model.visitDTO.VisitId;
				model.quickInputDTO.Physical.Vitals.DictationID 	= Constants.GUID_FORMAT;
				
				model.quickInputDTO.Physical.Vitals.Height 			= "0";
				model.quickInputDTO.Physical.Vitals.Weight 			= "0";
				model.quickInputDTO.Physical.Vitals.Temperature 	= "0";
				model.quickInputDTO.Physical.Vitals.Pulse 			= "0";
				model.quickInputDTO.Physical.Vitals.Respiration 	= "0";
				model.quickInputDTO.Physical.Vitals.BPSys 			= "0";
				model.quickInputDTO.Physical.Vitals.BPDys 			= "0";
				model.quickInputDTO.Physical.Vitals.CreatedAt       = new Date();
				model.quickInputDTO.Physical.Vitals.ModifiedAt      = Constants.NULL_DATE;
				model.quickInputDTO.Physical.Vitals.ModifiedBy      = model.loggedInUserDTO.UserId;
				model.quickInputDTO.Physical.Vitals.VisitDate       = model.createdVisitDate;
				
			}
			
			model.quickInputDTO.Physical.HPI_CC 			= new ArrayCollection();
			model.quickInputDTO.Physical.ReviewOfSystem		= new ArrayCollection();
			model.quickInputDTO.Physical.Labs 				= new ArrayCollection();
			model.quickInputDTO.Physical.Physicals			= new ArrayCollection();
			model.quickInputDTO.Physical.InHouseLabs		= new ArrayCollection();
			
			//M TEMP model.quickInputDTO.Assessment = new AssessmentDTO();
			model.quickInputDTO.Assessment 					= new AssessmentDTO();
			model.quickInputDTO.Assessment.Diagnosis 		= new ArrayCollection();
			model.quickInputDTO.Assessment.Recommendation 	= new ArrayCollection();
			model.quickInputDTO.Assessment.Procedure		= new ArrayCollection();
			
			model.quickInputDTO.Assessment.PatientFollowupInstruction = new ArrayCollection();
			// moved to Control
			//model.quickInputDTO.Assessment.PatientFollowUp = new PatientFollowUpDTO();
			
			
			//Notes
			model.quickInputDTO.ModuleNotes 		= new ArrayCollection();
			model.quickInputDTO.ModuleDictations 	= new ArrayCollection();
			
			//model.quickInputDTO.PMH.ComprehensiveHistory = new ComprehensiveHistoryDTO();
			model.socialHistoryDTO 				= new SocialHistoryDTO();
			model.socialHistoryDTO.PatientID 	= model.loadedPatientId;
			//model.socialHistoryDTO.VisitID 		= model.visitDTO.VisitId;
			model.socialHistoryDTO.ModifiedAt 	= Constants.NULL_DATE;
			model.socialHistoryDTO.CreatedAt 	= Constants.NULL_DATE;
			model.socialHistoryDTO.CreatedBy 	= model.loggedInUserDTO.UserId;
			if(model.createdVisitDate!=null)
			{
				model.socialHistoryDTO.VisitDate	= model.createdVisitDate;
			}
			else
			{
				model.socialHistoryDTO.VisitDate	= Constants.NULL_DATE;
			}
			
			model.socialHistoryDTO.SocialHistoryAddictionList = new ArrayCollection();
			
		}
		
		
		
		// zahid
		public static function initializeOnLoadVisitQuickInputDTO( ) : void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			if(model.quickInputDTO == null)
			{
				model.quickInputDTO = new QuickInputDTO();
				
				//M 
				model.quickInputDTO.SignedDate = Constants.NULL_DATE;			
				
				//VISIT
				
				
				model.quickInputDTO.ClinicBranchId			= model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq;
				
				//model.quickInputDTO.VisitId 				= model.visitDTO.VisitId;
				model.quickInputDTO.ActionDate 				= new Date();
				
				model.quickInputDTO.PatientId 				= model.loadedPatientId;
			}
			if(model.quickInputDTO.Visit == null)
			{
				model.quickInputDTO.Visit 					= new VisitDTO();
				model.quickInputDTO.Visit.RecGuid 			= Constants.GUID_FORMAT;
				model.quickInputDTO.Visit.VisitDate 		= model.createdVisitDate;
				//model.quickInputDTO.Visit.VisitId 			= model.visitDTO.VisitId;
				model.quickInputDTO.Visit.DictationID 		= Constants.GUID_FORMAT;
				model.quickInputDTO.Visit.ModifiedDate 		= Constants.NULL_DATE;							
				model.quickInputDTO.Visit.SignedDate 		= Constants.NULL_DATE;
				model.quickInputDTO.Visit.CoSignedDate		= Constants.NULL_DATE;
				model.quickInputDTO.Visit.CreatedBy 		= model.loggedInUserDTO.UserId;
				model.quickInputDTO.Visit.ModifiedBy		= model.loggedInUserDTO.UserId;
				model.quickInputDTO.Visit.VisitDate			= model.createdVisitDate;
				model.quickInputDTO.Visit.CreatedAt 		= new Date();
				model.quickInputDTO.Visit.ModifiedAt 		= Constants.NULL_DATE;
			}
			
			if(model.quickInputDTO.Visit.ClinicBranch == null)
				model.quickInputDTO.Visit.ClinicBranch 		= new ClinicBranchDTO();
			if(model.quickInputDTO.Visit.UserType == null)
				model.quickInputDTO.Visit.UserType 			= new UserTypeDTO();
			if(model.quickInputDTO.Visit.SignedByUserType == null)
				model.quickInputDTO.Visit.SignedByUserType 	= new UserTypeDTO();
			
			
			
			//PMH
			
			if(model.quickInputDTO.PMH == null)
				model.quickInputDTO.PMH 					= new PMHDTO();
			if(model.quickInputDTO.PMH.Allergy == null)
				model.quickInputDTO.PMH.Allergy				= new ArrayCollection();
			if(model.quickInputDTO.PMH.ChiefComplaint == null)
				model.quickInputDTO.PMH.ChiefComplaint 		= new ArrayCollection();
			if(model.quickInputDTO.PMH.ChronicDiagnosis == null)
				model.quickInputDTO.PMH.ChronicDiagnosis 	= new ArrayCollection();
			if(model.quickInputDTO.PMH.ChronicMedication == null)
				model.quickInputDTO.PMH.ChronicMedication 	= new ArrayCollection();
			if(model.quickInputDTO.PMH.ComprehensiveHistory == null)
				model.quickInputDTO.PMH.ComprehensiveHistory = new ComprehensiveHistoryDTO;
			if(model.quickInputDTO.PMH.ComprehensiveHistory.MedicalHistory == null)
				model.quickInputDTO.PMH.ComprehensiveHistory.MedicalHistory= new ArrayCollection();
			
			//M 24 Mar 2011
			if(model.quickInputDTO.PMH.ComprehensiveHistory.FamilyHistory == null)
				model.quickInputDTO.PMH.ComprehensiveHistory.FamilyHistory= new ArrayCollection();
			
			//M 19 Mar 2011
			if(model.quickInputDTO.PMH.ComprehensiveHistory.SocialHistory == null)
				model.quickInputDTO.PMH.ComprehensiveHistory.SocialHistory = new ArrayCollection();
			if(model.quickInputDTO.PMH.Immunization == null)
				model.quickInputDTO.PMH.Immunization 		= new ArrayCollection();
			
			//model.quickInputDTO.PMH.ComprehensiveHistory.MedicalHistory.
			//Physical
			if(model.quickInputDTO.Physical == null)
				model.quickInputDTO.Physical 				= new PhysicalDTO();
			if(model.quickInputDTO.Physical.Vitals == null)
				model.quickInputDTO.Physical.Vitals 		= new VitalDTO();			
			model.quickInputDTO.Physical.Vitals.IsMetricDisplaySelected = true;
			//INIT the null values
			if(model.quickInputDTO.Physical.Vitals.Height == null)
			{
				//model.quickInputDTO.Physical.Vitals.VisitID 		= model.visitDTO.VisitId;
				model.quickInputDTO.Physical.Vitals.DictationID 	= Constants.GUID_FORMAT;
				
				model.quickInputDTO.Physical.Vitals.Height 			= "0";
				model.quickInputDTO.Physical.Vitals.Weight 			= "0";
				model.quickInputDTO.Physical.Vitals.Temperature 	= "0";
				model.quickInputDTO.Physical.Vitals.Pulse 			= "0";
				model.quickInputDTO.Physical.Vitals.Respiration 	= "0";
				model.quickInputDTO.Physical.Vitals.BPSys 			= "0";
				model.quickInputDTO.Physical.Vitals.BPDys 			= "0";
				model.quickInputDTO.Physical.Vitals.CreatedAt       = new Date();
				model.quickInputDTO.Physical.Vitals.ModifiedAt      = Constants.NULL_DATE;
				model.quickInputDTO.Physical.Vitals.ModifiedBy      = model.loggedInUserDTO.UserId;
				model.quickInputDTO.Physical.Vitals.VisitDate       = model.createdVisitDate;
				
			}
			
			if(model.quickInputDTO.Physical.HPI_CC == null)
				model.quickInputDTO.Physical.HPI_CC 			= new ArrayCollection();
			if(model.quickInputDTO.Physical.ReviewOfSystem == null)
				model.quickInputDTO.Physical.ReviewOfSystem		= new ArrayCollection();
			if(model.quickInputDTO.Physical.Labs == null)
				model.quickInputDTO.Physical.Labs 				= new ArrayCollection();
			if(model.quickInputDTO.Physical.Physicals == null)
				model.quickInputDTO.Physical.Physicals			= new ArrayCollection();
			if(model.quickInputDTO.Physical.InHouseLabs == null)
				model.quickInputDTO.Physical.InHouseLabs		= new ArrayCollection();
			
			//M TEMP model.quickInputDTO.Assessment = new AssessmentDTO();
			if(model.quickInputDTO.Assessment == null)
				model.quickInputDTO.Assessment 					= new AssessmentDTO();
			if(model.quickInputDTO.Assessment.Diagnosis == null)
				model.quickInputDTO.Assessment.Diagnosis 		= new ArrayCollection();
			if(model.quickInputDTO.Assessment.Recommendation == null)
				model.quickInputDTO.Assessment.Recommendation 	= new ArrayCollection();
			if(model.quickInputDTO.Assessment.Procedure == null)
				model.quickInputDTO.Assessment.Procedure		= new ArrayCollection();
			if(model.quickInputDTO.Assessment.PatientFollowupInstruction == null)
				model.quickInputDTO.Assessment.PatientFollowupInstruction = new ArrayCollection();
			// moved to Control
			//model.quickInputDTO.Assessment.PatientFollowUp = new PatientFollowUpDTO();
			
			
			//Notes
			if(model.quickInputDTO.ModuleNotes == null)
				model.quickInputDTO.ModuleNotes 		= new ArrayCollection();
			if(model.quickInputDTO.ModuleDictations == null)
				model.quickInputDTO.ModuleDictations 	= new ArrayCollection();
			
			//model.quickInputDTO.PMH.ComprehensiveHistory = new ComprehensiveHistoryDTO();
			if(model.socialHistoryDTO == null)
			{
				model.socialHistoryDTO 				= new SocialHistoryDTO();
				model.socialHistoryDTO.PatientID 	= model.loadedPatientId;
				//model.socialHistoryDTO.VisitID 		= model.visitDTO.VisitId;
				model.socialHistoryDTO.ModifiedAt 	= Constants.NULL_DATE;
				model.socialHistoryDTO.CreatedAt 	= Constants.NULL_DATE;
				model.socialHistoryDTO.CreatedBy 	= model.loggedInUserDTO.UserId;
				if(model.createdVisitDate!=null)
				{
					model.socialHistoryDTO.VisitDate	= model.createdVisitDate;
				}
				else
				{
					model.socialHistoryDTO.VisitDate	= Constants.NULL_DATE;
				}
			}
			if(model.socialHistoryDTO.SocialHistoryAddictionList == null)
				model.socialHistoryDTO.SocialHistoryAddictionList = new ArrayCollection();
			
		}
		
		//zahid
		
		
		
		public static function createVisitDTO(encounterTypeId:int,templateId:int) : VisitDTO
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			var visitDTO:VisitDTO				= new VisitDTO();
			visitDTO.PatientId 					= model.loadedPatientId;
			visitDTO.TemplateId 				= templateId;
			visitDTO.EncounterTypeId 			= encounterTypeId;
			visitDTO.VisitDate 					= model.createdVisitDate;
			
			visitDTO.CreatedStationID 			= model.userSelectedStationDTO.StationID;
			
			visitDTO.ClinicBranch 				= new ClinicBranchDTO();
			visitDTO.ClinicBranch.ClinicBranchIdSeq = model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq;
			//visitDTO.RecordStatus =
			//visitDTO.OwnerId =
			visitDTO.UserId 					= model.loggedInUserDTO.UserId;
			visitDTO.UserType 					= new UserTypeDTO();
			visitDTO.UserType.UserTypeId 		= model.userSelectedRoleDTO.UserTypeRole.UserTypeId;
			visitDTO.VisitStatus				= Constants.UN_SIGNED_STATUS;
			visitDTO.ModifiedDate 				= Constants.NULL_DATE;
			visitDTO.SignedDate 				= Constants.NULL_DATE;
			visitDTO.CoSignedDate				= Constants.NULL_DATE;
			visitDTO.RecGuid 					= Constants.GUID_FORMAT;
			visitDTO.DictationID 				= Constants.GUID_FORMAT;
			
			//M new fields addded in DTO
			//28 Mar 2011
			visitDTO.CreatedBy 					= model.loggedInUserDTO.UserId;
			visitDTO.ModifiedBy					= model.loggedInUserDTO.UserId;
			visitDTO.VisitDate					= model.createdVisitDate;
			visitDTO.CreatedAt 					= new Date();
			visitDTO.ModifiedAt 				= Constants.NULL_DATE;
			//model.createdVisitDate 			= model.visitDTO.VisitDate;
			return visitDTO;
			
		}
		
		public static function reinitializeInstance() : void 
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			model.allSearchEngineDTOList 		= undefined ;
			model.allQuickLinksDTOList 			= undefined;
			
			model.registrationStaticDataDTO 	= undefined;
			model.addressBookStaticDataDTO		= undefined ;
			
			/*model.citiesList					= undefined ;
			model.zipcodeList	 				= undefined;
			
			
			model.citiesListG					= undefined;
			model.zipcodeListG 					= undefined;*/
			
			
			
			model.userSearchEngineDTOList 		= undefined;
			model.userPrefferedSearchEngineDTO	= undefined;
			
			model.userQuickLinksDTOList			= undefined;
			
			model.contactSearchSuggestionList	= undefined;
			
			model.loggedInUserDTO = undefined;
			model.userSelectedClinicBranchDTO 	= undefined ;
			model.userSelectedRoleDTO  			= undefined;
			
			model.UserLoggedIn					= false; // this is for state change ....
			
			model.quicklinkEnabled				= false;
			
			model.errorStatus = undefined;
			
		}
		
		public static function unLoadLoadedPatient() : void {			
			var model : AppModelLocator = AppModelLocator.getInstance();
			model.loadedPatientId 						= 0;
			model.patientAllergyInfoDTOList				= new ArrayCollection();
			model.patientChronicMedicationInfoDTOList	= new ArrayCollection();
			model.patientImmunizationInfoDTOList		= new ArrayCollection();
			model.patientDiagnosisInfoDTOList			= new ArrayCollection();
			model.patientInsuracneInfoDTOList			= new ArrayCollection();
			
			model.userPatientProfileBarSetting			= new PatientProfileSettingResponse();
			model.userPatientProfileBarInfoPopUpData 	= new PatientProfileTaggedDTO();
			
			model.patientAllergyDTO 					= new PatientAllergyDTO();
			model.primaryInsurance						= new PatientInsuranceDTO;
			model.secondaryInsurance					= new PatientInsuranceDTO();
			
			model.patientEmergencyContactDTO			= new PatientEmergencyContactDTO();
			
			model.patientLanguageDTO					= new PatientLanguageDTO();
		}
		
		public static function initializePatientProfileDTOs() : void {			
			
			var model : AppModelLocator = AppModelLocator.getInstance();
			model.patientProfileDTO							= new PatientProfileDTO();
			
			model.patientPrimaryPhoneDTO					= new PhoneDTO();
			model.motherPrimaryPhoneDTO						= new PhoneDTO();
			model.fatherPrimaryPhoneDTO						= new PhoneDTO();
			
			model.patientAddressDTO							= new AddressDTO();
			
			model.guarantorPrimaryPhoneDTO					= new PhoneDTO();
			model.guarantorAddressDTO						= new AddressDTO();
			
			model.primaryInsurance							= new PatientInsuranceDTO();
			model.secondaryInsurance					    = new PatientInsuranceDTO();
		}
		
		public static function InitializeRegistrationGuarantorDTOs() : void 
		{			
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			model.patientGuarantorDTO 							= new PatientGuarantorDTO();
			model.patientGuarantorDTO.DOB						= Constants.NULL_DATE;
			model.patientGuarantorDTO.AddressBook 				= new AddressBookDTO();
			model.patientGuarantorDTO.AddressBook.AddressDTOlist= new ArrayCollection();
			model.patientGuarantorDTO.AddressBook.PhoneDTOlist 	= new ArrayCollection();
			model.patientGuarantorDTO.AddressBook.CreatedAt 	= Constants.NULL_DATE;
			model.patientGuarantorDTO.AddressBook.PartyID 		= Constants.GUID_FORMAT;
			model.patientGuarantorDTO.AddressBook.UpdatedAt 	= Constants.NULL_DATE;
			model.patientGuarantorDTO.RecGuid 					= Constants.GUID_FORMAT;
		}
		
		public static function InitializeHealthInfoDTO() : void 
		{		
			var model : AppModelLocator = AppModelLocator.getInstance();
			model.healthHX 										= new PatientHealthDTO();			
			model.healthHX.PatientAllergyDTOList                = new ArrayCollection();
			model.healthHX.PatientFamilyHistoryDTOList			= new ArrayCollection();
			model.healthHX.PatientMedicalHistoryDTOList			= new ArrayCollection();
			
		}
		
		public static function InitializeRegistrationDTOs() : void {	
			var model : AppModelLocator = AppModelLocator.getInstance();
			if( model.userSelectedClinicBranchDTO!=null){
				
				
				model.regEventCount 								= undefined;
				
				model.basicUserDTO									= new BaseUserDTO() ;
				model.basicUserDTO.CreatedDate 						= Constants.NULL_DATE;
				model.basicUserDTO.CreatedAt						= Constants.NULL_DATE;
				model.basicUserDTO.ModifiedAt						= Constants.NULL_DATE;
				model.basicUserDTO.AccountStatus 					= new StatusTypeDTO();
				model.basicUserDTO.AccountStatus.StatusID			= Constants.ACTIVE_STATUS_ID;
				model.basicUserDTO.ClinicBranhId 					= model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq;
				model.basicUserDTO.ActiveUserType					= new UserTypeDTO();
				model.basicUserDTO.ActiveUserType.UserTypeId		= Constants.PATIENT_USER_TYPE_ID;					
				model.basicUserDTO.UserPassword 					= Constants.PASSWORD_FOR_REGISTRATION;
				
				model.patientDTO 									= new PatientDTO();
				model.patientDTO.RecGuid 							= Constants.GUID_FORMAT;
				model.patientDTO.CreatedDate   						= Constants.NULL_DATE;		
				model.patientDTO.StatusType          				= new StatusTypeDTO();
				model.patientDTO.StatusType.StatusID				= Constants.ACTIVE_STATUS_ID;
				
				//M 4 Apr 2011
				model.patientDTO.CreatedAt							=  new Date();
				model.patientDTO.ModifiedAt							=  Constants.NULL_DATE;
				
				model.patientUserId									= undefined ;
				model.patientId										= undefined  ;
				model.registrationErrorMsg							= "";
				
				model.addressBookDTO 								= new AddressBookDTO();
				model.addressBookDTO.PhoneDTOlist 					= new ArrayCollection();
				model.addressBookDTO.AddressDTOlist 				= new ArrayCollection();
				model.addressBookDTO.CreatedAt						= Constants.NULL_DATE;
				
				
				//model.citiesList							= new ArrayCollection() ;
				//model.zipcodeList							= new ArrayCollection() ;
				
			//	model.citiesListG							= new ArrayCollection() ;
			//	model.zipcodeListG							= new ArrayCollection() ;
				
				
				
				model.patientLanguageDTOList 						= new ArrayCollection() ;
				model.allergyDTOList								= new ArrayCollection();
				model.icdCodeList									= new ArrayCollection();
				//Tahir Alvi
				model.patientEmergencyContactDTOList				= new ArrayCollection();
				model.patientGuarantorDTOList						= new ArrayCollection();
				model.patientInsuranceDTOList 						= new ArrayCollection();
				
				//allergyHistoryList								= new ArrayCollection();
				//medicalHistoryList								= new ArrayCollection();
				//familyHistoryList   							= new ArrayCollection();
			}
		}
		
		
		
		public static function cancelRegistrationDTOs() : void 
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			model.regEventCount= 0;
			model.patientGuarantorDTO 							= null;
			
			
			model.healthHX 										= null;
			
			model.patientRegImageDTO							= null;
			
			model.basicUserDTO									= null;
			
			model.patientDTO 									= null;
			
			model.patientUserId									= undefined ;
			model.patientId										= undefined  ;
			
			model.addressBookDTO 								= null;
			model.patientGuarantorDTOList						= null;
			model.patientLanguageDTOList 						= null ;
			model.patientInsuranceDTOList 						= null;
			model.allergyDTOList								= null;
			model.icdCodeList									= null;
			model.patientEmergencyContactDTOList				= null;
			
			model.registrationErrorMsg							= "";
		}
		
		
		
		public static function clearViewBackground() : void 
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			model.immunizationDTOList					= null;
			model.medicalHistoryDTOListByPatient		= null;
			model.familyHistoryDTOListByPatient			= null;
			model.socialHistoryDTOListByPatient			= null;
			model.rosDTOListVB							= null;
			model.physicalsDTOListVB					= null;
			model.vitalDTOListByPatient					= null;
			model.inHouseLabDTOListByPatient			= null;
			model.HPI_CCDTOListByPatient				= null;
			model.patientRecommendationDTOListByPatientId= null;
			model.patientFollowupDTOListByPatientId		= null;
			model.labDTOListByPatient					= null;
			model.patientProcedureDTOListByPatient		= null;
			model.prescriptionMedicationDTOList			= null;
			model.patientDiagnosisDTOListByPatientId	= null;
			
			model.quicInputAllergyDTOList				= null;
			//chronic medication
			model.medicationDTOList						= null;
			
			/*model.quicInputAllergyDTOList					= null;
			model.medicationDTOList							= null;			
			model.followupLabsDTOList						= null;		
			model.patientChronicDiagnosisDTOListByPatientId	= null;*/
		}
	}
}