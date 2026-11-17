package com.gazuntite.provider.live.services.billing.appController
{
	import com.adobe.cairngorm.control.FrontController;
	import com.gazuntite.provider.live.services.billing.command.AddClaimTransactionCommand;
	import com.gazuntite.provider.live.services.billing.command.ClaimManagement.ChangeClaimStatusCommand;
	import com.gazuntite.provider.live.services.billing.command.ClaimManagement.ClaimPatientSearchCommand;
	import com.gazuntite.provider.live.services.billing.command.ClaimManagement.LoadClaimByCriteriaCommand;
	import com.gazuntite.provider.live.services.billing.command.ClaimManagement.ManageClaimCarrierCommand;
	import com.gazuntite.provider.live.services.billing.command.ClaimManagement.SendClaimsForProcessingCommand;
	import com.gazuntite.provider.live.services.billing.command.LoadAllClaimDiagnosisByVisitIdCommand;
	import com.gazuntite.provider.live.services.billing.command.LoadAllClaimMissingTransactionByVisitIdCommand;
	import com.gazuntite.provider.live.services.billing.command.LoadAllClaimTransactionByClaimIdCommand;
	import com.gazuntite.provider.live.services.billing.command.LoadAllClaimbyProviderIdCommand;
	import com.gazuntite.provider.live.services.billing.command.LoadAllPendingBillsbyProviderIdCommand;
	import com.gazuntite.provider.live.services.billing.command.RemoveClaimTransactionCommand;
	import com.gazuntite.provider.live.services.billing.command.SplitClaimTransactionCommand;
	import com.gazuntite.provider.live.services.billing.command.SuperBill.LoadCPTMedicalTypesCommand;
	import com.gazuntite.provider.live.services.billing.command.SuperBill.LoadCPTModifierTypesCommand;
	import com.gazuntite.provider.live.services.billing.command.SuperBill.LoadENMCodeTypesCommand;
	import com.gazuntite.provider.live.services.billing.command.SuperBill.LoadEncounterTypesCommand;
	import com.gazuntite.provider.live.services.billing.command.SuperBill.LoadFrequencyCodeTypesCommand;
	import com.gazuntite.provider.live.services.billing.command.SuperBill.LoadICDCodeTypesCommand;
	import com.gazuntite.provider.live.services.billing.command.SuperBill.LoadStateCodesCommand;
	import com.gazuntite.provider.live.services.billing.command.SuperBill.ManagePendingBillProceduresCommand;
	import com.gazuntite.provider.live.services.billing.command.SuperBill.SaveSuperBillCommand;
	import com.gazuntite.provider.live.services.billing.command.accountsAndReceiveables.AdjustmentMappingCommand;
	import com.gazuntite.provider.live.services.billing.command.accountsAndReceiveables.LoadAdjustmentReasonCodesCommand;
	import com.gazuntite.provider.live.services.billing.command.accountsAndReceiveables.LoadPatientAccountCommand;
	import com.gazuntite.provider.live.services.billing.command.accountsAndReceiveables.LoadPatientStatementCommand;
	import com.gazuntite.provider.live.services.billing.command.accountsAndReceiveables.ManageClaimPaymentCommand;
	import com.gazuntite.provider.live.services.billing.command.report.ERAClaimDetailReportCommand;
	import com.gazuntite.provider.live.services.billing.command.report.ERAReportSetupCommand;
	import com.gazuntite.provider.live.services.billing.command.report.PatientStatementReportCommand;
	import com.gazuntite.provider.live.services.billing.command.report.SuperBillSummaryReportCommand;
	import com.gazuntite.provider.live.services.billing.command.settings.LoadEDIReceiverByCriteriaCommand;
	import com.gazuntite.provider.live.services.billing.command.settings.ManageEDIReceiverCommand;
	import com.gazuntite.provider.live.services.billing.view.views.insuranceSettings.commands.LoadAllInsuranceByIDCommand;
	import com.gazuntite.provider.live.services.billing.view.views.insuranceSettings.commands.LoadInsurancesCommand;
	import com.gazuntite.provider.live.services.billing.view.views.insuranceSettings.commands.ManageAllInsuranceCommand;



	public class BillingController extends FrontController
	{
		//Patient Statement 
		public static const LOAD_PATIENT_STATEMENT_EVENT : String 			=	"LoadPatientStatementEvent";
		
		//accountsAndReceiveables-----------
		public static const ADJUSTMENT_MAPPING_EVENT : String 				=	"AdjustmentMappingEvent";
		public static const LOAD_PATIENT_ACCOUNT_EVENT : String 			=	"LoadPatientAccountEvent";
		public static const LOAD_ADJUSTMENT_REASON_CODES_EVENT : String 	=	"LoadAdjustmentReasonCodesEvent";
		public static const MANAGE_CLAIM_PAYMENT_EVENT : String 			=	"ManageClaimPaymentEvent";
		
		//Setting-----------------
		public static const LOAD_EDI_RECEIVER_BY_CRITERIA_EVENT : String 	=	"LoadEDIReceiverByCriteria";
		public static const MANAGE_EDI_RECEIVER_EVENT : String 				=	"ManageEDIReceiver";
		public static const GET_CITIES_LIST_EVENT : String 					=	"GetCitiesBillingEvent";
		public static const GET_STATES_LIST_EVENT : String 					=	"GetStatesBillingEvent";
		public static const GET_ZIP_LIST_EVENT : String 					=	"GetZIPBillingEvent";
		
		//Reports
		public static const SUPER_BILL_SUMMARY_REPORT_EVENT : String 		=	"SuperBillSummaryReportEvent";		
		public static const PATIENT_STATEMENT_REPORT_EVENT : String 		=	"PatientStatementReportEvent";		
		public static const ERA_REPORT_SETUP_EVENT : String 				=	"ERAReportSetupEvent";		
		public static const ERA_CLAIM_DETAIL_REPORT_EVENT : String 			=	"ERAClaimDetailReportEvent";		
		
		//Super Bill
		//---------------	
		public static const LOAD_STATE_CODE_EVENT : String 					=	"LoadStateCodeEvent";
		public static const LOAD_FREQUENCY_CODE_TYPES_EVENT : String 		=	"LoadFrequencyCodeTypesEvent";
		public static const SAVE_SUPER_BILL_EVENT : String 					=	"SaveSuperBillEvent";
		public static const LOAD_ENM_CODE_TYPES_EVENT : String 				=	"LoadENMCodeTypesEvent";
		public static const LOAD_ENCOUNTER_TYPES_EVENT : String 			=	"LoadEncounterTypesEvent";
		public static const LOAD_CPT_MEDICAL_TYPES_EVENT : String 			=	"LoadCPTMedicalTypesEvent";
		public static const LOAD_ICD_CODE_TYPES_EVENT : String 				=	"LoadICDCodeTypesEvent";
		public static const MANAGE_PENDING_BILL_PROCEDURES_EVENT : String	=	"ManagePendingBillProceduresEvent";
		public static const LOAD_CPT_MODIFIER_TYPES_EVENT : String 			=	"LoadCPTModifierTypesEvent";
		
		//____Claim Management________________________________________________________________________
			
		public static const SEND_CLAIMS_FOR_PROCESSING : String =	"SendClaimsForProcessingEvent";
		public static const CLAIM_PATIENT_SEARCH_EVENT : String =	"ClaimPatientSearchEvent";
		public static const CHANGE_CLAIM_STATUS_EVENT : String =	"ChangeClaimStatusEvent";
		public static const LOAD_CLAIM_BY_CRITERIA_EVENT : String =	"LoadClaimByCriteriaEvent";
		public static const MANAGE_CLAIM_CARRIER_EVENT : String =	"ManageClaimCarrierEvent";
		
		public static const LOAD_ALL_CLAIM_BY_PROVIDER_ID_EVENT : String =	"LoadAllClaimByPproviderIdEvent";		
		public static const LOAD_ALL_CLAIM_TRANSACTION_BY_CLAIM_ID_EVENT : String =	"LoadAllClaimTransactionByClaimIdEvent";
		public static const LOAD_ALL_CLAIM_DIAGNOSIS_BY_VISIT_ID_EVENT : String =	"LoadAllClaimDiagnosisByVisitIdEvent";
		public static const SPLIT_CLAIM_TRANSACTIONS_EVENT : String =	"SplitClaimTransactionEvent";
		public static const REMOVE_CLAIM_TRANSACTIONS_EVENT : String =	"RemoveClaimTransactionEvent";
		public static const ADD_CLAIM_TRANSACTIONS_EVENT : String =	"AddClaimTransactionEvent";
		public static const LOAD_ALL_CLAIM_MISSING_TRANSACTION_BY_VISIT_ID_EVENT : String =	"LoadAllClaimMissingTransactionByVisitIdEvent";
		public static const LOAD_ALL_PENDING_BILLS_BY_PROVIDER_ID_EVENT : String =	"LoadAllPendingBillsByProviderIdEvent";
		
		//---------------Insurance --------------------------------------------------------------
		
		public static const LOAD_INSURANCE_EVENT : String	 	=	"LoadInsurancesEvent";
		public static const LOAD_ALL_INSURANCE_BY_ID_EVENT:String 			= "LoadAllInsuranceByIDEvent" ;
		public static const MANAGE_ALL_INSURANCE_EVENT:String 				= "ManageAllInsuranceEvent" ;
		
		private static var m_oBillingController:BillingController ;
		
		public static function getInstance():BillingController 
		{
			if ( m_oBillingController == null )
				m_oBillingController = new BillingController(new Lock());
			return m_oBillingController;
		}
		
		public function BillingController(lock:Lock)
		{
			if(null == lock )
				throw("Can't create object. please use getInstance() method instead ... ")
				
			//Accounts & Receivables
			addCommand(ADJUSTMENT_MAPPING_EVENT,AdjustmentMappingCommand);
			addCommand(LOAD_PATIENT_ACCOUNT_EVENT, LoadPatientAccountCommand);
			addCommand(LOAD_ADJUSTMENT_REASON_CODES_EVENT, LoadAdjustmentReasonCodesCommand);
			addCommand(MANAGE_CLAIM_PAYMENT_EVENT, ManageClaimPaymentCommand);
			
			//Setting
			addCommand( LOAD_EDI_RECEIVER_BY_CRITERIA_EVENT, LoadEDIReceiverByCriteriaCommand );
			addCommand( MANAGE_EDI_RECEIVER_EVENT, ManageEDIReceiverCommand );
			/*addCommand( GET_CITIES_LIST_EVENT,    GetCitiesBillingCommand );
			addCommand( GET_STATES_LIST_EVENT,    GetStatesBillingCommand );
			addCommand( GET_ZIP_LIST_EVENT,    GetZipBillingCommand );*/
			
			//Reports
			addCommand( SUPER_BILL_SUMMARY_REPORT_EVENT, SuperBillSummaryReportCommand );
			addCommand( PATIENT_STATEMENT_REPORT_EVENT, PatientStatementReportCommand );
			addCommand( ERA_REPORT_SETUP_EVENT, ERAReportSetupCommand );
			addCommand( ERA_CLAIM_DETAIL_REPORT_EVENT, ERAClaimDetailReportCommand );
			
			//Super Bill
			//---------------
			addCommand( LOAD_STATE_CODE_EVENT, LoadStateCodesCommand );
			addCommand( LOAD_FREQUENCY_CODE_TYPES_EVENT, LoadFrequencyCodeTypesCommand );
			addCommand( SAVE_SUPER_BILL_EVENT, SaveSuperBillCommand );
			addCommand( LOAD_ENM_CODE_TYPES_EVENT, LoadENMCodeTypesCommand );
			addCommand( LOAD_ENCOUNTER_TYPES_EVENT, LoadEncounterTypesCommand );
			addCommand( LOAD_CPT_MEDICAL_TYPES_EVENT, LoadCPTMedicalTypesCommand );
			addCommand( LOAD_ICD_CODE_TYPES_EVENT, LoadICDCodeTypesCommand );
			addCommand( MANAGE_PENDING_BILL_PROCEDURES_EVENT, ManagePendingBillProceduresCommand );
			addCommand( LOAD_CPT_MODIFIER_TYPES_EVENT, LoadCPTModifierTypesCommand );
			//____________________________________________________________________________
			
			addCommand(LOAD_PATIENT_STATEMENT_EVENT,LoadPatientStatementCommand);
			
			addCommand(SEND_CLAIMS_FOR_PROCESSING, SendClaimsForProcessingCommand);
			
			addCommand( CLAIM_PATIENT_SEARCH_EVENT, ClaimPatientSearchCommand );
			
			addCommand( CHANGE_CLAIM_STATUS_EVENT, ChangeClaimStatusCommand );
			
			addCommand( LOAD_CLAIM_BY_CRITERIA_EVENT, LoadClaimByCriteriaCommand );
			
			addCommand( MANAGE_CLAIM_CARRIER_EVENT, ManageClaimCarrierCommand );
			
			addCommand( LOAD_ALL_CLAIM_BY_PROVIDER_ID_EVENT, LoadAllClaimbyProviderIdCommand );
			
			addCommand( LOAD_ALL_PENDING_BILLS_BY_PROVIDER_ID_EVENT, LoadAllPendingBillsbyProviderIdCommand );
			
			addCommand( LOAD_ALL_CLAIM_TRANSACTION_BY_CLAIM_ID_EVENT, LoadAllClaimTransactionByClaimIdCommand );
			
			addCommand( LOAD_ALL_CLAIM_DIAGNOSIS_BY_VISIT_ID_EVENT, LoadAllClaimDiagnosisByVisitIdCommand );
			
			addCommand( SPLIT_CLAIM_TRANSACTIONS_EVENT, SplitClaimTransactionCommand );
			
			addCommand( REMOVE_CLAIM_TRANSACTIONS_EVENT, RemoveClaimTransactionCommand );
			addCommand( ADD_CLAIM_TRANSACTIONS_EVENT, AddClaimTransactionCommand );
			
			addCommand( LOAD_ALL_CLAIM_MISSING_TRANSACTION_BY_VISIT_ID_EVENT, LoadAllClaimMissingTransactionByVisitIdCommand );
			
			//Insurance
			addCommand(LOAD_INSURANCE_EVENT,LoadInsurancesCommand)
			addCommand(	LOAD_ALL_INSURANCE_BY_ID_EVENT,LoadAllInsuranceByIDCommand) ;
			addCommand(MANAGE_ALL_INSURANCE_EVENT ,ManageAllInsuranceCommand);
		}
	}
}
class Lock
{
	//Singlton Lock
}