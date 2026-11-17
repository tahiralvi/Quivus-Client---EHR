package com.adobe.Quivus.utils.security
{
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.cairngorm.model.ModelLocator;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;

	public class QSSecurityUtil
	{
		private static const EDITABLE_SECURITY_TYPE:int		= 0;
		private static const VIEWABLE_SECURITY_TYPE:int		= 1;
		private static const SIGNABLE_SECURITY_TYPE:int		= 2;//only for VB encounter list
		private static const IMPORTABLE_SECURITY_TYPE:int	= 3;//only for QI diagnosis
	
		//TopBar-start
		public static const TOP_BAR:String 					= "top_bar";//NA
		public static const QUIVUS_WEB:String 				= "quivus_web";//D
		public static const QUICK_LINK:String 				= "quick_link";//D
		public static const PATIENT_REGISTRATION:String 	= "patient_registration ";//D
		public static const EPRESCRIPTION:String 			= "ePrescription ";//D
		public static const SCHEDULING:String 				= "scheduling ";//D
		public static const DOCUMENT_MANAGER:String 		= "document_manager ";//D
		public static const ELABS:String 					= "eLabs ";//D
		public static const BILLING:String 					= "billing ";//D
		public static const WEB_SEARCH_PANEL:String 		= "web_search";//D
		public static const CONTACT_SEARCH:String 			= "contact_search";//D
		//TopBar-Communication-start
		public static const COMMUNICATION_PANEL:String 		= "communication_panel";//D
		public static const EMAIL:String 					= "email";//D
		public static const SMS:String 						= "sms";// NA
		public static const VIDEO_CHAT:String 				= "video_chat";//NA
		public static const CHAT:String 					= "chat";//NA
		public static const CALL:String 					= "chat";//NA
		//TopBar-Communication- end
		public static const USER_PROFILE_PANEL:String 		= "user_profile_panel";//D
		public static const STATUS:String 					= "status";//D
		public static const LOCATION_LIST:String 			= "location_list";//D
		//TopBar-end
		
		//Patient Exam-Start
		public static const PATIENT_EXAM:String 			= "patient_exam";// NA
		public static const SEARCH_PATIENT:String 			= "search_patient";//?
		public static const RECENT_PATIENT_PANEL:String 	= "recent_patient";//D
		public static const COMMUNICATION:String 			= "communication";//NFI-where this check place in UI?
		public static const PATIENT_PROFILE:String 			= "patient_profile";//D-IsModuleEditable - IsModuleViewable
		//Patient Exam- View Background- Start
		public static const VIEW_BACKGROUND_PANEL:String 	= "view_background_panel";//D-IsModuleViewable
		public static const VB_ENCOUNTER_LIST:String 		= "vb_encounter_list";//D - IsModuleEditable, IsSignAllowed
		public static const VB_DOCUMENT_PANEL:String 		= "vb_document_panel";//D - IsModuleViewable
		public static const VB_CREATE_VIST:String 			= "vb_create_visit";//D-IsModuleViewable
		public static const VB_SUMMARY_VIEW:String 			= "vb_summary_view";//?
		public static const VB_ALLERGIES:String 			= "vb_allergies";//D - both
		public static const VB_COMPREHENSIVE_HISTORY:String	= "vb_comprehensive_history";//D - Both 
		public static const VB_CHRONIC_MEDICATION:String 	= "vb_chronic_medication";//D - Both 
		public static const VB_IMMUNIZATION:String 			= "vb_immunization";//D - Both 
		public static const VB_VITALS:String 				= "vb_vitals";//D - Both 
		public static const VB_CCHPI:String 				= "vb_cchpi";//D - Both 
		public static const VB_ROS:String 					= "vb_ros";//D - Both 
		public static const VB_PHYSICAL:String 				= "vb_physical";//D - Both 
		public static const VB_LAB:String 					= "vb_lab";//D - Both 
		public static const VB_LAB_IN:String 				= "vb_lab_in";//D - Both 
		public static const VB_LAB_OUT:String 				= "vb_lab_out";//D - Both 
		public static const VB_DIAGNOSIS:String 			= "vb_diagnosis";//D - Both 
		public static const VB_PRESCRIPTION:String 			= "vb_prescription";//D - Both 
		public static const VB_PROCEDURES:String 			= "vb_procedures";//D - Both 
		public static const VB_RECOMMENDATION:String 		= "vb_recommendation";//D - Both 
		public static const VB_FOLLOW_UP:String 			= "vb_follow-up";//D - Both 
		//Patient Exam- View Background- END
		//Patient Exam- QuickInput- START
		public static const QUICK_INPUT:String 				= "quick_input";//D - IsModuleViewable
		public static const QI_VISIT_PROPERTIES:String 		= "qi_visit-properties";//D 
		//Patient Exam- QuickInput-PMH - START
		public static const QI_PMH:String 					= "qi_pmh";//?
		public static const QI_ALLERGIES:String 			= "qi_allergies";//D 
		public static const QI_COMPREHENSIVE_HISTORY:String	= "qi_comprehensive_history";//D
		public static const QI_CHRONIC_MEDICATION:String 	= "qi_chronic_medication";//D
		public static const QI_IMMUNIZATION:String 			= "qi_immunization";//D
		//Patient Exam- QuickInput-PMH - END
		//Patient Exam- QuickInput-Physicals  - START
		public static const QI_PHYSICALS:String 			= "qi_physicals";//?
		public static const QI_VITALS:String 				= "qi_vitals";//?
		public static const QI_CCHPI:String 				= "qi_cchpi";//D
		public static const QI_ROS:String 					= "qi_ros";
		public static const QI_PHYSICAL:String 				= "qi_physical";
		public static const QI_LAB_IN:String 				= "qi_lab_in";//D
		//Patient Exam- QuickInput-Physicals  - END
		//Patient Exam- QuickInput-Assessment  - Start
		public static const QI_ASSESSMENT:String 			= "qi_assessment";//?
		public static const QI_DIAGNOSIS:String 			= "qi_diagnosis";//D
		public static const QI_TREATMENTS:String 			= "qi_treatments";//?
		public static const QI_PRESCRIPTION:String 			= "qi_prescription";//
		public static const QI_PROCEDURES:String 			= "qi_procedures";//D
		public static const QI_PLAN:String 					= "qi_plan";//?
		public static const QI_LAB_OUT:String 				= "qi_lab_out";//D
		public static const QI_RECOMMENDATION:String 		= "qi_recommendation";//D
		public static const QI_FOLLOW_UP:String 			= "qi_follow-up";//D
		//Patient Exam- QuickInput-Assessment  - END
		public static const REVIEW_HISTORY:String 			= "review_history";//D - IsViewAllowed
		public static const SIGN:String 					= "sign";//D - IsViewAllowed
		public static const SAVE_AND_REVIEW:String 			= "save_and_review";//D - IsViewAllowed
		//Patient Exam- QuickInput- END
				
		private var model:AppModelLocator		=	AppModelLocator.getInstance();
		
		private static var instance:QSSecurityUtil;
		
		public function QSSecurityUtil(lock:SecurityLock)
		{
			if( instance )
			{
				throw("SingletonError::please use \"SecurityUtil.Security\" instead");
			}
		}
		
		public static function get Security():QSSecurityUtil
		{
			if( null == instance )
			{
				instance = new QSSecurityUtil(new SecurityLock); 
			}
			return instance;
		}
		
		public function IsModuleEditable(moduleName:String, callBack:Function = null):Boolean
		{
			if( null == model.securityProxyObject )
			{
				Alert.show("Unable to load security information. Application is locked down, you can't access this module.", "application security", Alert.OK, FlexGlobals.topLevelApplication.mainContainer);
				return false;
			}
			
			var retVal:Boolean = true;
			switch( moduleName )
			{
				case TOP_BAR:
					retVal = CheckTopBar( EDITABLE_SECURITY_TYPE );
					break;
				case QUIVUS_WEB:
					retVal = CheckQuivusWeb( EDITABLE_SECURITY_TYPE );
					break;
				case QUICK_LINK:
					retVal = CheckQuickLink( EDITABLE_SECURITY_TYPE );
					break;
				case PATIENT_REGISTRATION:
					retVal = CheckPatientRegistration( EDITABLE_SECURITY_TYPE );
					break;
				case EPRESCRIPTION:
					retVal = CheckEprescription( EDITABLE_SECURITY_TYPE );
					break;
				case SCHEDULING:
					retVal = CheckScheduling( EDITABLE_SECURITY_TYPE );
					break;
				case DOCUMENT_MANAGER:
					retVal = CheckDocumentManager( EDITABLE_SECURITY_TYPE );
					break;
				case ELABS:
					retVal = CheckElabs( EDITABLE_SECURITY_TYPE );
					break;
				case BILLING:
					retVal = CheckBilling( EDITABLE_SECURITY_TYPE );
					break;
				case WEB_SEARCH_PANEL:
					retVal = CheckWebSearch( EDITABLE_SECURITY_TYPE );
					break;
				case CONTACT_SEARCH:
					retVal = CheckContactSearch( EDITABLE_SECURITY_TYPE );
					break;
				case COMMUNICATION_PANEL:
					retVal = CheckCommunication( EDITABLE_SECURITY_TYPE );
					break;
				case EMAIL:
					retVal = CheckEmail( EDITABLE_SECURITY_TYPE );
					break;
				case SMS:
					retVal = CheckSms( EDITABLE_SECURITY_TYPE );
					break;
				case VIDEO_CHAT:
					retVal = CheckVideoChat( EDITABLE_SECURITY_TYPE );
					break;
				case CHAT:
					retVal = CheckChat( EDITABLE_SECURITY_TYPE );
					break;
				case CALL:
					retVal = CheckCall( EDITABLE_SECURITY_TYPE );
					break;
				case USER_PROFILE_PANEL:
					retVal = CheckUserProfile( EDITABLE_SECURITY_TYPE );
					break;
				case STATUS:
					retVal = CheckStatus( EDITABLE_SECURITY_TYPE );
					break;
				case LOCATION_LIST:
					retVal = CheckLocationList( EDITABLE_SECURITY_TYPE );
					break;
				case PATIENT_EXAM:
					retVal = CheckPatientExam( EDITABLE_SECURITY_TYPE );
					break;
				case SEARCH_PATIENT:
					retVal = CheckSearchPatient( EDITABLE_SECURITY_TYPE );
					break;
				case RECENT_PATIENT_PANEL:
					retVal = CheckRecentPatient( EDITABLE_SECURITY_TYPE );
					break;
				case COMMUNICATION:
					retVal = CheckPatientCommunication( EDITABLE_SECURITY_TYPE );
					break;
				case PATIENT_PROFILE:
					retVal = CheckPatientProfile( EDITABLE_SECURITY_TYPE );
					break;
				case VIEW_BACKGROUND_PANEL:
					retVal = CheckViewBackground( EDITABLE_SECURITY_TYPE );
					break;
				case VB_ENCOUNTER_LIST:
					retVal = CheckEncounterList( EDITABLE_SECURITY_TYPE );
					break;
				case VB_DOCUMENT_PANEL:
					retVal = CheckVBDocument( EDITABLE_SECURITY_TYPE );
					break;
				case VB_CREATE_VIST:
					retVal = CheckCreateVisit( EDITABLE_SECURITY_TYPE );
					break;
				case VB_SUMMARY_VIEW:
					retVal = CheckSummaryView( EDITABLE_SECURITY_TYPE );
					break;
				case VB_ALLERGIES:
					retVal = CheckVBAllergies( EDITABLE_SECURITY_TYPE );
					break;
				case VB_COMPREHENSIVE_HISTORY:
					retVal = CheckVBComprehensiveHistory( EDITABLE_SECURITY_TYPE );
					break;
				case VB_CHRONIC_MEDICATION:
					retVal = CheckVBChronicMedication( EDITABLE_SECURITY_TYPE );
					break;
				case VB_IMMUNIZATION:
					retVal = CheckVBImmunization( EDITABLE_SECURITY_TYPE );
					break;
				case VB_VITALS:
					retVal = CheckVBVitals( EDITABLE_SECURITY_TYPE );
					break;
				case VB_CCHPI:
					retVal = CheckVBCCHpi( EDITABLE_SECURITY_TYPE );
					break;
				case VB_ROS:
					retVal = CheckVBROS( EDITABLE_SECURITY_TYPE );
					break;
				case VB_PHYSICAL:
					retVal = CheckVBPhysical( EDITABLE_SECURITY_TYPE );
					break;
				case VB_LAB_IN:
					retVal = CheckVBLabIn( EDITABLE_SECURITY_TYPE );
					break;
				case VB_LAB:
					retVal = CheckVBLab( EDITABLE_SECURITY_TYPE );
					break;
				case VB_DIAGNOSIS:
					retVal = CheckVBDiagnosis( EDITABLE_SECURITY_TYPE );
					break;
				case VB_PRESCRIPTION:
					retVal = CheckVBPrescription( EDITABLE_SECURITY_TYPE );
					break;
				case VB_PROCEDURES:
					retVal = CheckVBProcedures( EDITABLE_SECURITY_TYPE );
					break;
				case VB_LAB_OUT:
					retVal = CheckVBLabOut( EDITABLE_SECURITY_TYPE );
					break;
				case VB_RECOMMENDATION:
					retVal = CheckVBRecommendation( EDITABLE_SECURITY_TYPE );
					break;
				case VB_FOLLOW_UP:
					retVal = CheckVBFollowup( EDITABLE_SECURITY_TYPE );
					break;
				case QUICK_INPUT:
					retVal = CheckQuickInput( EDITABLE_SECURITY_TYPE );
					break;
				case QI_VISIT_PROPERTIES:
					retVal = CheckVisitProperties( EDITABLE_SECURITY_TYPE );
					break;
				case QI_PMH:
					retVal = CheckQIPmh( EDITABLE_SECURITY_TYPE );
					break;
				case QI_ALLERGIES:
					retVal = CheckQIAllergies( EDITABLE_SECURITY_TYPE );
					break;
				case QI_COMPREHENSIVE_HISTORY:
					retVal = CheckQIComprehensiveHistory( EDITABLE_SECURITY_TYPE );
					break;
				case QI_CHRONIC_MEDICATION:
					retVal = CheckQIChronicMedication( EDITABLE_SECURITY_TYPE );
					break;
				case QI_IMMUNIZATION:
					retVal = CheckQIImmunization( EDITABLE_SECURITY_TYPE );
					break;
				case QI_PHYSICALS:
					retVal = CheckQIPhysicals( EDITABLE_SECURITY_TYPE );
					break;
				case QI_VITALS:
					retVal = CheckQIVitals( EDITABLE_SECURITY_TYPE );
					break;
				case QI_CCHPI:
					retVal = CheckQICCHPI( EDITABLE_SECURITY_TYPE );
					break;
				case QI_ROS:
					retVal = CheckQIROS( EDITABLE_SECURITY_TYPE );
					break;
				case QI_PHYSICAL:
					retVal = CheckQIPhysical( EDITABLE_SECURITY_TYPE );
					break;
				case QI_LAB_IN:
					retVal = CheckQILabIn( EDITABLE_SECURITY_TYPE );
					break;
				case QI_ASSESSMENT:
					retVal = CheckQIAssessment( EDITABLE_SECURITY_TYPE );
					break;
				case QI_DIAGNOSIS:
					retVal = CheckQIDiagnosis( EDITABLE_SECURITY_TYPE );
					break;
				case QI_TREATMENTS:
					retVal = CheckQITreatments( EDITABLE_SECURITY_TYPE );
					break;
				case QI_PRESCRIPTION:
					retVal = CheckQIPrescription( EDITABLE_SECURITY_TYPE );
					break;
				case QI_PROCEDURES:
					retVal = CheckQIProcedures( EDITABLE_SECURITY_TYPE );
					break;
				case QI_PLAN:
					retVal = CheckQIPlan( EDITABLE_SECURITY_TYPE );
					break;
				case QI_LAB_OUT:
					retVal = CheckQILabOut( EDITABLE_SECURITY_TYPE );
					break;
				case QI_RECOMMENDATION:
					retVal = CheckQIRecommendation( EDITABLE_SECURITY_TYPE );
					break;
				case QI_FOLLOW_UP:
					retVal = CheckQIFollowUp( EDITABLE_SECURITY_TYPE );
					break;
				case REVIEW_HISTORY:
					retVal = CheckQIReviewHistory( EDITABLE_SECURITY_TYPE );
					break;
				case SIGN:
					retVal = CheckQISign( EDITABLE_SECURITY_TYPE );
					break;
				case SAVE_AND_REVIEW:
					retVal = CheckQISaveAndReview( EDITABLE_SECURITY_TYPE );
					break;
			}
			
			if( null != callBack )
				callBack( moduleName, "IsEditAllowed", retVal );
			
			if(false == retVal)
			{
				Alert.show("You are not authorized.", "application security", Alert.OK, FlexGlobals.topLevelApplication.mainContainer);
			}
			return retVal;
		}
		
		public function IsModuleViewable(moduleName:String, callBack:Function = null):Boolean
		{
			if( null == model.securityProxyObject )
			{
				Alert.show("Unable to load security information. Application is locked down, you can't access this module.", "application security", Alert.OK, FlexGlobals.topLevelApplication.mainContainer);
				return false;
			}
			
			var retVal:Boolean = true;
			switch( moduleName )
			{
				case TOP_BAR:
					retVal = CheckTopBar( VIEWABLE_SECURITY_TYPE );
					break;
				case QUIVUS_WEB:
					retVal = CheckQuivusWeb( VIEWABLE_SECURITY_TYPE );
					break;
				case QUICK_LINK:
					retVal = CheckQuickLink( VIEWABLE_SECURITY_TYPE );
					break;
				case PATIENT_REGISTRATION:
					retVal = CheckPatientRegistration( VIEWABLE_SECURITY_TYPE );
					break;
				case EPRESCRIPTION:
					retVal = CheckEprescription( VIEWABLE_SECURITY_TYPE );
					break;
				case SCHEDULING:
					retVal = CheckScheduling( VIEWABLE_SECURITY_TYPE );
					break;
				case DOCUMENT_MANAGER:
					retVal = CheckDocumentManager( VIEWABLE_SECURITY_TYPE );
					break;
				case ELABS:
					retVal = CheckElabs( VIEWABLE_SECURITY_TYPE );
					break;
				case BILLING:
					retVal = CheckBilling( VIEWABLE_SECURITY_TYPE );
					break;
				case WEB_SEARCH_PANEL:
					retVal = CheckWebSearch( VIEWABLE_SECURITY_TYPE );
					break;
				case CONTACT_SEARCH:
					retVal = CheckContactSearch( VIEWABLE_SECURITY_TYPE );
					break;
				case COMMUNICATION_PANEL:
					retVal = CheckCommunication( VIEWABLE_SECURITY_TYPE );
					break;
				case EMAIL:
					retVal = CheckEmail( VIEWABLE_SECURITY_TYPE );
					break;
				case SMS:
					retVal = CheckSms( VIEWABLE_SECURITY_TYPE );
					break;
				case VIDEO_CHAT:
					retVal = CheckVideoChat( VIEWABLE_SECURITY_TYPE );
					break;
				case CHAT:
					retVal = CheckChat( VIEWABLE_SECURITY_TYPE );
					break;
				case CALL:
					retVal = CheckCall( VIEWABLE_SECURITY_TYPE );
					break;
				case USER_PROFILE_PANEL:
					retVal = CheckUserProfile( VIEWABLE_SECURITY_TYPE );
					break;
				case STATUS:
					retVal = CheckStatus( VIEWABLE_SECURITY_TYPE );
					break;
				case LOCATION_LIST:
					retVal = CheckLocationList( VIEWABLE_SECURITY_TYPE );
					break;
				case PATIENT_EXAM:
					retVal = CheckPatientExam( VIEWABLE_SECURITY_TYPE );
					break;
				case SEARCH_PATIENT:
					retVal = CheckSearchPatient( VIEWABLE_SECURITY_TYPE );
					break;
				case RECENT_PATIENT_PANEL:
					retVal = CheckRecentPatient( VIEWABLE_SECURITY_TYPE );
					break;
				case COMMUNICATION:
					retVal = CheckPatientCommunication( VIEWABLE_SECURITY_TYPE );
					break;
				case PATIENT_PROFILE:
					retVal = CheckPatientProfile( VIEWABLE_SECURITY_TYPE );
					break;
				case VIEW_BACKGROUND_PANEL:
					retVal = CheckViewBackground( VIEWABLE_SECURITY_TYPE );
					break;
				case VB_ENCOUNTER_LIST:
					retVal = CheckEncounterList( VIEWABLE_SECURITY_TYPE );
					break;
				case VB_DOCUMENT_PANEL:
					retVal = CheckVBDocument( VIEWABLE_SECURITY_TYPE );
					break;
				case VB_CREATE_VIST:
					retVal = CheckCreateVisit( VIEWABLE_SECURITY_TYPE );
					break;
				case VB_SUMMARY_VIEW:
					retVal = CheckSummaryView( VIEWABLE_SECURITY_TYPE );
					break;
				case VB_ALLERGIES:
					retVal = CheckVBAllergies( VIEWABLE_SECURITY_TYPE );
					break;
				case VB_COMPREHENSIVE_HISTORY:
					retVal = CheckVBComprehensiveHistory( VIEWABLE_SECURITY_TYPE );
					break;
				case VB_CHRONIC_MEDICATION:
					retVal = CheckVBChronicMedication( VIEWABLE_SECURITY_TYPE );
					break;
				case VB_IMMUNIZATION:
					retVal = CheckVBImmunization( VIEWABLE_SECURITY_TYPE );
					break;
				case VB_VITALS:
					retVal = CheckVBVitals( VIEWABLE_SECURITY_TYPE );
					break;
				case VB_CCHPI:
					retVal = CheckVBCCHpi( VIEWABLE_SECURITY_TYPE );
					break;
				case VB_ROS:
					retVal = CheckVBROS( VIEWABLE_SECURITY_TYPE );
					break;
				case VB_PHYSICAL:
					retVal = CheckVBPhysical( VIEWABLE_SECURITY_TYPE );
					break;
				case VB_LAB:
					retVal = CheckVBLab( VIEWABLE_SECURITY_TYPE );
					break;
				case VB_LAB_IN:
					retVal = CheckVBLabIn( VIEWABLE_SECURITY_TYPE );
					break;
				case VB_LAB_OUT:
					retVal = CheckVBLabOut( VIEWABLE_SECURITY_TYPE );
					break;
				case VB_DIAGNOSIS:
					retVal = CheckVBDiagnosis( VIEWABLE_SECURITY_TYPE );
					break;
				case VB_PRESCRIPTION:
					retVal = CheckVBPrescription( VIEWABLE_SECURITY_TYPE );
					break;
				case VB_PROCEDURES:
					retVal = CheckVBProcedures( VIEWABLE_SECURITY_TYPE );
					break;
				case VB_RECOMMENDATION:
					retVal = CheckVBRecommendation( VIEWABLE_SECURITY_TYPE );
					break;
				case VB_FOLLOW_UP:
					retVal = CheckVBFollowup( VIEWABLE_SECURITY_TYPE );
					break;
				case QUICK_INPUT:
					retVal = CheckQuickInput( VIEWABLE_SECURITY_TYPE );
					break;
				case QI_VISIT_PROPERTIES:
					retVal = CheckVisitProperties( VIEWABLE_SECURITY_TYPE );
					break;
				case QI_PMH:
					retVal = CheckQIPmh( VIEWABLE_SECURITY_TYPE );
					break;
				case QI_ALLERGIES:
					retVal = CheckQIAllergies( VIEWABLE_SECURITY_TYPE );
					break;
				case QI_COMPREHENSIVE_HISTORY:
					retVal = CheckQIComprehensiveHistory( VIEWABLE_SECURITY_TYPE );
					break;
				case QI_CHRONIC_MEDICATION:
					retVal = CheckQIChronicMedication( VIEWABLE_SECURITY_TYPE );
					break;
				case QI_IMMUNIZATION:
					retVal = CheckQIImmunization( VIEWABLE_SECURITY_TYPE );
					break;
				case QI_PHYSICALS:
					retVal = CheckQIPhysicals( VIEWABLE_SECURITY_TYPE );
					break;
				case QI_VITALS:
					retVal = CheckQIVitals( VIEWABLE_SECURITY_TYPE );
					break;
				case QI_CCHPI:
					retVal = CheckQICCHPI( VIEWABLE_SECURITY_TYPE );
					break;
				case QI_ROS:
					retVal = CheckQIROS( VIEWABLE_SECURITY_TYPE );
					break;
				case QI_PHYSICAL:
					retVal = CheckQIPhysical( VIEWABLE_SECURITY_TYPE );
					break;
				case QI_LAB_IN:
					retVal = CheckQILabIn( VIEWABLE_SECURITY_TYPE );
					break;
				case QI_ASSESSMENT:
					retVal = CheckQIAssessment( VIEWABLE_SECURITY_TYPE );
					break;
				case QI_DIAGNOSIS:
					retVal = CheckQIDiagnosis( VIEWABLE_SECURITY_TYPE );
					break;
				case QI_TREATMENTS:
					retVal = CheckQITreatments( VIEWABLE_SECURITY_TYPE );
					break;
				case QI_PRESCRIPTION:
					retVal = CheckQIPrescription( VIEWABLE_SECURITY_TYPE );
					break;
				case QI_PROCEDURES:
					retVal = CheckQIProcedures( VIEWABLE_SECURITY_TYPE );
					break;
				case QI_PLAN:
					retVal = CheckQIPlan( VIEWABLE_SECURITY_TYPE );
					break;
				case QI_LAB_OUT:
					retVal = CheckQILabOut( VIEWABLE_SECURITY_TYPE );
					break;
				case QI_RECOMMENDATION:
					retVal = CheckQIRecommendation( VIEWABLE_SECURITY_TYPE );
					break;
				case QI_FOLLOW_UP:
					retVal = CheckQIFollowUp( VIEWABLE_SECURITY_TYPE );
					break;
				case REVIEW_HISTORY:
					retVal = CheckQIReviewHistory( VIEWABLE_SECURITY_TYPE );
					break;
				case SIGN:
					retVal = CheckQISign( VIEWABLE_SECURITY_TYPE );
					break;
				case SAVE_AND_REVIEW:
					retVal = CheckQISaveAndReview( VIEWABLE_SECURITY_TYPE );
					break;
			}
			
			if( null != callBack )
				callBack( moduleName, "IsViewAllowed", retVal );
			
			if(false == retVal)
			{
				Alert.show("You are not authorized.", "application security", Alert.OK, FlexGlobals.topLevelApplication.mainContainer);
			}
			
			return retVal;
		}
		
		public function IsModuleSignable(moduleName:String, callBack:Function = null):Boolean
		{
			if( null == model.securityProxyObject )
			{
				Alert.show("Unable to load security information. Application is locked down, you can't access this module.", "application security", Alert.OK, FlexGlobals.topLevelApplication.mainContainer);
				return false;
			}
			
			var retVal:Boolean = true;
			switch( moduleName )
			{
				case VB_ENCOUNTER_LIST:
					retVal = CheckEncounterList( SIGNABLE_SECURITY_TYPE );
					break;
			}
			
			if( null != callBack )
				callBack( moduleName, "IsSignAllowed", retVal );
			
			if(false == retVal)
			{
				Alert.show("You are not authorized.", "application security", Alert.OK, FlexGlobals.topLevelApplication.mainContainer);
			}
			
			return retVal;
		}
		public function IsModuleImportable(moduleName:String, callBack:Function = null):Boolean
		{
			if( null == model.securityProxyObject )
			{
				Alert.show("Unable to load security information. Application is locked down, you can't access this module.", "application security", Alert.OK, FlexGlobals.topLevelApplication.mainContainer);
				return false;
			}
			
			var retVal:Boolean = true;
			switch( moduleName )
			{
				case QI_DIAGNOSIS:
					retVal = CheckQIDiagnosis( IMPORTABLE_SECURITY_TYPE );
					break;
			}
			
			if( null != callBack )
				callBack( moduleName, "IsImportAllowed", retVal );
			
			if(false == retVal)
			{
				Alert.show("You are not authorized.", "application security", Alert.OK, FlexGlobals.topLevelApplication.mainContainer);
			}
			
			return retVal;
		}
	//****************************** check methods *******************************************	
		private  function CheckTopBar( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckQuivusWeb( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.QuivusWeb.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.QuivusWeb.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckQuickLink( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.QuickLink.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.QuickLink.IsViewAllowed;
				}
			}
			
			return retVal;
		}
		private  function CheckPatientRegistration( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.QuickLink.PatientRegistration.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.QuickLink.PatientRegistration.IsViewAllowed;
				}
			}
			
			return retVal;
		}
		private  function CheckEprescription( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.QuickLink.ePrescription.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.QuickLink.ePrescription.IsViewAllowed;
				}
			}
			
			return retVal;
		}
		private  function CheckScheduling( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.QuickLink.Scheduling.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.QuickLink.Scheduling.IsViewAllowed;
				}
			}
			
			return retVal;
		}
		private  function CheckDocumentManager( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.QuickLink.DocumentManager.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.QuickLink.DocumentManager.IsViewAllowed;
				}
			}
			
			return retVal;
		}
		private  function CheckElabs( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.QuickLink.ELabs.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.QuickLink.ELabs.IsViewAllowed;
				}
			}
			
			return retVal;
		}
		private  function CheckBilling( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.QuickLink.Billing.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.QuickLink.Billing.IsViewAllowed;
				}
			}
			
			return retVal;
		}
		private  function CheckWebSearch( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.WebSearch.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.WebSearch.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckContactSearch( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.ContactSearch.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.ContactSearch.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckCommunication( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.Communication.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.Communication.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckEmail( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.Communication.Email.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.Communication.Email.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckSms( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.Communication.SMS.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.Communication.SMS.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckVideoChat( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.Communication.VideoChat.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.Communication.VideoChat.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckChat( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.Communication.Chat.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.Communication.Chat.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckCall( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.Communication.Call.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.Communication.Call.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckUserProfile( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.UserProfile.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.UserProfile.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckStatus( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.Status.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.Status.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckLocationList( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.Locationlist.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.TopBar.Locationlist.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckPatientExam( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckSearchPatient( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.PatientSearch.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.PatientSearch.IsViewAllowed;
				}
			}
			
			return retVal;
		}
		private  function CheckRecentPatient( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.MostrecentPatient.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.MostrecentPatient.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckPatientCommunication( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.Communication.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.Communication.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckPatientProfile( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.PatientProfile.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.PatientProfile.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckViewBackground( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckEncounterList( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.Encounterlist.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.Encounterlist.IsViewAllowed;
				}
				else if(type == SIGNABLE_SECURITY_TYPE)
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.Encounterlist.IsSignAllowed;
				}
			}
			return retVal;
		}
		private  function CheckVBDocument( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.Documents.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.Documents.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckCreateVisit( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.CreateVisit.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.CreateVisit.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckSummaryView( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.SummaryView.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.SummaryView.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckVBAllergies( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.Allergies.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.Allergies.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckVBComprehensiveHistory( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.ComprehensiveHistory.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.ComprehensiveHistory.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckVBChronicMedication( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.ChronicMedication.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.ChronicMedication.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckVBImmunization( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.Immunization.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.Immunization.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckVBVitals( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.VitalSigns.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.VitalSigns.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckVBCCHpi( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.CCHPI.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.CCHPI.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckVBROS( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.ROS.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.ROS.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckVBPhysical( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.Physical.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.Physical.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckVBLabIn( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.Lab.LabIN.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.Lab.LabIN.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckVBLab( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.Lab.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.Lab.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckVBDiagnosis( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.Diagnosis.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.Diagnosis.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckVBPrescription( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.Prescription.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.Prescription.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckVBProcedures( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.Procedures.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.Procedures.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckVBLabOut( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.Lab.LabOut.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.Lab.LabOut.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckVBRecommendation( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.Recommendation.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.Recommendation.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckVBFollowup( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.FollowUp.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.ViewBackground.FollowUp.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckQuickInput( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckVisitProperties( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.VisitProperties.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.VisitProperties.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckQIPmh( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.PMH.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.PMH.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckQIAllergies( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.PMH.Allergies.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.PMH.Allergies.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckQIComprehensiveHistory( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.PMH.ComprehensiveHistory.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.PMH.ComprehensiveHistory.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckQIChronicMedication( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.PMH.ChronicMedication.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.PMH.ChronicMedication.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckQIImmunization( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.PMH.Immunization.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.PMH.Immunization.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckQIPhysicals( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Physicals.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Physicals.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckQIVitals( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Physicals.VitalSigns.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Physicals.VitalSigns.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckQICCHPI( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Physicals.CCHPI.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Physicals.CCHPI.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckQIROS( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Physicals.ROS.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Physicals.ROS.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckQIPhysical( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Physicals.Physical.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Physicals.Physical.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckQILabIn( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Physicals.LabIn.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Physicals.LabIn.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckQIAssessment( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Assessment.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Assessment.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckQIDiagnosis( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Assessment.Diagnosis.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Assessment.Diagnosis.IsViewAllowed;
				}
				else if( type == IMPORTABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Assessment.Diagnosis.IsImportAllowed;
				}
			}
			return retVal;
		}
		private  function CheckQITreatments( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Assessment.Treatments.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Assessment.Treatments.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckQIPrescription( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Assessment.Treatments.Prescription.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Assessment.Treatments.Prescription.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckQIProcedures( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Assessment.Treatments.Procedures.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Assessment.Treatments.Procedures.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckQIPlan( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Assessment.Plans.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Assessment.Plans.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckQILabOut( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Assessment.Plans.LabOut.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Assessment.Plans.LabOut.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckQIRecommendation( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Assessment.Plans.Recommendation.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Assessment.Plans.Recommendation.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckQIFollowUp( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Assessment.Plans.FollowUp.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Assessment.Plans.FollowUp.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckQIReviewHistory( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.ReviewHistory.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.ReviewHistory.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckQISign( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Sign.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.Sign.IsViewAllowed;
				}
			}
			return retVal;
		}
		private  function CheckQISaveAndReview( type:int ):Boolean
		{
			var retVal:Boolean = false; 
			if(model.securityProxyObject )
			{
				if( type == EDITABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.SaveAndReview.IsEditAllowed;
				}
				else if( type == VIEWABLE_SECURITY_TYPE )
				{
					retVal = model.securityProxyObject.PatientExam.QuickInput.SaveAndReview.IsViewAllowed;
				}
			}
			return retVal;
		}
		//**************************** end methods ***********************************
	}
}

class SecurityLock
{
	// singleton lock
}