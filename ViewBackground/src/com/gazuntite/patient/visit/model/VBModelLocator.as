package com.gazuntite.patient.visit.model
{
	import com.adobe.cairngorm.model.ModelLocator;
	import com.gazuntite.common.dto.PatientDTO;
	import com.gazuntite.common.util.QSConstants;
	import com.gazuntite.patient.visit.dto.PageDTO;
	import com.gazuntite.patient.visit.view.vbViews.vbTabSection.SummaryViewXMLCollection;
	
	import mx.collections.ArrayCollection;
	import mx.formatters.DateFormatter;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.utils.ObjectProxy;

	[Bindable]
	public class VBModelLocator implements ModelLocator
	{
		////////////// singlton impl start /////////////
		
		private var logger:ILogger = Log.getLogger("com.gazuntite.patient.visit.model.VBModelLocator");
		private static var model:VBModelLocator;
		
		public var searchFieldTypeDTOList:ArrayCollection; 
		
		public function VBModelLocator()
		{
			if ( model != null )
				throw new Error( "Only one VBMobelLocator instance should be instantiated. use getInstance() method instead." );
		}
		
		public static function getInstance() : VBModelLocator 
		{
			if ( model == null )
				model = new VBModelLocator();
			return model;
		}
		
		//--------------------------Logged In User info members... -----------------------------------------
		private var m_iLoggedInUserId:int, 
		m_iLoggedInUserSelectedBranchId:int, 
		m_iLoggedInUserProviderId:int, 
		m_iLoggedInUserProviderTypeId:int,
		m_sLoggedInUserSelectedPracticeName:String, 
		m_sLoggedInUserSelectedStationName:String,
		m_iLoggedInUserSelectedStationID:int,
		m_bIsloggedInUserProvider:Boolean,
		m_bIsloggedInUserFemale:Boolean,
		m_sLoggedInUserSessionID:String,_ClinicBranchIdSeq:int = 7;   // temp id
		
		private var m_ipatientDocSearchPageNo:int = 1 ;
		private var _patientID:int;
		
		public  var securityProxyObject:ObjectProxy;
		
		private var _defaultFilterAndPaging:PageDTO;// for VB
		
		public var vbFilter:String = QSConstants.BY_TYPE;
		public var vbVisitId:int;
		
		private var _gaxenID:String = '';
		private var _thirdSectionLabel:String;
		
		public var dictationUploadInProcessCount:int = 0 ; // for loading the diseases of family history
		
		public var PatientDocumentDTOList:ArrayCollection;
		public var docSectionTypeDTOList:ArrayCollection;
		public var patientDocumentTotalPageNo:int = 0 ;
		public var isPatientDocSearching:Boolean;
		
		public var patientMedACList:ArrayCollection;
		public var patientMedACInactiveList:ArrayCollection;
		public var patientChronicMedACInactiveList:ArrayCollection;
		public var patientChronicMedACList:ArrayCollection;
		
		public var totalRecords_PE:int = 0;
		public var totalRecords_DM:int = 0;
		
		public var lastVisitDate:String;// in VB Header
		public var nextAppointmentDate:String; 	//in VB Header
		
		public var quickInputDataLoadedFlag:Boolean = false;
		
		public function updateModel(loggedInUserId:int, loggedInUserProviderId:int, loggedInUserProviderTypeId:int, loggedInUserSelectedBranchId:int, userSelectedPracticeName:String, stationName:String, stationId:int, authentication:ObjectProxy, IsloggedInUserProvider:Boolean, IsloggedInUserFemale:Boolean, loggedInUserSessionID:String):void
		{
			this.LoggedInUserId						= loggedInUserId;
			this.LoggedInUserProviderId				= loggedInUserProviderId;
			this.LoggedInUserProviderTypeId			= loggedInUserProviderTypeId;
			this.LoggedInUserSelectedBranchId		= loggedInUserSelectedBranchId;
			this.LoggedInUserSelectedPracticeName	= userSelectedPracticeName; 
			this.LoggedInUserSelectedStationName 	= stationName; 
			this.LoggedInUserSelectedStationID		= stationId;
			this.IsloggedInUserProvider				= IsloggedInUserProvider;
			this.IsloggedInUserFemale				= IsloggedInUserFemale;
			this.LoggedInUserSessionID				= loggedInUserSessionID;
		}

		public function updateRequiredValues(patientIDVal:int, gaxenIDVal:String, stationIDsForVBVal:ArrayCollection, isAllStationSelectedVal:Boolean):void
		{
			this.patientID = patientIDVal;
			this.gaxenID = gaxenIDVal;
			
			if (!stationIDsForVBVal)
				stationIDsForVBVal = new ArrayCollection();
			
			this.stationIdsForVB = stationIDsForVBVal;
			this.isAllStationSelected = isAllStationSelectedVal;
		}
		
		public function updateVBAllergies(gaxenID:String, qiAllergiesList:ArrayCollection, thirdSectionLabel:String, allergyNKDAFlag:Boolean):void
		{
			this.gaxenID = gaxenID;
			this.QIAllergyDTOList = qiAllergiesList;
			this.thirdSectionLabel = thirdSectionLabel;
			this.AllergyNKDAFlag = allergyNKDAFlag;
		}
		
		public function updateVBPrescription(gaxenID:String, patientMedACList:ArrayCollection, patientChronicMedACList:ArrayCollection,
											 patientMedACInactiveList:ArrayCollection, patientChronicMedACInactiveList:ArrayCollection, 
											 chMedicationDTOList:ArrayCollection, prescriptionDToList:ArrayCollection):void
		{
			this.gaxenID = gaxenID;
			this.patientMedACList = patientMedACList;
			this.patientChronicMedACList = patientChronicMedACList;
			this.patientMedACInactiveList = patientMedACInactiveList;
			this.patientChronicMedACInactiveList = patientChronicMedACInactiveList;
			this.chMedicationDTOList = chMedicationDTOList;
			this.prescriptionDTOList = prescriptionDToList;
		}
		//-------------------------------------------------------------------//
		//------------GETTER & SETTERS --------------------------------------//
		//-------------------------------------------------------------------//
		
		public function get LoggedInUserId():int
		{
			return m_iLoggedInUserId;
		}

		public function set LoggedInUserId(value:int):void
		{
			m_iLoggedInUserId = value;
		}

		public function get LoggedInUserSelectedBranchId():int
		{
			return m_iLoggedInUserSelectedBranchId;
		}

		public function set LoggedInUserSelectedBranchId(value:int):void
		{
			m_iLoggedInUserSelectedBranchId = value;
		}

		public function get LoggedInUserProviderId():int
		{
			return m_iLoggedInUserProviderId;
		}

		public function set LoggedInUserProviderId(value:int):void
		{
			m_iLoggedInUserProviderId = value;
		}

		public function get LoggedInUserProviderTypeId():int
		{
			return m_iLoggedInUserProviderTypeId;
		}

		public function set LoggedInUserProviderTypeId(value:int):void
		{
			m_iLoggedInUserProviderTypeId = value;
		}

		public function get LoggedInUserSelectedPracticeName():String
		{
			return m_sLoggedInUserSelectedPracticeName;
		}

		public function set LoggedInUserSelectedPracticeName(value:String):void
		{
			m_sLoggedInUserSelectedPracticeName = value;
		}

		public function get LoggedInUserSelectedStationName():String
		{
			return m_sLoggedInUserSelectedStationName;
		}

		public function set LoggedInUserSelectedStationName(value:String):void
		{
			m_sLoggedInUserSelectedStationName = value;
		}

		public function get LoggedInUserSelectedStationID():int
		{
			return m_iLoggedInUserSelectedStationID;
		}

		public function set LoggedInUserSelectedStationID(value:int):void
		{
			m_iLoggedInUserSelectedStationID = value;
		}

		public function get IsloggedInUserProvider():Boolean
		{
			return m_bIsloggedInUserProvider;
		}

		public function set IsloggedInUserProvider(value:Boolean):void
		{
			m_bIsloggedInUserProvider = value;
		}

		public function get IsloggedInUserFemale():Boolean
		{
			return m_bIsloggedInUserFemale;
		}

		public function set IsloggedInUserFemale(value:Boolean):void
		{
			m_bIsloggedInUserFemale = value;
		}

		public function get LoggedInUserSessionID():String
		{
			return m_sLoggedInUserSessionID;
		}

		public function set LoggedInUserSessionID(value:String):void
		{
			m_sLoggedInUserSessionID = value;
		}

		public function get ClinicBranchIdSeq():int
		{
			return _ClinicBranchIdSeq;
		}

		public function set ClinicBranchIdSeq(value:int):void
		{
			_ClinicBranchIdSeq = value;
		}

		public function get defaultFilterAndPaging():PageDTO
		{
			return _defaultFilterAndPaging;
		}
		
		public function set defaultFilterAndPaging(value:PageDTO):void
		{
			_defaultFilterAndPaging = value;
		}
		
		public function get gaxenID():String
		{
			return _gaxenID;
		}
		
		public function set gaxenID(value:String):void
		{
			_gaxenID = value;
		}
		
		public function get thirdSectionLabel():String
		{
			return _thirdSectionLabel;
		}
		
		public function set thirdSectionLabel(value:String):void
		{
			_thirdSectionLabel = value;
		}
		
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

		public function get patientID():int
		{
			return _patientID;
		}

		public function set patientID(value:int):void
		{
			_patientID = value;
		}

		
		public var patientEncounterList:ArrayCollection
		
		public var QIAllergyDTOList:ArrayCollection; // records of allergies
		public var AllergyNKDAFlag:Boolean = false; // records of allergies
		
		public var summary:SummaryViewXMLCollection;
		public var visitDTO:Object;//VisitDTO ;	//created
		public var VisitID:int;
		public var basicUserDTO:Object;//BaseUserDTO ;
		public var sessionDTO:Object;//UserSessionDTO;
		public var userSelectedStationDTO:Object;//StationDTO;
		public var stationIdsForVB:ArrayCollection;
		public var isAllStationSelected:Boolean;
		
		// ViewBackGround
		public var allergyCurrentPageByPatient:PageDTO;
		//Saman
		public var vbEventCounter:int;
		public var vbDataLoadedFlag:Boolean = false;
		
		public var signCoSignBtnLabel:String;
		
		public var userSelectedClinicBranchDTO:Object;//UserClinicBranchDTO;
		
		public var quickInputDTO:Object;//QuickInputDTO;
		public var errorStatus:String;
		
		//############# COMPREHENSIVE HISTORY ##############
		public var medicalHistoryCurrentPageByPatient:PageDTO;
		public var familyHistoryCurrentPageByPatient:PageDTO;
		public var socialHistoryCurrentPageByPatient:PageDTO;
		
		public var medicalHistoryDTOListByPatient:ArrayCollection;
		public var familyHistoryDTOListByPatient:ArrayCollection;
		public var socialHistoryDTOListByPatient:ArrayCollection;
		
		public var rosCurrentPageByPatient:PageDTO;
		public var rosDTOList:ArrayCollection;
		public var physicalsCurrentPageByPatient:PageDTO;
		public var physicalDTOList:ArrayCollection;
		
		public var socialHistoryMediumTypeDTOList:ArrayCollection;
		public var socialHistoryUsageAmountTypeDTOList:ArrayCollection;
		
		public var relationshipTypeDTOList:ArrayCollection;
		
		public var medicalHistoryTypeDTOList:ArrayCollection;
		public var familyHistoryTypeDTOList:ArrayCollection;
		public var socialHistoryAddictionTypeDTOList:ArrayCollection;
		//############################# PRESCRIPTION  ############################################
		public var prescriptionCurrentPageByPatient:PageDTO; //VB
		public var prescriptionMedicationDTOList:ArrayCollection; // patient 
		
		public var medicationCurrentPageByPatient:PageDTO;
		public var medicationDTOList:ArrayCollection;
		
		public var chMedicationDTOList:ArrayCollection;
		public var prescriptionDTOList:ArrayCollection;
		
		//############# visit Immunization##############################
		public var immunizationCurrentPageByPatient:PageDTO;
		public var immunizationDTOList:ArrayCollection;
		
		public var generalTypeDTOListForImmunizationType:ArrayCollection;
		public var generalLabelDTOListForDose:ArrayCollection;
		public var generalLabelDTOListForManufacturer:ArrayCollection;
		public var generalLabelDTOListForSeries:ArrayCollection;
		public var generalLabelDTOListForRefusal:ArrayCollection;
		public var generalLabelDTOListForRoute:ArrayCollection;
		public var generalLabelDTOListForSite:ArrayCollection;
		public var generalLabelDTOListForLot:ArrayCollection;
		
		//############# LABS ##############################
		public var labOutCurrentPageByPatient:PageDTO;
		public var inHouseLabCurrentPageByPatient:PageDTO;
		public var inHouseLabDTOListByPatient:ArrayCollection;
		
		public var labDTOListByPatient:ArrayCollection;
		
		public var labTestTypeDTOList:ArrayCollection;
		public var labTypeDTOList:ArrayCollection; // Laboratrory
		public var icdCodeDTOList:ArrayCollection; // Associated Diagnosis
		
		public var inHouseLabTestTypeDTOList:ArrayCollection;
		public var lionicLabTestTypeDTOList:ArrayCollection;
		//############# LABS ##############################
		
		//############# VITALS ##############################
		public var vitalCurrentPageByPatient:PageDTO;
		public var vitalDTOListByPatient:ArrayCollection;
		//############# ##### ##############################
		
		//############# HPI ##############################
		public var HPI_CCCurrentPageByPatient:PageDTO;
		public var HPI_CCDTOListByPatient:ArrayCollection;
		
		public var symptom:ArrayCollection;		
		public var location:ArrayCollection;		
		public var severity:ArrayCollection;		
		public var modifyingFactors:ArrayCollection;		
		public var progression:ArrayCollection;		
		public var duration:ArrayCollection;		
		public var quality:ArrayCollection;		
		public var context:ArrayCollection;		
		public var exacerbating:ArrayCollection;		
		public var radiation:ArrayCollection;
		
		public var hpiTypeDTOList:ArrayCollection;
		//############# HPI ##############################
		
		//############# DIAGNOSIS ##############
		public var diagnosisDTOListByPatientId:ArrayCollection;
		
		public var diagnosisAcuteCurrentPageByPatient:PageDTO;
		public var diagnosisChronicCurrentPageByPatient:PageDTO;
		public var diagnosisResolvedCurrentPageByPatient:PageDTO;
		
		public var diagnosisDTOAcuteListByPatientId:ArrayCollection;//VB
		public var diagnosisDTOChronicListByPatientId:ArrayCollection;//VB
		public var diagnosisDTOResolvedListByPatientId:ArrayCollection;//VB
		//############# DIAGNOSIS ##############################
		
		//############# PROCEDURE ##############################
		public var procedureCurrentPageByPatient:PageDTO;
		public var procedureDTOListByPatient:ArrayCollection;
		
		public var cptMedicalTypeDTOList:ArrayCollection;
		//############# PROCEDURE ##############################
		
		//############# RECOMMENDATION DD ##############################
		public var recommendationCurrentPageByPatient:PageDTO;
		public var recommendationDTOListByPatientId:ArrayCollection;
		
		public var recommendationDurationTypeDTOList:ArrayCollection;
		public var recommendationPlanTypeDTOList:ArrayCollection;
		public var recommendationMethodTypeDTOList:ArrayCollection;
		public var recommendationLinkAutoCompleteDTOList:ArrayCollection;
		
		//############# RECOMMENDATION DD ##############################
		
		//############# FOLLOW UP  ##############################
		public var followUpInstructionDTOListByPatient:ArrayCollection;
		
		public var followUpCurrentPageByPatient:PageDTO;
		public var followUpDTOListByPatientId:ArrayCollection;
		
		public var generalTypeDTOListForFollowUpMethod:ArrayCollection;
		public var followUpServiceTypeDTOList:ArrayCollection;
		public var followUpServiceTypeDTODateList:ArrayCollection;
	}
}