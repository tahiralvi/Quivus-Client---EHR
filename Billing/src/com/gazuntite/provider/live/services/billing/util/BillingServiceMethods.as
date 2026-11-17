package com.gazuntite.provider.live.services.billing.util
{
	public final class BillingServiceMethods
	{
		//Patient Statement
		public static const LOAD_PATIENT_STATEMENT					    :String = "LoadPatientStatements";
		
		//Accounts & Receivables
		public static const MANAGE_ADJUSTMENT_MAPPING					:String = "ManageAdjustmentMapping";
		public static const LOAD_ADJUSTMENT_MAPPING						:String = "LoadAdjustmentMapping/";
		public static const LOAD_PATIENT_ACCOUNT						:String = "LoadPatientAccountByPatientId";
		public static const LOAD_ADJUSTMENT_REASON_CODES				:String = "GetAdjustmentReasonCodes";
		public static const MANAGE_CLAIM_PAYMENTS						:String = "ManageClaimPayments";
		
		//settings
		public static const LOAD_EDI_RECEIVER_BY_CRITERIA				:String = "LoadEDIReceiverByCriteria";
		public static const MANAGE_EDI_RECEIVER							:String = "ManageEDIReceiver";
		public static const MANAGE_INSURANCE_ORGANIZATION				:String = "ManageInsuranceOrganization";
		public static const LOAD_BILLING_INSURANCE    	    			:String = "LoadBillingInsurance";
		public static const LOAD_BILLING_INSURANCE_BY_CRITERIA    	    :String = "LoadBillingInsuranceByCriteria";
		
		//Reports		
		public static const SAVE_REPORT	:String 						= "SaveReport";
		public static const PATIENT_STATEMENT_REPORT:String 			= "PatientStatementReport";
		public static const LOAD_PAYMENT_TRANSACTIONS:String 			= "LoadPaymentTransactions";
		public static const ERA_CLAIM_DETAIL_REPORT:String 			    = "ERAClaimDetailReport";
				
		//Super Bill
		//----------------------------------------------------------------		
		
		public static const LOAD_STATE_CODES	:String = "LoadStates";
		public static const LOAD_FREQUENCY_CODE_TYPES	:String = "LoadFrequencyCodeTypes";
		public static const SAVE_SUPER_BILL	:String = "SaveSuperBill";
		public static const LOAD_ENM_CODE_TYPES	:String = "LoadENMCodeTypes";
		public static const LOAD_ENCOUNTER_TYPES	:String = "LoadEncounterTypes/";
		
		public static const LOAD_ICD_CODE_TYPES	:String = "LoadICDCodeByName";
		public static const LOAD_CPT_MODIFIER_TYPES	:String = "LoadProcedureModifierTypes";
		public static const LOAD_CPT_MEDICAL_TYPES	:String = "LoadCPTMedicalTypes";
		public static const MANAGE_PENDING_BILL_PROCEDURES	:String = "ManagePendingBillProcedures";
		
		//////////////////////////////////////////////////////////////////
		
		public static const LOAD_PENDING_BILLS_BY_SEARCH_CRITERIA	:String = "LoadPendingBillsByCriteria";
		
		public static const SEND_CLAIMS_FOR_PROCESSING	:String = "SendClaims";
		public static const LOAD_CLAIM_PATIENTS_BY_CLINIC	:String = "LoadClaimPatientList";
		public static const CHANGE_CLAIM_STATUS	:String 		    = "ChangeClaimStatus";
		public static const MANAGE_CLAIM_INSURANCE	:String 		= "ManageClaimInsurance";		
		public static const LOAD_ALL_CLAIM_BY_PROVIDER_ID	:String = "GetProviderClaims";	
		public static const LOAD_CLAIM_BY_SEARCH_CRITERIA	:String = "LoadClaimsBySearchCriteria";
		public static const LOAD_ALL_PENDING_BILLS_BY_PROVIDER_ID	:String = "GetProviderPendingBills";
		public static const LOAD_ALL_CLAIM_TRANSACTION_BY_CLAIM_ID	:String = "GetClaimTransactionsByClaimId";
		public static const LOAD_ALL_CLAIM_DIAGNOSIS_BY_VISIT_ID	:String = "GetVisitDiagnosisByVisitId";
		public static const SPLIT_CLAIM_TRANSACTIONS	:String = "SplitClaimTransactions";
		public static const REMOVE_CLAIM_TRANSACTIONS	:String = "RemoveClaimTransactions";
		public static const ADD_CLAIM_TRANSACTIONS	:String = "AddClaimTransactions";
		public static const LOAD_ALL_CLAIM_MISSING_TRANSACTION_BY_VISIT_ID	:String = "GetClaimMissingTransactionsByVisitId";
	}
}