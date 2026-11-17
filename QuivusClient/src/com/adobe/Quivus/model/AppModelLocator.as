package com.adobe.Quivus.model
{
	
	import com.adobe.Quivus.customDTO.AssociatedVisit;
	import com.adobe.Quivus.customDTO.SyncInfo;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.Quivus.view.controls.custom.patientExamView.quickInput.signCoSign.reviewAll.reviewcomponents.ReviewAllXML;
	import com.adobe.Quivus.view.controls.custom.patientExamView.viewBackground.vbTabSection.SummaryViewXMLCollection;
	import com.adobe.cairngorm.model.ModelLocator;
	import com.gazuntite.common.util.xml.XmlUtils;
	import com.gazuntite.provider.search.services.patient.util.PSConstants;
	import com.gazuntite.provider.search.services.provider.dto.ProviderBasicInfoResult;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.controls.Text;
	import mx.formatters.DateFormatter;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.utils.ObjectProxy;
	
	import valueObjects.*;
	
	[Bindable]
	public class AppModelLocator implements ModelLocator {
		
		private var logger:ILogger = Log.getLogger("com.adobe.Quivus.model.AppModelLocator");
		
		
		private static var model 							:AppModelLocator;
		
		public var KickOutPreviousSession					:Boolean;
		public var searchFieldTypeDTOList					:ArrayCollection; 
		private var _reviewHistroy                          :ReviewAllXML;
		private var _appVersion								:String;
		
		
		public var streamingServiceLoaded					:Boolean;
		public var quivusManagerServiceLoaded				:Boolean;
		public var confidentialitText						:String;//Tahir Alvi - General Setting 
		public var isUserLoginSuccessfully					:Boolean;//Tahir Alvi - General Setting 
		public var isConfidentialityNotificationRule		:Boolean;//Tahir Alvi - General Setting 
		public var isSessionInActivityLockRule				:Boolean;//Tahir Alvi - General Setting 
		public var isInActivityLockRuleEnable				:Boolean;//Tahir Alvi - General Setting 
		public var isSessionInActivityTime					:int;//Tahir Alvi - General Setting 
		public var hideSessionInActivityWindow				:Boolean;//Tahir Alvi - General Setting 
		public var isActivityWindow							:Boolean;//Tahir Alvi - General Setting 
		public var connectedUserName						:String;//Tahir Alvi - General Setting 
		private var _ImmunizationsReviewHistory				:ArrayCollection; // for review history
		private var _wsdlLoaded								:Boolean;
		private var _gaxenIDSaved							:Boolean;
		private var _isNewPatientReg						:Boolean;
		public var patientTempDTO							:Object;
		public var userImageData							:String;//For user Image @ Top Bar
		//-------for provider in QI ------------------
		public var VisitProviderDTOList						:ArrayCollection;//tahir alvi - for provider list in QI
		public var VisitProviderSelected					:int;//tahir alvi - for provider list in QI
		public var VisitProviderOwnerType					:int;//tahir alvi - for provider list in QI
		public var VisitProviderSelectedUserID				:int;//tahir alvi - for provider list in QI
		public var VisitProviderOwnerUSerTypeID				:int;//tahir alvi - for provider list in QI
		public var isVisitPhysicainSaved					:Boolean = false;
		//-------for provider in QI ------------------
		public function get wsdlLoaded():Boolean
		{
			return _wsdlLoaded;
		}
		
		public function set wsdlLoaded(value:Boolean):void
		{
			_wsdlLoaded = value;
		}
		
		public var  isNewVisitCreated						:Boolean;
		public  var sessionDTO								:UserSessionDTO;
		
		public  var securityProxyObject						:ObjectProxy;
		public  var generalSetttingProxyObject				:ObjectProxy;
		
		public var vbFilter									:String = Constants.BY_TYPE;
		public var vbVisitId								:int ;
		
		//Mansoor for AutoSave utility count hanler
		public var autoSaveCount							:int=0;
		public var isQISocHistorySave:Boolean				= false;
		
		public var dictationUploadInProcessCount			:int=0 ; // for loading the diseases of family history
		
		public var _gaxenID:String='';
		public var isAtRegGaxenID:Boolean;
		public var newRegGaxenID:String;
		
		public var lastVisitDate:String;		// in VB Header
		public var nextAppointmentDate:String; 	//in VB Header
		public var selectedPatientDTO:Object;
		public var patientMedACList:ArrayCollection;
		public var patientMedAC_inactiveList:ArrayCollection;
		public var patientChronicMedAC_inactiveList:ArrayCollection;
		public var patientChronicMedACList:ArrayCollection;
		
		//########################### Quivus Configuration ##########################
		
		
		private var _ServiceConfigXML					:XML;
		private var _SettingConfigXML					:XML;
		
		public function get ServiceConfigXML():XML
		{
			return _ServiceConfigXML;
		}
		
		public function set ServiceConfigXML(value:XML):void
		{
			_ServiceConfigXML = value;
			
			Constants.DICTATION_FOLDER_NAME 			= XmlUtils.getPropertyValueByName( 'DICTATION_FOLDER_NAME', value );
			Constants.DICTATION_SERVER_URL  			= XmlUtils.getPropertyValueByName( 'DICTATION_SERVER_URL', value );
			Constants.DICTATION_SERVICE_METHOD  		= XmlUtils.getPropertyValueByName( 'DICTATION_SERVICE_METHOD', value );
			Constants.RESTFUL_SERVICE_BASE_URL 			= XmlUtils.getPropertyValueByName( 'RESTFUL_SERVICE_BASE_URL', value );
			Constants.SECURITY_SERVICE_BASE_URL 		= XmlUtils.getPropertyValueByName( 'SECURITY_SERVICE_BASE_URL', value );
			Constants.QUIVUS_SECURITY_SERVICE_BASE_URL 	= XmlUtils.getPropertyValueByName( 'QUIVUS_SECURITY_SERVICE_BASE_URL', value );
			Constants.PATIENT_SEARCH_RESTFULSERVICE 	= XmlUtils.getPropertyValueByName( 'PATIENT_SEARCH_RESTFULSERVICE', value );
			Constants.BILLING_REPORT_BASE_URL       	= XmlUtils.getPropertyValueByName( 'BILLING_REPORT_BASE_URL', value );
			Constants.RESTFULL_PROVIDER_SERVICE_BASE_URL= XmlUtils.getPropertyValueByName( 'EPRESCRIPTION_PROVIDER_SERVICE', value );
			Constants.RESTFULL_ADRESSBOOK_SERVICE_BASE_URL = XmlUtils.getPropertyValueByName( 'EPRESCRIPTION_ADRESSBOOK_SERVICE', value );
			
			//logger.debug( "DICTATION_FOLDER_NAME: " + Constants.DICTATION_FOLDER_NAME );
			//logger.debug( "DICTATION_SERVER_URL: "  + Constants.DICTATION_SERVER_URL );
			//logger.debug( "DICTATION_SERVICE_METHOD: "  + Constants.DICTATION_SERVICE_METHOD );
			//logger.debug( "RESTFUL_SERVICE_BASE_URL: "  + Constants.RESTFUL_SERVICE_BASE_URL );
		}
		
		public function get SettingConfigXML():XML
		{
			return _SettingConfigXML;
		}
		
		public function set SettingConfigXML(value:XML):void
		{
			_SettingConfigXML = value;
			
			if( Log.isDebug() )
				logger.debug( "SettingConfigXML: " + value );
		}
		
		
		//############### e priscription ######################################
		public var ePrescriptionURL							:String;
		public var ePrescriptionANSURL						:String;
		
		public var ePrescriptionEditAllergiesURL			:String;
		public var ePrescriptionEditPrescriptionURL			:String;
		public var ePrescriptionEditMedicationURL			:String;
		//############### e priscription ######################################
		
		private var m_oUserPatientProfileBarInfoPopUpData	:PatientProfileTaggedDTO ;
		private var m_oUserPatientProfileBarSetting			:PatientProfileSettingResponse ;
		
		public var userPatientProfileBarSettingTemp			:PatientProfileSettingResponse ;
		
		private var m_sFirstSectionData						:String;
		private var m_sSecondSectionData					:String;
		private var m_sThirdSectionData						:String;
		
		private var m_sFirstSectionLabel					:String;
		private var m_sSecondSectionLabel					:String;
		private var m_sThirdSectionLabel					:String;
		
		
		private var m_oFirstSectionDTO					:PatientProfileSettingDTO;
		private var m_oSecondSectionDTO					:PatientProfileSettingDTO;
		private var m_oThirdSectionDTO					:ProfileSettingsCollectionDTO;
		
		//public var isUserManagerServiceOnline:Boolean;
		public var imageTypeDTOList						:ArrayCollection;
		
		public var profileImageTypeDTO					:ImageTypeDTO;
		public var insuranceImageTypeDTO 				:ImageTypeDTO;
		
		
		//############################# LABS STATIC DATA ############################################
		public var labNatureTypeDTOList						:ArrayCollection; // radio
		public var labTestPriorityTypeDTOList				:ArrayCollection;
		public var labTestSpecimenTypeDTOList				:ArrayCollection;
		public var labTestTypeDTOList						:ArrayCollection;
		public var labTypeDTOList							:ArrayCollection; // Laboratrory
		public var labTestOrderMethodTypeDTOList			:ArrayCollection;
		public var icdCodeDTOList							:ArrayCollection; // Associated Diagnosis
		
		public var inHouseLabTestTypeDTOList				:ArrayCollection;
		public var cptMedicalTypesDTOList					:ArrayCollection;
		public var lionicLabTestTypeDTOList					:ArrayCollection;
		//############################# LABS STATIC DATA ############################################
		
		//############################# PRESCRIPTION  ############################################
		public var prescriptionCurrentPageByPatient			:PageDTO; //VB
		public var prescriptionMedicationDTOList			:ArrayCollection; // pateint 
		//public var prescriptionDTOList					:ArrayCollection;
		public var medicationCurrentPageByPatient			:PageDTO;
		public var medicationDTOList						:ArrayCollection;
		public var chMedicationDTOList						:ArrayCollection;
		public var prescriptionDToList						:ArrayCollection;
		//############################# LABS STATIC DATA ############################################
		
		public var patientPreviousVitalsList				:ArrayCollection; // patient's most recent vitals
		
		//########## patient history data pop-up lists
		public var setAsDefault							:Boolean;
		
		public var patientAllergyInfoDTOList			:ArrayCollection ;
		public var patientChronicMedicationInfoDTOList	:ArrayCollection ;
		public var patientImmunizationInfoDTOList		:ArrayCollection ;
		public var patientDiagnosisInfoDTOList			:ArrayCollection ;
		public var patientInsuracneInfoDTOList			:ArrayCollection ;
		
		public var allSearchEngineDTOList				:ArrayCollection;
		public var allQuickLinksDTOList					:ArrayCollection;
		
		public var patientSearchPageNo					:int=1 ;
		public var patientSearchResultDTO				:PatientSearchResultDTO ;//complete search result
		public var patientSearchDTOList 				:ArrayCollection; // this is the list from the searh result
		
		public var zipcodeList							:ArrayCollection;
		public var citiesList							:ArrayCollection;
		public var statscodeList						:ArrayCollection;
		
		public var userProfileBarStaticDataList			:ArrayCollection;
		public var userProfileBarHealthStaticDataList	:ArrayCollection;
		//For Gurantor
		public var zipcodeListG							:ArrayCollection;
		public var citiesListG							:ArrayCollection;
		public var statscodeListG						:ArrayCollection;
		
		public var loadedPatientId						:int=0 ;
		
		
		public var followupServiceTypeControlId			:int = 1;
		public var followupDateTypeControlId			:int = 2;
		
		public var allModulesDTOList					:ArrayCollection; // all modules list 
		
		public var allGeneralHistoryTypeDTOList			:ArrayCollection; // all MedicalHistoryTypeDTOs list 
		public var allFamilyHistoryTypeDTOList			:ArrayCollection; // all FamilyHistoryTypeDTOs list
		public var allSocialHistoryAddictionTypeDTOList	:ArrayCollection; // all SocialHistoryTypeDTOs list
		
		//public var socialHistoryUsageAmountDTOList		:ArrayCollection; // 
		//public var socialHistoryMediumTypesDTOList		:ArrayCollection; //
		
		public var usageAmountDTOData					:SocialHistoryUsageAmountTypeResponse;
		public var historyMediumTypesDTOData			:SocialHistoryMediumTypeResponse;
		//############# visit ##############################
		
		public var quicInputAllergyDTOList				:ArrayCollection;
		
		//09/03/2012 by Shahid Munir
		public var AllergyList				    :ArrayCollection; // for dropdown search
		public var QIAllergyDTOList				:ArrayCollection; // records of allergies
		public var AllergyNKDAFlag				:Boolean = false; // records of allergies
		
		public var summary:SummaryViewXMLCollection;
		
		public var visitStakeHolderDTOList				:ArrayCollection;
		public var canCoSign							:Boolean;
		public var canSign								:Boolean;
		public var signCosignBtnEnabled					:Boolean;
		public var saveBtnEnabled						:Boolean;
		public var visitDTO								:VisitDTO ;	//created
		public var placeOfServiceID					    :int ;	//created
		public var placeOfServiceName					:String ;	//created
		
		// ViewBackGround
		public var allergyCurrentPageByPatient			:PageDTO;
		//Saman
		public var vbEventCounter						:int;
		public var vbDataLoadedFlag						:Boolean = false;
		
		public var signCoSignBtnLabel					:String;
		
		//single point to access the formated visit date.....TH
		public function get FormatedVisitDate():String
		{
			var retString:String = "";
			try
			{
				var f:DateFormatter			= new DateFormatter();
				f.formatString				= "MM-DD-YYYY";
				retString = f.format( visitDTO.VisitDate );
			}
			catch(e:Error)
			{
				trace("FormatedVisitDate:: ","unable to parse visit date");
				retString = f.format( new Date() );
			}
			finally
			{
				return retString;
			}
		}
		
		public function set FormatedVisitDate(value:String):void
		{
			
		}
		
		public var QLpatientEncounterResult				:PatientEncounterResult ;
		public var patientEncounterResult				:PatientEncounterResult ;
		public var visitId								:int ; 
		public var soapTemplateTypeDTOList				:ArrayCollection;
		public var templateId							:int ; //  for created visit
		public var encounterTypeId						:int ; //  for created visit
		public var placeOfServiceList					:ArrayCollection;
		public var encounterTypeDTOList					:ArrayCollection;
		public var createdVisitDate						:Date;
		public var generalTemplateId					:int ;
		public var unSignedVisitDates					:ArrayCollection;
		
		
		//delete this, after changing the binding
		public var moduleNoteDTOList					:ArrayCollection;// for manupilating(loading, saving) module level notes for a visit.
		//############# end         ########################################
		
		
		
		
		public var moduleNoteDTOListByPatient			:ArrayCollection;// for VB
		public var moduleDictationDTOListByPatient		:ArrayCollection;// for VB
		
		
		
		private var _defaultFilterAndPaging					:PageDTO;// for VB
		public function get defaultFilterAndPaging():PageDTO
		{
			return _defaultFilterAndPaging;
		}
		
		public function set defaultFilterAndPaging(value:PageDTO):void
		{
			_defaultFilterAndPaging = value;
		}
		
		
		
		
		
		//############# visit Quick-inout ##############################
		public var quickInputDTO						:QuickInputDTO;		
		public var socialHistoryDTO						:SocialHistoryDTO;
		//############# end         ########################################
		
		public var patientProcedureCurrentPageByPatient		:PageDTO;
		public var patientProcedureDTOListByPatient		:ArrayCollection;
		
		//############# visit Immunization##############################
		public var immunizationCurrentPageByPatient		:PageDTO;
		public var visitImmunizationDTOList				:ArrayCollection;
		public var immunizationDTOList					:ArrayCollection; // this is for quickinpput data 
		
		
		public var visitChronicMedicationDTOList		:ArrayCollection;
		public var chronicMedicationDTOList				:ArrayCollection; // this is for quickinpput data 
		
		public var immunizationId						:int ;
		public var immunizationTypeDTOList				:ArrayCollection;
		public var immunizationLotNumberList			:ArrayCollection;
		public var immunizationDoseList					:ArrayCollection;
		public var immunizationRefusalReasonList		:ArrayCollection;
		public var immunizationSitesList				:ArrayCollection;
		public var immunizationSeriesList				:ArrayCollection;
		public var immunizationManufacturerList			:ArrayCollection;
		public var immunizationRoutList					:ArrayCollection;
		//############# end         ########################################
		
		//############# LABS ##############################
		public var LabOutCurrentPageByPatient			:PageDTO;
		public var inHouseLabCurrentPageByPatient		:PageDTO;
		public var inHouseLabDTOListByVisit				:ArrayCollection;
		public var inHouseLabDTOListByPatient			:ArrayCollection;
		
		public var labDTOListByVisit					:ArrayCollection;
		public var labDTOListByPatient					:ArrayCollection;
		//############# LABS ##############################
		
		//############# VITALS ##############################
		public var vitalCurrentPageByPatient			:PageDTO;
		public var vitalDTOListByPatient				:ArrayCollection;
		public var vitalDTOListByVisit					:ArrayCollection;
		//############# ##### ##############################
		
		//############# HPI ##############################
		public var HPI_CCCurrentPageByPatient			:PageDTO;
		public var HPI_CCDTOListByPatient				:ArrayCollection;
		public var HPI_CCDTOListByVisit					:ArrayCollection;
		//############# ##### ##############################
		
		public var PatientDocumentDTOList				:ArrayCollection;
		public var docSectionTypeDTOList				:ArrayCollection;
		public var isPatientDocSearching				:Boolean;
		public var totalPatientDocRec					:int=0;
		public var firstPatientDocRec					:int=0;
		public var lastPatientDocRec					:int=0;
		public var patientDocumentTotalPageNo			:int=0 ;
		public var patientDocRecPageNo					:int=0;
		
		private var m_ipatientDocSearchPageNo				:int=1 ;
		
		//by shahid munir
		public var isPatientFemale:Boolean = false;
		
		public function get patientDocSearchPageNo():int
		{
			return m_ipatientDocSearchPageNo;
		}
		
		public function set patientDocSearchPageNo(value:int):void
		{
			if( value <= 0 )
			{
				m_ipatientDocSearchPageNo = 1;
			}
			else if( value >= patientDocumentTotalPageNo )
			{
				m_ipatientDocSearchPageNo = patientDocumentTotalPageNo;
			}
			else
			{
				m_ipatientDocSearchPageNo = value;
			}
		}
		
		
		//############# COMPREHENSIVE HISTORY ##############
		public var medicalHistoryDTOListByVisit     	:ArrayCollection;
		public var familyHistoryDTOListByVisit			:ArrayCollection;
		public var socialHistoryDTOListByVisit			:ArrayCollection;
		
		
		public var medicalHistoryCurrentPageByPatient			:PageDTO;
		public var familyHistoryCurrentPageByPatient			:PageDTO;
		public var socialHistoryCurrentPageByPatient			:PageDTO;
		
		public var medicalHistoryDTOListByPatient     	:ArrayCollection;
		public var familyHistoryDTOListByPatient		:ArrayCollection;
		public var socialHistoryDTOListByPatient		:ArrayCollection;
		
		//########################NEW HISTRY IMPL############
		public var medicalHistoryList		:ArrayCollection;
		public var familyHistoryList		:ArrayCollection;
		public var socialHistoryList		:ArrayCollection;
		//############# ##### ##############################
		
		//############# DIAGNOSIS ##############
		public var patientDiagnosisDTOListByPatientId     		:ArrayCollection;
		public var patientChronicDiagnosisDTOListByPatientId	:ArrayCollection;
		
		public var DiagnosisAcuteCurrentPageByPatient			:PageDTO;
		public var DiagnosisChronicCurrentPageByPatient			:PageDTO;
		public var DiagnosisResolvedCurrentPageByPatient		:PageDTO;
		
		public var patientDiagnosisDTOAcuteListByPatientId     	:ArrayCollection;//VB
		public var patientDiagnosisDTOChronicListByPatientId    :ArrayCollection;//VB
		public var patientDiagnosisDTOResolvedListByPatientId   :ArrayCollection;//VB
		
		public var patientDiagnosisDTOAllChronicCurrentPageByPatient :PageDTO;
		public var patientDiagnosisDTOAllChronicListByPatientId    :ArrayCollection;
		public var patientDiagnosisAllChronicTemplateAvailable    :Boolean;
		//############# ##### ##############################
		
		
		
		//############# patient profile loaded##############################
		public var patientProfileDTO					:PatientProfileDTO;
		public var EDItimelyFilingIndicator:String;
		public var EDIexceptionCode:String; 
		public var patientSSN:String; 
		
		public var patientPrimaryPhoneDTO				:PhoneDTO;
		public var patientAddressDTO					:AddressDTO;
		public var motherPrimaryPhoneDTO				:PhoneDTO;
		public var fatherPrimaryPhoneDTO				:PhoneDTO;
		public var guarantorPrimaryPhoneDTO				:PhoneDTO;
		public var guarantorAddressDTO					:AddressDTO;
		public var imageDTO								:ImageDTO;
		
		public var primaryInsurance						:PatientInsuranceDTO;
		public var secondaryInsurance					:PatientInsuranceDTO;
		
		public var patientAllergyDTO					:PatientAllergyDTO;
		
		public var patientEmergencyContactDTO			:PatientEmergencyContactDTO;
		
		public var patientLanguageDTO					:PatientLanguageDTO;
		
		public var chdataLoaded							:Boolean;
		//for display in the basic section popup
		public var patientPhoneList:ArrayCollection;
		public var patientlanguage:String ='';
		public var patientName:String ;//for show in topbar
		public var providerName:String ;//for show in topbar
		
		//############# end ##############################
		
		public var diseaseCallNumber					:int=0 ; // for loading the diseases of family history
		public var hpiCallNumber						:int=0 ; // for loading the hpi dd
		
		public var userEmail							:String;
		
		//#############   REGISTRATION  ##############################
		public var dataToLoad							:ArrayCollection ;
		public var callNumber							:int=0 ;
		public var registrationStaticDataDTO			:RegisterationStaticDataDTO;
		public var addressBookStaticDataDTO				:AddressBookStaticDataDTO;
		
		public var registrationErrorMsg					:String;
		public var regEventCount						:int;
		
		public var patientRegImageDTO					:ImageDTO;
		
		public var basicUserDTO							:BaseUserDTO ;
		public var patientDTO							:PatientDTO ;
		public var patientUserId						:int ;
		public var patientId							:int ;
		public var addressBookDTO						:AddressBookDTO;
		public var healthHX								:PatientHealthDTO;
		public var patientGuarantorDTO					:PatientGuarantorDTO;
		public var patientGuarantorDTOList				:ArrayCollection;
		public var patientLanguageDTOList				:ArrayCollection ;
		public var patientInsuranceDTOList				:ArrayCollection ;
		public var allergyDTOList						:ArrayCollection ;
		public var icdCodeList							:ArrayCollection ;
		public var patientEmergencyContactDTOList		:ArrayCollection ;
		
		//public var allergyHistoryList					:ArrayCollection ;
		//public var medicalHistoryList					:ArrayCollection ;
		//public var familyHistoryList					:ArrayCollection ;
		
		
		//############# COMPREHENSIVE HISTORY FAMILY DISEASE LOADED ##############################
		public var cancerDiseaseTypesDTOList			:ArrayCollection;
		public var diabetesDiseaseTypesDTOList			:ArrayCollection;
		public var heartDiseaseDiseaseTypesDTOList		:ArrayCollection;
		public var hypertensionDiseaseTypesDTOList		:ArrayCollection;
		public var otherDiseaseTypesDTOList				:ArrayCollection;		
		
		//############# end ##############################
		
		public var rosDTOList							:ArrayCollection;
		public var physicalsDTOList						:ArrayCollection;
		
		public var rosCurrentPageByPatient				:PageDTO;
		public var rosDTOListVB							:ArrayCollection;
		public var physicalsCurrentPageByPatient		:PageDTO;
		public var physicalsDTOListVB					:ArrayCollection;
		//############# HPI DD ##############################
		
		public var contextList							:ArrayCollection;//1
		public var duration								:ArrayCollection;//2
		public var exacerbating							:ArrayCollection;//3
		public var location								:ArrayCollection;//4	
		public var modifyingFactors						:ArrayCollection;//5
		public var progression							:ArrayCollection;//6
		public var quality								:ArrayCollection;//7
		public var radiation							:ArrayCollection;//8
		public var severity								:ArrayCollection;//9
		public var symptom								:ArrayCollection;//10		
		
		//M
		public var hpiDetailTypesList					:ArrayCollection;		
		
		//############# end ##############################
		
		
		//############# RECOMMENDATION DD ##############################
		
		//M
		public var planTypesList					:ArrayCollection;		
		public var methodTypesList					:ArrayCollection;
		public var linksList						:ArrayCollection;//Recommendation links
		public var durationTypesList				:ArrayCollection;
		
		
		public var patientRecommendationCurrentPageByPatient	:PageDTO;
		public var patientRecommendationDTOListByPatientId	:ArrayCollection;
		
		//############# end ##############################
		
		
		//############# FOLLOW UP  ##############################
		public var patientFollowupInstructionDTOList	:ArrayCollection;	 // loaded by visit id ....	
		public var patientFollowupInstructionDTOListByPatient	:ArrayCollection;	 
		
		public var serviceTypeDTOList					:ArrayCollection;	 // static data
		public var DateServiceTypeDTOList				:ArrayCollection;	 // static data
		public var instructionDurationTypeDTOList		:ArrayCollection;	 // static data
		public var instructionAgeTypeDTOList			:ArrayCollection;	 // static data
		public var instructionAgeValueTypeDTOList		:ArrayCollection;	 // static data
		
		public var followUpMethodTypeList				:ArrayCollection;    //  
		
		public var followupDataControlTypeDTOList		:ArrayCollection;  
		
		public var followupLabsDTOList					:ArrayCollection;    //
		
		public var patientFollowupCurrentPageByPatient	:PageDTO;
		public var patientFollowupDTOListByPatientId	:ArrayCollection;
		
		//############# end ##############################
		//************** patient basic info ********************
		public var patientBasicInfo:Object;
		//############## Start - Total Records #########################
		public var totalRecords_PE:int 			= 0;
		public var totalRecords_DM:int			= 0;
		public var totalRecords_RP:int			= 0;
		public var totalRecords_CDP:int			= 0;
		public var totalPatientsInDB:int 		= 0;//Total records in DB in All patient service
		public var lastRecordNumberInDB:int 	= 0;//Total Loaded patient in newst service
		public var pageNumberInDB:int 			= 1;//Last result page no
		public var totalPatientsList:ArrayCollection;
		public var currentDayPatientsList:ArrayCollection;
		public var lastSyncTime:String = '';//Last sync Time of Local DB with Live DB
		public var localSearchList:ArrayCollection;//Local Search result List from Local DB
		
		//############## End - Total Records   #########################
		
		//############## Start - Application Syncing   #########################
		
		public var SyncHeaderLabel:String 		= "Initializing Application"
		/*public var SyncHeaderLabel:String 	= "Syncing Application";
		public var SyncTotalToSyncLabel:String 	= "Syncing Application";
		public var SyncSyncedLabel:String 		= "Syncing Application";*/
		public var SyncTotalToSyncCount:int 	= 0;
		public var SyncSyncedCount:int 			= 0;
		public var syncInfo:SyncInfo			= new SyncInfo();
		
		
		//############## End - Application Syncing   #########################
		
		
		
		//#######################################
		
		
		public var userSearchEngineDTOList				:ArrayCollection;
		public var userPrefferedSearchEngineDTO			:SearchEngineDTO;
		
		public var userQuickLinksDTOList				:ArrayCollection;
		
		public var contactSearchSuggestionList			:ArrayCollection;
		
		public var loggedInUserDTO						:LoginDTO;
		public var userSelectedClinicBranchDTO			:UserClinicBranchDTO  ;
		public var userSelectedRoleDTO					:UserClinicRoleDTO  ;
		
		public var userSelectedStationDTO				:StationDTO  ;
		
		public var stationIdsForVB						:ArrayCollection  ;
		
		public var isAllStationSelected					:Boolean  ;
		
		private var isUserLoggedIn						:Boolean= false; // this is for state change ....
		private var isSyncingApplication				:Boolean= false; // this is for update change ....
		public var SyncingApplicationStatus 			:String;
		
		public var quicklinkEnabled						:Boolean= false;
		
		public var errorStatus 							:String;
		private var _lostPasswordResult					:String;
		private var _lostPasswordIsLockedResult			:String;
		private var _lostPasswordIsActiveResult			:String;
		private var _lostPasswordIsValidResult          :String;
		private var _errorMessageResult          		:String;
		
		private var _loginCounter                       :int=0;
		private var _userName							:String ;
		private var m_sCurrentSearchMode				:String = Constants.CONTACTS_SEARCH_MODE;
		
		public var mostRecentPatientList				:ArrayCollection;
		
		
		public var tempQIExists							: Boolean;
		
		
		
		public var patientAllDiagnosisForRecommendationList				:ArrayCollection;
		
		
		//Mansoor		
		public var quickInputDataLoadedFlag	:Boolean = false;
		public var quickInputVitalsDataLoaded:Boolean = false;
		
		
		
		public function AppModelLocator() : void {
			if ( AppModelLocator.model != null )
				throw new Error( "Only one AppModelLocator instance should be instantiated" );
		}
		
		
		
		
		public static function getInstance() : AppModelLocator {
			if ( model == null )
				model = new AppModelLocator();
			return model;
		}
		
		// used only in signing-out from the application...
		public static function reSetModelInstance() : void {
			
			model = null;
			
		}
		
		
		
		
		
		private var m_oSearchProviderDetailsResults:ProviderBasicInfoResult;
		
		public var UserSessionStatus					:ArrayCollection;
		
		
		
		//############################ DATA MEMBERS GETTERS SETTERS #########################################
		
		/*public function get UserSessionStatus():ArrayCollection
		{
		return m_oUserSessionStatus;
		}
		
		public function set UserSessionStatus(value:ArrayCollection):void
		{
		m_oUserSessionStatus = value;
		}*/
		
		
		public function get SearchProviderDetailsResults():ProviderBasicInfoResult
		{
			return m_oSearchProviderDetailsResults;
		}
		
		public function set SearchProviderDetailsResults(value:ProviderBasicInfoResult):void
		{
			m_oSearchProviderDetailsResults = value;
		}
		
		
		private var _m_ovideoCallInfo:String;
		
		public function get m_ovideoCallInfo():String
		{
			return _m_ovideoCallInfo;
		}
		
		public function set m_ovideoCallInfo(value:String):void
		{
			_m_ovideoCallInfo = value;
		}
		
		//Associated Visit Section;
		private var mCHistoryAssociatedVisit:AssociatedVisit;
		private var mImmonizationAssociatedVisit:AssociatedVisit;
		private var mDiagnosisAssociatedVisit:AssociatedVisit;
		
		// ######################## GETTER SETTERSsss #########################
		
		public function get UserLoggedIn():Boolean
		{
			return isUserLoggedIn;
		}
		
		public function set UserLoggedIn(value:Boolean):void
		{
			isUserLoggedIn = value;
		}
		
		public function get SyncingApplication():Boolean
		{
			return isSyncingApplication;
		}
		
		public function set SyncingApplication(value:Boolean):void
		{
			isSyncingApplication = value;
		}
		
		public function get CurrentSearchMode():String
		{
			return m_sCurrentSearchMode;
		}
		
		public function set CurrentSearchMode(value:String):void
		{
			m_sCurrentSearchMode = value;
		}
		public function get userPatientProfileBarSetting():PatientProfileSettingResponse
		{
			return m_oUserPatientProfileBarSetting;
		}
		
		public function set userPatientProfileBarSetting(value:PatientProfileSettingResponse):void
		{
			m_oUserPatientProfileBarSetting = value;
			if(value!=null && value.CompleteSettings!=null)
			{
				
				if(value.CompleteSettings.SectionFirstData!=null)
				{
					FirstSectionLabel = value.CompleteSettings.SectionFirstData.DisplayText;
					FirstSectionData 	=  value.CompleteSettings.SectionFirstData.FieldData;
				}else
				{
					FirstSectionLabel = "";
					FirstSectionData 	=  "";
				}
				if(value.CompleteSettings.SectionSecondData!=null){
					SecondSectionLabel = value.CompleteSettings.SectionSecondData.DisplayText;
					SecondSectionData 	=  value.CompleteSettings.SectionSecondData.FieldData;
				}
				else
				{
					SecondSectionLabel = "";
					SecondSectionData 	=  "";
				}
				
				ThirdSectionData 	= getThirdSectionData();
				
				/*	Tahir Alvi - Now set from QiAllergiesCommand
				if(this.userPatientProfileBarSetting.CompleteSettings.SectionThirdData!=null){				
				ThirdSectionLabel = this.userPatientProfileBarSetting.CompleteSettings.SectionThirdData.CollectionType;
				}
				else
				{
				ThirdSectionLabel = "";
				}
				*/
				
				if(value.CompleteSettings.SectionFirstData!=null)
				{
					FirstSectionDTO 	= value.CompleteSettings.SectionFirstData;
				}else
				{
					FirstSectionDTO = new PatientProfileSettingDTO();
				}
				if(value.CompleteSettings.SectionSecondData!=null)
				{
					SecondSectionDTO 	= value.CompleteSettings.SectionSecondData;
				}else
				{
					SecondSectionDTO = new PatientProfileSettingDTO();
				}
				
				if(value.CompleteSettings.SectionThirdData!=null)
				{
					ThirdSectionDTO		= value.CompleteSettings.SectionThirdData;
				}
				else
				{
					ThirdSectionDTO = new ProfileSettingsCollectionDTO();
				}
			}
			
		}
		public function get ThirdSectionLabel():String
		{
			return m_sThirdSectionLabel;
		}
		
		public function set ThirdSectionLabel(value:String):void
		{
			m_sThirdSectionLabel = value;
		}
		
		public function get ThirdSectionData():String
		{
			return m_sThirdSectionData;
		}
		
		public function set ThirdSectionData(value:String):void
		{
			m_sThirdSectionData = value;
		}
		
		public function get SecondSectionData():String
		{
			return m_sSecondSectionData;
		}
		public function get SecondSectionLabel():String
		{
			return m_sSecondSectionLabel;
		}
		
		public function set SecondSectionData(value:String):void
		{
			m_sSecondSectionData = value;
		}
		public function set SecondSectionLabel(value:String):void
		{
			m_sSecondSectionLabel = value;
		}
		
		public function get FirstSectionData():String
		{
			return m_sFirstSectionData;
		}
		public function get FirstSectionLabel():String
		{
			return m_sFirstSectionLabel;
		}
		
		public function set FirstSectionData(value:String):void
		{
			m_sFirstSectionData = value;
		}
		public function set FirstSectionLabel(value:String):void
		{
			m_sFirstSectionLabel = value;
		}
		
		public function get ThirdSectionDTO():ProfileSettingsCollectionDTO
		{
			return m_oThirdSectionDTO;
		}
		
		public function set ThirdSectionDTO(value:ProfileSettingsCollectionDTO):void
		{
			m_oThirdSectionDTO = value;
		}
		
		public function get SecondSectionDTO():PatientProfileSettingDTO
		{
			return m_oSecondSectionDTO;
		}
		
		public function set SecondSectionDTO(value:PatientProfileSettingDTO):void
		{
			m_oSecondSectionDTO = value;
		}
		
		public function get FirstSectionDTO():PatientProfileSettingDTO
		{
			return m_oFirstSectionDTO;
		}
		
		public function set FirstSectionDTO(value:PatientProfileSettingDTO):void
		{
			m_oFirstSectionDTO = value;
		}
		
		public function get userPatientProfileBarInfoPopUpData():PatientProfileTaggedDTO
		{
			return m_oUserPatientProfileBarInfoPopUpData;
		}
		
		public function set userPatientProfileBarInfoPopUpData(value:PatientProfileTaggedDTO):void
		{
			m_oUserPatientProfileBarInfoPopUpData = value;
		}
		
		private function getThirdSectionData():String
		{
			if(this.userPatientProfileBarSetting.CompleteSettings.SectionThirdData!=null){
				var type:String = this.userPatientProfileBarSetting.CompleteSettings.SectionThirdData.CollectionType;
				var coll:ArrayCollection;
				var retVal:String ;
				try
				{
					switch( type )
					{
						case Constants.ALLERGIES_CATEGORY_NAME:
							coll = this.userPatientProfileBarSetting.CompleteSettings.SectionThirdData.AllergyList;
							retVal = ( coll[0] as PatientAllergyInfoDTO ).AllergyName
							break;
						case Constants.DIAGNOSIS_CATEGORY_NAME:
							coll = this.userPatientProfileBarSetting.CompleteSettings.SectionThirdData.DiagnosisList;
							retVal = ( coll[0] as PatientDiagnosisInfoDTO ).ICDCodeId;
							break;
						case Constants.IMMUNIZATION_CATEGORY_NAME:
							coll = this.userPatientProfileBarSetting.CompleteSettings.SectionThirdData.ImmunizationList;
							retVal = ( coll[0] as PatientImmunizationInfoDTO ).IsActive.toString();
							break;
						case Constants.CHRONIC_MEDICATION_CATEGORY_NAME:
							coll = this.userPatientProfileBarSetting.CompleteSettings.SectionThirdData.ChronicMedicationList;
							retVal = ( coll[0] as PatientChronicMedicationInfoDTO).MedicationName + " " + ( coll[0] as PatientChronicMedicationInfoDTO).MedicationStrength;
							break;
						case Constants.INSURANCE_CATEGORY_NAME:
							coll = this.userPatientProfileBarSetting.CompleteSettings.SectionThirdData.InsuranceList;
							retVal = ( coll[0] as PatientInsuracneInfoDTO ).PatientInsuranceId.toString();
							break;
						default:
							retVal = "Not Available";
							break;
					}
				}
				catch(e:Error)
				{
					trace("model::ThirdSectionData", type, e.message)
					retVal = "Not Available";
				}
				finally
				{
					//retVal = this.userPatientProfileBarSetting.SectionThirdData.CollectionType + ' ' + retVal;
					
					trace( "model::ThirdSectionData", retVal );
					return retVal;
				}
			}else
			{
				return "";
			}
		}
		
		public function get CHistoryAssociatedVisit():AssociatedVisit
		{
			return mCHistoryAssociatedVisit;
		}
		
		public function set CHistoryAssociatedVisit(value:AssociatedVisit):void
		{
			mCHistoryAssociatedVisit = value;
		}
		
		public function get ImmonizationAssociatedVisit():AssociatedVisit
		{
			return mImmonizationAssociatedVisit;
		}
		
		public function set ImmonizationAssociatedVisit(value:AssociatedVisit):void
		{
			mImmonizationAssociatedVisit = value;
		}
		
		public function get DiagnosisAssociatedVisit():AssociatedVisit
		{
			return mDiagnosisAssociatedVisit;
		}
		
		public function set DiagnosisAssociatedVisit(value:AssociatedVisit):void
		{
			mDiagnosisAssociatedVisit = value;
		}
		
		public function get lostPasswordResult():String
		{
			return _lostPasswordResult;
		}
		
		public function set lostPasswordResult(value:String):void
		{
			_lostPasswordResult = value;
		}
		
		public function get loginCounter():int
		{
			return _loginCounter;
		}
		
		public function set loginCounter(value:int):void
		{
			_loginCounter = value;
		}
		
		public function get userName():String
		{
			return _userName;
		}
		
		public function set userName(value:String):void
		{
			_userName = value;
		}
		
		
		
		public function get reviewHistroy():ReviewAllXML
		{
			return _reviewHistroy;
		}
		
		public function set reviewHistroy(value:ReviewAllXML):void
		{
			_reviewHistroy = value;
		}
		
		public function get ImmunizationsReviewHistory():ArrayCollection
		{
			return _ImmunizationsReviewHistory;
		}
		
		public function set ImmunizationsReviewHistory(value:ArrayCollection):void
		{
			_ImmunizationsReviewHistory = value;
		}
		public function get errorMessageResult():String
		{
			return _errorMessageResult;
		}
		
		public function set errorMessageResult(value:String):void
		{
			_errorMessageResult = value;
		}
		
		public function get lostPasswordIsValidResult():String
		{
			return _lostPasswordIsValidResult;
		}
		
		public function set lostPasswordIsValidResult(value:String):void
		{
			_lostPasswordIsValidResult = value;
		}
		
		public function get lostPasswordIsActiveResult():String
		{
			return _lostPasswordIsActiveResult;
		}
		
		public function set lostPasswordIsActiveResult(value:String):void
		{
			_lostPasswordIsActiveResult= value;
		}
		
		public function get lostPasswordIsLockedResult():String
		{
			return _lostPasswordIsLockedResult;
		}
		
		public function set lostPasswordIsLockedResult(value:String):void
		{
			_lostPasswordIsLockedResult = value;
		}
		
		public function get appVersion():String
		{
			return _appVersion;
		}
		
		public function set appVersion(value:String):void
		{
			_appVersion = value;
			PSConstants.appVersion = value;
		}
		
		public function get gaxenIDSaved():Boolean
		{
			return _gaxenIDSaved;
		}
		
		public function set gaxenIDSaved(value:Boolean):void
		{
			_gaxenIDSaved = value;
		}
		
		public function get isNewPatientReg():Boolean
		{
			return _isNewPatientReg;
		}
		
		public function set isNewPatientReg(value:Boolean):void
		{
			_isNewPatientReg = value;
		}
		
		public function get gaxenID():String
		{
			return _gaxenID;
		}
		
		public function set gaxenID(value:String):void
		{
			_gaxenID = value;
		}
		
		
	}
}