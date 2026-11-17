package com.adobe.Quivus.appController 
{
	import com.adobe.Quivus.command.CombineAllergyCommand;
	import com.adobe.Quivus.command.LoadLoggedInUserImageCommand;
	import com.adobe.Quivus.command.LoadPatientLabTestsForFollowupByPatientIdCommand;
	import com.adobe.Quivus.command.LoadUserMostRecentPatientCommand;
	import com.adobe.Quivus.command.LogInCombinedCommand;
	import com.adobe.Quivus.command.LostPasswordCommand;
	import com.adobe.Quivus.command.PingServiceCommand;
	import com.adobe.Quivus.command.RegisterNewPatientCommand;
	import com.adobe.Quivus.command.SavePatientAllergyCommand;
	import com.adobe.Quivus.command.authenticate.LoginCommand;
	import com.adobe.Quivus.command.authenticate.LoginSuccessfullCommand;
	import com.adobe.Quivus.command.authenticate.SignOutCommand;
	import com.adobe.Quivus.command.authenticate.UpdateUserSessionCommand;
	import com.adobe.Quivus.command.authenticate.UpdateUserSessionStatusCommand;
	import com.adobe.Quivus.command.authenticate.VerifyUserMainCommand;
	import com.adobe.Quivus.command.communication.GetClinicUserDetailsCommand;
	import com.adobe.Quivus.command.communication.videochat.GetIncomingVideoChatSessionCommand;
	import com.adobe.Quivus.command.communication.videochat.GetOutgoingVideoChatSessionCommand;
	import com.adobe.Quivus.command.communication.videochat.VideoCallAcceptCommand;
	import com.adobe.Quivus.command.communication.videochat.VideoCallNotificationCommand;
	import com.adobe.Quivus.command.communication.videochat.VideoCallRejectCommand;
	import com.adobe.Quivus.command.ePrescription.GetANSUrlCommand;
	import com.adobe.Quivus.command.ePrescription.GetUrlForEditAllergiesCommand;
	import com.adobe.Quivus.command.ePrescription.GetUrlForEditMedicationCommand;
	import com.adobe.Quivus.command.ePrescription.GetUrlForEditPrescriptionCommand;
	import com.adobe.Quivus.command.ePrescription.PrepareLoginCallForEprescriptionCommand;
	import com.adobe.Quivus.command.ePrescription.SyncEPrescriptionCommand;
	import com.adobe.Quivus.command.email.GetEmailByUserIdCommand;
	import com.adobe.Quivus.command.email.SendEmailCommand;
	import com.adobe.Quivus.command.patientProfile.LoadPatientImageCommand;
	import com.adobe.Quivus.command.patientProfile.LoadPatientProfileCommand;
	import com.adobe.Quivus.command.patientProfile.LoadPatientProfileMergeCommand;
	import com.adobe.Quivus.command.patientProfileCustomization.LoadPatientHistoryPopupDataCommand;
	import com.adobe.Quivus.command.patientProfileCustomization.LoadPatientProfileCustomizedSettingCommand;
	import com.adobe.Quivus.command.patientProfileCustomization.LoadPatientProfilePopUpDataCommand;
	import com.adobe.Quivus.command.patientProfileCustomization.ManageUserPatientProfileBarSettingCommand;
	import com.adobe.Quivus.command.quickInput.DeleteComprehensiveModuleDatabyPatientIDCommand;
	import com.adobe.Quivus.command.quickInput.DeleteTempQuickInputCommand;
	import com.adobe.Quivus.command.quickInput.LoadQuickInputByVisitIdCommand;
	import com.adobe.Quivus.command.quickInput.LoadTempQuickInputByFileNameCommand;
	import com.adobe.Quivus.command.quickInput.ManageQuickInputCommand;
	import com.adobe.Quivus.command.quickInput.SaveFamilyHistoryCommand;
	import com.adobe.Quivus.command.quickInput.SaveSocialHistoryCommand;
	import com.adobe.Quivus.command.quickInput.SaveTempQuickInputCommand;
	import com.adobe.Quivus.command.quickInput.VerifyTempQuickInputCommand;
	import com.adobe.Quivus.command.quickInput.diagnosis.LoadDiagnosisForRecommendationByPatientIdCommand;
	import com.adobe.Quivus.command.quickInput.diagnosis.LoadPatientAllChronicDiagnosisByPatientIdCommand;
	import com.adobe.Quivus.command.quickInput.diagnosis.LoadPatientDiagnosisByVisitIdCommand;
	import com.adobe.Quivus.command.quickInput.diagnosis.ManageCustomICDCodeCommand;
	import com.adobe.Quivus.command.quickInput.soapNote.GenerateSoapNoteByVisitIDCommand;
	import com.adobe.Quivus.command.quickInput.soapNote.GenerateSoapNotePreviewMainCommand;
	import com.adobe.Quivus.command.quickLink.LoadUserQuickLinksCommand;
	import com.adobe.Quivus.command.registration.RegisterPatientProfileAndLanguageCommand;
	import com.adobe.Quivus.command.registration.RegisterUserProfileCommand;
	import com.adobe.Quivus.command.registration.SaveAddressBookCommand;
	import com.adobe.Quivus.command.registration.SavePatientEmergencyContactCommand;
	import com.adobe.Quivus.command.registration.SavePatientGuarantorCommand;
	import com.adobe.Quivus.command.registration.SavePatientHealthInfoCommand;
	import com.adobe.Quivus.command.registration.SavePatientImageCommand;
	import com.adobe.Quivus.command.registration.SavePatientInsuranceCommand;
	import com.adobe.Quivus.command.search.LoadContactSearchSuggestionListCommand;
	import com.adobe.Quivus.command.search.PatientSearchCommand;
	import com.adobe.Quivus.command.search.SearchAllergyTypeByNameCommand;
	import com.adobe.Quivus.command.search.SearchICDCodeByCodeCommand;
	import com.adobe.Quivus.command.search.SearchICDCommand;
	import com.adobe.Quivus.command.search.searchEngine.ChangeDefaultSearchEngineCommand;
	import com.adobe.Quivus.command.search.searchEngine.LoadUserSearchEngineCommand;
	import com.adobe.Quivus.command.search.searchEngine.ManageUserSearchEnginesCommand;
	import com.adobe.Quivus.command.security.LoadClinicGeneralSettingMainCommand;
	import com.adobe.Quivus.command.security.LoadUserAccessRightCommand;
	import com.adobe.Quivus.command.security.LogInUnlockCommand;
	import com.adobe.Quivus.command.staticData.LoadAllModuleTypesCommand;
	import com.adobe.Quivus.command.staticData.LoadAllSearchEnginesCommand;
	import com.adobe.Quivus.command.staticData.LoadImageTypesStaticDataCommand;
	import com.adobe.Quivus.command.staticData.LoadProfileBarStaticDataCommand;
	import com.adobe.Quivus.command.staticData.LoadUserSessionCommand;
	import com.adobe.Quivus.command.staticData.addressBook.LoadAddressBookStaticDataCommand;
	import com.adobe.Quivus.command.staticData.addressBook.LoadCitiesByStateIdCommand;
	import com.adobe.Quivus.command.staticData.comprehensiveHistory.LoadFamilyDiseaseStaticDataCommand;
	import com.adobe.Quivus.command.staticData.comprehensiveHistory.LoadFamilyHistoryTypesCommand;
	import com.adobe.Quivus.command.staticData.comprehensiveHistory.LoadGeneralHistoryTypesCommand;
	import com.adobe.Quivus.command.staticData.comprehensiveHistory.LoadSocialHistoryMediumTypesStaticDataCommand;
	import com.adobe.Quivus.command.staticData.comprehensiveHistory.LoadSocialHistoryTypesCommand;
	import com.adobe.Quivus.command.staticData.comprehensiveHistory.LoadSocialHistoryUsageAmountStaticDataCommand;
	import com.adobe.Quivus.command.staticData.document.LoadSearchByTypeStaticDataCommand;
	import com.adobe.Quivus.command.staticData.immunization.LoadImmunizationDoseStaticDataCommand;
	import com.adobe.Quivus.command.staticData.immunization.LoadImmunizationLotNumberStaticDataCommand;
	import com.adobe.Quivus.command.staticData.immunization.LoadImmunizationManufacturerStaticDataCommand;
	import com.adobe.Quivus.command.staticData.immunization.LoadImmunizationRefusalReasonStaticDataCommand;
	import com.adobe.Quivus.command.staticData.immunization.LoadImmunizationRoutStaticDataCommand;
	import com.adobe.Quivus.command.staticData.immunization.LoadImmunizationSeriesStaticDataCommand;
	import com.adobe.Quivus.command.staticData.immunization.LoadImmunizationSiteStaticDataCommand;
	import com.adobe.Quivus.command.staticData.immunization.LoadImmunizationTypesStaticDataCommand;
	import com.adobe.Quivus.command.staticData.lab.LoadInHouseLabTestTypeByClinicIdCommand;
	import com.adobe.Quivus.command.staticData.lab.LoadLabTestNatureTypeStaticDataCommand;
	import com.adobe.Quivus.command.staticData.lab.LoadLabTestOrderMethodTypeStaticDataCommand;
	import com.adobe.Quivus.command.staticData.lab.LoadLabTestPriorityTypeStaticDataCommand;
	import com.adobe.Quivus.command.staticData.lab.LoadLabTestSpecimenTypeStaticDataCommand;
	import com.adobe.Quivus.command.staticData.lab.LoadLabTypeStaticDataCommand;
	import com.adobe.Quivus.command.staticData.patientsData.LoadCurrentDayAddedPatientsCommand;
	import com.adobe.Quivus.command.staticData.patientsData.LoadPatientsByPracticeIdCommand;
	import com.adobe.Quivus.command.staticData.physical.LoadPhysicalStaticDataCommand;
	import com.adobe.Quivus.command.staticData.recommendation.LoadAllDurationTypesCommand;
	import com.adobe.Quivus.command.staticData.recommendation.LoadAllLinksCommand;
	import com.adobe.Quivus.command.staticData.recommendation.LoadAllMethodTypesCommand;
	import com.adobe.Quivus.command.staticData.recommendation.LoadAllPlanTypesCommand;
	import com.adobe.Quivus.command.staticData.registration.LoadInsuranceOrganizationsCommand;
	import com.adobe.Quivus.command.staticData.registration.LoadRegistrationStaticDataCommand;
	import com.adobe.Quivus.command.staticData.registration.LoadSpecifiedRegistrationStaticDataCommand;
	import com.adobe.Quivus.command.staticData.ros.LoadROSStaticDataCommand;
	import com.adobe.Quivus.command.staticData.visit.LoadSoapTemplatesCommand;
	import com.adobe.Quivus.command.staticData.visit.LoadVisitEncounterTypesCommand;
	import com.adobe.Quivus.command.viewBackground.allergy.LoadPatientAllergyByPatientIdCommand;
	import com.adobe.Quivus.command.viewBackground.comprehensiveHistory.LoadFamilyHistoryByPatientIdCommand;
	import com.adobe.Quivus.command.viewBackground.comprehensiveHistory.LoadMedicalHistoryByPatientIdCommand;
	import com.adobe.Quivus.command.viewBackground.comprehensiveHistory.LoadPatientFamilyHistoryByVisitIdCommand;
	import com.adobe.Quivus.command.viewBackground.comprehensiveHistory.LoadPatientMedicalHistoryByVisitIdCommand;
	import com.adobe.Quivus.command.viewBackground.comprehensiveHistory.LoadPatientSocialHistoryByVisitIdCommand;
	import com.adobe.Quivus.command.viewBackground.comprehensiveHistory.LoadSocialHistoryByPatientIdCommand;
	import com.adobe.Quivus.command.viewBackground.comprehensiveHistory.ManagePatientFamilyHistoryCommand;
	import com.adobe.Quivus.command.viewBackground.comprehensiveHistory.ManagePatientMedicalHistoryCommand;
	import com.adobe.Quivus.command.viewBackground.comprehensiveHistory.ManagePatientSocialHistoryCommand;
	import com.adobe.Quivus.command.viewBackground.diagnosis.LoadPatientChronicDiagnosisByPatientIdCommand;
	import com.adobe.Quivus.command.viewBackground.diagnosis.LoadPatientDiagnosisAcuteByPatientIdCommand;
	import com.adobe.Quivus.command.viewBackground.diagnosis.LoadPatientDiagnosisChronicByPatientIdCommand;
	import com.adobe.Quivus.command.viewBackground.diagnosis.LoadPatientDiagnosisResolvedByPatientIdCommand;
	import com.adobe.Quivus.command.viewBackground.dictation.LoadModuleDictationsByPatientIdCommand;
	import com.adobe.Quivus.command.viewBackground.document.LoadPatientDocumentByPatientIdCommand;
	import com.adobe.Quivus.command.viewBackground.document.LoadSectionTypesCommand;
	import com.adobe.Quivus.command.viewBackground.document.SearchPatientDocumentByPatientIdCommand;
	import com.adobe.Quivus.command.viewBackground.followUp.LoadPatientFollowUpByPatientIdCommand;
	import com.adobe.Quivus.command.viewBackground.followUp.LoadPatientFollowUpInstructionByPatientIdCommand;
	import com.adobe.Quivus.command.viewBackground.followUp.LoadPatientFollowUpInstructionByVisitIdCommand;
	import com.adobe.Quivus.command.viewBackground.followUp.ManagePatientFollowUpInstructionCommand;
	import com.adobe.Quivus.command.viewBackground.hpi.LoadPatientHPIByPatientIdCommand;
	import com.adobe.Quivus.command.viewBackground.immunization.LoadPatientImmunizationCommand;
	import com.adobe.Quivus.command.viewBackground.immunization.LoadPatientVisitImmunizationCommand;
	import com.adobe.Quivus.command.viewBackground.lab.LoadPatientInHouseLabsByPatientIdCommand;
	import com.adobe.Quivus.command.viewBackground.lab.LoadPatientInHouseLabsByVisitIdCommand;
	import com.adobe.Quivus.command.viewBackground.lab.LoadPatientLabsByPatientIdCommand;
	import com.adobe.Quivus.command.viewBackground.lab.ManagePatientInHouseLabResultsCommand;
	import com.adobe.Quivus.command.viewBackground.lab.ManagePatientInHouseLabsCommand;
	import com.adobe.Quivus.command.viewBackground.lab.ManagePatientLabsCommand;
	import com.adobe.Quivus.command.viewBackground.notes.LoadModuleNotesByPatientIdCommand;
	import com.adobe.Quivus.command.viewBackground.notes.LoadModuleNotesCommand;
	import com.adobe.Quivus.command.viewBackground.notes.ManageModuleNotesCommand;
	import com.adobe.Quivus.command.viewBackground.physical.LoadPatientPhysicalsByPatientIdCommand;
	import com.adobe.Quivus.command.viewBackground.physical.ManagePatientPhysicalCommand;
	import com.adobe.Quivus.command.viewBackground.prescription.LoadPatientPrescriptionByPatientIdCommand;
	import com.adobe.Quivus.command.viewBackground.prescription.LoadPrescriptionMedicationByPatientPrescriptionIdCommand;
	import com.adobe.Quivus.command.viewBackground.procedure.LoadPatientProcedureByPatientIdCommand;
	import com.adobe.Quivus.command.viewBackground.recommendation.LoadPatientRecommendationByPatientIdCommand;
	import com.adobe.Quivus.command.viewBackground.recommendation.ManagePatientRecommendationCommand;
	import com.adobe.Quivus.command.viewBackground.ros.LoadPatientROSByPatientIdCommand;
	import com.adobe.Quivus.command.viewBackground.ros.ManagePatientROSCommand;
	import com.adobe.Quivus.command.viewBackground.summary.LoadSummaryCommand;
	import com.adobe.Quivus.command.viewBackground.vital.LoadPatientVitalByVisitCommand;
	import com.adobe.Quivus.command.viewBackground.vital.LoadPatientVitalsByPatientIdCommand;
	import com.adobe.Quivus.command.visit.CoSignVisitMainCommand;
	import com.adobe.Quivus.command.visit.CreateVisitCommand;
	import com.adobe.Quivus.command.visit.ImportVisitByPatientIdCommand;
	import com.adobe.Quivus.command.visit.LoadPatientVisitListCommand;
	import com.adobe.Quivus.command.visit.LoadPatientVisitsByProviderIDCommand;
	import com.adobe.Quivus.command.visit.LoadVisitPhysiciansbyClinicBranchIDCommand;
	import com.adobe.Quivus.command.visit.LoadVisitStakeHoldersByVisitIdCommand;
	import com.adobe.Quivus.command.visit.SignVisitMainCommand;
	import com.adobe.Quivus.command.visit.UpdateVisitCommand;
	import com.adobe.cairngorm.control.FrontController;
	
	
	
	public class AppController extends FrontController {
		
		public static const COMBINE_ALLERGY_EVENT : String 	=						"COMBINE_ALLERGY_EVENT";
		public static const PING_SERVICE_EVENT : String 	=						"PING_SERVICE_EVENT";
		public static const LOGIN_COMBINED_EVENT : String 	=						"LOGIN_COMBINED_EVENT";
		public static const LOGIN_UNLOCK_EVENT : String 	=						"LOGIN_UNLOCK_EVENT";
		public static const LOGIN_EVENT : String =									"LOGIN_EVENT";
		public static const LOST_PASSWORD_EVENT : String =							"LOST_PASSWORD_EVENT";
		public static const GET_ANS_URL_EVENT : String =							"GET_ANS_URL_EVENT";
		public static const SYNC_E_PRESCRIPTION_EVENT : String =					"SYNC_E_PRESCRIPTION_EVENT";
		public static const VERIFY_USER_MAIN_EVENT : String =						"VERIFY_USER_MAIN_EVENT";
		public static const LOAD_ALL_PLAN_TYPES : String =							"LOAD_ALL_PLAN_TYPES";
		public static const LOAD_ALL_METHOD_TYPES : String =						"LOAD_ALL_METHOD_TYPES";
		public static const LOAD_ALL_LINKS : String =								"LOAD_ALL_LINKS";
		public static const LOAD_ALL_DURATION_TYPES : String =						"LOAD_ALL_DURATION_TYPES";
		public static const CREATE_VISIT_EVENT : String =							"CREATE_VISIT_EVENT";
		public static const UPDATE_VISIT_EVENT : String =							"UPDATE_VISIT_EVENT";
		public static const LOAD_ICD_CODE_EVENT : String =							"LOAD_ICD_CODE_EVENT";
		public static const CO_SIGN_VISIT_MAIN_EVENT : String =						"CO_SIGN_VISIT_MAIN_EVENT";
		public static const LOAD_VISIT_PHYSICIANS_BY_CLINIC_BRANCH_ID_EVENT : String =							"LOAD_VISIT_PHYSICIANS_BY_CLINIC_BRANCH_ID_EVENT";
		public static const SAVE_PATIENT_IMAGE_EVENT : String =						"SAVE_PATIENT_IMAGE_EVENT";
		public static const LOAD_PATIENT_IMAGE_EVENT : String =						"LOAD_PATIENT_IMAGE_EVENT";
		public static const MANAGE_PATIENT_SOCIAL_HISTORY_EVENT : String =			"MANAGE_PATIENT_SOCIAL_HISTORY_EVENT";
		public static const MANAGE_PATIENT_MEDICAL_HISTORY_EVENT : String =			"MANAGE_PATIENT_MEDICAL_HISTORY_EVENT";
		public static const MANAGE_PATIENT_FAMILY_HISTORY_EVENT : String =			"MANAGE_PATIENT_FAMILY_HISTORY_EVENT";
		public static const GET_URL_FOR_EDIT_ALLERGIES_EVENT : String =				"GET_URL_FOR_EDIT_ALLERGIES_EVENT";
		public static const GET_URL_FOR_EDIT_PRESCRIPTION_EVENT : String =			"GET_URL_FOR_EDIT_PRESCRIPTION_EVENT";
		public static const GET_URL_FOR_EDIT_MEDICATION_EVENT : String =			"GET_URL_FOR_EDIT_MEDICATION_EVENT";
		
		public static const MANAGE_PATIENT_IN_HOUSE_LAB_RESULTS_EVENT : String =	"MANAGE_PATIENT_IN_HOUSE_LAB_RESULTS_EVENT";
		public static const LOAD_PATIENT_PROCEDURE_BY_PATIENT_ID_EVENT : String =	"LOAD_PATIENT_PROCEDURE_BY_PATIENT_ID_EVENT";
		public static const MANAGE_PATIENT_IN_HOUSE_LABS_EVENT : String =			"MANAGE_PATIENT_IN_HOUSE_LABS_EVENT";
		public static const MANAGE_PATIENT_PROCEDURE_EVENT : String =				"MANAGE_PATIENT_PROCEDURE_EVENT";
		public static const MANAGE_PATIENT_LABS_EVENT : String =					"MANAGE_PATIENT_LABS_EVENT";
		public static const MANAGE_PATIENT_VITALS_EVENT : String =					"MANAGE_PATIENT_VITALS_EVENT";
		public static const LOAD_PATIENT_LABS_BY_VISIT_ID_EVENT : String =			"LOAD_PATIENT_LABS_BY_VISIT_ID_EVENT";
		public static const LOAD_PATIENT_LABS_BY_PATIENT_ID_EVENT : String =		"LOAD_PATIENT_LABS_BY_PATIENT_ID_EVENT";
		public static const LOAD_PATEINT_IN_HOUSE_LABS_BY_VISIT_ID_EVENT : String =	"LOAD_PATEINT_IN_HOUSE_LABS_BY_VISIT_ID_EVENT";
		public static const LOAD_PATIENT_IN_HOUSE_LABS_BY_PATIENT_ID_EVENT :String ="LOAD_PATIENT_IN_HOUSE_LABS_BY_PATIENT_ID_EVENT";
		public static const LOAD_PATIENT_HPI_BY_VISIT_ID_EVENT : String =			"LOAD_PATIENT_HPI_BY_VISIT_ID_EVENT";
		public static const LOAD_PATIENT_HPI_BY_PATIENT_ID_EVENT : String =			"LOAD_PATIENT_HPI_BY_PATIENT_ID_EVENT";
		
		public static const LOAD_PATIENT_DOCUMENT_BY_PATIENT_ID_EVENT : String =	"LOAD_PATIENT_DOCUMENT_BY_PATIENT_ID_EVENT";
		public static const SEARCH_PATIENT_DOCUMENT_BY_PATIENT_ID_EVENT : String =	"SEARCH_PATIENT_DOCUMENT_BY_PATIENT_ID_EVENT";
		
		public static const MANAGE_PATIENT_HPI_EVENT : String =						"MANAGE_PATIENT_HPI_EVENT";
		public static const LOAD_FOLLOW_UP_METHOD_TYPE_EVENT : String =				"LOAD_FOLLOW_UP_METHOD_TYPE_EVENT";
		public static const LOAD_FOLLOW_UP_DATE_CONTROL_TYPE_EVENT : String =		"LOAD_FOLLOW_UP_DATE_CONTROL_TYPE_EVENT";
		public static const LOAD_INSTRUCTION_AGE_TYPE_EVENT : String =				"LOAD_INSTRUCTION_AGE_TYPE_EVENT";
		public static const LOAD_INSTRUCTION_AGE_VALUE_TYPE_EVENT : String =		"LOAD_INSTRUCTION_AGE_VALUE_TYPE_EVENT";
		public static const LOAD_INSTRUCTION_DURATION_TYPE_EVENT : String =			"LOAD_INSTRUCTION_DURATION_TYPE_EVENT";
		public static const LOAD_SERVICE_TYPE_EVENT : String =						"LOAD_SERVICE_TYPE_EVENT";
		public static const LOAD_QUICK_INPUT_BY_VISIT_ID_EVENT : String =			"LOAD_QUICK_INPUT_BY_VISIT_ID_EVENT";
		public static const LOAD_SOAP_NOTE_BY_VISIT_ID_EVENT 	: String =			"LOAD_SOAP_NOTE_BY_VISIT_ID_EVENT";
		//public static const GENERATE_SOAP_NOTE_PREVIEW_EVENT 	: String =			"GENERATE_SOAP_NOTE_PREVIEW_EVENT";
		public static const GENERATE_SOAP_NOTE_PREVIEW_MAIN_EVENT 	: String =			"GENERATE_SOAP_NOTE_PREVIEW_MAIN_EVENT";
		public static const LOAD_HPI_STATIC_DATA_EVENT : String =					"LOAD_HPI_STATIC_DATA_EVENT";
		public static const LOAD_PHYSICAL_STATIC_DATA_EVENT : String =				"LOAD_PHYSICAL_STATIC_DATA_EVENT";
		public static const LOAD_ROS_STATIC_DATA_EVENT : String =					"LOAD_ROS_STATIC_DATA_EVENT";
		public static const LOAD_LIONIC_LAB_TEST_TYPE_EVENT : String =				"LOAD_LIONIC_LAB_TEST_TYPE_EVENT";
		public static const LOAD_PATIENT_MOST_RECENT_VITALS_EVENT : String =		"LOAD_PATIENT_MOST_RECENT_VITALS_EVENT";
		public static const MANAGE_PATIENT_TREATMENT_EVENT : String =				"MANAGE_PATIENT_TREATMENT_EVENT";
		public static const MANAGE_PATIENT_ROS_EVENT : String =						"MANAGE_PATIENT_ROS_EVENT";
		public static const LOAD_PATIENT_ROS_BY_PATIENT_ID_EVENT : String =			"LOAD_PATIENT_ROS_BY_PATIENT_ID_EVENT";
		public static const LOAD_PATIENT_PHYSICALS_BY_PATIENT_ID_EVENT : String =	"LOAD_PATIENT_PHYSICALS_BY_PATIENT_ID_EVENT";
		public static const MANAGE_PATIENT_PHYSICAL_EVENT : String =				"MANAGE_PATIENT_PHYSICAL_EVENT";
		public static const LOAD_PATIENT_VITAL_BY_VISIT_EVENT : String =			"LOAD_PATIENT_VITAL_BY_VISIT_EVENT";
		public static const LOAD_PATIENT_VITALS_BY_PATIENT_ID_EVENT : String =		"LOAD_PATIENT_VITALS_BY_PATIENT_ID_EVENT";
		public static const LOAD_LAB_TYPE_STATIC_DATA_EVENT : String =				"LOAD_LAB_TYPE_STATIC_DATA_EVENT";
		public static const LOAD_LAB_TEST_TYPE_STATIC_DATA_EVENT : String =			"LOAD_LAB_TEST_TYPE_STATIC_DATA_EVENT";
		public static const LOAD_LAB_TEST_NATURE_TYPE_STATIC_DATE_EVENT : String =	"LOAD_LAB_TEST_NATURE_TYPE_STATIC_DATE_EVENT";
		public static const LOAD_GENERAL_HISTORY_TYPES_EVENT : String =				"LOAD_GENERAL_HISTORY_TYPES_EVENT";
		public static const LOAD_FAMILY_HISTORY_TYPES_EVENT : String =				"LOAD_FAMILY_HISTORY_TYPES_EVENT";
		public static const LOAD_SOCIAL_HISTORY_TYPES_EVENT : String =				"LOAD_SOCIAL_HISTORY_TYPES_EVENT";
		public static const SIGN_VISIT_MAIN_EVENT : String =						"SIGN_VISIT_MAIN_EVENT";
		public static const MANAGE_VISIT_OWNER_EVENT : String =						"MANAGE_VISIT_OWNER_EVENT";
		public static const PREPARE_LOGIN_CALL_FOR_E_PRESCRIPTION_EVENT : String =	"PREPARE_LOGIN_CALL_FOR_E_PRESCRIPTION_EVENT";
		public static const LOAD_LOGGED_IN_USER_IMAGE_EVENT : String =				"LOAD_LOGGED_IN_USER_IMAGE_EVENT";
		public static const LOAD_ALL_MODULE_TYPES : String =						"LOAD_ALL_MODULE_TYPES";
		
		public static const LOAD_SEARCH_BY_TYPE_STATIC_DATA_EVENT : String =		"LOAD_SEARCH_BY_TYPE_STATIC_DATA_EVENT";
		
		public static const LOAD_ALL_HPI_DETAIL_TYPES_EVENT : String =				"LOAD_ALL_HPI_DETAIL_TYPES_EVENT";
		public static const LOAD_PATIENT_VISIT_IMMUNIZATION_EVENT : String =		"LOAD_PATIENT_VISIT_IMMUNIZATION_EVENT";
		public static const LOAD_PATIENT_IMMUNIZATION_EVENT : String =				"LOAD_PATIENT_IMMUNIZATION_EVENT";
		public static const MANAGE_MODULE_NOTES_EVENT : String =					"MANAGE_MODULE_NOTES_EVENT";
		public static const LOAD_MODULE_NOTES_EVENT : String =						"LOAD_MODULE_NOTES_EVENT";
		public static const LOAD_IMMUNIZATION_ROUT_STATIC_DATA_EVENT : String =		"LOAD_IMMUNIZATION_ROUT_STATIC_DATA_EVENT";
		public static const MANAGE_PATIENT_IMMUNIZATION_EVENT : String =			"MANAGE_PATIENT_IMMUNIZATION_EVENT";
		public static const LOAD_IMMUNIZATION_SERIES_STATIC_DATA_EVENT : String =	"LOAD_IMMUNIZATION_SERIES_STATIC_DATA_EVENT";
		public static const LOAD_IMMUNIZATION_SITES_STATIC_DATA_EVENT : String =	"LOAD_IMMUNIZATION_SITES_STATIC_DATA_EVENT";
		public static const LOAD_IMMUNIZATION_DOSE_STATIC_DATA_EVENT : String =		"LOAD_IMMUNIZATION_DOSE_STATIC_DATA_EVENT";
		public static const LOAD_IMMUNIZATION_TYPES_STATIC_DATA_EVENT : String =	"LOAD_IMMUNIZATION_TYPES_STATIC_DATA_EVENT";
		public static const LOAD_SOAP_TEMPLATES_EVENT : String =					"LOAD_SOAP_TEMPLATES_EVENT";
		public static const LOAD_VISIT_ENCOUNTER_TYPES_EVENT : String =				"LOAD_VISIT_ENCOUNTER_TYPES_EVENT";
		public static const MANAGE_QUICK_INPUT_EVENT : String =						"MANAGE_QUICK_INPUT_EVENT";
		public static const LOAD_PATIENT_VISIT_LIST_EVENT : String =				"LOAD_PATIENT_VISIT_LIST_EVENT";
		public static const LOAD_PATIENT_VISITS_BY_PROVIDER_ID_EVENT : String =		"LOAD_PATIENT_VISITS_BY_PROVIDER_ID_EVENT";
		public static const LOAD_PATIENT_PROFILE_EVENT : String =					"LOAD_PATIENT_PROFILE_EVENT";
		public static const LOAD_IMAGE_TYPES_STATIC_DATA_EVENT : String =			"LOAD_IMAGE_TYPES_STATIC_DATA_EVENT";
		public static const MANAGE_USER_SEARCH_ENGINES_EVENT : String =				"MANAGE_USER_SEARCH_ENGINES_EVENT";
		public static const LOAD_PATIENT_HISTORY_POPUP_DATA_EVENT : String =		"LOAD_PATIENT_HISTORY_POPUP_DATA_EVENT";
		public static const LOAD_PATIENT_PROFILE_POP_UP_DATA_EVENT : String =		"LOAD_PATIENT_PROFILE_POP_UP_DATA_EVENT";
		public static const GET_EMAIL_BY_USER_ID_EVENT : String =					"GET_EMAIL_BY_USER_ID_EVENT";
		public static const LOAD_PROFILE_BAR_STATIC_DATA_EVENT : String =			"LOAD_PROFILE_BAR_STATIC_DATA_EVENT";
		public static const SAVE_PATIENT_ALLERGY_EVENT : String =					"SAVE_PATIENT_ALLERGY_EVENT";
		public static const LOAD_USER_MOST_RECENT_PATIENT_EVENT : String =			"LOAD_USER_MOST_RECENT_PATIENT_EVENT";
		public static const PATIENT_SEARCH_EVENT : String =							"PATIENT_SEARCH_EVENT";
		public static const LOGIN_SUCCESSFULL_EVENT : String =						"LOGIN_SUCCESSFULL_EVENT";
		
		public static const UPDATE_USER_SESSION_EVENT : String =					"UPDATE_USER_SESSION_EVENT";
		
		public static const SIGN_OUT_EVENT : String =								"SIGN_OUT_EVENT";
		
		public static const LOAD_USER_SEARCH_ENGINE_EVENT : String =				"LOAD_USER_SEARCH_ENGINE_EVENT";
		public static const LOAD_USER_QUICK_LINKS_EVENT : String =					"LOAD_USER_QUICK_LINKS_EVENT";
		public static const LOAD_ALL_SEARCH_ENGINS_EVENT : String =					"LOAD_ALL_SEARCH_ENGINS_EVENT";
		public static const LOAD_CONTACT_SEARCH_SUGGESTION_LIST_EVENT : String =	"LOAD_CONTACT_SEARCH_SUGGESTION_LIST_EVENT";
		public static const SEND_EMAIL_EVENT : String =								"SEND_EMAIL_EVENT";
		public static const SET_DEFAULT_SEARCH_ENGINE_EVENT : String =				"SET_DEFAULT_SEARCH_ENGINE_EVENT";
		public static const LOAD_REGISTRATION_STATIC_DATA_EVENT : String =			"LOAD_REGISTRATION_STATIC_DATA_EVENT";
		public static const REGISTER_NEW_PATIENT_EVENT : String =					"REGISTER_NEW_PATIENT_EVENT";
		public static const LOAD_CITIES_BY_STATE_ID_EVENT : String =				"LOAD_CITIES_BY_STATE_ID_EVENT";
		public static const LOAD_ADDRESS_BOOK_STATIC_DATA_EVENT : String =			"LOAD_ADDRESS_BOOK_STATIC_DATA_EVENT";
		public static const REGISTER_USER_PROFILE_EVENT : String =					"REGISTER_USER_PROFILE_EVENT";
		public static const SAVE_PATIENT_EMERGENCY_CONTACT_EVENT : String =			"SAVE_PATIENT_EMERGENCY_CONTACT_EVENT";		
		public static const SAVE_PATIENT_GURANTOR_EVENT : String =					"SAVE_PATIENT_GURANTOR_EVENT";
		public static const SAVE_PATIENT_INSURANCE_EVENT : String =					"SAVE_PATIENT_INSURANCE_EVENT";		
		public static const SAVE_ADDRESS_BOOK_EVENT : String =						"SAVE_ADDRESS_BOOK_EVENT";
		public static const SAVE_PATIENT_HEALTH_HX_EVENT : String =					"SAVE_PATIENT_HEALTH_HX_EVENT";
		public static const SEARCH_ALLERGY_TYPE_BY_NAME_EVENT : String =			"SEARCH_ALLERGY_TYPE_BY_NAME_EVENT";		
		public static const SEARCH_ICD_CODE_BY_CODE_EVENT : String =				"SEARCH_ICD_CODE_BY_CODE_EVENT";
		public static const LOAD_VISIT_STAKEHOLDERS_BY_VISITID_EVENT : String =		"LOAD_VISIT_STAKEHOLDERS_BY_VISITID_EVENT";
		public static const LOAD_CPT_MEDICAL_TYPES_EVENT : String =					"LOAD_CPT_MEDICAL_TYPES_EVENT";
		public static const LOAD_PATEINT_PRESCRIPTION_BY_PATIENT_ID_EVENT :String =	"LOAD_PATEINT_PRESCRIPTION_BY_PATIENT_ID_EVENT";
		
		public static const LOAD_SPECIFIED_REGISTRATION_STATIC_DATA_EVENT : String =		"LOAD_SPECIFIED_REGISTRATION_STATIC_DATA_EVENT";
		public static const LOAD_FAMILY_DISEASE_STATIC_DATA_EVENT : String =				"LOAD_FAMILY_DISEASE_STATIC_DATA_EVENT";
		public static const LOAD_IMMUNIZATION_MANUFACTURER_STATIC_DATA_EVENT : String =		"LOAD_IMMUNIZATION_MANUFACTURER_STATIC_DATA_EVENT";
		public static const LOAD_SOCIAL_HISTORY_USAGE_AMOUNT_STATIC_DATA_EVENT : String =	"LOAD_SOCIAL_HISTORY_USAGE_AMOUNT_STATIC_DATA_EVENT";
		public static const LOAD_SOCIAL_HISTORY_MEDIUM_TYPES_STATIC_DATA_EVENT : String =	"LOAD_SOCIAL_HISTORY_MEDIUM_TYPES_STATIC_DATA_EVENT";
		public static const LOAD_LAB_TEST_ORDER_METHOD_TYPE_STATIC_DATA_EVENT : String =	"LOAD_LAB_TEST_ORDER_METHOD_TYPE_STATIC_DATA_EVENT";
		public static const LOAD_PATIENT_SOCIAL_HISTORY_BY_VISIT_ID_EVENT : String =		"LOAD_PATIENT_SOCIAL_HISTORY_BY_VISIT_ID_EVENT";
		public static const LOAD_PATIENT_MEDICAL_HISTORY_BY_VISIT_ID_EVENT : String=		"LOAD_PATIENT_MEDICAL_HISTORY_BY_VISIT_ID_EVENT";
		public static const LOAD_MEDICAL_HISTORY_BY_PATIENT_ID_EVENT : String=				"LOAD_MEDICAL_HISTORY_BY_PATIENT_ID_EVENT";
		public static const LOAD_SOCIAL_HISTORY_BY_PATIENT_ID_EVENT : String=				"LOAD_SOCIAL_HISTORY_BY_PATIENT_ID_EVENT";
		public static const LOAD_PATIENT_FAMILY_HISTORY_BY_VISIT_ID_EVENT : String =		"LOAD_PATIENT_FAMILY_HISTORY_BY_VISIT_ID_EVENT";
		public static const LOAD_FAMILY_HISTORY_BY_PATIENT_ID_EVENT : String =				"LOAD_FAMILY_HISTORY_BY_PATIENT_ID_EVENT";
		public static const LOAD_ZIPCODES_BY_STATEID_AND_CITY_NAME_EVENT : String =			"LOAD_ZIPCODES_BY_STATEID_AND_CITY_NAME_EVENT";
		public static const MANAGE_USER_PATIENT_PROFILE_BAR_SETTING_EVENT : String =		"MANAGE_USER_PATIENT_PROFILE_BAR_SETTING_EVENT";
		public static const REGISTER_PATIENT_PROFILE_AND_LANGUAGES_EVENT : String =			"REGISTER_PATIENT_PROFILE_AND_LANGUAGES_EVENT";
		public static const LOAD_PATIENT_PROFILE_CUSTOMIZED_SETTING_EVENT : String =		"LOAD_PATIENT_PROFILE_CUSTOMIZED_SETTING_EVENT";
		public static const LOAD_IMMUNIZATION_REFUSAL_R_STATIC_DATA_EVENT : String =		"LOAD_IMMUNIZATION_REFUSAL_R_STATIC_DATA_EVENT";
		public static const LOAD_IMMUNIZATION_LOT_NUMBER_STATIC_DATA_EVENT : String =		"LOAD_IMMUNIZATION_LOT_NUMBER_STATIC_DATA_EVENT";
		public static const LOAD_LAB_TEST_PRIORITY_TYPE_STATIC_DATA_EVENT : String =		"LOAD_LAB_TEST_PRIORITY_TYPE_STATIC_DATA_EVENT";
		public static const LOAD_LAB_TEST_SPECIMEN_TYPE_STATIC_DATA_EVENT : String =		"LOAD_LAB_TEST_SPECIMEN_TYPE_STATIC_DATA_EVENT";
		public static const LOAD_PATIENT_ALLERGY_BY_PATIENT_ID_EVENT : String =				"LOAD_PATIENT_ALLERGY_BY_PATIENT_ID_EVENT";
		public static const MANAGE_PATIENT_FOLLOW_UP_EVENT : String =						"MANAGE_PATIENT_FOLLOW_UP_EVENT";
		public static const MANAGE_PATIENT_FOLLOWUP_INSTRUCTION_EVENT : String =			"MANAGE_PATIENT_FOLLOWUP_INSTRUCTION_EVENT";
		public static const LOAD_IN_HOUSE_LAB_TEST_TYPE_BY_CLINIC_ID_EVENT : String =		"LOAD_IN_HOUSE_LAB_TEST_TYPE_BY_CLINIC_ID_EVENT";
		public static const LOAD_PATIENT_FOLLOW_UP_INSTRUCTION_BY_VISIT_ID_EVENT : String =	"LOAD_PATIENT_FOLLOW_UP_INSTRUCTION_BY_VISIT_ID_EVENT";
		public static const LOAD_PATIENT_FOLLOW_UP_INSTRUCTION_BY_PATIENT_ID_EVENT : String =	"LOAD_PATIENT_FOLLOW_UP_INSTRUCTION_BY_PATIENT_ID_EVENT";
		
		
		public static const LOAD_PATIENT_LAB_TESTS_FOR_FOLLOW_UP_BY_PATIENT_ID_EVENT : String =		"LOAD_PATIENT_LAB_TESTS_FOR_FOLLOW_UP_BY_PATIENT_ID_EVENT";
		public static const LOAD_PATIENT_MEDICATION_PRESCRIPTION_BY_PATIENT_ID_EVENT : String =		"LOAD_PATIENT_MEDICATION_PRESCRIPTION_BY_PATIENT_ID_EVENT";
		public static const LOAD_PRESCRIPTION_MEDICATION_BY_PATIENT_PRESCRIPTION_ID_EVENT :String = "LOAD_PRESCRIPTION_MEDICATION_BY_PATIENT_PRESCRIPTION_ID_EVENT";
		
		public static const IMPORT_VISIT_BY_PATIENTID_EVENT:String 							= "IMPORT_VISIT_BY_PATIENTID_EVENT";
		public static const MANAGE_PATIENT_DIAGNOSIS_EVENT:String 							= "MANAGE_PATIENT_DIAGNOSIS_EVENT";
		public static const MANAGE_CUSTOM_ICD_CODE_EVENT:String 							= "MANAGE_CUSTOM_ICD_CODE_EVENT";
		
		public static const LOAD_PATIENT_CHRONIC_DIAGNOSIS_BY_PATIENTID_EVENT:String		= "LOAD_PATIENT_CHRONIC_DIAGNOSIS_BY_PATIENTID_EVENT";
		public static const LOAD_PATIENT_ALL_CHRONIC_DIAGNOSIS_BY_PATIENTID_EVENT:String	= "LOAD_PATIENT_ALL_CHRONIC_DIAGNOSIS_BY_PATIENTID_EVENT";
		public static const LOAD_PATIENT_DIAGNOSIS_ACUTE_BY_PATIENTID_EVENT:String			= "LOAD_PATIENT_DIAGNOSIS_ACUTE_BY_PATIENTID_EVENT";
		public static const LOAD_PATIENT_DIAGNOSIS_CHRONIC_BY_PATIENTID_EVENT:String		= "LOAD_PATIENT_DIAGNOSIS_CHRONIC_BY_PATIENTID_EVENT";
		public static const LOAD_PATIENT_DIAGNOSIS_RESOLVED_BY_PATIENTID_EVENT:String		= "LOAD_PATIENT_DIAGNOSIS_RESOLVED_BY_PATIENTID_EVENT";
		public static const LOAD_PATIENT_FOLLOWUP_BY_PATIENT_ID_EVENT:String				= "LOAD_PATIENT_FOLLOWUP_BY_PATIENT_ID_EVENT";
		public static const LOAD_PATIENT_RECOMMENDATION_BY_PATIENT_ID_EVENT:String			= "LOAD_PATIENT_RECOMMENDATION_BY_PATIENT_ID_EVENT";
		
		public static const LOAD_MODULE_NOTES_BY_PATIENT_ID_EVENT : String 					= "LOAD_MODULE_NOTES_BY_PATIENT_ID_EVENT";
		public static const LOAD_MODULE_DICTATIONS_BY_PATIENT_ID_EVENT : String 			= "LOAD_MODULE_DICTATIONS_BY_PATIENT_ID_EVENT";
		
		
		public static const SAVE_TEMP_QUICKINPUT_EVENT : String								= "SAVE_TEMP_QUICKINPUT_EVENT";
		public static const DELETE_TEMP_QUICKINPUT_EVENT : String							= "DELETE_TEMP_QUICKINPUT_EVENT";
		public static const VERIFY_TEMP_QUICKINPUT_EVENT : String 							= "VERIFY_TEMP_QUICKINPUT_EVENT";
		public static const LOAD_TEMP_QUICKINPUT_BYFILENAME_EVENT : String					= "LOAD_TEMP_QUICKINPUT_BYFILENAME_EVENT";
		
		public static const LOAD_PATIENT_DIAGNOSIS_FOR_RECOMMENDATION_BY_PATIENTID_EVENT:String	= "LOAD_PATIENT_DIAGNOSIS_FOR_RECOMMENDATION_BY_PATIENTID_EVENT";
		
		public static const LOAD_PATIENT_DIAGNOSIS_BY_VISITID_EVENT:String							= "LOAD_PATIENT_DIAGNOSIS_BY_VISITID_EVENT";
		
		public static const LOAD_USER_ACCESS_RIGHT_EVENT : String =					"LOAD_USER_ACCESS_RIGHT_EVENT";
		public static const LOAD_CLINIC_GENERAL_SETTING_MAIN_EVENT : String =					"LOAD_CLINIC_GENERAL_SETTING_MAIN_EVENT";
		
		// Added by Zahid
		public static const LOAD_CLINIC_USER_BASIC_INFO	: String 							= "LOAD_CLINIC_USER_BASIC_INFO";
		public static const GET_INCOMING_VIDEO_CHAT_SESSION	: String 							= "GET_INCOMING_VIDEO_CHAT_SESSION";
		public static const GET_OUTGOING_VIDEO_CHAT_SESSION	: String 							= "GET_OUTGOING_VIDEO_CHAT_SESSION";
		public static const REJECT_VIDEO_CALL_NOTIFICATION	: String 							= "REJECT_VIDEO_CALL_NOTIFICATION";
		public static const ACCEPT_VIDEO_CALL_NOTIFICATION	: String 							= "ACCEPT_VIDEO_CALL_NOTIFICATION";
		public static const OUTGOING_VIDEO_CALL_NOTIFICATION	: String 							= "OUTGOING_VIDEO_CALL_NOTIFICATION";
		
		public static const LOAD_USER_SESSION_STATUS: String 								= "LOAD_USER_SESSION_STATUS";
		
		public static const UPDATE_USER_SESSION_STATUS_EVENT : String 					="UPDATE_USER_SESSION_STATUS_EVENT";
		public static const SEARCH_ICD_EVENT: String = 									"SEARCH_ICD";
		public static const SAVE_MEDICAL_HISTORY_EVENT: String = 									"SAVE_MEDICAL_HISTORY_EVENT";
		
		public static const SAVE_SOCIAL_HISTORY_EVENT: String = 									"SAVE_SOCIAL_HISTORY_EVENT";
		public static const SAVE_FAMILY_HISTORY_EVENT: String = 									"SAVE_FAMLY_HISTORY_EVENT";
		public static const DELETE_COMPREHENSIVE_MODULE_DATA_EVENT: String = 				"DeleteComprehensiveModuleDatabyPatientIDEvent";
		//Tahir Alvi - for storing patients data locally.
		public static const LOAD_PATIENTS_BY_PRACTICE_ID_EVENT: String = 					"LOAD_PATIENTS_BY_PRACTICE_ID_EVENT";
		//Tahir Alvi - for loading last 24 Hr added patients
		public static const LOAD_CURRENT_DAY_ADDED_PATIENTS_EVENT: String = 				"LOAD_CURRENT_DAY_ADDED_PATIENTS_EVENT";
		public static const LOAD_VB_SUMMARY_EVENT: String = 								"LOAD_VB_SUMMARY_EVENT";
		public static const LOAD_SECTION_TYPES_EVENT: String 			= 					"LOAD_SECTION_TYPES_EVENT";
		//Saman Khan for review histroy
		public static const Save_Review_Histroy_Event:String			=                   "SAVE_REVIEW_HISTROY_EVENT";
		public static const Load_Review_Histroy_Event:String			=					"LOAD_REVIEW_HISTROY_EVENT";
		//Tahir Alvi - 15 aug-2012
		public static const LOAD_INSURANCE_ORGANIZATION_EVENT : String =		"LOAD_INSURANCE_ORGANIZATION_EVENT";
		public static const SAVE_PATIENT_GAXENID_EVENT : String =		"SAVE_PATIENT_GAXENID_EVENT";
		public static const LOAD_PATIENT_PROFILE_MERGE_EVENT : String =		"LOAD_PATIENT_PROFILE_MERGE_EVENT";
		
		
		private static var m_oAppController:AppController ;
		
		public static function getInstance():AppController 
		{
			if ( m_oAppController == null )
				m_oAppController = new AppController(new Lock());
			return m_oAppController;
		}
		
		public function AppController(lock:Lock) 
		{
			if(null == lock )
				throw("Can't create object. please use getInstance() method instead ... ")
				
			addCommand( AppController.COMBINE_ALLERGY_EVENT, 						CombineAllergyCommand );
			addCommand( AppController.PING_SERVICE_EVENT, 							PingServiceCommand );
			addCommand( AppController.LOGIN_COMBINED_EVENT, 						LogInCombinedCommand );
			addCommand( AppController.LOGIN_UNLOCK_EVENT, 							LogInUnlockCommand );
			addCommand( AppController.LOGIN_EVENT, 									LoginCommand );
			addCommand( AppController.LOST_PASSWORD_EVENT, 							LostPasswordCommand );
			addCommand( AppController.GET_ANS_URL_EVENT, 							GetANSUrlCommand );
			
			addCommand( AppController.MANAGE_PATIENT_PHYSICAL_EVENT, 				ManagePatientPhysicalCommand );
			
			/*addCommand( AppController.MANAGE_PATIENT_FOLLOW_UP_EVENT, 				ManagePatientFollowUpCommand );*/
			/*addCommand( AppController.MANAGE_PATIENT_HPI_EVENT, 					ManagePatientHPICommand );*/
			/*addCommand( AppController.LOAD_FOLLOW_UP_DATE_CONTROL_TYPE_EVENT, 		LoadFollowupDataControlTypeCommand );*/
			/*	addCommand( AppController.MANAGE_PATIENT_DIAGNOSIS_EVENT,				ManagePatientDiagnosisCommand);*/
			/*addCommand( AppController.MANAGE_PATIENT_PROCEDURE_EVENT,				ManagePatientProcedureCommand    );*/
			/*addCommand( AppController.LOAD_LIONIC_LAB_TEST_TYPE_EVENT,				LoadLIONICLabTestTypeCommand    );*/
			/*addCommand(AppController.SAVE_MEDICAL_HISTORY_EVENT,SaveMedicalHistoryCommand);*/
			/*addCommand(Save_Review_Histroy_Event,SaveReviewHistroyCommand);*/
			/*addCommand(AppController.Load_Review_Histroy_Event,LoadReviewHistroyCommand);*/
			/*addCommand(AppController.MANAGE_VISIT_OWNER_EVENT, ManageVisitOwnerCommand);*/
			/*addCommand( AppController.LOAD_HPI_STATIC_DATA_EVENT,  			 LoadHPIStaticDataCommand );			*/
			/*addCommand( AppController.LOAD_ALL_HPI_DETAIL_TYPES_EVENT, 		 LoadAllHPIDetailTypesCommand );*/
			/*addCommand( AppController.MANAGE_PATIENT_IMMUNIZATION_EVENT,     ManagePatientImmunizationCommand   );*/	
			/*addCommand( AppController.LOAD_PATIENT_MOST_RECENT_VITALS_EVENT, LoadPatientMostRecentVitalsCommand );*/
			/*addCommand( AppController.LOAD_FOLLOW_UP_METHOD_TYPE_EVENT, 	 LoadFollowUpMethodTypeCommand );*/
			/*addCommand( AppController.LOAD_PATIENT_HPI_BY_VISIT_ID_EVENT, 	 LoadPatientHPIByVisitIdCommand );*/
			/*addCommand( AppController.LOAD_PATIENT_LABS_BY_VISIT_ID_EVENT, 	 LoadPatientLabsByVisitIdCommand );*/
			/*addCommand( AppController.MANAGE_PATIENT_VITALS_EVENT		, 	 ManagePatientVitalsCommand );*/
			/*addCommand( AppController.LOAD_CPT_MEDICAL_TYPES_EVENT, 		 LoadCPTMedicalTypesCommand );*/
			/*addCommand( AppController.LOAD_INSTRUCTION_AGE_VALUE_TYPE_EVENT, LoadInstructionAgeValueTypeCommand);*/
			/*addCommand( AppController.LOAD_LAB_TEST_TYPE_STATIC_DATA_EVENT,  			 	LoadLabTestTypeStaticDataCommand );*/
			/*addCommand( AppController.LOAD_INSTRUCTION_DURATION_TYPE_EVENT, 				LoadInstructionDurationTypeCommand);*/
			/*addCommand( AppController.LOAD_INSTRUCTION_AGE_TYPE_EVENT, 	 					LoadInstructionAgeTypeCommand);*/
			/*addCommand( AppController.LOAD_SERVICE_TYPE_EVENT, 	LoadServiceTypeCommand );*/
			/*addCommand( AppController.LOAD_ICD_CODE_EVENT,  	LoadICDCodeCommand );*/
			
			addCommand( AppController.CO_SIGN_VISIT_MAIN_EVENT, 					CoSignVisitMainCommand );
			addCommand( AppController.SIGN_VISIT_MAIN_EVENT,  					 	SignVisitMainCommand );
			addCommand( AppController.VERIFY_USER_MAIN_EVENT, 						VerifyUserMainCommand );
			addCommand( AppController.GENERATE_SOAP_NOTE_PREVIEW_MAIN_EVENT, 	 	GenerateSoapNotePreviewMainCommand );
			
			addCommand( AppController.SYNC_E_PRESCRIPTION_EVENT, 					SyncEPrescriptionCommand );
			addCommand( AppController.LOAD_PATIENT_DIAGNOSIS_BY_VISITID_EVENT, 		LoadPatientDiagnosisByVisitIdCommand );
			addCommand( AppController.MANAGE_CUSTOM_ICD_CODE_EVENT,					ManageCustomICDCodeCommand);
			addCommand( AppController.LOGIN_SUCCESSFULL_EVENT,						LoginSuccessfullCommand);
			addCommand( AppController.LOAD_USER_SEARCH_ENGINE_EVENT, 				LoadUserSearchEngineCommand);
			addCommand( AppController.LOAD_USER_QUICK_LINKS_EVENT, 					LoadUserQuickLinksCommand);
			addCommand( AppController.LOAD_ALL_SEARCH_ENGINS_EVENT , 				LoadAllSearchEnginesCommand);
			addCommand( AppController.LOAD_CONTACT_SEARCH_SUGGESTION_LIST_EVENT  , 	LoadContactSearchSuggestionListCommand);
			addCommand( AppController.SEND_EMAIL_EVENT  ,							SendEmailCommand );
			addCommand( AppController.SET_DEFAULT_SEARCH_ENGINE_EVENT  ,			ChangeDefaultSearchEngineCommand );
			addCommand( AppController.LOAD_REGISTRATION_STATIC_DATA_EVENT  ,		LoadRegistrationStaticDataCommand );
			addCommand( AppController.REGISTER_NEW_PATIENT_EVENT  , 				RegisterNewPatientCommand );
			addCommand( AppController.LOAD_CITIES_BY_STATE_ID_EVENT  , 				LoadCitiesByStateIdCommand  );
			addCommand( AppController.LOAD_ADDRESS_BOOK_STATIC_DATA_EVENT  ,  		LoadAddressBookStaticDataCommand  );
			addCommand( AppController.REGISTER_USER_PROFILE_EVENT  ,  				RegisterUserProfileCommand   );
			addCommand( AppController.REGISTER_PATIENT_PROFILE_AND_LANGUAGES_EVENT, RegisterPatientProfileAndLanguageCommand     );
			addCommand( AppController.SAVE_PATIENT_EMERGENCY_CONTACT_EVENT  ,  		SavePatientEmergencyContactCommand     );
			addCommand( AppController.SAVE_PATIENT_GURANTOR_EVENT, 					SavePatientGuarantorCommand  );
			addCommand( AppController.SAVE_PATIENT_INSURANCE_EVENT,  				SavePatientInsuranceCommand  );
			addCommand( AppController.SAVE_ADDRESS_BOOK_EVENT,  					SaveAddressBookCommand   );
			addCommand( AppController.SAVE_PATIENT_HEALTH_HX_EVENT,   				SavePatientHealthInfoCommand   );
			addCommand( AppController.SEARCH_ALLERGY_TYPE_BY_NAME_EVENT,    		SearchAllergyTypeByNameCommand   );
			addCommand( AppController.SEARCH_ICD_CODE_BY_CODE_EVENT,     			SearchICDCodeByCodeCommand   );
			addCommand( AppController.PATIENT_SEARCH_EVENT,  						PatientSearchCommand );
			addCommand( AppController.LOAD_USER_MOST_RECENT_PATIENT_EVENT,   		LoadUserMostRecentPatientCommand );
			addCommand( AppController.SAVE_PATIENT_ALLERGY_EVENT,					SavePatientAllergyCommand    );
			addCommand( AppController.MANAGE_PATIENT_IN_HOUSE_LABS_EVENT,			ManagePatientInHouseLabsCommand    );
			addCommand( AppController.GET_URL_FOR_EDIT_ALLERGIES_EVENT,				GetUrlForEditAllergiesCommand    );
			addCommand( AppController.MANAGE_PATIENT_FOLLOWUP_INSTRUCTION_EVENT,	ManagePatientFollowUpInstructionCommand    );
			addCommand( AppController.LOAD_PATIENT_VITALS_BY_PATIENT_ID_EVENT, 			LoadPatientVitalsByPatientIdCommand  );
			addCommand( AppController.LOAD_PATIENT_PROFILE_POP_UP_DATA_EVENT, 			LoadPatientProfilePopUpDataCommand  );
			addCommand( AppController.MANAGE_USER_PATIENT_PROFILE_BAR_SETTING_EVENT,  	ManageUserPatientProfileBarSettingCommand  );
			addCommand( AppController.LOAD_PROFILE_BAR_STATIC_DATA_EVENT, 				LoadProfileBarStaticDataCommand   );
			addCommand( AppController.GET_EMAIL_BY_USER_ID_EVENT, 						GetEmailByUserIdCommand   );
			addCommand( AppController.LOAD_PATIENT_PROFILE_CUSTOMIZED_SETTING_EVENT, 	LoadPatientProfileCustomizedSettingCommand   );
			addCommand( AppController.LOAD_PATIENT_PROFILE_EVENT, 						LoadPatientProfileCommand);
			addCommand( AppController.LOAD_PATIENT_HISTORY_POPUP_DATA_EVENT,  			LoadPatientHistoryPopupDataCommand  );
			addCommand( AppController.MANAGE_USER_SEARCH_ENGINES_EVENT, 				ManageUserSearchEnginesCommand   );
			addCommand( AppController.LOAD_IMAGE_TYPES_STATIC_DATA_EVENT, 				LoadImageTypesStaticDataCommand   );
/*			addCommand( AppController.LOAD_IMMUNIZATION_SERIES_STATIC_DATA_EVENT,  		LoadImmunizationSeriesStaticDataCommand   );
			addCommand( AppController.LOAD_IMMUNIZATION_SITES_STATIC_DATA_EVENT,		LoadImmunizationSiteStaticDataCommand   );
			addCommand( AppController.LOAD_IMMUNIZATION_REFUSAL_R_STATIC_DATA_EVENT,	LoadImmunizationRefusalReasonStaticDataCommand   );
			addCommand( AppController.LOAD_IMMUNIZATION_DOSE_STATIC_DATA_EVENT,     	LoadImmunizationDoseStaticDataCommand   );
			addCommand( AppController.LOAD_IMMUNIZATION_TYPES_STATIC_DATA_EVENT,    	LoadImmunizationTypesStaticDataCommand   );
			addCommand( AppController.LOAD_IMMUNIZATION_LOT_NUMBER_STATIC_DATA_EVENT,   LoadImmunizationLotNumberStaticDataCommand   );
			addCommand( AppController.LOAD_IMMUNIZATION_MANUFACTURER_STATIC_DATA_EVENT,	LoadImmunizationManufacturerStaticDataCommand   );
			addCommand( AppController.LOAD_IMMUNIZATION_ROUT_STATIC_DATA_EVENT,     	LoadImmunizationRoutStaticDataCommand   );*/
			addCommand( AppController.LOAD_PATIENT_FAMILY_HISTORY_BY_VISIT_ID_EVENT, 	LoadPatientFamilyHistoryByVisitIdCommand );
			addCommand( AppController.LOAD_PATIENT_MEDICAL_HISTORY_BY_VISIT_ID_EVENT, 	LoadPatientMedicalHistoryByVisitIdCommand );
			addCommand( AppController.MANAGE_PATIENT_FAMILY_HISTORY_EVENT,  			ManagePatientFamilyHistoryCommand );
			addCommand( AppController.MANAGE_PATIENT_MEDICAL_HISTORY_EVENT, 			ManagePatientMedicalHistoryCommand );
			addCommand( AppController.LOAD_PATIENT_SOCIAL_HISTORY_BY_VISIT_ID_EVENT, 	LoadPatientSocialHistoryByVisitIdCommand );
			addCommand( AppController.MANAGE_PATIENT_SOCIAL_HISTORY_EVENT , 			ManagePatientSocialHistoryCommand );
			addCommand( AppController.LOAD_SPECIFIED_REGISTRATION_STATIC_DATA_EVENT,	LoadSpecifiedRegistrationStaticDataCommand );
			addCommand( AppController.LOAD_PATIENT_ALLERGY_BY_PATIENT_ID_EVENT, 		LoadPatientAllergyByPatientIdCommand	 );
			addCommand( AppController.LOAD_IN_HOUSE_LAB_TEST_TYPE_BY_CLINIC_ID_EVENT, 	LoadInHouseLabTestTypeByClinicIdCommand	 );
			addCommand( AppController.LOAD_PATEINT_IN_HOUSE_LABS_BY_VISIT_ID_EVENT, 	LoadPatientInHouseLabsByVisitIdCommand	 );
			addCommand( AppController.LOAD_PATIENT_HPI_BY_PATIENT_ID_EVENT, 			LoadPatientHPIByPatientIdCommand	 );
			addCommand( AppController.LOAD_PATIENT_ROS_BY_PATIENT_ID_EVENT, 			LoadPatientROSByPatientIdCommand	 );
			addCommand( AppController.LOAD_PATIENT_PHYSICALS_BY_PATIENT_ID_EVENT, 		LoadPatientPhysicalsByPatientIdCommand	 );
			addCommand( AppController.GET_URL_FOR_EDIT_PRESCRIPTION_EVENT, 				GetUrlForEditPrescriptionCommand	 );
			addCommand( AppController.GET_URL_FOR_EDIT_MEDICATION_EVENT, 				GetUrlForEditMedicationCommand	 );
			addCommand( AppController.LOAD_SOCIAL_HISTORY_BY_PATIENT_ID_EVENT, 			LoadSocialHistoryByPatientIdCommand	 );
			addCommand( AppController.LOAD_PATIENT_PROCEDURE_BY_PATIENT_ID_EVENT, 		LoadPatientProcedureByPatientIdCommand	 );
			addCommand( AppController.LOAD_PATIENT_LABS_BY_PATIENT_ID_EVENT, 			LoadPatientLabsByPatientIdCommand	 );
			addCommand( AppController.LOAD_SOAP_TEMPLATES_EVENT,  			 LoadSoapTemplatesCommand );
			addCommand( AppController.LOAD_VISIT_ENCOUNTER_TYPES_EVENT, 	 LoadVisitEncounterTypesCommand );
			addCommand( AppController.LOAD_PATIENT_VISIT_LIST_EVENT,  		 LoadPatientVisitListCommand   );
			addCommand( AppController.LOAD_PATIENT_VISITS_BY_PROVIDER_ID_EVENT,  	LoadPatientVisitsByProviderIDCommand  );
			addCommand( AppController.MANAGE_QUICK_INPUT_EVENT,   			 ManageQuickInputCommand   );
			addCommand( AppController.LOAD_ROS_STATIC_DATA_EVENT, 			 LoadROSStaticDataCommand );			
			addCommand( AppController.LOAD_PHYSICAL_STATIC_DATA_EVENT, 		 LoadPhysicalStaticDataCommand );						
			addCommand( AppController.LOAD_MODULE_NOTES_EVENT, 				 LoadModuleNotesCommand);
			addCommand( AppController.MANAGE_MODULE_NOTES_EVENT, 			 ManageModuleNotesCommand);			
			addCommand( AppController.LOAD_PATIENT_IMMUNIZATION_EVENT, 		 LoadPatientImmunizationCommand);			
			addCommand( AppController.LOAD_PATIENT_VISIT_IMMUNIZATION_EVENT, LoadPatientVisitImmunizationCommand);
			addCommand( AppController.LOAD_ALL_MODULE_TYPES,  				 LoadAllModuleTypesCommand);			
			addCommand( AppController.LOAD_LOGGED_IN_USER_IMAGE_EVENT, 		 LoadLoggedInUserImageCommand );			
			addCommand( AppController.SAVE_PATIENT_IMAGE_EVENT, 			 SavePatientImageCommand );			
			addCommand( AppController.LOAD_PATIENT_IMAGE_EVENT, 			 LoadPatientImageCommand );
			addCommand( AppController.LOAD_GENERAL_HISTORY_TYPES_EVENT,  	 LoadGeneralHistoryTypesCommand );
			addCommand( AppController.LOAD_FAMILY_HISTORY_TYPES_EVENT,  	 LoadFamilyHistoryTypesCommand );
			addCommand( AppController.LOAD_SOCIAL_HISTORY_TYPES_EVENT,  	 LoadSocialHistoryTypesCommand );
			addCommand( AppController.LOAD_FAMILY_DISEASE_STATIC_DATA_EVENT, LoadFamilyDiseaseStaticDataCommand ); 
			addCommand( AppController.LOAD_QUICK_INPUT_BY_VISIT_ID_EVENT, 	 LoadQuickInputByVisitIdCommand );
			addCommand( AppController.LOAD_SOAP_NOTE_BY_VISIT_ID_EVENT, 	 GenerateSoapNoteByVisitIDCommand );	
			addCommand( AppController.MANAGE_PATIENT_TREATMENT_EVENT, 	 	 ManagePatientRecommendationCommand );
			addCommand( AppController.MANAGE_PATIENT_ROS_EVENT, 	 		 ManagePatientROSCommand );
			addCommand( AppController.LOAD_PATIENT_VITAL_BY_VISIT_EVENT, 	 LoadPatientVitalByVisitCommand );	
			addCommand( AppController.MANAGE_PATIENT_LABS_EVENT			, 	 ManagePatientLabsCommand );
			addCommand( AppController.PREPARE_LOGIN_CALL_FOR_E_PRESCRIPTION_EVENT, 			PrepareLoginCallForEprescriptionCommand);
			addCommand( AppController.LOAD_LAB_TEST_NATURE_TYPE_STATIC_DATE_EVENT,  	 	LoadLabTestNatureTypeStaticDataCommand );
			addCommand( AppController.LOAD_LAB_TEST_PRIORITY_TYPE_STATIC_DATA_EVENT,     	LoadLabTestPriorityTypeStaticDataCommand );
			addCommand( AppController.LOAD_LAB_TEST_SPECIMEN_TYPE_STATIC_DATA_EVENT,  	 	LoadLabTestSpecimenTypeStaticDataCommand );
			addCommand( AppController.LOAD_LAB_TYPE_STATIC_DATA_EVENT,  				 	LoadLabTypeStaticDataCommand );
			addCommand( AppController.LOAD_LAB_TEST_ORDER_METHOD_TYPE_STATIC_DATA_EVENT, 	LoadLabTestOrderMethodTypeStaticDataCommand );
			addCommand( AppController.LOAD_SOCIAL_HISTORY_USAGE_AMOUNT_STATIC_DATA_EVENT,	LoadSocialHistoryUsageAmountStaticDataCommand );
			addCommand( AppController.LOAD_SOCIAL_HISTORY_MEDIUM_TYPES_STATIC_DATA_EVENT,  	LoadSocialHistoryMediumTypesStaticDataCommand );
			addCommand( AppController.LOAD_VISIT_STAKEHOLDERS_BY_VISITID_EVENT, 			LoadVisitStakeHoldersByVisitIdCommand);
			addCommand( AppController.MANAGE_PATIENT_IN_HOUSE_LAB_RESULTS_EVENT, 			ManagePatientInHouseLabResultsCommand);
			addCommand( AppController.LOAD_PATEINT_PRESCRIPTION_BY_PATIENT_ID_EVENT, 		LoadPatientPrescriptionByPatientIdCommand);
			addCommand( AppController.LOAD_PATIENT_FOLLOW_UP_INSTRUCTION_BY_VISIT_ID_EVENT, LoadPatientFollowUpInstructionByVisitIdCommand);
			
			addCommand( AppController.LOAD_PATIENT_IN_HOUSE_LABS_BY_PATIENT_ID_EVENT, 	 	LoadPatientInHouseLabsByPatientIdCommand);
			addCommand( AppController.LOAD_FAMILY_HISTORY_BY_PATIENT_ID_EVENT, 	 			LoadFamilyHistoryByPatientIdCommand);
			addCommand( AppController.LOAD_MEDICAL_HISTORY_BY_PATIENT_ID_EVENT, 	 		LoadMedicalHistoryByPatientIdCommand);
			
			
			addCommand( AppController.LOAD_MODULE_NOTES_BY_PATIENT_ID_EVENT, 	 		    LoadModuleNotesByPatientIdCommand);
			addCommand( AppController.LOAD_MODULE_DICTATIONS_BY_PATIENT_ID_EVENT, 	 		LoadModuleDictationsByPatientIdCommand);
			
			
			
			addCommand( AppController.CREATE_VISIT_EVENT, 		CreateVisitCommand );
			addCommand( AppController.UPDATE_VISIT_EVENT,		UpdateVisitCommand );
			addCommand( AppController.LOAD_ALL_LINKS, 			LoadAllLinksCommand );
			
			addCommand( AppController.LOAD_ALL_PLAN_TYPES, 		LoadAllPlanTypesCommand );			
			addCommand( AppController.LOAD_ALL_METHOD_TYPES, 	LoadAllMethodTypesCommand );
			addCommand( AppController.LOAD_ALL_DURATION_TYPES, 	LoadAllDurationTypesCommand );
			
			addCommand( AppController.LOAD_PATIENT_CHRONIC_DIAGNOSIS_BY_PATIENTID_EVENT,	LoadPatientChronicDiagnosisByPatientIdCommand); 
			addCommand( AppController.LOAD_PATIENT_DIAGNOSIS_ACUTE_BY_PATIENTID_EVENT,		LoadPatientDiagnosisAcuteByPatientIdCommand);
			addCommand( AppController.LOAD_PATIENT_DIAGNOSIS_CHRONIC_BY_PATIENTID_EVENT,	LoadPatientDiagnosisChronicByPatientIdCommand);
			addCommand( AppController.LOAD_PATIENT_DIAGNOSIS_RESOLVED_BY_PATIENTID_EVENT,	LoadPatientDiagnosisResolvedByPatientIdCommand);
			addCommand( AppController.LOAD_PATIENT_ALL_CHRONIC_DIAGNOSIS_BY_PATIENTID_EVENT,	LoadPatientAllChronicDiagnosisByPatientIdCommand);
			
			addCommand( AppController.LOAD_PATIENT_FOLLOWUP_BY_PATIENT_ID_EVENT, LoadPatientFollowUpByPatientIdCommand);
			
			addCommand( AppController.LOAD_PATIENT_LAB_TESTS_FOR_FOLLOW_UP_BY_PATIENT_ID_EVENT, 	LoadPatientLabTestsForFollowupByPatientIdCommand);
			addCommand( AppController.LOAD_PRESCRIPTION_MEDICATION_BY_PATIENT_PRESCRIPTION_ID_EVENT,LoadPrescriptionMedicationByPatientPrescriptionIdCommand);
			
			addCommand( AppController.IMPORT_VISIT_BY_PATIENTID_EVENT, ImportVisitByPatientIdCommand);			
			
			addCommand( AppController.LOAD_PATIENT_RECOMMENDATION_BY_PATIENT_ID_EVENT, LoadPatientRecommendationByPatientIdCommand);
			addCommand( AppController.LOAD_PATIENT_FOLLOW_UP_INSTRUCTION_BY_PATIENT_ID_EVENT, LoadPatientFollowUpInstructionByPatientIdCommand);
			
			
			addCommand( AppController.SAVE_TEMP_QUICKINPUT_EVENT, SaveTempQuickInputCommand);
			addCommand( AppController.DELETE_TEMP_QUICKINPUT_EVENT, DeleteTempQuickInputCommand);
			addCommand( AppController.VERIFY_TEMP_QUICKINPUT_EVENT, VerifyTempQuickInputCommand);
			addCommand( AppController.LOAD_TEMP_QUICKINPUT_BYFILENAME_EVENT, LoadTempQuickInputByFileNameCommand);
			
			
			addCommand( AppController.LOAD_PATIENT_DOCUMENT_BY_PATIENT_ID_EVENT, LoadPatientDocumentByPatientIdCommand);
			addCommand( AppController.SEARCH_PATIENT_DOCUMENT_BY_PATIENT_ID_EVENT, SearchPatientDocumentByPatientIdCommand);
			
			addCommand( AppController.LOAD_USER_ACCESS_RIGHT_EVENT, 	LoadUserAccessRightCommand);
			addCommand( AppController.LOAD_CLINIC_GENERAL_SETTING_MAIN_EVENT, 	LoadClinicGeneralSettingMainCommand);
			
			addCommand( AppController.LOAD_SEARCH_BY_TYPE_STATIC_DATA_EVENT, LoadSearchByTypeStaticDataCommand);
			
			
			addCommand( AppController.LOAD_PATIENT_DIAGNOSIS_FOR_RECOMMENDATION_BY_PATIENTID_EVENT, LoadDiagnosisForRecommendationByPatientIdCommand);
			
			addCommand( AppController.UPDATE_USER_SESSION_EVENT,  UpdateUserSessionCommand);
			addCommand( AppController.SIGN_OUT_EVENT,   SignOutCommand);
			
			// ADDED BY ZAHID
			addCommand( AppController.LOAD_CLINIC_USER_BASIC_INFO,  GetClinicUserDetailsCommand);
			addCommand( AppController.GET_INCOMING_VIDEO_CHAT_SESSION,  GetIncomingVideoChatSessionCommand);
			addCommand( AppController.GET_OUTGOING_VIDEO_CHAT_SESSION,  GetOutgoingVideoChatSessionCommand);
			addCommand(AppController.LOAD_USER_SESSION_STATUS, LoadUserSessionCommand);
			addCommand(AppController.UPDATE_USER_SESSION_STATUS_EVENT, UpdateUserSessionStatusCommand);
			addCommand(AppController.REJECT_VIDEO_CALL_NOTIFICATION,VideoCallRejectCommand);
			addCommand(AppController.ACCEPT_VIDEO_CALL_NOTIFICATION,VideoCallAcceptCommand);
			addCommand(AppController.OUTGOING_VIDEO_CALL_NOTIFICATION,VideoCallNotificationCommand);
			addCommand(AppController.SEARCH_ICD_EVENT,SearchICDCommand);
			
			
			
			addCommand(AppController.SAVE_SOCIAL_HISTORY_EVENT,SaveSocialHistoryCommand);
			addCommand(AppController.SAVE_FAMILY_HISTORY_EVENT,SaveFamilyHistoryCommand);
			addCommand(AppController.DELETE_COMPREHENSIVE_MODULE_DATA_EVENT, DeleteComprehensiveModuleDatabyPatientIDCommand);
			
			addCommand(AppController.LOAD_VB_SUMMARY_EVENT, LoadSummaryCommand);
			//
			//Added by Tahir Alvi
			addCommand(AppController.LOAD_PATIENTS_BY_PRACTICE_ID_EVENT, LoadPatientsByPracticeIdCommand);
			addCommand(AppController.LOAD_CURRENT_DAY_ADDED_PATIENTS_EVENT, LoadCurrentDayAddedPatientsCommand);
			addCommand(AppController.LOAD_SECTION_TYPES_EVENT, LoadSectionTypesCommand);
			addCommand(AppController.LOAD_INSURANCE_ORGANIZATION_EVENT, LoadInsuranceOrganizationsCommand);
			
			
			addCommand(AppController.LOAD_VISIT_PHYSICIANS_BY_CLINIC_BRANCH_ID_EVENT, LoadVisitPhysiciansbyClinicBranchIDCommand);
			
			addCommand(AppController.LOAD_PATIENT_PROFILE_MERGE_EVENT, LoadPatientProfileMergeCommand);
		}
	}
}
class Lock
{
	//Singlton Lock
}