package com.gazuntite.common.appController
{
	import com.adobe.cairngorm.control.FrontController;
	import com.gazuntite.common.command.GetPatientGaxenIdCommand;
	import com.gazuntite.common.command.GetStateCityZipCodeCombineCommand;
	import com.gazuntite.common.command.LoadAllInsuranceCommand;
	import com.gazuntite.common.command.LoadICDCodeCommand;
	import com.gazuntite.common.command.LoadPatientMedCommand;
	import com.gazuntite.common.command.LoadPatientbyPatientIDCommand;
	import com.gazuntite.common.command.LoadPlaceOfServiceTypesCommand;
	import com.gazuntite.common.command.LoadStateCodesOnlyCommand;
	import com.gazuntite.common.command.QSAllergyCommand;
	import com.gazuntite.common.command.SavePatientGaxenIdCommand;
	import com.gazuntite.common.command.SendErrorReportCommand;
	import com.gazuntite.common.command.ccHpi.LoadAllHPIDetailTypesCommand;
	import com.gazuntite.common.command.ccHpi.LoadHPIStaticDataCommand;
	import com.gazuntite.common.command.compHistory.LoadAllBloodRelationShipTypeDTOCommand;
	import com.gazuntite.common.command.compHistory.LoadComprehensiveHistoryStaticDataCommand;
	import com.gazuntite.common.command.followUp.LoadFollowUpMethodTypeCommand;
	import com.gazuntite.common.command.followUp.LoadFollowUpServiceTypeCommand;
	import com.gazuntite.common.command.immunization.LoadImmunizationStaticDataCommand;
	import com.gazuntite.common.command.immunization.ManagePatientImmunizationCommand;
	import com.gazuntite.common.command.labs.LoadInHouseLabStaticDataCommand;
	import com.gazuntite.common.command.labs.LoadLIONICLabTestTypeCommand;
	import com.gazuntite.common.command.labs.LoadLabTestTypeStaticDataCommand;
	import com.gazuntite.common.command.labs.LoadLabTypeStaticDataCommand;
	import com.gazuntite.common.command.procedure.LoadCPTMedicalTypesCommand;
	import com.gazuntite.common.command.recommendation.LoadAllRecommendationDurationTypesCommand;
	import com.gazuntite.common.command.recommendation.LoadAllRecommendationMethodTypesCommand;
	import com.gazuntite.common.command.recommendation.LoadAllRecommendationPlanTypesCommand;
	import com.gazuntite.common.command.recommendation.LoadRecommendationLinksAutoCompleteCommand;
	import com.gazuntite.common.command.visit.CoSignVisitCommand;
	import com.gazuntite.common.command.visit.GenerateSoapNotePreviewCommonCommand;
	import com.gazuntite.common.command.visit.SignVisitCommand;
	import com.gazuntite.common.command.visit.VerifyUserCommand;
	import com.gazuntite.common.event.SendErrorReportEvent;
	import com.gazuntite.common.util.QSConstants;
	import com.gazuntite.common.util.xml.XmlUtils;
	
	import mx.containers.ControlBar;

	public class QSCommonController extends FrontController
	{
		public static const SEND_ERROR_REPORT_EVENT:String = "SendErrorEmail";
		public static const LOAD_PATIENT_BY_PATIENT_ID_EVENT:String = "LOAD_PATIENT_BY_PATIENT_ID_EVENT";
		public static const LOAD_PLACE_OF_SERVICE_TYPES_EVENT:String = "LoadPlaceOfServiceTypesEvent";
		public static const LOAD_ALL_INSURANCE_EVENT:String = "LoadAllInsuranceEvent";
		public static const GET_STATE_CITY_ZIP_CODE_COMBINE_EVENT:String = "GET_STATE_CITY_ZIP_CODE_COMBINE_EVENT";
		public static const QS_ALLERGY_EVENT:String = "QS_ALLERGY_EVENT";
		public static const LOAD_PATIENT_PRESCRIPTION:String= "LOAD_PATIENT_PRESCRIPTION";
		public static const SAVE_PATIENT_GAXENID_EVENT:String = "SAVE_PATIENT_GAXENID_EVENT";
		public static const GET_PATIENT_GAXENID:String = "GET_PATIENT_GAXENID";
		public static const GENERATE_SOAP_NOTE_PREVIEW_COMMON_EVENT:String = "GENERATE_SOAP_NOTE_PREVIEW_COMMON_EVENT";
		public static const LOAD_STATE_CODES_ONLY_EVENT:String = "LOAD_STATE_CODES_ONLY_EVENT";
		public static const VERIFY_USER_EVENT:String = "VERIFY_USER_EVENT";
		public static const SIGN_VISIT_EVENT:String = "SIGN_VISIT_EVENT";
		public static const CO_SIGN_VISIT_EVENT:String = "CO_SIGN_VISIT_EVENT";
		public static const LOAD_IMMUNIZATION_STATIC_DATA:String = "LOAD_IMMUNIZATION_STATIC_DATA";
		
		public static const LOAD_ICD_CODE_EVENT:String = "LOAD_ICD_CODE_EVENT";
		public static const LOAD_ALL_BLOOD_RELATIONSHIP_TYPE_DTO_EVENT:String = "LOAD_ALL_BLOOD_RELATIONSHIP_TYPE_DTO_EVENT";
		public static const LOAD_COMPREHENSIVE_HISTORY_STATIC_DATA:String = "LOAD_COMPREHENSIVE_HISTORY_STATIC_DATA";
		
		public static const LOAD_HPI_STATIC_DATA_EVENT:String = "LOAD_HPI_STATIC_DATA_EVENT";
		public static const LOAD_ALL_HPI_DETAIL_TYPES_EVENT:String = "LOAD_ALL_HPI_DETAIL_TYPES_EVENT";
		public static const LOAD_IN_HOUSE_LAB_STATIC_DATA_EVENT:String = "LOAD_IN_HOUSE_LAB_STATIC_DATA_EVENT";
		
		public static const LOAD_CPT_MEDICAL_TYPES_EVENT:String = "LOAD_CPT_MEDICAL_TYPES_EVENT";
		
		public static const LOAD_LAB_TEST_TYPE_STATIC_DATA_EVENT:String = "LOAD_LAB_TEST_TYPE_STATIC_DATA_EVENT";
		public static const LOAD_LAB_TYPE_STATIC_DATA_EVENT:String = "LOAD_LAB_TYPE_STATIC_DATA_EVENT";
		public static const LOAD_LIONIC_LAB_TEST_TYPE_EVENT:String = "LOAD_LIONIC_LAB_TEST_TYPE_EVENT";
		
		public static const LOAD_ALL_DURATION_TYPES_EVENT:String = "LOAD_ALL_DURATION_TYPES_EVENT";
		public static const LOAD_ALL_RECOMMENDATION_METHOD_TYPES_EVENT:String =	"LOAD_ALL_RECOMMENDATION_METHOD_TYPES_EVENT";
		public static const LOAD_ALL_RECOMMENDATION_PLAN_TYPES_EVENT:String =	"LOAD_ALL_RECOMMENDATION_PLAN_TYPES_EVENT";
		public static const LOAD_RECOMMENDATION_LINK_AUTO_COMPLETE_EVENT:String = "LOAD_RECOMMENDATION_LINK_AUTO_COMPLETE_EVENT";
		
		public static const LOAD_FOLLOW_UP_METHOD_TYPE_EVENT:String = "LOAD_FOLLOW_UP_METHOD_TYPE_EVENT";
		public static const LOAD_SERVICE_TYPE_EVENT:String = "LOAD_SERVICE_TYPE_EVENT";
		
		public static const MANAGE_PATIENT_IMMUNIZATION_EVENT:String = "MANAGE_PATIENT_IMMUNIZATION_EVENT";
		
		private static var m_oControllerInstance:QSCommonController;
		
		public static function getInstance():QSCommonController 
		{
			if ( m_oControllerInstance == null )
				m_oControllerInstance = new QSCommonController( new Lock() );
			return m_oControllerInstance;
		}

		public function QSCommonController(lock:Lock) 
		{
			if(null == lock )
				throw("Can't create object. please use getInstance() method instead ... ")
			
			addCommand(SEND_ERROR_REPORT_EVENT,SendErrorReportCommand);
			addCommand(LOAD_PATIENT_BY_PATIENT_ID_EVENT, LoadPatientbyPatientIDCommand);
			addCommand(LOAD_PLACE_OF_SERVICE_TYPES_EVENT, LoadPlaceOfServiceTypesCommand);
			addCommand(LOAD_ALL_INSURANCE_EVENT, LoadAllInsuranceCommand );
			addCommand(GET_STATE_CITY_ZIP_CODE_COMBINE_EVENT, GetStateCityZipCodeCombineCommand );
			addCommand(QS_ALLERGY_EVENT, QSAllergyCommand );
			addCommand(LOAD_PATIENT_PRESCRIPTION, LoadPatientMedCommand );
			addCommand(SAVE_PATIENT_GAXENID_EVENT, SavePatientGaxenIdCommand );
			addCommand(GET_PATIENT_GAXENID, GetPatientGaxenIdCommand );
			addCommand(GENERATE_SOAP_NOTE_PREVIEW_COMMON_EVENT, GenerateSoapNotePreviewCommonCommand );
			addCommand(LOAD_STATE_CODES_ONLY_EVENT, LoadStateCodesOnlyCommand);
			addCommand(VERIFY_USER_EVENT , VerifyUserCommand);
			addCommand(SIGN_VISIT_EVENT , SignVisitCommand);
			addCommand(CO_SIGN_VISIT_EVENT , CoSignVisitCommand);
			
			addCommand(LOAD_IMMUNIZATION_STATIC_DATA, LoadImmunizationStaticDataCommand);
			addCommand(LOAD_ICD_CODE_EVENT, LoadICDCodeCommand);
			addCommand(LOAD_ALL_BLOOD_RELATIONSHIP_TYPE_DTO_EVENT, LoadAllBloodRelationShipTypeDTOCommand);
			addCommand(LOAD_COMPREHENSIVE_HISTORY_STATIC_DATA, LoadComprehensiveHistoryStaticDataCommand);
			
			addCommand(LOAD_HPI_STATIC_DATA_EVENT, LoadHPIStaticDataCommand);
			addCommand(LOAD_ALL_HPI_DETAIL_TYPES_EVENT, LoadAllHPIDetailTypesCommand);
			
			addCommand(LOAD_IN_HOUSE_LAB_STATIC_DATA_EVENT, LoadInHouseLabStaticDataCommand);
			
			addCommand(LOAD_CPT_MEDICAL_TYPES_EVENT, LoadCPTMedicalTypesCommand);
			
			addCommand(LOAD_LAB_TEST_TYPE_STATIC_DATA_EVENT, LoadLabTestTypeStaticDataCommand);
			addCommand(LOAD_LAB_TYPE_STATIC_DATA_EVENT, LoadLabTypeStaticDataCommand);
			addCommand(LOAD_LIONIC_LAB_TEST_TYPE_EVENT, LoadLIONICLabTestTypeCommand);
			
			addCommand(LOAD_ALL_DURATION_TYPES_EVENT, LoadAllRecommendationDurationTypesCommand);
			addCommand(LOAD_ALL_RECOMMENDATION_METHOD_TYPES_EVENT, LoadAllRecommendationMethodTypesCommand);
			addCommand(LOAD_ALL_RECOMMENDATION_PLAN_TYPES_EVENT, LoadAllRecommendationPlanTypesCommand);
			addCommand(LOAD_RECOMMENDATION_LINK_AUTO_COMPLETE_EVENT, LoadRecommendationLinksAutoCompleteCommand);
			
			addCommand(LOAD_FOLLOW_UP_METHOD_TYPE_EVENT, LoadFollowUpMethodTypeCommand);
			addCommand(LOAD_SERVICE_TYPE_EVENT, LoadFollowUpServiceTypeCommand);
			
			addCommand(MANAGE_PATIENT_IMMUNIZATION_EVENT, ManagePatientImmunizationCommand);
		}
		
		public function ApplicationConfig(configXML:XML ):void
		{
			QSConstants.BILLING_RESTFULL_SERVICE_BASE_URL = XmlUtils.getPropertyValueByName( 'BILLING_RESTFUL_SERVICE', configXML );
			QSConstants.BILLING_RESTFULL_SERVICE_BASE_URL = XmlUtils.getPropertyValueByName( 'BILLING_RESTFUL_SERVICE', configXML );
			QSConstants.RESTFULL_ADRESSBOOK_SERVICE_BASE_URL = XmlUtils.getPropertyValueByName( 'EPRESCRIPTION_ADRESSBOOK_SERVICE', configXML );
			QSConstants.RESTFULL_SERVICE_BASE_URL = XmlUtils.getPropertyValueByName( 'EPRESCRIPTION_RESTFULSERVICE', configXML );
			QSConstants.EPRESCRIPTION_USER_SERVICE = XmlUtils.getPropertyValueByName( 'EPRESCRIPTION_USER_SERVICE', configXML );
			QSConstants.RESTFULL_PROVIDER_SERVICE_BASE_URL = XmlUtils.getPropertyValueByName( 'EPRESCRIPTION_PROVIDER_SERVICE', configXML );
			QSConstants.EPRESCRIPTION_QM_SERVICE = XmlUtils.getPropertyValueByName( 'EPRESCRIPTION_QM_SERVICE', configXML );
			QSConstants.RESTFUL_SERVICE_BASE_URL = XmlUtils.getPropertyValueByName('RESTFUL_SERVICE_BASE_URL', configXML);
		}
	}
	
	
}
class Lock
{
	//Singlton Lock
}