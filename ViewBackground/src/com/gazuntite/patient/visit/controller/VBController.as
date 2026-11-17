package com.gazuntite.patient.visit.controller
{
	//////////////////////////////////////////////////////////////////////////////////////
	//																					//
	//		ViewBackGround Controller 	(ZIGRON INC)									//
	//																					//
	//////////////////////////////////////////////////////////////////////////////////////
	import com.adobe.cairngorm.control.FrontController;
	import com.gazuntite.common.util.xml.XmlUtils;
	import com.gazuntite.patient.visit.command.LoadFollowUpByPatientIdPagedCommand;
	import com.gazuntite.patient.visit.command.LoadHPIByPatientIdPagedCommand;
	import com.gazuntite.patient.visit.command.LoadModuleDictationByPatientIDCommand;
	import com.gazuntite.patient.visit.command.LoadPatientImmunizationsByPatientIdCommand;
	import com.gazuntite.patient.visit.command.LoadPatientVisitsByPatientIdAndClinicIdCommand;
	import com.gazuntite.patient.visit.command.LoadPhysicalsByPatientIdPagedCommand;
	import com.gazuntite.patient.visit.command.LoadProcedureByPatientIdPagedCommand;
	import com.gazuntite.patient.visit.command.LoadROSByPatientIdPagedCommand;
	import com.gazuntite.patient.visit.command.LoadRecommendationByPatientIdPagedCommand;
	import com.gazuntite.patient.visit.command.LoadVitalsByPatientIdPagedCommand;
	import com.gazuntite.patient.visit.command.compHistory.LoadFamilyHistoryByPatientIdPagedCommand;
	import com.gazuntite.patient.visit.command.compHistory.LoadMedicalHistoryByPatientIdPagedCommand;
	import com.gazuntite.patient.visit.command.compHistory.LoadSocialHistoryByPatientIdPagedCommand;
	import com.gazuntite.patient.visit.command.diagnosis.LoadAcuteDiagnosisByPatientIdPagedCommand;
	import com.gazuntite.patient.visit.command.diagnosis.LoadChronicDiagnosisByPatientIdPagedCommand;
	import com.gazuntite.patient.visit.command.diagnosis.LoadResolvedDiagnosisByPatientIdPagedCommand;
	import com.gazuntite.patient.visit.command.labs.LoadInHouseLabsByPatientIdPagedCommand;
	import com.gazuntite.patient.visit.command.labs.LoadLabsByPatientIdPagedCommand;
	import com.gazuntite.patient.visit.command.summary.LoadSummaryCommand;
	import com.gazuntite.patient.visit.utlis.VBConstants;
	
	public class VBController extends FrontController
	{
		public static const LOAD_VB_SUMMARY_EVENT:String = "loadVBSummary";
		public static const LOAD_PATIENT_IMMUNIZATIONS_BY_PATIENT_ID_EVENT:String = "loadPatientImmunizationsByPatientId";
		public static const LOAD_PATIENT_VISITS_BY_PATIENTID_AND_CLINICID_EVENT:String = "LOAD_PATIENT_VISITS_BY_PATIENTID_AND_CLINICID_EVENT";
		public static const LOAD_MEDICAL_HISTORY_BY_PATIENT_ID_PAGED_EVENT:String = "LOAD_MEDICAL_HISTORY_BY_PATIENT_ID_PAGED_EVENT";
		public static const LOAD_FAMILY_HISTORY_BY_PATIENT_ID_PAGED_EVENT:String = "LOAD_FAMILY_HISTORY_BY_PATIENT_ID_PAGED_EVENT";
		public static const LOAD_SOCIAL_HISTORY_BY_PATIENT_ID_PAGED_EVENT:String = "LOAD_SOCIAL_HISTORY_BY_PATIENT_ID_PAGED_EVENT";
		public static const LOAD_VITALS_BY_PATIENT_ID_PAGED_EVENT:String = "LOAD_VITALS_BY_PATIENT_ID_PAGED_EVENT";
		public static const LOAD_HPI_BY_PATIENT_ID_PAGED_EVENT:String = "LOAD_HPI_BY_PATIENT_ID_PAGED_EVENT";
		public static const LOAD_ROS_BY_PATIENT_ID_PAGED_EVENT:String = "LOAD_ROS_BY_PATIENT_ID_PAGED_EVENT";
		public static const LOAD_PHYSICALS_BY_PATIENT_ID_PAGED_EVENT:String = "LOAD_PHYSICALS_BY_PATIENT_ID_PAGED_EVENT";
		public static const LOAD_IN_HOUSE_LABS_BY_PATIENT_ID_PAGED_EVENT:String = "LOAD_IN_HOUSE_LABS_BY_PATIENT_ID_PAGED_EVENT";
		public static const LOAD_ACUTE_DIAGNOSIS_BY_PATIENT_ID_PAGED_EVENT:String = "LOAD_ACUTE_DIAGNOSIS_BY_PATIENT_ID_PAGED_EVENT";
		public static const LOAD_CHRONIC_DIAGNOSIS_BY_PATIENT_ID_PAGED_EVENT:String = "LOAD_CHRONIC_DIAGNOSIS_BY_PATIENT_ID_PAGED_EVENT";
		public static const LOAD_RESOLVED_DIAGNOSIS_BY_PATIENT_ID_PAGED_EVENT:String = "LOAD_RESOLVED_DIAGNOSIS_BY_PATIENT_ID_PAGED_EVENT";
		public static const LOAD_PROCEDURE_BY_PATIENT_ID_PAGED_EVENT:String = "LOAD_PROCEDURE_BY_PATIENT_ID_PAGED_EVENT";
		public static const LOAD_LABS_BY_PATIENT_ID_PAGED_EVENT:String = "LOAD_LABS_BY_PATIENT_ID_PAGED_EVENT";
		public static const LOAD_RECOMMENDATION_BY_PATIENT_ID_PAGED_EVENT:String = "LOAD_RECOMMENDATION_BY_PATIENT_ID_PAGED_EVENT";
		public static const LOAD_FOLLOW_UP_BY_PATIENT_ID_PAGED_EVENT:String = "LOAD_FOLLOW_UP_BY_PATIENT_ID_PAGED_EVENT";
		
		public static const LOAD_MODULE_DICTATION_BY_PATIENT_ID_EVENT:String = "LOAD_MODULE_DICTATION_BY_PATIENT_ID_EVENT";
		
		private static var m_oVBController:VBController;
		
		public static function getInstance():VBController 
		{
			if ( m_oVBController == null )
				m_oVBController = new VBController( new Lock() );
			return m_oVBController;
		}
		
		public function VBController(lock:Lock)
		{
			if(null == lock )
				throw("Can't create object. please use getInstance() method instead ... ")
				
			addCommands();
		}
		
		//~~~~~~~~~~~~~~~~~~~~ Write Event name Here ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		public static const TEST_EVENT:String = "TEST_EVENT";
		
		protected function addCommands():void
		{
			addCommand(LOAD_VB_SUMMARY_EVENT, LoadSummaryCommand);
			addCommand(LOAD_PATIENT_VISITS_BY_PATIENTID_AND_CLINICID_EVENT, LoadPatientVisitsByPatientIdAndClinicIdCommand);
			addCommand(LOAD_PATIENT_IMMUNIZATIONS_BY_PATIENT_ID_EVENT, LoadPatientImmunizationsByPatientIdCommand);
			addCommand(LOAD_MEDICAL_HISTORY_BY_PATIENT_ID_PAGED_EVENT, LoadMedicalHistoryByPatientIdPagedCommand);
			addCommand(LOAD_FAMILY_HISTORY_BY_PATIENT_ID_PAGED_EVENT, LoadFamilyHistoryByPatientIdPagedCommand);
			addCommand(LOAD_SOCIAL_HISTORY_BY_PATIENT_ID_PAGED_EVENT, LoadSocialHistoryByPatientIdPagedCommand);
			addCommand(LOAD_VITALS_BY_PATIENT_ID_PAGED_EVENT, LoadVitalsByPatientIdPagedCommand);
			addCommand(LOAD_HPI_BY_PATIENT_ID_PAGED_EVENT, LoadHPIByPatientIdPagedCommand);
			addCommand(LOAD_ROS_BY_PATIENT_ID_PAGED_EVENT, LoadROSByPatientIdPagedCommand);
			addCommand(LOAD_PHYSICALS_BY_PATIENT_ID_PAGED_EVENT, LoadPhysicalsByPatientIdPagedCommand);
			addCommand(LOAD_IN_HOUSE_LABS_BY_PATIENT_ID_PAGED_EVENT, LoadInHouseLabsByPatientIdPagedCommand);
			addCommand(LOAD_ACUTE_DIAGNOSIS_BY_PATIENT_ID_PAGED_EVENT, LoadAcuteDiagnosisByPatientIdPagedCommand);
			addCommand(LOAD_CHRONIC_DIAGNOSIS_BY_PATIENT_ID_PAGED_EVENT, LoadChronicDiagnosisByPatientIdPagedCommand);
			addCommand(LOAD_RESOLVED_DIAGNOSIS_BY_PATIENT_ID_PAGED_EVENT, LoadResolvedDiagnosisByPatientIdPagedCommand);
			addCommand(LOAD_PROCEDURE_BY_PATIENT_ID_PAGED_EVENT, LoadProcedureByPatientIdPagedCommand);
			addCommand(LOAD_LABS_BY_PATIENT_ID_PAGED_EVENT, LoadLabsByPatientIdPagedCommand);
			addCommand(LOAD_RECOMMENDATION_BY_PATIENT_ID_PAGED_EVENT, LoadRecommendationByPatientIdPagedCommand);
			addCommand(LOAD_FOLLOW_UP_BY_PATIENT_ID_PAGED_EVENT, LoadFollowUpByPatientIdPagedCommand);
			
			addCommand(LOAD_MODULE_DICTATION_BY_PATIENT_ID_EVENT, LoadModuleDictationByPatientIDCommand);
		}
		
		public function ApplicationConfig(configXML:XML ):void
		{
			VBConstants.EPRESCRIPTION_RESTFULSERVICE = XmlUtils.getPropertyValueByName('EPRESCRIPTION_RESTFULSERVICE', configXML);
			VBConstants.RESTFULL_SERVICE_BASE_URL = XmlUtils.getPropertyValueByName('EPRESCRIPTION_QM_SERVICE', configXML);
			VBConstants.BILLING_RESTFUL_SERVICE = XmlUtils.getPropertyValueByName('BILLING_RESTFUL_SERVICE', configXML);
			VBConstants.RESTFUL_SERVICE_BASE_URL = XmlUtils.getPropertyValueByName('RESTFUL_SERVICE_BASE_URL', configXML);
		}
	}
}
class Lock
{
	//Singlton Lock
}