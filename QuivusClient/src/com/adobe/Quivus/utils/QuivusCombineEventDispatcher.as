package com.adobe.Quivus.utils
{
	import com.adobe.Quivus.events.LoadLoggedInUserImageEvent;
	import com.adobe.Quivus.events.LoadPatientLabTestsForFollowupByPatientIdEvent;
	import com.adobe.Quivus.events.authenticate.LoginSuccessFullEvent;
	import com.adobe.Quivus.events.ePrescription.GetUrlForEditAllergiesEvent;
	import com.adobe.Quivus.events.ePrescription.GetUrlForEditMedicationEvent;
	import com.adobe.Quivus.events.ePrescription.GetUrlForEditPrescriptionEvent;
	import com.adobe.Quivus.events.ePrescription.PrepareLoginCallForEprescriptionEvent;
	import com.adobe.Quivus.events.patientProfile.LoadPatientImageEvent;
	import com.adobe.Quivus.events.patientProfile.LoadPatientProfileEvent;
	import com.adobe.Quivus.events.patientProfileCustomization.LoadPatientProfileCustomizedSettingEvent;
	import com.adobe.Quivus.events.patientProfileCustomization.LoadPatientProfilePopUpDataEvent;
	import com.adobe.Quivus.events.quickInput.LoadQuickInputByVisitIdEvent;
	import com.adobe.Quivus.events.registration.RegisterPatientProfileAndLanguageEvent;
	import com.adobe.Quivus.events.registration.RegisterUserProfileEvent;
	import com.adobe.Quivus.events.registration.SaveAddressBookEvent;
	import com.adobe.Quivus.events.registration.SavePatientEmergencyContactEvent;
	import com.adobe.Quivus.events.registration.SavePatientGuarantorEvent;
	import com.adobe.Quivus.events.registration.SavePatientHealthInfoEvent;
	import com.adobe.Quivus.events.registration.SavePatientImageEvent;
	import com.adobe.Quivus.events.registration.SavePatientInsuranceEvent;
	import com.adobe.Quivus.events.search.LoadContactSearchSuggestionListEvent;
	import com.adobe.Quivus.events.search.searchEngine.LoadUserSearchEngineEvent;
	import com.adobe.Quivus.events.staticData.LoadAllModuleTypesEvent;
	import com.adobe.Quivus.events.staticData.LoadImageTypesStaticDataEvent;
	import com.adobe.Quivus.events.staticData.addressBook.LoadAddressBookStaticDataEvent;
	import com.adobe.Quivus.events.staticData.addressBook.LoadCitiesByStateIdEvent;
	import com.adobe.Quivus.events.staticData.addressBook.LoadZipcodesByStateIdAndCityNameEvent;
	import com.adobe.Quivus.events.staticData.comprehensiveHistory.LoadFamilyHistoryTypesEvent;
	import com.adobe.Quivus.events.staticData.comprehensiveHistory.LoadGeneralHistoryTypesEvent;
	import com.adobe.Quivus.events.staticData.comprehensiveHistory.LoadSocialHistoryMediumTypesStaticDataEvent;
	import com.adobe.Quivus.events.staticData.comprehensiveHistory.LoadSocialHistoryTypesEvent;
	import com.adobe.Quivus.events.staticData.comprehensiveHistory.LoadSocialHistoryUsageAmountStaticDataEvent;
	import com.adobe.Quivus.events.staticData.document.LoadSearchByTypeStaticDataEvent;
	import com.adobe.Quivus.events.staticData.followUp.LoadFollowUpMethodTypeEvent;
	import com.adobe.Quivus.events.staticData.followUp.LoadFollowupDataControlTypeEvent;
	import com.adobe.Quivus.events.staticData.followUp.LoadInstructionAgeTypeEvent;
	import com.adobe.Quivus.events.staticData.followUp.LoadInstructionAgeValueTypeEvent;
	import com.adobe.Quivus.events.staticData.followUp.LoadInstructionDurationTypeEvent;
	import com.adobe.Quivus.events.staticData.followUp.LoadServiceTypeEvent;
	import com.adobe.Quivus.events.staticData.hpi.LoadAllHPIDetailTypesEvent;
	import com.adobe.Quivus.events.staticData.immunization.LoadImmunizationTypesStaticDataEvent;
	import com.adobe.Quivus.events.staticData.lab.LoadInHouseLabTestTypeByClinicIdEvent;
	import com.adobe.Quivus.events.staticData.lab.LoadLabTestNatureTypeStaticDataEvent;
	import com.adobe.Quivus.events.staticData.lab.LoadLabTestOrderMethodTypeStaticDataEvent;
	import com.adobe.Quivus.events.staticData.lab.LoadLabTestPriorityTypeStaticDataEvent;
	import com.adobe.Quivus.events.staticData.lab.LoadLabTestSpecimenTypeStaticDataEvent;
	import com.adobe.Quivus.events.staticData.lab.LoadLabTestTypeStaticDataEvent;
	import com.adobe.Quivus.events.staticData.lab.LoadLabTypeStaticDataEvent;
	import com.adobe.Quivus.events.staticData.physical.LoadPhysicalStaticDataEvent;
	import com.adobe.Quivus.events.staticData.recommendation.LoadAllDurationTypesEvent;
	import com.adobe.Quivus.events.staticData.recommendation.LoadAllMethodTypesEvent;
	import com.adobe.Quivus.events.staticData.recommendation.LoadAllPlanTypesEvent;
	import com.adobe.Quivus.events.staticData.registration.LoadRegistrationStaticDataEvent;
	import com.adobe.Quivus.events.staticData.registration.LoadSpecifiedRegistrationStaticDataEvent;
	import com.adobe.Quivus.events.staticData.ros.LoadROSStaticDataEvent;
	import com.adobe.Quivus.events.staticData.visit.LoadSoapTemplatesEvent;
	import com.adobe.Quivus.events.staticData.visit.LoadVisitEncounterTypesEvent;
	import com.adobe.Quivus.events.viewBackground.allergy.LoadPatientAllergyByPatientIdEvent;
	import com.adobe.Quivus.events.viewBackground.comprehensiveHistory.LoadFamilyHistoryByPatientIdEvent;
	import com.adobe.Quivus.events.viewBackground.comprehensiveHistory.LoadMedicalHistoryByPatientIdEvent;
	import com.adobe.Quivus.events.viewBackground.comprehensiveHistory.LoadSocialHistoryByPatientIdEvent;
	import com.adobe.Quivus.events.viewBackground.dictation.LoadModuleDictationsByPatientIdEvent;
	import com.adobe.Quivus.events.viewBackground.document.LoadPatientDocumentByPatientIdEvent;
	import com.adobe.Quivus.events.viewBackground.document.LoadSectionTypesEvent;
	import com.adobe.Quivus.events.viewBackground.followUp.LoadPatientFollowUpByPatientIdEvent;
	import com.adobe.Quivus.events.viewBackground.followUp.LoadPatientFollowUpInstructionByPatientIdEvent;
	import com.adobe.Quivus.events.viewBackground.followUp.LoadPatientFollowUpInstructionByVisitIdEvent;
	import com.adobe.Quivus.events.viewBackground.hpi.LoadPatientHPIByPatientIdEvent;
	import com.adobe.Quivus.events.viewBackground.immunization.LoadPatientImmunizationEvent;
	import com.adobe.Quivus.events.viewBackground.lab.LoadPatientInHouseLabsByPatientIdEvent;
	import com.adobe.Quivus.events.viewBackground.lab.LoadPatientLabsByPatientIdEvent;
	import com.adobe.Quivus.events.viewBackground.lab.LoadPatientLabsByVisitIdEvent;
	import com.adobe.Quivus.events.viewBackground.notes.LoadModuleNotesByPatientIdEvent;
	import com.adobe.Quivus.events.viewBackground.physical.LoadPatientPhysicalsByPatientIdEvent;
	import com.adobe.Quivus.events.viewBackground.prescription.LoadPatientPrescriptionByPatientIdEvent;
	import com.adobe.Quivus.events.viewBackground.prescription.LoadPrescriptionMedicationByPatientPrescriptionIdEvent;
	import com.adobe.Quivus.events.viewBackground.procedure.LoadPatientProcedureByPatientIdEvent;
	import com.adobe.Quivus.events.viewBackground.recommendation.LoadPatientRecommendationByPatientIdEvent;
	import com.adobe.Quivus.events.viewBackground.ros.LoadPatientROSByPatientIdEvent;
	import com.adobe.Quivus.events.viewBackground.summary.LoadSummaryEvent;
	import com.adobe.Quivus.events.viewBackground.vital.LoadPatientMostRecentVitalsEvent;
	import com.adobe.Quivus.events.viewBackground.vital.LoadPatientVitalsByPatientIdEvent;
	import com.adobe.Quivus.events.visit.LoadPatientVisitListEvent;
	import com.adobe.Quivus.events.visit.LoadVisitStakeHoldersByVisitIdEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.event.LoadPlaceOfServiceTypesEvent;
	import com.gazuntite.dataBridge.controller.LiveServicesController;
	import com.gazuntite.patient.visit.dto.visit.VisitDTO;
	import com.gazuntite.patient.visit.event.assessment.diagnosis.LoadPatientChronicDiagnosisByPatientIdEvent;
	import com.gazuntite.patient.visit.event.visit.CreateVisitEvent;
	import com.gazuntite.patient.visit.model.QIModelLocator;
	import com.gazuntite.provider.services.email.model.EmailModelLocator;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;
	
	import valueObjects.PageDTO;
	import valueObjects.PatientEmergencyContactDTO;
	import valueObjects.PatientGuarantorDTO;
	import valueObjects.PatientInsuranceDTO;
	import valueObjects.PatientLanguageDTO;
	
	///
	//* this class is responsible for dispatching group of events....
	///
	public class QuivusCombineEventDispatcher
	{
		/**
		 * onPatientLoadUICallBack(date); 
		 */		
		public static var onPatientLoadUICallBack:Function;
		
		public static var patientLoadedCallBackFunction:Function;
		
		public function QuivusCombineEventDispatcher()
		{
		}
		
		
		public static function checkIfLoadedPatientUnsavedDataExists():void
		{
			if(onPatientLoadUICallBack)
				AutoSaveUtility.isQuickInputExists(onPatientLoadUICallBack);	
			else
				trace("function null for QI UI creation....");
			
		}
		
		// this is called when the user has logged-in successfully
		// for loading the static and user specfic data
		public static function dispatchSuccessFullLoginEvent():void
		{
			
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			if(model.UserLoggedIn)
			{
				var luiEvent : LoadLoggedInUserImageEvent = new LoadLoggedInUserImageEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( luiEvent );
				
				// hassan: 10/2/2012
				var seEvent : LoadUserSearchEngineEvent = new LoadUserSearchEngineEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( seEvent );
				
				//var qlEvent : LoadUserQuickLinksEvent = new LoadUserQuickLinksEvent();
				//CairngormEventDispatcher.getInstance().dispatchEvent( qlEvent );
				
				var csEvent : LoadContactSearchSuggestionListEvent = new LoadContactSearchSuggestionListEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( csEvent );
				
				//var mrpEvent : LoadUserMostRecentPatientEvent = new LoadUserMostRecentPatientEvent();
				//CairngormEventDispatcher.getInstance().dispatchEvent( mrpEvent );
				
				//var pbsdEvent : LoadProfileBarStaticDataEvent = new LoadProfileBarStaticDataEvent();
				//CairngormEventDispatcher.getInstance().dispatchEvent( pbsdEvent );
				
				var mtEvent : LoadAllModuleTypesEvent = new LoadAllModuleTypesEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( mtEvent );
				
				//M 27-05-2011			 
				//var regSDEvent : LoadRegistrationStaticDataEvent = new LoadRegistrationStaticDataEvent(model.dataToLoad);
				//CairngormEventDispatcher.getInstance().dispatchEvent( regSDEvent );
				
				/**
				 * retrieved at login
				 * because the data is obtained by the UI even before UI is created(displayed to user) 
				 
				 getComprehensiveHistoryStaticData();*/
			}
		}
		
		// this is called after the authentication has been done from the service side, to get the
		// session key fot the current succession.
		public static function dispatchEventForSessionKey():void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			if(model.UserLoggedIn)
			{
				var cgEvent : LoginSuccessFullEvent = new LoginSuccessFullEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( cgEvent );
			}
		}
		
		public static function getComprehensiveHistoryStaticData(): void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			if(model.UserLoggedIn)
			{
				if(model.allGeneralHistoryTypeDTOList==null || model.allGeneralHistoryTypeDTOList.length==0)
				{
					var luiEvent : LoadGeneralHistoryTypesEvent = new LoadGeneralHistoryTypesEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( luiEvent );
				}
				
				if(model.allFamilyHistoryTypeDTOList==null || model.allFamilyHistoryTypeDTOList.length==0)
				{
					var lfhEvent : LoadFamilyHistoryTypesEvent = new LoadFamilyHistoryTypesEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( lfhEvent );
				}
				
				if(model.allSocialHistoryAddictionTypeDTOList==null || model.allSocialHistoryAddictionTypeDTOList.length==0)
				{
					var lshEvent : LoadSocialHistoryTypesEvent = new LoadSocialHistoryTypesEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( lshEvent );
				}
				
				
				if(model.usageAmountDTOData ==null )
				{
					
					var shuaEvent : LoadSocialHistoryUsageAmountStaticDataEvent = new LoadSocialHistoryUsageAmountStaticDataEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( shuaEvent );
				}
				
				if(model.historyMediumTypesDTOData ==null )
				{
					
					var shmtEvent : LoadSocialHistoryMediumTypesStaticDataEvent = new LoadSocialHistoryMediumTypesStaticDataEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( shmtEvent );
				}
				
			}
		}
		//old implementation - no more in use (Tahir Alvi)
		// After new Quick Input
		public static function createVisitBtnClickEvents():void
		{
			/*var model : AppModelLocator = AppModelLocator.getInstance();
			var QIModel:QIModelLocator = QIModelLocator.getInstance();
			
			if(model.UserLoggedIn)
			{
				
				var visit:VisitDTO = new VisitDTO(	model.patientDTO.PatientId,
					model.loggedInUserDTO.UserId,
					model.userSelectedRoleDTO.UserTypeRole.UserTypeId,
					0,
					0,
					model.userSelectedStationDTO.StationID,
					model.placeOfServiceID ,
					model.loggedInUserDTO.UserId,
					new Date(),
					new Date(),
					model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq);
				
				QIModel.patientID = model.patientDTO.PatientId;
				QIModel.gaxenID = model.gaxenID;
				
				var cve:CreateVisitEvent = new CreateVisitEvent(visit);
				CairngormEventDispatcher.getInstance().dispatchEvent( cve );
				
				trace(QIModel.VisitID);
				
				model.canCoSign				= false;
				model.signCosignBtnEnabled	= false;
				model.isNewVisitCreated 	= true;
				model.signCoSignBtnLabel    = Constants.SIGN_LABEL;
				
				QIModel.canSign 				= false;
				QIModel.canCoSign				= false;
				QIModel.signCosignBtnEnabled	= false;
				QIModel.signCoSignBtnLabel    = Constants.SIGN_LABEL;
				
			}*/
			
		}
		
		
		
		
		public static function loadROSPhysicalStaticDataEvents(callForPatientData:Boolean): void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			//trace(model.patientProfileDTO.UserDTO.Gender.GenderName);
			var isMale:Boolean = false;
			if(model.patientProfileDTO.UserDTO.Gender.GenderName == Constants.MALE 
				|| model.patientProfileDTO.UserDTO.Gender.GenderName == Constants.UNDIFFERENTIATED)
			{
				isMale= true;
			}
			
			var lrossdEvent : LoadROSStaticDataEvent = new LoadROSStaticDataEvent(isMale,callForPatientData);
			CairngormEventDispatcher.getInstance().dispatchEvent( lrossdEvent );
			
			
			var lpsdEvent : LoadPhysicalStaticDataEvent = new LoadPhysicalStaticDataEvent(isMale,callForPatientData);
			CairngormEventDispatcher.getInstance().dispatchEvent( lpsdEvent );
		}
		
		public static function LoadPlaceOfServiceList():void
		{				
			//var posEvent : LoadPlaceOfServiceTypesEvent = new LoadPlaceOfServiceTypesEvent("All", onTypesOfServiceLoaded );
			var posEvent : LoadPlaceOfServiceTypesEvent = new LoadPlaceOfServiceTypesEvent("qi", onTypesOfServiceLoaded );
			CairngormEventDispatcher.getInstance().dispatchEvent( posEvent );				
		}
		public static function LoadEncounterList():void
		{				
			var etEvent : LoadVisitEncounterTypesEvent = new LoadVisitEncounterTypesEvent();
			CairngormEventDispatcher.getInstance().dispatchEvent( etEvent );
		}
		
		private static function onTypesOfServiceLoaded(placeOfServiceList:ArrayCollection):void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			model.placeOfServiceList	= placeOfServiceList;
		}
		
		public static function createVisitStaticDataLoad():void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			if(model.UserLoggedIn)
			{
				
				getComprehensiveHistoryStaticData();
				loadROSPhysicalStaticDataEvents(true);
				if(model.registrationStaticDataDTO==null || model.registrationStaticDataDTO.RelationshipTypes==null)
				{
					var dataToLoad:ArrayCollection = new ArrayCollection();
					dataToLoad.addItem(Constants.RELATIONSHIP_TYPE_REGISTERATION_STATIC_DATA);
					
					var lrtEvent : LoadSpecifiedRegistrationStaticDataEvent = new LoadSpecifiedRegistrationStaticDataEvent(dataToLoad);
					CairngormEventDispatcher.getInstance().dispatchEvent( lrtEvent );
				}
				
				if(model.registrationStaticDataDTO==null || model.registrationStaticDataDTO.BloodRelationshipTypes==null)
				{
					var dataToLoad:ArrayCollection = new ArrayCollection();
					dataToLoad.addItem(Constants.BLOOD_RELATIONSHIP_TYPE_REGISTERATION_STATIC_DATA);
					
					var lrtEvent : LoadSpecifiedRegistrationStaticDataEvent = new LoadSpecifiedRegistrationStaticDataEvent(dataToLoad);
					CairngormEventDispatcher.getInstance().dispatchEvent( lrtEvent );
				}
				
				if(model.registrationStaticDataDTO==null || model.registrationStaticDataDTO.MaritalStatusTypes ==null)
				{
					var dataToLoad:ArrayCollection = new ArrayCollection();
					dataToLoad.addItem(Constants.MARITAL_STATUS_TYPE_REGISTERATION_STATIC_DATA);
					
					var lmsEvent : LoadSpecifiedRegistrationStaticDataEvent = new LoadSpecifiedRegistrationStaticDataEvent(dataToLoad);
					CairngormEventDispatcher.getInstance().dispatchEvent( lmsEvent );
				}
				
				
				if(model.labNatureTypeDTOList==null || model.labNatureTypeDTOList.length==0)
				{
					var lltnEvent : LoadLabTestNatureTypeStaticDataEvent = new LoadLabTestNatureTypeStaticDataEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( lltnEvent );
				}
				
				if(model.labTestPriorityTypeDTOList==null || model.labTestPriorityTypeDTOList.length==0)
				{
					var llptEvent : LoadLabTestPriorityTypeStaticDataEvent	 = new LoadLabTestPriorityTypeStaticDataEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( llptEvent );
				}
				if(model.labTestSpecimenTypeDTOList==null || model.labTestSpecimenTypeDTOList.length==0)
				{
					var lltsEvent : LoadLabTestSpecimenTypeStaticDataEvent = new LoadLabTestSpecimenTypeStaticDataEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( lltsEvent );
				}
				if(model.labTestTypeDTOList==null || model.labTestTypeDTOList.length==0)
				{
					var llttEvent : LoadLabTestTypeStaticDataEvent = new LoadLabTestTypeStaticDataEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( llttEvent );
				}
				if(model.labTypeDTOList==null || model.labTypeDTOList.length==0)
				{
					var lltEvent : LoadLabTypeStaticDataEvent = new LoadLabTypeStaticDataEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( lltEvent );
				}
				if(model.labTestOrderMethodTypeDTOList==null || model.labTestOrderMethodTypeDTOList.length==0)
				{
					var lltoEvent : LoadLabTestOrderMethodTypeStaticDataEvent = new LoadLabTestOrderMethodTypeStaticDataEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( lltoEvent );
				}
				
				
				if(model.inHouseLabTestTypeDTOList==null || model.inHouseLabTestTypeDTOList.length==0)
				{
					var llhltEvent:LoadInHouseLabTestTypeByClinicIdEvent = new LoadInHouseLabTestTypeByClinicIdEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( llhltEvent );
				}
				
				/**
				 * because this event now takes cptName
				 */
				/*if(model.cptMedicalTypesDTOList==null || model.cptMedicalTypesDTOList.length==0)
				{
				var lcptmtEvent:LoadCPTMedicalTypesEvent = new LoadCPTMedicalTypesEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lcptmtEvent );
				}*/
				
				
				if(model.patientPreviousVitalsList ==null || model.patientPreviousVitalsList.length==0)
				{
					var lpmrvEvent : LoadPatientMostRecentVitalsEvent = new LoadPatientMostRecentVitalsEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( lpmrvEvent );
				}
				
				
				/*if(model.symptom ==null || model.symptom.length==0)
				{
				
				
				model.hpiCallNumber = 1;
				var sectionId:int = UtilityFunctions.getHPIDetailTypeIdByName(Constants.CONTEXT_MODULE_NAME);
				var ldsdEvent : LoadHPIStaticDataEvent = new LoadHPIStaticDataEvent(sectionId,Constants.EMPTY_STRING);
				CairngormEventDispatcher.getInstance().dispatchEvent( ldsdEvent );
				}*/
				
				if(model.usageAmountDTOData ==null )
				{
					
					var shuaEvent : LoadSocialHistoryUsageAmountStaticDataEvent = new LoadSocialHistoryUsageAmountStaticDataEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( shuaEvent );
				}
				
				if(model.historyMediumTypesDTOData ==null )
				{
					
					var shmtEvent : LoadSocialHistoryMediumTypesStaticDataEvent = new LoadSocialHistoryMediumTypesStaticDataEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( shmtEvent );
				}
				
				
				//###############FOLLOW UP STATIC DATA #########################				
				if( UtilityFunctions.IsNullOrEmpty( model.serviceTypeDTOList ) )
				{
					
					var lstEvent : LoadServiceTypeEvent = new LoadServiceTypeEvent(model.followupServiceTypeControlId);
					CairngormEventDispatcher.getInstance().dispatchEvent( lstEvent );
				}
				
				//load DateType Static Data
				if( UtilityFunctions.IsNullOrEmpty( model.DateServiceTypeDTOList ) )
				{
					lstEvent = new LoadServiceTypeEvent( model.followupDateTypeControlId );
					CairngormEventDispatcher.getInstance().dispatchEvent( lstEvent );
				}
				
				if(model.instructionDurationTypeDTOList ==null || model.instructionDurationTypeDTOList.length==0)
				{
					
					var ldtEvent : LoadInstructionDurationTypeEvent = new LoadInstructionDurationTypeEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( ldtEvent );
				}
				
				if(model.instructionAgeTypeDTOList ==null || model.instructionAgeTypeDTOList.length==0)
				{
					
					var liatEvent : LoadInstructionAgeTypeEvent = new LoadInstructionAgeTypeEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( liatEvent );
				}
				
				if(model.instructionAgeValueTypeDTOList ==null || model.instructionAgeValueTypeDTOList.length==0)
				{
					
					var lavttEvent : LoadInstructionAgeValueTypeEvent = new LoadInstructionAgeValueTypeEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( lavttEvent );
				}
				//############### END #########################
				
				
				
				//****************************************************888
				/* moved to mainContainer.mxml line 130
				if(model.imageTypeDTOList==null || model.imageTypeDTOList.length==0)
				{
				var istEvent : LoadImageTypesStaticDataEvent = new LoadImageTypesStaticDataEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( istEvent );					
				}*/
				if(model.encounterTypeDTOList==null || model.encounterTypeDTOList.length==0)
				{
					var etEvent : LoadVisitEncounterTypesEvent = new LoadVisitEncounterTypesEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( etEvent );
				}
				if(model.soapTemplateTypeDTOList==null || model.soapTemplateTypeDTOList.length==0)
				{
					var stEvent : LoadSoapTemplatesEvent = new LoadSoapTemplatesEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( stEvent );
				}
				if(model.immunizationTypeDTOList==null || model.immunizationTypeDTOList.length==0)
				{
					var imsttEvent : LoadImmunizationTypesStaticDataEvent = new LoadImmunizationTypesStaticDataEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( imsttEvent );
				}
				//****************************************************888
				if(model.hpiDetailTypesList==null || model.hpiDetailTypesList.length==0)
				{
					var hpidtEvent : LoadAllHPIDetailTypesEvent = new LoadAllHPIDetailTypesEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( hpidtEvent );
				}
				if(model.planTypesList==null || model.planTypesList.length==0)
				{
					var laptEvent : LoadAllPlanTypesEvent = new LoadAllPlanTypesEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( laptEvent );
				}
				
				if(model.durationTypesList==null || model.durationTypesList.length==0)
				{
					var ladtEvent : LoadAllDurationTypesEvent = new LoadAllDurationTypesEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( ladtEvent );
				}
				
				if(model.methodTypesList==null || model.methodTypesList.length==0)
				{
					var lmtEvent : LoadAllMethodTypesEvent = new LoadAllMethodTypesEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( lmtEvent );
				}
				if(model.followUpMethodTypeList==null || model.followUpMethodTypeList.length==0)
				{
					var lfmtEvent : LoadFollowUpMethodTypeEvent = new LoadFollowUpMethodTypeEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( lfmtEvent );
				}
				
				
				//loading of place of service
				LoadPlaceOfServiceList();
			}
		}
		
		
		public static function loadQuickInputEvents( visitId:int, loadStaticData:Boolean):void
		{
			
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			if(model.UserLoggedIn)
			{
				model.canSign 	= false;
				model.canCoSign	= false;
				model.signCosignBtnEnabled= false;
				
				if(loadStaticData)
					createVisitStaticDataLoad();
				
				model.isNewVisitCreated = false;
				FlexGlobals.topLevelApplication.mainContainer.callLater( function():void//delay calling these events ....
				{
					var lqivEvent: LoadQuickInputByVisitIdEvent = new LoadQuickInputByVisitIdEvent( visitId ); 
					CairngormEventDispatcher.getInstance().dispatchEvent( lqivEvent );
					
					var lvshEvent: LoadVisitStakeHoldersByVisitIdEvent = new LoadVisitStakeHoldersByVisitIdEvent( visitId ); 
					CairngormEventDispatcher.getInstance().dispatchEvent( lvshEvent );
					
					var lpfiEvent: LoadPatientFollowUpInstructionByVisitIdEvent = new LoadPatientFollowUpInstructionByVisitIdEvent( visitId ); 
					CairngormEventDispatcher.getInstance().dispatchEvent( lpfiEvent );
					
					var lpltffEvent : LoadPatientLabTestsForFollowupByPatientIdEvent = new LoadPatientLabTestsForFollowupByPatientIdEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( lpltffEvent );
					
					//Start Comment [Tahir Alvi]- load labout records for QI when visit load in edit mode
					var lplabEvent : LoadPatientLabsByVisitIdEvent = new LoadPatientLabsByVisitIdEvent(visitId);
					CairngormEventDispatcher.getInstance().dispatchEvent( lplabEvent );
					//End Comment - load labout records for QI when visit load in edit mode
				});
			}
		}
		
		public static function loadPrescriptionMedicationByPateintId( pateintId:int):void
		{
			
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			if(model.UserLoggedIn)
			{
				var lpmpidEvent: LoadPrescriptionMedicationByPatientPrescriptionIdEvent = new LoadPrescriptionMedicationByPatientPrescriptionIdEvent( /*pateintId*/ ); 
				CairngormEventDispatcher.getInstance().dispatchEvent( lpmpidEvent );
			}
		}
		
		
		public static function dispatchEventsAfterPatientLoad():void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			if(model.UserLoggedIn)
			{
				model.patientDocRecPageNo = 1;
				
				
				var cgEvent : LoadPatientImageEvent = new LoadPatientImageEvent(model.patientProfileDTO.UserDTO.UserId);
				CairngormEventDispatcher.getInstance().dispatchEvent( cgEvent );
				
				var lpvEvent:LoadPatientVisitListEvent = new LoadPatientVisitListEvent( model.loadedPatientId, false );
				CairngormEventDispatcher.getInstance().dispatchEvent( lpvEvent );
				
				var lpdEvent : LoadPatientDocumentByPatientIdEvent = new LoadPatientDocumentByPatientIdEvent(model.patientDocRecPageNo);
				CairngormEventDispatcher.getInstance().dispatchEvent( lpdEvent );
				
				var lstEvent : LoadSectionTypesEvent = new LoadSectionTypesEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lstEvent );
				
				//Load Documetn related static data....
				if(model.searchFieldTypeDTOList==null || model.searchFieldTypeDTOList.length==0)
				{
					var lsbtEvent : LoadSearchByTypeStaticDataEvent = new LoadSearchByTypeStaticDataEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( lsbtEvent );
				}
				
				checkIfLoadedPatientUnsavedDataExists();
				/*var lpmpEvent : LoadPatientMedicationPrescriptionByPatientIdEvent = new LoadPatientMedicationPrescriptionByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lpmpEvent );*/
				
				// FOR PATIENT SELECTION - COMMENTING OUT.....
				/*
				
				
				
				
				
				
				loadROSPhysicalStaticDataEvents(true);
				
				var lpaEvent : LoadPatientAllergyByPatientIdEvent = new LoadPatientAllergyByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lpaEvent );
				
				//chronic medication
				var lppbpEvent : LoadPatientPrescriptionByPatientIdEvent = new LoadPatientPrescriptionByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lppbpEvent );*/
				
				
				/*var lpltffEvent : LoadPatientLabTestsForFollowupByPatientIdEvent = new LoadPatientLabTestsForFollowupByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lpltffEvent );
				
				
				//beacuse if the patient is loaded n user wants to edit VB, so for that static data should be there .... 
				createVisitStaticDataLoad();
				
				if(model.searchFieldTypeDTOList==null || model.searchFieldTypeDTOList.length==0)
				{
				var lsbtEvent : LoadSearchByTypeStaticDataEvent = new LoadSearchByTypeStaticDataEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lsbtEvent );
				}
				
				
				loadPMHForViewBackground();
				loadPhysicalForViewBackground();
				loadAssesmentForViewBackground();
				
				
				var lpdEvent : LoadPatientDocumentByPatientIdEvent = new LoadPatientDocumentByPatientIdEvent(model.patientDocRecPageNo);
				CairngormEventDispatcher.getInstance().dispatchEvent( lpdEvent );
				
				//this to be moved to RX btn click ......				
				var plcfepEvent : PrepareLoginCallForEprescriptionEvent = new PrepareLoginCallForEprescriptionEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( plcfepEvent );
				
				
				*/
				
				
				
				
				
				//model.vbFilter = Constants.BY_TYPE;
				/*
				var isQIExists = AutoSaveUtility.isQuickInputExists(onPatientLoadUICallBack);
				if(isQIExists)
				{
				
				
				
				
				Alert.show("System crashed without saving QuickInput, do you want to load ?", 
				"Previous QuickInput Data Load",
				Alert.YES | Alert.NO, FlexGlobals.topLevelApplication.mainContainer, 
				function handleAlert(event:CloseEvent):void
				{
				if (event.detail == Alert.YES)
				{
				
				var QI:QuickInputDTO = AutoSaveUtility.loadQuickInput();
				
				if(QI != null)
				{
				model.quickInputDTO.Visit = QI.Visit;									
				
				model.quickInputDTO = QI;
				
				//model.visitDTO = model.quickInputDTO.Visit;
				
				if(onPatientLoadUICallBack!=null)
				{
				onPatientLoadUICallBack(model.quickInputDTO.Visit.VisitDate);
				}
				
				}
				}
				else if( event.detail == Alert.NO)
				{
				AutoSaveUtility.deleteQuickInput();
				}
				});
				}*/
				
				//Ayesha: 28/02/2013
				/*model.stationIdsForVB = new ArrayCollection();
				model.stationIdsForVB.addItem(model.userSelectedStationDTO.StationID);
				model.isAllStationSelected = false;*/
				
				
				
				model.totalPatientDocRec	= 0;
				model.firstPatientDocRec	= 0;
				model.lastPatientDocRec		= 0;
				
				model.patientDocRecPageNo	= 1;
				
				
				
				//Mansoor
				//Date 24 5 2011
				//moved here
				/*if(model.soapTemplateTypeDTOList==null || model.soapTemplateTypeDTOList.length>0)
				{
				var stEvent : LoadSoapTemplatesEvent = new LoadSoapTemplatesEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( stEvent );
				}*/
				
				
				//summary view
				//Ayesha: 27/02/2013
				/*var evt:LoadSummaryEvent = new LoadSummaryEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( evt );*/
				
			}
		}
		
		
		public static function loadVBVisitStaticData():void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			if(model.UserLoggedIn)
			{
				createVisitStaticDataLoad();
				getComprehensiveHistoryStaticData();
				/*if(model.soapTemplateTypeDTOList==null || model.soapTemplateTypeDTOList.length==0)
				{
				var stEvent : LoadSoapTemplatesEvent = new LoadSoapTemplatesEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( stEvent );
				}*/
				if(model.followupDataControlTypeDTOList==null || model.followupDataControlTypeDTOList.length==0)
				{
					var lfdctEvent: LoadFollowupDataControlTypeEvent = new LoadFollowupDataControlTypeEvent(  ); 
					CairngormEventDispatcher.getInstance().dispatchEvent( lfdctEvent );
				}
				
				
				
				/* moved to PatientSelection
				if(model.searchFieldTypeDTOList==null || model.searchFieldTypeDTOList.length==0)
				{
				var lsbtEvent : LoadSearchByTypeStaticDataEvent = new LoadSearchByTypeStaticDataEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lsbtEvent );
				}
				*/
				
				
				//change the call with respective page set with default values;
				if( UtilityFunctions.IsNullOrEmpty( model.allergyCurrentPageByPatient ) )
				{
					model.allergyCurrentPageByPatient = new PageDTO();
				}
				
				if( UtilityFunctions.IsNullOrEmpty( model.medicationCurrentPageByPatient ) )
				{
					model.medicationCurrentPageByPatient = new PageDTO();
				}
				
				
				QSUtilityFunctions.CheckUserPageOrSetPageToZero( model.allergyCurrentPageByPatient );
				QSUtilityFunctions.CheckUserPageOrSetPageToZero( model.medicationCurrentPageByPatient );
				
				
				var lpaEvent : LoadPatientAllergyByPatientIdEvent = new LoadPatientAllergyByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lpaEvent );
				
				
				var lppbpEvent : LoadPatientPrescriptionByPatientIdEvent = new LoadPatientPrescriptionByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lppbpEvent );
				
				
				var lpltffEvent : LoadPatientLabTestsForFollowupByPatientIdEvent = new LoadPatientLabTestsForFollowupByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lpltffEvent );
				
			}
			
		}
		
		
		public static function loadVB():void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			if(model.UserLoggedIn)
			{
				//getComprehensiveHistoryStaticData();
				
				loadVBVisitStaticData();
				//ON PATIENT SELECTION
				/*if(model.soapTemplateTypeDTOList==null || model.soapTemplateTypeDTOList.length==0)
				{
				var stEvent : LoadSoapTemplatesEvent = new LoadSoapTemplatesEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( stEvent );
				}*/
				
				/*var lpvEvent:LoadPatientVisitListEvent = new LoadPatientVisitListEvent( model.loadedPatientId, false );
				CairngormEventDispatcher.getInstance().dispatchEvent( lpvEvent );
				var lpdEvent : LoadPatientDocumentByPatientIdEvent = new LoadPatientDocumentByPatientIdEvent(model.patientDocRecPageNo);
				CairngormEventDispatcher.getInstance().dispatchEvent( lpdEvent );*/
				
				/*if(model.followupDataControlTypeDTOList==null || model.followupDataControlTypeDTOList.length==0)
				{
				var lfdctEvent: LoadFollowupDataControlTypeEvent = new LoadFollowupDataControlTypeEvent(  ); 
				CairngormEventDispatcher.getInstance().dispatchEvent( lfdctEvent );
				}*/
				//
				
				
				// AFTER PATIENT LOAD ...			
				//loadROSPhysicalStaticDataEvents(true);
				
				/*var lpaEvent : LoadPatientAllergyByPatientIdEvent = new LoadPatientAllergyByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lpaEvent );
				
				//chronic medication
				var lppbpEvent : LoadPatientPrescriptionByPatientIdEvent = new LoadPatientPrescriptionByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lppbpEvent );
				
				
				var lpltffEvent : LoadPatientLabTestsForFollowupByPatientIdEvent = new LoadPatientLabTestsForFollowupByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lpltffEvent );*/
				
				
				//beacuse if the patient is loaded n user wants to edit VB, so for that static data should be there .... 
				//createVisitStaticDataLoad();
				
				/*if(model.searchFieldTypeDTOList==null || model.searchFieldTypeDTOList.length==0)
				{
				var lsbtEvent : LoadSearchByTypeStaticDataEvent = new LoadSearchByTypeStaticDataEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lsbtEvent );
				}*/
				
				model.vbEventCounter = 0;
				model.vbDataLoadedFlag = false;
				
				
				
				/*if(model.UserLoggedIn)
				{
				//medicalHistoryDTOListByPatient
				var lmhbpEvent: LoadMedicalHistoryByPatientIdEvent = new LoadMedicalHistoryByPatientIdEvent( ); 
				CairngormEventDispatcher.getInstance().dispatchEvent( lmhbpEvent );
				model.vbEventCounter = model.vbEventCounter + 1;								
				//socialHistoryDTOListByPatient
				var lshvb:LoadSocialHistoryByPatientIdEvent = new LoadSocialHistoryByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lshvb );
				model.vbEventCounter = model.vbEventCounter + 1;
				
				
				//prescription - prescriptionMedicationDTOList
				var lpmbpp:LoadPrescriptionMedicationByPatientPrescriptionIdEvent = new LoadPrescriptionMedicationByPatientPrescriptionIdEvent(model.loadedPatientId);
				CairngormEventDispatcher.getInstance().dispatchEvent( lpmbpp );
				model.vbEventCounter = model.vbEventCounter +1 ;
				
				//diagnosis - patientDiagnosisDTOListByPatientId
				var lpdbp:LoadPatientDiagnosisByPatientIdEvent = new LoadPatientDiagnosisByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lpdbp );
				model.vbEventCounter = model.vbEventCounter + 1;
				
				var lpaEvent : LoadPatientAllergyByPatientIdEvent = new LoadPatientAllergyByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lpaEvent );
				
				
				
				//Immunization - immunizationDTOList
				var lpviEvent: LoadPatientImmunizationEvent = new LoadPatientImmunizationEvent( model.loadedPatientId ); 
				CairngormEventDispatcher.getInstance().dispatchEvent( lpviEvent );
				model.vbEventCounter = model.vbEventCounter + 1;
				
				
				//chronic medication
				//TODO: check if not fired twice if yes then remove this call
				var lppbpEvent : LoadPatientPrescriptionByPatientIdEvent = new LoadPatientPrescriptionByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lppbpEvent );
				}*/
				/*var model : AppModelLocator = AppModelLocator.getInstance();
				
				model.vitalCurrentPageByPatient = new PageDTO();
				model.vitalCurrentPageByPatient.pageNumber = 1;
				model.vitalCurrentPageByPatient.pageSize = 200;
				model.vitalCurrentPageByPatient.fromDate = Constants.NULL_DATE;
				model.vitalCurrentPageByPatient.toDate   = Constants.NULL_DATE;
				model.vitalCurrentPageByPatient.pageSize = 200;
				
				
				model.vitalCurrentPageByPatient.LastVisitNumber = 4; //or user can send date range
				var lpv:LoadPatientVitalsByPatientIdEvent = new LoadPatientVitalsByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lpv );*/
				
				//COMMENTED FOR NEW IMPL -----TJ
				//loadPMHForViewBackground();
				//loadPhysicalForViewBackground();
				//loadAssesmentForViewBackground();
				
				
				
				
				//this to be moved to RX btn click ......		 moved to on patient selection		
				/*var plcfepEvent : PrepareLoginCallForEprescriptionEvent = new PrepareLoginCallForEprescriptionEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( plcfepEvent );*/
			}
			
		}
		
		
		public static function onPatientSelection( patientId:int/*,  patientUserID:int*/):void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			if(model.UserLoggedIn)
			{
				model.vbFilter = Constants.BY_TYPE;
				
				clearLoadedVB();
				
				/*
				FOR PATIENT SELECTION - COMMENTING OUT.....
				if(model.soapTemplateTypeDTOList==null || model.soapTemplateTypeDTOList.length==0)
				{
				var stEvent : LoadSoapTemplatesEvent = new LoadSoapTemplatesEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( stEvent );
				}
				
				var lpvEvent:LoadPatientVisitListEvent = new LoadPatientVisitListEvent( patientId, false );
				CairngormEventDispatcher.getInstance().dispatchEvent( lpvEvent );
				
				
				if(model.followupDataControlTypeDTOList==null || model.followupDataControlTypeDTOList.length==0)
				{
				var lfdctEvent: LoadFollowupDataControlTypeEvent = new LoadFollowupDataControlTypeEvent(  ); 
				CairngormEventDispatcher.getInstance().dispatchEvent( lfdctEvent );
				}
				
				
				*/
				
				var lpppEvent : LoadPatientProfilePopUpDataEvent = new LoadPatientProfilePopUpDataEvent( patientId );
				CairngormEventDispatcher.getInstance().dispatchEvent( lpppEvent );
				
				if(model.userPatientProfileBarSettingTemp==null)
				{
					var testEvent : LoadPatientProfileCustomizedSettingEvent = new LoadPatientProfileCustomizedSettingEvent(patientId,true);
					CairngormEventDispatcher.getInstance().dispatchEvent( testEvent );
				}
				else
				{
					var testEvent : LoadPatientProfileCustomizedSettingEvent = new LoadPatientProfileCustomizedSettingEvent(patientId,false);
					CairngormEventDispatcher.getInstance().dispatchEvent( testEvent );
				}
				
				
				
				
				var lppEvent:LoadPatientProfileEvent = new LoadPatientProfileEvent( patientId );
				CairngormEventDispatcher.getInstance().dispatchEvent( lppEvent );
				
				/*var lpviEvent: LoadPatientImmunizationEvent = new LoadPatientImmunizationEvent( patientId ); 
				CairngormEventDispatcher.getInstance().dispatchEvent( lpviEvent );*/
				
				var plcfepEvent : PrepareLoginCallForEprescriptionEvent = new PrepareLoginCallForEprescriptionEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( plcfepEvent );
				
				var lmnvb:LoadModuleNotesByPatientIdEvent = new LoadModuleNotesByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lmnvb );				
				
				
				var lmdvb:LoadModuleDictationsByPatientIdEvent = new LoadModuleDictationsByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lmdvb );
			}
		}
		
		
		public static function afterPatientProfileUpdation( patientId:int):void
		{
			var lpppEvent : LoadPatientProfilePopUpDataEvent = new LoadPatientProfilePopUpDataEvent( patientId );
			CairngormEventDispatcher.getInstance().dispatchEvent( lpppEvent );
			
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			if(model.userPatientProfileBarSettingTemp==null)
			{
				var testEvent : LoadPatientProfileCustomizedSettingEvent = new LoadPatientProfileCustomizedSettingEvent(patientId,true);
				CairngormEventDispatcher.getInstance().dispatchEvent( testEvent );
			}
			else
			{
				var testEvent : LoadPatientProfileCustomizedSettingEvent = new LoadPatientProfileCustomizedSettingEvent(patientId,false);
				CairngormEventDispatcher.getInstance().dispatchEvent( testEvent );
			}
			
			var lppEvent:LoadPatientProfileEvent = new LoadPatientProfileEvent( patientId );
			CairngormEventDispatcher.getInstance().dispatchEvent( lppEvent );
			
			var cgEvent : LoadPatientImageEvent = new LoadPatientImageEvent(model.patientProfileDTO.UserDTO.UserId);
			CairngormEventDispatcher.getInstance().dispatchEvent( cgEvent );
		}
		
		public static function dispatchEventToGetAllergyEditURL():void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			if(model.UserLoggedIn)
			{
				var gufaeEvent: GetUrlForEditAllergiesEvent = new GetUrlForEditAllergiesEvent(  ); 
				CairngormEventDispatcher.getInstance().dispatchEvent( gufaeEvent );
			}
		}
		public static function dispatchEventToGetMedicationEditURL():void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			if(model.UserLoggedIn)
			{
				var gufmeEvent: GetUrlForEditMedicationEvent = new GetUrlForEditMedicationEvent(  ); 
				CairngormEventDispatcher.getInstance().dispatchEvent( gufmeEvent );
			}
		}
		
		public static function dispatchEventToGetPrescriptionEditURL():void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			if(model.UserLoggedIn)
			{
				var gufpeEvent: GetUrlForEditPrescriptionEvent = new GetUrlForEditPrescriptionEvent(  ); 
				CairngormEventDispatcher.getInstance().dispatchEvent( gufpeEvent );
			}
		}
		
		public static function clearLoadedVB():void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			if(model.UserLoggedIn)
			{
				// ################# CLEARING PMH ####################
				model.immunizationDTOList = new ArrayCollection();				
				model.medicalHistoryDTOListByPatient = new ArrayCollection(); // CH-medical
				model.familyHistoryDTOListByPatient = new ArrayCollection(); // CH-family
				model.socialHistoryDTOListByPatient = new ArrayCollection(); // CH-social				
				model.quicInputAllergyDTOList = new ArrayCollection();	// allergies			
				model.medicationDTOList = new ArrayCollection(); // chronic medication
				
				model.moduleNoteDTOListByPatient = new ArrayCollection();
				model.moduleDictationDTOListByPatient = new ArrayCollection();
				
				
				
				// ################# CLEARING PHYSICAL ####################
				model.rosDTOListVB = new ArrayCollection();
				model.physicalsDTOListVB = new ArrayCollection();
				model.vitalDTOListByPatient = new ArrayCollection();
				model.inHouseLabDTOListByPatient = new ArrayCollection();
				model.HPI_CCDTOListByPatient = new ArrayCollection();
				
				
				// ################# CLEARING ASSESMENT ####################
				model.patientRecommendationDTOListByPatientId = new ArrayCollection();
				model.patientFollowupDTOListByPatientId = new ArrayCollection();
				model.patientFollowupInstructionDTOListByPatient = new ArrayCollection();
				model.labDTOListByPatient = new ArrayCollection();
				model.patientProcedureDTOListByPatient = new ArrayCollection();
				model.prescriptionMedicationDTOList = new ArrayCollection();
				model.patientDiagnosisDTOListByPatientId = new ArrayCollection();
				
				model.patientDiagnosisDTOAcuteListByPatientId = new ArrayCollection();
				model.patientDiagnosisDTOChronicListByPatientId = new ArrayCollection();
				model.patientDiagnosisDTOResolvedListByPatientId = new ArrayCollection();
				
				
			}
			
		}
		
		public static function loadPMHForViewBackground():void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			if(model.UserLoggedIn)
			{
				//Immunization - immunizationDTOList
				loadImmunizationForVB();
				
				// ############### COMPREHENSIVE HISTORY  ###############
				loadComprehensiveHistoryForVB();
				
				// ###############  END  ###############
				
				
				//TODO: check if not fired twice if yes then remove this call
				//var lpaEvent : LoadPatientAllergyByPatientIdEvent = new LoadPatientAllergyByPatientIdEvent();
				//CairngormEventDispatcher.getInstance().dispatchEvent( lpaEvent );
				
				
				//chronic medication
				//TODO: check if not fired twice if yes then remove this call
				//var lppbpEvent : LoadPatientPrescriptionByPatientIdEvent = new LoadPatientPrescriptionByPatientIdEvent();
				//CairngormEventDispatcher.getInstance().dispatchEvent( lppbpEvent );
				
				
				var lmnvb:LoadModuleNotesByPatientIdEvent = new LoadModuleNotesByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lmnvb );				
				
				
				var lmdvb:LoadModuleDictationsByPatientIdEvent = new LoadModuleDictationsByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lmdvb );
				
			}
		}
		public static function loadImmunizationForVB():void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			if(model.UserLoggedIn)
			{
				//Immunization - immunizationDTOList
				var lpviEvent: LoadPatientImmunizationEvent = new LoadPatientImmunizationEvent( model.loadedPatientId ); 
				CairngormEventDispatcher.getInstance().dispatchEvent( lpviEvent );
				model.vbEventCounter = model.vbEventCounter + 1;
			}
		}
		public static function loadComprehensiveHistoryForVB():void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			if(model.UserLoggedIn)
			{
				//medicalHistoryDTOListByPatient
				var lmhbpEvent: LoadMedicalHistoryByPatientIdEvent = new LoadMedicalHistoryByPatientIdEvent( ); 
				CairngormEventDispatcher.getInstance().dispatchEvent( lmhbpEvent );
				model.vbEventCounter = model.vbEventCounter + 1;
				
				//familyHistoryDTOListByPatient
				var lhvbpEvent: LoadFamilyHistoryByPatientIdEvent = new LoadFamilyHistoryByPatientIdEvent( ); 
				CairngormEventDispatcher.getInstance().dispatchEvent( lhvbpEvent );
				model.vbEventCounter = model.vbEventCounter + 1;
				
				//socialHistoryDTOListByPatient
				var lshvb:LoadSocialHistoryByPatientIdEvent = new LoadSocialHistoryByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lshvb );
				model.vbEventCounter = model.vbEventCounter + 1;
				
			}
		}
		// ******************** Tahir Alvi - start - loading data only section that has some update(record add)
		public static function loadMedicalHistoryForVB():void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			if(model.UserLoggedIn)
			{
				//medicalHistoryDTOListByPatient
				var lmhbpEvent: LoadMedicalHistoryByPatientIdEvent = new LoadMedicalHistoryByPatientIdEvent( ); 
				CairngormEventDispatcher.getInstance().dispatchEvent( lmhbpEvent );
				model.vbEventCounter = model.vbEventCounter + 1;
			}
		}
		public static function loadFamilyHistoryForVB():void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			if(model.UserLoggedIn)
			{
				//familyHistoryDTOListByPatient
				var lhvbpEvent: LoadFamilyHistoryByPatientIdEvent = new LoadFamilyHistoryByPatientIdEvent( ); 
				CairngormEventDispatcher.getInstance().dispatchEvent( lhvbpEvent );
				model.vbEventCounter = model.vbEventCounter + 1;
			}
		}
		public static function loadSocialHistoryForVB():void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			if(model.UserLoggedIn)
			{
				//socialHistoryDTOListByPatient
				var lshvb:LoadSocialHistoryByPatientIdEvent = new LoadSocialHistoryByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lshvb );
				model.vbEventCounter = model.vbEventCounter + 1;
			}
		}
		// ************** Tahir Alvi - End ******************************* 
		public static function loadPhysicalForViewBackground():void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			if(model.UserLoggedIn)
			{
				//ros - rosDTOListVB
				/*
				//removed from in LoadROSStaticDataCommand*/
				var lpros:LoadPatientROSByPatientIdEvent = new LoadPatientROSByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lpros );
				model.vbEventCounter ++ ;
				
				//physical - physicalsDTOListVB
				/*
				//removed from in LoadPhysicalStaticDataCommand*/
				var lpp:LoadPatientPhysicalsByPatientIdEvent = new LoadPatientPhysicalsByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lpp );
				model.vbEventCounter ++ ;
				
				//vital - vitalDTOListByPatient
				var lpv:LoadPatientVitalsByPatientIdEvent = new LoadPatientVitalsByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lpv );
				model.vbEventCounter = model.vbEventCounter + 1;
				
				
				//in-house labs - inHouseLabDTOListByPatient
				var lpihl:LoadPatientInHouseLabsByPatientIdEvent = new LoadPatientInHouseLabsByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lpihl );
				model.vbEventCounter = model.vbEventCounter + 1;
				
				
				//hpi - HPI_CCDTOListByPatient
				var lphpicc:LoadPatientHPIByPatientIdEvent = new LoadPatientHPIByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lphpicc );
				model.vbEventCounter = model.vbEventCounter + 1;
			}
		}
		
		
		public static function loadAssesmentForViewBackground():void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			if(model.UserLoggedIn)
			{
				//recommendation - patientRecommendationDTOListByPatientId
				var lprbp:LoadPatientRecommendationByPatientIdEvent = new LoadPatientRecommendationByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lprbp );
				model.vbEventCounter = model.vbEventCounter + 1;
				
				//follow-up - patientFollowupDTOListByPatientId
				var lpfbp:LoadPatientFollowUpByPatientIdEvent = new LoadPatientFollowUpByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lpfbp );
				model.vbEventCounter = model.vbEventCounter + 1;
				
				// follow-up instructions -- patientFollowupInstructionDTOListByPatient
				var lpfip:LoadPatientFollowUpInstructionByPatientIdEvent = new LoadPatientFollowUpInstructionByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lpfip );
				model.vbEventCounter = model.vbEventCounter + 1;
				
				//lab - labDTOListByPatient
				var lplbp:LoadPatientLabsByPatientIdEvent = new LoadPatientLabsByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lplbp );
				model.vbEventCounter = model.vbEventCounter + 1;
				
				//procedure - patientProcedureDTOListByPatient
				var lppbp:LoadPatientProcedureByPatientIdEvent = new LoadPatientProcedureByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lppbp );
				model.vbEventCounter = model.vbEventCounter + 1;
				
				
				//prescription - prescriptionMedicationDTOList
				var lpmbpp:LoadPrescriptionMedicationByPatientPrescriptionIdEvent = new LoadPrescriptionMedicationByPatientPrescriptionIdEvent(/*model.loadedPatientId*/);
				CairngormEventDispatcher.getInstance().dispatchEvent( lpmbpp );
				model.vbEventCounter = model.vbEventCounter +1 ;
				
				
				//diagnosis - patientDiagnosisDTOListByPatientId //now there are three event for each type acute, chronic, resolved
				/*var lpdbp:LoadPatientDiagnosisByPatientIdEvent = new LoadPatientDiagnosisByPatientIdEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( lpdbp );*/
				model.vbEventCounter = model.vbEventCounter + 1;
			}
		}
		
		public static function loadRegistrationStaticData():void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			if(model.UserLoggedIn)
			{
				if(model.registrationStaticDataDTO==null || model.registrationStaticDataDTO.PrefixTypes==null) 
				{
					model.dataToLoad = new ArrayCollection();
					model.dataToLoad.addItem(Constants.PREFIX_TYPE_REGISTERATION_STATIC_DATA);
					model.dataToLoad.addItem(Constants.GENDER_TYPE_REGISTERATION_STATIC_DATA);
					model.dataToLoad.addItem(Constants.MARITAL_STATUS_TYPE_REGISTERATION_STATIC_DATA);
					model.dataToLoad.addItem(Constants.LANGUAGE_ABILITY_MODE_TYPE_REGISTERATION_STATIC_DATA);
					model.dataToLoad.addItem(Constants.INSURANCE_NATURE_TYPE_REGISTERATION_STATIC_DATA);
					model.dataToLoad.addItem(Constants.INSURANCE_ORGANIZATION_TYPE_REGISTERATION_STATIC_DATA);
					model.dataToLoad.addItem(Constants.SMOKING_TYPE_REGISTERATION_STATIC_DATA);
					model.dataToLoad.addItem(Constants.INSURANCE_TYPE_REGISTERATION_STATIC_DATA);
					model.dataToLoad.addItem(Constants.STATUS_TYPE_REGISTERATION_STATIC_DATA);
					model.dataToLoad.addItem(Constants.USER_TYPE_REGISTERATION_STATIC_DATA);
					model.callNumber=1;
					var regSDEvent : LoadRegistrationStaticDataEvent = new LoadRegistrationStaticDataEvent(model.dataToLoad);
					CairngormEventDispatcher.getInstance().dispatchEvent( regSDEvent );
				}
				
				if(model.imageTypeDTOList == null || model.imageTypeDTOList.length == 0)
				{
					var istEvent : LoadImageTypesStaticDataEvent = new LoadImageTypesStaticDataEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( istEvent );					
				}
				
				if(model.addressBookStaticDataDTO == null)
				{
					var abSDEvent : LoadAddressBookStaticDataEvent = new LoadAddressBookStaticDataEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( abSDEvent );
				}
			}
		}
		
		
		public static function getCitiesAndZipCodesByState(stateId:int, cityName:String, dataRequiredFor:String):void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			if(model.UserLoggedIn)
			{
				var qlEvent : LoadCitiesByStateIdEvent = new LoadCitiesByStateIdEvent( stateId, dataRequiredFor );
				CairngormEventDispatcher.getInstance().dispatchEvent( qlEvent );
				
				var qzEvent : LoadZipcodesByStateIdAndCityNameEvent = new LoadZipcodesByStateIdAndCityNameEvent(stateId, cityName, dataRequiredFor);
				CairngormEventDispatcher.getInstance().dispatchEvent( qzEvent );
			}
			
		}
		
		public static function updatePatientProfile( resultFunction:Function ):void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			if(model.UserLoggedIn)
			{
				if(model.patientProfileDTO!=null)
				{
					
					model.regEventCount = 0;
					model.registrationErrorMsg = "";
					var i:int; 
					if(model.basicUserDTO.IsDirty)
					{
						model.basicUserDTO.ModifiedBy = model.loggedInUserDTO.UserId;
						model.basicUserDTO.ModifiedAt = new Date();
						var rpEvent : RegisterUserProfileEvent = new RegisterUserProfileEvent(Constants.UPDATE_PURPOSE,resultFunction);
						CairngormEventDispatcher.getInstance().dispatchEvent( rpEvent );
						model.regEventCount= model.regEventCount+1;
					}
					
					if(model.patientLanguageDTOList != null)
					{
						model.patientLanguageDTOList.filterFunction = null;
						model.patientEmergencyContactDTOList.refresh();
						var newList:ArrayCollection = new ArrayCollection();					
						for(i=0;i<model.patientLanguageDTOList.length;i++)
						{
							var dto:PatientLanguageDTO = model.patientLanguageDTOList.getItemAt(i) as PatientLanguageDTO;
							if(dto.IsDeleted == true || dto.IsDirty == true) 
							{
								newList.addItem(dto);
							}
							
						}
						if(newList.length>0 || model.patientDTO.IsDirty)
						{
							if(model.patientDTO.IsDirty)
							{
								model.patientDTO.ModifiedBy = model.loggedInUserDTO.UserId;
								model.patientDTO.ModifiedAt = new Date();
							}
							var rpplEvent : RegisterPatientProfileAndLanguageEvent = new RegisterPatientProfileAndLanguageEvent(Constants.UPDATE_PURPOSE,model.patientDTO,newList,Constants.UPDATE_PURPOSE,resultFunction);
							CairngormEventDispatcher.getInstance().dispatchEvent( rpplEvent );
							model.regEventCount= model.regEventCount+1;
						}
					}
					
					
					if(model.patientEmergencyContactDTOList!=null)//  model.patientEmergencyContactDTOList.length>0)
					{
						model.patientEmergencyContactDTOList.filterFunction = null;
						model.patientEmergencyContactDTOList.refresh();
						
						newList = new ArrayCollection();
						for(i=0;i<model.patientEmergencyContactDTOList.length;i++)
						{
							var eDTO:PatientEmergencyContactDTO = model.patientEmergencyContactDTOList.getItemAt(i) as PatientEmergencyContactDTO;
							if(eDTO.IsDeleted == true || eDTO.IsDirty == true)
							{
								newList.addItem(eDTO);
							}
							
						}
						if(newList.length>0 )
						{	
							var ecEvent : SavePatientEmergencyContactEvent = new SavePatientEmergencyContactEvent(Constants.UPDATE_PURPOSE,model.loadedPatientId,newList,resultFunction);
							CairngormEventDispatcher.getInstance().dispatchEvent( ecEvent );
							model.regEventCount= model.regEventCount+1;
						}
					}
					//-- Start Tahir Alvi
					if(model.patientGuarantorDTOList !=null )
					{
						model.patientGuarantorDTOList.filterFunction = null;
						model.patientGuarantorDTOList.refresh();
						
						newList = new ArrayCollection();
						for(i=0;i<model.patientGuarantorDTOList.length;i++)
						{
							var gDTO:PatientGuarantorDTO = model.patientGuarantorDTOList.getItemAt(i) as PatientGuarantorDTO;
							if(gDTO.IsDeleted == true || gDTO.IsDirty == true)
							{
								newList.addItem(gDTO);
							}
						}
						if(newList.length>0 )
						{	
							var gEvent : SavePatientGuarantorEvent = new SavePatientGuarantorEvent(Constants.UPDATE_PURPOSE,model.loadedPatientId,newList,resultFunction);
							CairngormEventDispatcher.getInstance().dispatchEvent( gEvent );
							model.regEventCount= model.regEventCount+1;
						}
					}
					
					if(model.patientInsuranceDTOList!=null)
					{
						model.patientInsuranceDTOList.filterFunction = null;
						model.patientInsuranceDTOList.refresh();
						
						newList = new ArrayCollection();
						for(i=0;i<model.patientInsuranceDTOList.length;i++)
						{
							var iDTO:PatientInsuranceDTO = model.patientInsuranceDTOList.getItemAt(i) as PatientInsuranceDTO;
							if(iDTO.IsDeleted == true || iDTO.IsDirty == true)
							{
								newList.addItem(iDTO);
							}
						}
						if(newList.length>0 )
						{	
							var piEvent : SavePatientInsuranceEvent = new SavePatientInsuranceEvent(Constants.UPDATE_PURPOSE,model.loadedPatientId,newList,resultFunction);
							CairngormEventDispatcher.getInstance().dispatchEvent( piEvent );
							model.regEventCount= model.regEventCount+1;
						}
					}				
					//-- End Tahir Alvi
					var abEvent : SaveAddressBookEvent = new SaveAddressBookEvent(Constants.UPDATE_PURPOSE,model.loadedPatientId,model.addressBookDTO,resultFunction);
					CairngormEventDispatcher.getInstance().dispatchEvent( abEvent );
					model.regEventCount= model.regEventCount+1;
					
					
					if(model.healthHX != null)
					{
						if(null != model.healthHX.PatientMedicalHistoryDTOList)
						{
							model.healthHX.PatientMedicalHistoryDTOList.filterFunction = null;
							model.healthHX.PatientMedicalHistoryDTOList.refresh();
						}
						
						if(null != model.healthHX.PatientFamilyHistoryDTOList)
						{
							model.healthHX.PatientFamilyHistoryDTOList.filterFunction = null;
							model.healthHX.PatientFamilyHistoryDTOList.refresh();
						}
						
						if( null != model.healthHX.PatientAllergyDTOList)
						{
							model.healthHX.PatientAllergyDTOList.filterFunction = null;
							model.healthHX.PatientAllergyDTOList.refresh();
						}
						
						var hEvent : SavePatientHealthInfoEvent = new SavePatientHealthInfoEvent(Constants.UPDATE_PURPOSE,model.loadedPatientId,model.healthHX,resultFunction);
						CairngormEventDispatcher.getInstance().dispatchEvent( hEvent );
						model.regEventCount= model.regEventCount+1;
					}
					
					if(model.patientRegImageDTO!=null && model.patientRegImageDTO.ImageData!=null && model.patientRegImageDTO.ImageData.length>0)
					{
						model.patientRegImageDTO.UserId			= model.patientUserId;
						model.patientRegImageDTO.UserTypeID 	= Constants.PATIENT_USER_TYPE_ID;
						model.patientRegImageDTO.CreatedAt 		= new Date();
						model.patientRegImageDTO.CreatedBy 		= model.loggedInUserDTO.UserId;
						model.patientRegImageDTO.ImageTypeId 	= model.profileImageTypeDTO.ImageTypeId;
						
						var pimEvent : SavePatientImageEvent 	= new SavePatientImageEvent(Constants.UPDATE_PURPOSE,resultFunction);
						CairngormEventDispatcher.getInstance().dispatchEvent( pimEvent );
						
						model.regEventCount						= model.regEventCount+1;
					}
				}
			}
		}
		
		
		public static function UpdateModel():void
		{
			//User has changed location from Header, new user selected location is sotred in model.userSelectedStationDTO
			//TODO Implement service/integration for application level
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			if(model.UserLoggedIn)
			{
				LiveServicesController.getInstance().updateLiveServicesModel( model.loggedInUserDTO.UserId,
					model.userSelectedRoleDTO.UserTypeProfileID,
					model.userSelectedRoleDTO.UserTypeRole.UserTypeId, 
					model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq,
					model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchName,
					model.userSelectedStationDTO.StationName,
					model.userSelectedStationDTO.StationID,
					model.securityProxyObject,
					model.userSelectedRoleDTO.UserTypeRole.IsProvider
				);
				
				EmailModelLocator.getInstance().updateModel(model.loggedInUserDTO.UserId,
					model.userSelectedRoleDTO.UserTypeProfileID,
					model.userSelectedRoleDTO.UserTypeRole.UserTypeId, 
					model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq,
					model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchName,
					model.userSelectedStationDTO.StationName,
					model.userSelectedStationDTO.StationID
				);
				
			}
			
		}
		
		public static function LoadViewBackgroundDataByLocation():void
		{
			//User changed location Viewbackground 
			//TODO Implement service/integration for ViewBackground
			loadPMHForViewBackground();
			loadPhysicalForViewBackground();
			loadAssesmentForViewBackground();
			
		}
		
		public static function LoadDocumentList(pageNo:int):void
		{
			
			var ld:LoadPatientDocumentByPatientIdEvent = new LoadPatientDocumentByPatientIdEvent(pageNo);
			
			CairngormEventDispatcher.getInstance().dispatchEvent( ld );
		}
		
	}
}