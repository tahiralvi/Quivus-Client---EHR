package com.gazuntite.common.util
{
	public final class QSConstants
	{
		public static const STRING_NULL						:String = "NULL";
		public static const STRING_TRUE						:String = "true";
		public static const STRING_FALSE					:String = "false";
		public static const STRING_YES						:String = "YES";
		public static const STRING_NO						:String = "NO";

		public static const STRING_YES_UI:String = "Yes";
		public static const STRING_NO_UI:String = "No";
		public static const STRING_NONE_UI:String = "None";
		
		public static const ALLERGY_CALL_TYPE_LOAD_ALL						:int = 1;
		public static const ALLERGY_CALL_TYPE_LOAD_PATIENT					:int = 2;
		public static const ALLERGY_CALL_TYPE_ADD							:int = 3;
		public static const ALLERGY_CALL_TYPE_DELETE						:int = 4;
		
		public static const ERROR:String = "Error occured on server";
		public static const GUID_FORMAT:String = "00000000-0000-0000-0000-000000000000";
		public static const NULL_DATE:Date = new Date(1901, 0, 01, 12, 0, 0);
		
		public static const SIGNED_STATUS:String = "Signed";
		public static const VISIT_SIGNED:String = "visitSigned";
		public static const VISIT_COSIGNED:String = "visitCoSigned";
		public static const INVALID_CREDENTIALS:String = "invalidCredentials";
		
		public static var RESTFULL_SERVICE_BASE_URL 								:String;
		public static var EPRESCRIPTION_USER_SERVICE 								:String; 
		
		public static var RESTFULL_SERVICE_BASE_URL_dev 							:String = "http://quivus.com/QuivusAirDev/Communcation/CommunicationService.svc/";
		public static const QI_PATIENT_ALLERGY_RESTFUL_SERVICE						:String = "http://beta.quivus.com/Eprescriptionstagging/Service/EPrescriptionService.svc/";
		public static const ALLERGY_RESTFUL_SERVICE_METHOD_GetAllergies				:String = "GetAllergies";
		public static const ALLERGY_RESTFUL_SERVICE_METHOD_GetPatientAllergies		:String = "GetPatientAllergies";
		public static const ALLERGY_RESTFUL_SERVICE_METHOD_AddAllergies				:String = "AddAllergies";
		public static const ALLERGY_RESTFUL_SERVICE_METHOD_DeletePatientAllergies	:String = "DeletePatientAllergies";
		public static var RESTFULL_PROVIDER_SERVICE_BASE_URL:String;
		public static var EPRESCRIPTION_QM_SERVICE:String;
		public static var BILLING_RESTFULL_SERVICE_BASE_URL 	: String;
		public static var RESTFULL_ADRESSBOOK_SERVICE_BASE_URL 	: String;
		public static var RESTFUL_SERVICE_BASE_URL:String; //Ayesha 04/03/2013
		
		//V filters
		public static const BY_VISIT:String = "By Visit";
		public static const BY_TYPE:String = "By Type";
		
		public static var DICTATION_FOLDER_NAME:String = "temp/Dictation";
		public static var DICTATION_SERVER_URL:String = "http://quivus.com/QuivusAirDev/DictationService/QuivusDictationService.svc/" ;
		
		//**************************** SECTION NAMES ******************************************************
		public static const ALLERGY_MODULE_NAME:String = "Allergy";
		public static const CHIEF_COMPLAINT_MODULE_NAME:String = "ChiefComplaint";
		public static const COMPREHENSIVE_HISTORY_MODULE_NAME:String = "ComprehensiveHistory";
		public static const IMMUNIZATION_MODULE_NAME:String = "Immunization";
		public static const MEDICAL_HISTORY_MODULE_NAME:String = "MedicalHistory";
		public static const FAMILY_HISTORY_MODULE_NAME:String = "FamilyHistory";
		public static const SOCIAL_HISTORY_MODULE_NAME:String = "SocialHistory";
		public static const VITALS_MODULE_NAME:String = "Vitals";
		public static const REVIEW_OF_SYSTEM_MODULE_NAME:String = "ReviewOfSystem";
		public static const PHYSICAL_MODULE_NAME:String = "Physical";
		public static const LAB_IN_MODULE_NAME:String = "LabIn";
		public static const LAB_OUT_MODULE_NAME:String = "LabOut";
		public static const DIAGNOSIS_MODULE_NAME:String = "Diagnosis";
		public static const PROCEDURE_MODULE_NAME:String = "Procedure";
		public static const RECOMMENDATION_MODULE_NAME:String = "Recommendation";
		public static const FOLLOW_UP_MODULE_NAME:String = "FollowUp";
		public static const TREATMENT_MODULE_NAME:String = "Treatment";
		public static const PLAN_MODULE_NAME:String = "Plan";
		public static const QUICK_INPUT_MODULE_NAME:String = "QuickInput";
		public static const VIEW_BACKGROUND_MODULE_NAME:String = "ViewBackground";
		
		//**************************** VIEW BACKGROUNG 	SECTION HEADER NAMES *****************************************************
		public static const VB_SECTION_NAME_IMMUNIZATION :String = "Immunization";
		public static const VB_SECTION_NAME_VITALS :String = "PatientVital";
		public static const VB_SECTION_NAME_LABS :String = "Labs";
		public static const VB_SECTION_NAME_CC_HPI :String = "Chief Complaint/HPI";
		public static const VB_SECTION_NAME_PLAN :String = "Plan";		
		public static const VB_SECTION_NAME_TREATMENT :String = "Treatment";	
		public static const VB_SECTION_NAME_DIAGNOSIS :String = "Diagnosis";	
		public static const VB_SECTION_NAME_ROS :String = "Review of System";	
		public static const VB_SECTION_NAME_PHYSICAL :String = "Physical";
		public static const VB_SECTION_NAME_COMPREHENSIVE_HISTORY :String = "Comprehensive History";
		public static const VB_SECTION_NAME_PRESCRIPTION :String = "Prescription";
		
		//**************************** HPI 	SECTION NAMES *****************************************************
		public static const CONTEXT_MODULE_NAME:String = "Context";
		public static const DURATION_MODULE_NAME:String = "Duration";
		public static const EXACERBATING_MODULE_NAME:String = "Exacerbating";
		public static const LOCATION_MODULE_NAME:String = "Location";
		public static const MODIFYINGFACTORS_MODULE_NAME:String = "ModifyingFactors";		
		public static const PROGRESSION_MODULE_NAME:String = "Progression";	
		public static const QUALITY_MODULE_NAME:String = "Quality";	
		public static const RADIATION_MODULE_NAME:String = "Radiation";	
		public static const SEVERITY_MODULE_NAME:String = "Severity";	
		public static const SYMPTOM_MODULE_NAME:String = "Symptom";		
		//**************************** End Section names ******************************************************
		
		//**************************** Immunization Section names ******************************************************
		public static const DOSE_SELECT_TYPE:String = "dose";
		public static const MANUFACTURER_SELECT_TYPE:String = "manufacture";
		public static const REFUSAL_SELECT_TYPE:String 	= "refusal";
		public static const ROUT_SELECT_TYPE:String = "rout";
		public static const SERIERS_SELECT_TYPE:String = "seriers";
		public static const SITE_SELECT_TYPE:String = "site";
		public static const TYPE_SELECT_TYPE:String = "type";
		public static const LOT_SELECT_TYPE:String = "lot";
		
		//**************************** End Immunization Section names ******************************************************
		
		//*********** MERITAL STATUS IDS FOR COMPREHENSIVE HISTORY SOCIAL SECTION *****************
		public static const DIVORCED_MARITAL_STATUS_ID:int = 2;
		public static const MARRIED_MARITAL_STATUS_ID:int = 6;
		public static const WIDOWED_MARITAL_STATUS_ID:int = 9;
		public static const SINGLE_MARITAL_STATUS_ID:int = 7;
		//**************************************************************************************
	}
}
