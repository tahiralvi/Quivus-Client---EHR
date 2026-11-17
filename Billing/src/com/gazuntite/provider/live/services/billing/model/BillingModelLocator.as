package com.gazuntite.provider.live.services.billing.model
{
	import com.adobe.cairngorm.model.ModelLocator;
	import com.gazuntite.common.dto.AddInsuranceDTO;
	import com.gazuntite.common.util.xml.XmlUtils;
	import com.gazuntite.provider.live.services.billing.dto.ClaimManagement.CMSearchDTO;
	import com.gazuntite.provider.live.services.billing.dto.ClaimManagement.CarrierDTO;
	import com.gazuntite.provider.live.services.billing.dto.SearchClaimResultsList;
	import com.gazuntite.provider.live.services.billing.dto.SearchClaimTransactionResultsList;
	import com.gazuntite.provider.live.services.billing.dto.SearchPendingBillsResultList;
	import com.gazuntite.provider.live.services.billing.dto.SuperBill.CMS1500DTO;
	import com.gazuntite.provider.live.services.billing.dto.accountsAndReceiveables.PatientAccountDTO;
	import com.gazuntite.provider.live.services.billing.dto.settings.EDIReceiverDTO;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.utils.ObjectProxy;
	
	[Bindable]
	public class BillingModelLocator implements ModelLocator 
	{
		private var logger:ILogger = Log.getLogger("com.gazuntite.provider.live.services.billing.model.BillingModelLocator");
		
		private static var model 	:BillingModelLocator;
		
		public function BillingModelLocator() : void 
		{
			if ( model != null )
				throw new Error( "Only one BillingModelLocator instance should be instantiated" );
		}		

		public function get ClaimPatientBilling():CarrierDTO
		{
			return _ClaimPatientBilling;
		}

		public function set ClaimPatientBilling(value:CarrierDTO):void
		{
			_ClaimPatientBilling = value;
		}

		public function get AdjustmentGroupCodeListADM():ArrayCollection
		{
			return _AdjustmentGroupCodeListADM;
		}

		public function set AdjustmentGroupCodeListADM(value:ArrayCollection):void
		{
			_AdjustmentGroupCodeListADM = value;
		}

		public function get AdjustmentReasonCodeListADM():ArrayCollection
		{
			return _AdjustmentReasonCodeListADM;
		}

		public function set AdjustmentReasonCodeListADM(value:ArrayCollection):void
		{
			_AdjustmentReasonCodeListADM = value;
		}

		public function get InsuranceListforAdjustmentMapping():ArrayCollection
		{
			return _InsuranceListforAdjustmentMapping;
		}

		public function set InsuranceListforAdjustmentMapping(value:ArrayCollection):void
		{
			_InsuranceListforAdjustmentMapping = value;
		}

		public function get AdjustmentMappingList():ArrayCollection
		{
			return _AdjustmentMappingList;
		}

		public function set AdjustmentMappingList(value:ArrayCollection):void
		{
			_AdjustmentMappingList = value;
		}

		public function get AdjustmentGroupCodeListADJ():ArrayCollection
		{
			return _AdjustmentGroupCodeListADJ;
		}

		public function set AdjustmentGroupCodeListADJ(value:ArrayCollection):void
		{
			_AdjustmentGroupCodeListADJ = value;
		}

		public function get AdjustmentGroupCodeListWOF():ArrayCollection
		{
			return _AdjustmentGroupCodeListWOF;
		}

		public function set AdjustmentGroupCodeListWOF(value:ArrayCollection):void
		{
			_AdjustmentGroupCodeListWOF = value;
		}

		public function get AdjustmentReasonCodeListADJ():ArrayCollection
		{
			return _AdjustmentReasonCodeListADJ;
		}

		public function set AdjustmentReasonCodeListADJ(value:ArrayCollection):void
		{
			_AdjustmentReasonCodeListADJ = value;
		}

		public function get AdjustmentReasonCodeListWOF():ArrayCollection
		{
			return _AdjustmentReasonCodeListWOF;
		}

		public function set AdjustmentReasonCodeListWOF(value:ArrayCollection):void
		{
			_AdjustmentReasonCodeListWOF = value;
		}

		public function get AdjustmentReasonCodeList():ArrayCollection
		{
			return _AdjustmentReasonCodeList;
		}

		public function set AdjustmentReasonCodeList(value:ArrayCollection):void
		{
			_AdjustmentReasonCodeList = value;
		}

		public function get PatienListForAccount():ArrayCollection
		{
			return m_aPatienListForAccount;
		}

		public function set PatienListForAccount(value:ArrayCollection):void
		{
			m_aPatienListForAccount = value;
		}

		public function get CurrentPatienAccount():PatientAccountDTO
		{
			return m_oCurrentPatienAccount;
		}

		public function set CurrentPatienAccount(value:PatientAccountDTO):void
		{
			m_oCurrentPatienAccount = value;
		}

		public function get EDIReceiverListForSetup():ArrayCollection
		{
			return m_aEDIReceiverListForSetup;
		}

		public function set EDIReceiverListForSetup(value:ArrayCollection):void
		{
			m_aEDIReceiverListForSetup = value;
		}

		public function get BillingStateList():ArrayCollection
		{
			return m_oBillingStateList;
		}

		public function set BillingStateList(value:ArrayCollection):void
		{
			m_oBillingStateList = value;
		}

		public static function getInstance() : BillingModelLocator
		{
			if ( model == null )
				model = new BillingModelLocator();
			return model;
		}

		//######################### BILLING DATA MEMBERS END ##########################################
		public var totalRecordMessage_PB			:String="";
		public var totalrecords_PB				:int=0;
		public var firstRecord_PB							:int=0 ;
		public var lastRecord_PB							:int=0 ;
		public var PendingBillTotalPageNo				    :int=0 ;
		private var m_iPendingBillSearchPageNo				:int=1 ;	
		
		public function get PendingBillSearchPageNo():int
		{
			return m_iPendingBillSearchPageNo;
		}
		
		public function set PendingBillSearchPageNo(value:int):void
		{
			if( value <= 0 )
			{
				m_iPendingBillSearchPageNo = 1;
			}
			else if( value >= PendingBillTotalPageNo )
			{
				m_iPendingBillSearchPageNo = PendingBillTotalPageNo;
			}
			else
			{
				m_iPendingBillSearchPageNo = value;
			}
		}
		
		//------------------------ERA Report Setup--------------------------------------------------------
						
		private var _PaymentTransactionList			:ArrayCollection;
				
		public var totalRecordMessage_ERA			:String="";
		public var totalrecords_ERA				    :int=0;
		public var firstRecord_ERA					:int=0 ;
		public var lastRecord_ERA					:int=0 ;
		public var ERATotalPageNo					:int=0 ;
		private var _ERASearchPageNo				:int=1 ;	
		
		public function get ERASearchPageNo():int
		{
			return _ERASearchPageNo;
		}
		
		public function set ERASearchPageNo(value:int):void
		{
			if( value <= 0 )
			{
				_ERASearchPageNo = 1;
			}
			else if( value >= ERATotalPageNo )
			{
				_ERASearchPageNo = ERATotalPageNo;
			}
			else
			{
				_ERASearchPageNo = value;
			}
		}
		
		public function get PaymentTransactionList():ArrayCollection
		{
			return _PaymentTransactionList;
		}
		
		public function set PaymentTransactionList(value:ArrayCollection):void
		{
			_PaymentTransactionList = value;
		}
		
		private var _PaymentClaimList:ArrayCollection;
		
		public function get PaymentClaimList():ArrayCollection
		{
			return _PaymentClaimList;
		}
		
		public function set PaymentClaimList(value:ArrayCollection):void
		{
			_PaymentClaimList = value;
		}
		
		//------------------------Patient Statement--------------------------------------------------------
			
		private var _PatientStatementList			:ArrayCollection;
		private var _StatementPatientDetailList	:ArrayCollection;
		
		public var totalRecordMessage_PS			:String="";
		public var totalrecords_PS				    :int=0;
		public var firstRecord_PS					:int=0 ;
		public var lastRecord_PS					:int=0 ;
		public var PatientStatementTotalPageNo		:int=0 ;
		private var _PatientStatementSearchPageNo	:int=1 ;	
		
		public function get PatientStatementSearchPageNo():int
		{
			return _PatientStatementSearchPageNo;
		}
		
		public function set PatientStatementSearchPageNo(value:int):void
		{
			if( value <= 0 )
			{
				_PatientStatementSearchPageNo = 1;
			}
			else if( value >= PatientStatementTotalPageNo )
			{
				_PatientStatementSearchPageNo = PatientStatementTotalPageNo;
			}
			else
			{
				_PatientStatementSearchPageNo = value;
			}
		}
		
		public function get PatientStatementList()
		{
			return _PatientStatementList;
		}
		
		public function set PatientStatementList(value):void
		{
			_PatientStatementList = value;
		}
		
		public function get StatementPatientDetailList()
		{
			return _StatementPatientDetailList;
		}
		
		public function set StatementPatientDetailList(value):void
		{
			_StatementPatientDetailList = value;
		}
		
		//-------------------Claim Management------------------------------------------------------------------
		public var totalRecordMessage_CM			:String="";
		public var totalrecords_CM				:int=0;
		public var firstRecord_CM							:int=0 ;
		public var lastRecord_CM							:int=0 ;
		public var ClaimManagementTotalPageNo				    :int=0 ;
		private var m_iClaimManagementSearchPageNo				:int=1 ;	
		
		public function get ClaimManagementSearchPageNo():int
		{
			return m_iClaimManagementSearchPageNo;
		}
		
		public function set ClaimManagementSearchPageNo(value:int):void
		{
			if( value <= 0 )
			{
				m_iClaimManagementSearchPageNo = 1;
			}
			else if( value >= ClaimManagementTotalPageNo )
			{
				m_iClaimManagementSearchPageNo = ClaimManagementTotalPageNo;
			}
			else
			{
				m_iClaimManagementSearchPageNo = value;
			}
		}
		//-----------------------------------------------------------------------------------------------------
		
		//-------------------EDI Receiver------------------------------------------------------------------
		public var totalRecordMessage_ER			:String="";
		public var totalrecords_ER				:int=0;
		public var firstRecord_ER							:int=0 ;
		public var lastRecord_ER							:int=0 ;
		public var EDIReceiverTotalPageNo				    :int=0 ;
		private var m_iEDIReceiverSearchPageNo				:int=1 ;
		
		public var ERSearchType:int = 0;
		public var ERSearchString:String = "0";
				
		public function get EDIReceiverSearchPageNo():int
		{
			return m_iEDIReceiverSearchPageNo;
		}
		
		public function set EDIReceiverSearchPageNo(value:int):void
		{
			if( value <= 0 )
			{
				m_iEDIReceiverSearchPageNo = 1;
			}
			else if( value >= EDIReceiverTotalPageNo )
			{
				m_iEDIReceiverSearchPageNo = EDIReceiverTotalPageNo;
			}
			else
			{
				m_iEDIReceiverSearchPageNo = value;
			}
		}
		
		private var m_aEDIReceiverListForSetup:ArrayCollection;
		public var isEDIReceiverGeneralList:Boolean;
		
		private var m_aEDIReceiverList:ArrayCollection;
		private var m_oCurrentEDIReceiver:EDIReceiverDTO;
		public function get CurrentEDIReceiver():EDIReceiverDTO
		{
			return m_oCurrentEDIReceiver;
		}

		public function set CurrentEDIReceiver(value:EDIReceiverDTO):void
		{
			m_oCurrentEDIReceiver = value;
		}

		
		public function get EDIReceiverList():ArrayCollection
		{
			return m_aEDIReceiverList;
		}
		
		public function set EDIReceiverList(value:ArrayCollection):void
		{
			m_aEDIReceiverList = value;
		}
		
		//-----------------------------------------------------------------------------------------------------
		
		//-------------------Insurance Setup------------------------------------------------------------------
		public var totalRecordMessage_IS			:String="";
		public var totalrecords_IS				:int=0;
		public var firstRecord_IS							:int=0 ;
		public var lastRecord_IS							:int=0 ;
		public var InsuranceSetupTotalPageNo				    :int=0 ;
		private var m_iInsuranceSetupSearchPageNo				:int=1 ;		
			
		public function get InsuranceSetupSearchPageNo():int
		{
			return m_iInsuranceSetupSearchPageNo;
		}
		
		public function set InsuranceSetupSearchPageNo(value:int):void
		{
			if( value <= 0 )
			{
				m_iInsuranceSetupSearchPageNo = 1;
			}
			else if( value >= InsuranceSetupTotalPageNo )
			{
				m_iInsuranceSetupSearchPageNo = InsuranceSetupTotalPageNo;
			}
			else
			{
				m_iInsuranceSetupSearchPageNo = value;
			}
		}
		
		//-----------------------------------------------------------------------------------------------------
		
		private var m_sVisitDateRange:String;
		
		public function get VisitDateRange():String
		{
			return m_sVisitDateRange;
		}
		
		public function set VisitDateRange(value:String):void
		{
			m_sVisitDateRange = value;
		}
				
		private var m_oSearchClaimResults:SearchClaimResultsList;
		private var m_oSearchPendingBillsResults:SearchPendingBillsResultList;
		private var m_oSearchClaimTransactionResults:SearchClaimTransactionResultsList;
		private var m_oSearchClaimMissingTransactionResults:SearchClaimTransactionResultsList;
		private var m_sSearchClaimDiagnoses:String;
		private var m_bResult:Boolean;
		
		//Accounts & Receivable
		private var m_oCurrentPatienAccount:PatientAccountDTO;
		private var m_aPatienListForAccount:ArrayCollection;
		private var _AdjustmentReasonCodeList:ArrayCollection;
		private var _AdjustmentReasonCodeListWOF:ArrayCollection;
		private var _AdjustmentReasonCodeListADM:ArrayCollection;
		private var _AdjustmentReasonCodeListADJ:ArrayCollection;
		private var _AdjustmentGroupCodeListWOF:ArrayCollection;
		private var _AdjustmentGroupCodeListADJ:ArrayCollection;
		private var _AdjustmentGroupCodeListADM:ArrayCollection;
		
		private var _AdjustmentMappingList:ArrayCollection;
		
		//Reports
		private var m_bIsReport:Boolean;
		
		public function get IsReport():Boolean
		{
			return m_bIsReport;
		}
		
		public function set IsReport(value:Boolean):void
		{
			m_bIsReport = value;
		}
		private var m_nCurrentReportID:int;
		
		public function get CurrentReportID():int
		{
			return m_nCurrentReportID;
		}
		
		public function set CurrentReportID(value:int):void
		{
			m_nCurrentReportID = value;
		}
		
		//-----Sper Bill------------------------
		
		private var m_nDLScale:String
		
		public function get CurrentDecisionLevelScale():String
		{
			return m_nDLScale;
		}
		
		public function set CurrentDecisionLevelScale(value:String):void
		{
			m_nDLScale = value;
		}
		
		private var m_nELScale:String
		
		public function get CurrentExaminationLevelScale():String
		{
			return m_nELScale;
		}
		
		public function set CurrentExaminationLevelScale(value:String):void
		{
			m_nELScale = value;
		}
		
		private var m_nHLScale:String
		
		public function get CurrentHistoryLevelScale():String
		{
			return m_nHLScale;
		}
		
		public function set CurrentHistoryLevelScale(value:String):void
		{
			m_nHLScale = value;
		}
		
		
		private var m_bIsActionButtonEnabled:Boolean
		
		public function get ActionButtonEnabled():Boolean
		{
			return m_bIsActionButtonEnabled;
		}
		
		public function set ActionButtonEnabled(value:Boolean):void
		{
			m_bIsActionButtonEnabled = value;
		}
		
		public var SendClaimInsuranceTypeId:int;
		public var SendClaimMediaTypeId:int;
		public var SendClaimEDIReceiverId:int;
		
		public var CMSViewInsuranceType:String;
		
		public var CMS1500StateCodeIndex:int = -1;
		
		private var m_oCMS:CMS1500DTO;
		
		public function get CMS1500Info():CMS1500DTO
		{
			return m_oCMS;
		}
		
		public function set CMS1500Info(value:CMS1500DTO):void
		{
			m_oCMS = value;
		}
		
		private var m_oENMServiceInfo:ArrayCollection;
		
		public function get CurrentENMServiceInfo():ArrayCollection
		{
			return m_oENMServiceInfo;
		}
		
		public function set CurrentENMServiceInfo(value:ArrayCollection):void
		{
			m_oENMServiceInfo = value;
		}
		
		private var m_aWRService:ArrayCollection;
		
		public function get CurrentWRServices():ArrayCollection
		{
			return m_aWRService;
		}
		public function set CurrentWRServices(value:ArrayCollection):void
		{
			m_aWRService = value;
		}
		
		private var m_aCurrentDiagnosis:ArrayCollection;
		
		public function get CurrentDiagnosis():ArrayCollection
		{
			return m_aCurrentDiagnosis;
		}			
		
		public function set CurrentDiagnosis(value:ArrayCollection):void
		{
			m_aCurrentDiagnosis = value;
		}
		
		private var m_aCurrentOtherProcedures:ArrayCollection;
		
		public function get CurrentOtherProcedures():ArrayCollection
		{
			return m_aCurrentOtherProcedures;
		}			
		
		public function set CurrentOtherProcedures(value:ArrayCollection):void
		{
			m_aCurrentOtherProcedures = value;
		}
		
		private var m_aCurrentProcedures:ArrayCollection;
		
		public function get CurrentProcedures():ArrayCollection
		{
			return m_aCurrentProcedures;
		}			
		
		public function set CurrentProcedures(value:ArrayCollection):void
		{
			m_aCurrentProcedures = value;
		}
		
		/*
		private var m_aReceivedProcedures:ArrayCollection;
		
		public function get ReceivedProcedures():ArrayCollection
		{
			return m_aReceivedProcedures;
		}			
		
		public function set ReceivedProcedures(value:ArrayCollection):void
		{
			m_aReceivedProcedures = value;
		}
		*/
		private var m_sCurrentPOSTypeID:String;
		
		public function get CurrentPOSTypeID():String
		{
			return m_sCurrentPOSTypeID;
		}			
		
		public function set CurrentPOSTypeID(value:String):void
		{
			m_sCurrentPOSTypeID = value;
		}
		
		private var m_sPOSCode:String;
		
		public function get CurrentPOSCode():String
		{
			return m_sPOSCode;
		}			
		
		public function set CurrentPOSCode(value:String):void
		{
			m_sPOSCode = value;
		}
		
		private var m_sModeOfPayment:String;
		
		public function get CurrentPaymentTypeId():String
		{
			return m_sModeOfPayment;
		}			
		
		public function set CurrentPaymentTypeId(value:String):void
		{
			m_sModeOfPayment = value;
		}
		
		private var m_sCheckNo:String;
		
		public function get CheckNo():String
		{
			return m_sCheckNo;
		}			
		
		public function set CheckNo(value:String):void
		{
			m_sCheckNo = value;
		}
		
		private var m_sTOSID:String;
		
		public function get CurrentTOSID():String
		{
			return m_sTOSID;
		}			
		
		public function set CurrentTOSID(value:String):void
		{
			m_sTOSID = value;
		}
		
		public function CalculateSuperBill():void
		{
			if(TotalCharges > 0 &&  Number(model.ReceivedCopay.replace("%","")) == model.Copay && model.IsPercentCopay == true)
			{
				var perCopay:Number = (Copay / TotalCharges) * 100;
				PatientBalance = TotalCharges - ( perCopay + PrimaryResponsibility + 
					SecondaryResponsibility + BillingDisallowed + 
					AdditionalPayment  + WriteOff )
			}
			else
				PatientBalance = TotalCharges - ( Copay + PrimaryResponsibility + 
				           SecondaryResponsibility + BillingDisallowed + 
						   AdditionalPayment  + WriteOff )
		}
		
		private var m_sSuperBillWriteOff:Number
		
		public function get WriteOff():Number
		{
			return m_sSuperBillWriteOff;
		}			
		
		public function set WriteOff(value:Number):void
		{
			m_sSuperBillWriteOff = value;
		}
		
		private var m_sSuperBillAdditionalPayment:Number
		
		public function get AdditionalPayment():Number
		{
			return m_sSuperBillAdditionalPayment;
		}			
		
		public function set AdditionalPayment(value:Number):void
		{
			m_sSuperBillAdditionalPayment = value;
		}
		
		private var m_sSuperBillDisallowed:Number
		
		public function get BillingDisallowed():Number
		{
			return m_sSuperBillDisallowed;
		}			
		
		public function set BillingDisallowed(value:Number):void
		{
			m_sSuperBillDisallowed = value;
		}
		
		private var m_sSuperBillSecInsResp:Number
		
		public function get SecondaryResponsibility():Number
		{
			return m_sSuperBillSecInsResp;
		}			
		
		public function set SecondaryResponsibility(value:Number):void
		{
			m_sSuperBillSecInsResp = value;
		}
		
		private var m_sSuperBillPriInsResp:Number
		
		public function get PrimaryResponsibility():Number
		{
			return m_sSuperBillPriInsResp;
		}			
		
		public function set PrimaryResponsibility(value:Number):void
		{
			m_sSuperBillPriInsResp = value;
		}
		
		private var m_sSuperBillPatientbalance:Number
		
		public function get PatientBalance():Number
		{
			return m_sSuperBillPatientbalance;
		}			
		
		public function set PatientBalance(value:Number):void
		{
			m_sSuperBillPatientbalance = value;
		}
		
		private var m_sUpdatedCopay:Number
		
		public function get UpdatedCopay():Number
		{
			return m_sUpdatedCopay;
		}			
		
		public function set UpdatedCopay(value:Number):void
		{
			m_sUpdatedCopay = value;
		}
		
		private var m_sReceivedCopay:String
		
		public function get ReceivedCopay():String
		{
			return m_sReceivedCopay;
		}			
		
		public function set ReceivedCopay(value:String):void
		{
			m_sReceivedCopay = value;
		}
		
		private var m_sSuperBillDisplayCopay:String
		
		public function get DisplayCopay():String
		{
			return m_sSuperBillDisplayCopay;
		}			
		
		public function set DisplayCopay(value:String):void
		{
			m_sSuperBillDisplayCopay = value;
		}
		
		private var m_sSuperBillCopay:Number
		
		public function get Copay():Number
		{
			return m_sSuperBillCopay;
		}			
		
		public function set Copay(value:Number):void
		{
			m_sSuperBillCopay = value;
		}
		
		private var m_bPercentCopay:Boolean
		
		public function get IsPercentCopay():Boolean
		{
			return m_bPercentCopay;
		}			
		
		public function set IsPercentCopay(value:Boolean):void
		{
			m_bPercentCopay = value;
		}
		
		private var m_sSuperBillTotalcharges:Number
		
		
		public function get TotalCharges():Number
		{
			return m_sSuperBillTotalcharges;
		}			
		
		public function set TotalCharges(value:Number):void
		{
			m_sSuperBillTotalcharges = value;
		}		
		
		private var m_sSuperBillPaymentMode:String
		
		
		public function get ModeOfPayment():String
		{
			return m_sSuperBillPaymentMode;
		}			
		
		public function set ModeOfPayment(value:String):void
		{
			m_sSuperBillPaymentMode = value;
		}
		
		private var m_aCurrentModifiers:ArrayCollection;
		
		
		public function get CurrentModifiers():ArrayCollection
		{
			return m_aCurrentModifiers;
		}			
		
		public function set CurrentModifiers(value:ArrayCollection):void
		{
			m_aCurrentModifiers = value;
		}
		
		private var m_oCPTModifierTypeList1:ArrayCollection;
		
		public function get CPTModifierTypeList1():ArrayCollection
		{
			return m_oCPTModifierTypeList1;
		}
		
		public function set CPTModifierTypeList1(value:ArrayCollection):void
		{
			m_oCPTModifierTypeList1 = value;
		}
		
		private var m_oCPTModifierTypeList2:ArrayCollection;
		
		public function get CPTModifierTypeList2():ArrayCollection
		{
			return m_oCPTModifierTypeList2;
		}
		
		public function set CPTModifierTypeList2(value:ArrayCollection):void
		{
			m_oCPTModifierTypeList2 = value;
		}
		
		private var m_oCPTModifierTypeList3:ArrayCollection;
		
		public function get CPTModifierTypeList3():ArrayCollection
		{
			return m_oCPTModifierTypeList3;
		}
		
		public function set CPTModifierTypeList3(value:ArrayCollection):void
		{
			m_oCPTModifierTypeList3 = value;
		}
		
		private var m_oBillingStateList:ArrayCollection;
		
		private var m_oPOSTypeList:ArrayCollection;
		
		public function get PlaceOfServiceTypeList():ArrayCollection
		{
			return m_oPOSTypeList;
		}
		
		public function set PlaceOfServiceTypeList(value:ArrayCollection):void
		{
			m_oPOSTypeList = value;
		}
		
		private var m_oTOSTypeList:ArrayCollection;
		
		public function get TypeOfServiceList():ArrayCollection
		{
			return m_oTOSTypeList;
		}
		
		public function set TypeOfServiceList(value:ArrayCollection):void
		{
			m_oTOSTypeList = value;
		}
		
		private var m_oClaimCurrentCarriers:ArrayCollection;
		
		public function get ClaimCurrentCarriers():ArrayCollection
		{
			return m_oClaimCurrentCarriers;
		}
		
		public function set ClaimCurrentCarriers(value:ArrayCollection):void
		{
			m_oClaimCurrentCarriers = value;
		}
		
		private var m_oClaimCarrier1:CarrierDTO;
		
		public function get ClaimCarrier1():CarrierDTO
		{
			return m_oClaimCarrier1;
		}
		
		public function set ClaimCarrier1(value:CarrierDTO):void
		{
			m_oClaimCarrier1 = value;
		}
		
		private var m_oClaimCarrier2:CarrierDTO;
		
		public function get ClaimCarrier2():CarrierDTO
		{
			return m_oClaimCarrier2;
		}
		
		public function set ClaimCarrier2(value:CarrierDTO):void
		{
			m_oClaimCarrier2 = value;
		}
		
		private var _ClaimPatientBilling:CarrierDTO;
		private var m_oClaimCarrier3:CarrierDTO;
		
		public function get ClaimCarrier3():CarrierDTO
		{
			return m_oClaimCarrier3;
		}
		
		public function set ClaimCarrier3(value:CarrierDTO):void
		{
			m_oClaimCarrier3 = value;
		}
		
		private var m_oClaimCarrierIniBillDate:String;
		
		public function get ClaimCarrierIniBillDate():String
		{
			return m_oClaimCarrierIniBillDate;
		}
		
		public function set ClaimCarrierIniBillDate(value:String):void
		{
			m_oClaimCarrierIniBillDate = value;
		}		
		
		private var m_oInsuranceListforCarrier3:ArrayCollection;
		
		public function get InsuranceListforCarrier3():ArrayCollection
		{
			return m_oInsuranceListforCarrier3;
		}
		
		public function set InsuranceListforCarrier3(value:ArrayCollection):void
		{
			m_oInsuranceListforCarrier3 = value;
		}
		
		private var m_oInsuranceListforCarrier2:ArrayCollection;
		
		public function get InsuranceListforCarrier2():ArrayCollection
		{
			return m_oInsuranceListforCarrier2;
		}
		
		public function set InsuranceListforCarrier2(value:ArrayCollection):void
		{
			m_oInsuranceListforCarrier2 = value;
		}
		
		private var m_oClaimPatientList:ArrayCollection;
		
		public function get ClaimPatientList():ArrayCollection
		{
			return m_oClaimPatientList;
		}
		
		public function set ClaimPatientList(value:ArrayCollection):void
		{
			m_oClaimPatientList = value;
		}
		
		private var m_oInsuranceListforCarrier1:ArrayCollection;
		
		public function get InsuranceListforCarrier1():ArrayCollection
		{
			return m_oInsuranceListforCarrier1;
		}
		
		public function set InsuranceListforCarrier1(value:ArrayCollection):void
		{
			m_oInsuranceListforCarrier1 = value;
		}
		
		
		private var _InsuranceListByID:ArrayCollection ;
		
		
		private var m_oInsuranceListfoClaimListOnly:ArrayCollection;
		private var _InsuranceListforAdjustmentMapping:ArrayCollection;
		
		public function get InsuranceListfoClaimListOnly():ArrayCollection
		{
			return m_oInsuranceListfoClaimListOnly;
		}
		
		public function set InsuranceListfoClaimListOnly(value:ArrayCollection):void
		{
			m_oInsuranceListfoClaimListOnly = value;
		}
		
		
		private var m_oClaimListOnlyCritera:CMSearchDTO;
		
		public function get ClaimListOnlyCritera():CMSearchDTO
		{
			return m_oClaimListOnlyCritera;
		}
		
		public function set ClaimListOnlyCritera(value:CMSearchDTO):void
		{
			m_oClaimListOnlyCritera = value;
		}
		
		private var m_sClaimNewNote:String;
		
		public function get ClaimNewNote():String
		{
			return m_sClaimNewNote;
		}
		
		public function set ClaimNewNote(value:String):void
		{
			m_sClaimNewNote = value;
		}
		
		private var m_sClaimNote:String;
		
		public function get ClaimNote():String
		{
			return m_sClaimNote;
		}
		
		public function set ClaimNote(value:String):void
		{
			m_sClaimNote = value;
		}
		
		private var m_oStateCodeList:ArrayCollection;
		
		public function get StateCodeList():ArrayCollection
		{
			return m_oStateCodeList;
		}
		
		public function set StateCodeList(value:ArrayCollection):void
		{
			m_oStateCodeList = value;
		}
		
		private var m_oCPTModifierTypeList4:ArrayCollection;
		
		public function get CPTModifierTypeList4():ArrayCollection
		{
			return m_oCPTModifierTypeList4;
		}
		
		public function set CPTModifierTypeList4(value:ArrayCollection):void
		{
			m_oCPTModifierTypeList4 = value;
		}
		
		private var m_oCPTMedicalTypeList:ArrayCollection;
		
		public function get CPTMedicalTypeList():ArrayCollection
		{
			return m_oCPTMedicalTypeList;
		}
		
		public function set CPTMedicalTypeList(value:ArrayCollection):void
		{
			m_oCPTMedicalTypeList = value;
		}
		
		private var m_oCPTMedicalTypeListOther:ArrayCollection;
		
		public function get CPTMedicalTypeListOther():ArrayCollection
		{
			return m_oCPTMedicalTypeListOther;
		}
		
		public function set CPTMedicalTypeListOther(value:ArrayCollection):void
		{
			m_oCPTMedicalTypeListOther = value;
		}
		
		private var m_oICDCodeTypeList:ArrayCollection;
		
		public function get ICDCodeTypeList():ArrayCollection
		{
			return m_oICDCodeTypeList;
		}
		
		public function set ICDCodeTypeList(value:ArrayCollection):void
		{
			m_oICDCodeTypeList = value;
		}
		
		private var m_oENMCodeList:ArrayCollection;
		
		public function get ENMSuggestedCodeList():ArrayCollection
		{
			return m_oENMCodeList;
		}
		
		public function set ENMSuggestedCodeList(value:ArrayCollection):void
		{
			m_oENMCodeList = value;
		}
		
		private var m_oFrequencyCodeList:ArrayCollection;
		
		public function get FrequencyCodeList():ArrayCollection
		{
			return m_oFrequencyCodeList;
		}
		
		public function set FrequencyCodeList(value:ArrayCollection):void
		{
			m_oFrequencyCodeList = value;
		}
		
		//############################ DATA MEMBERS GETTERS SETTERS #########################################
		
		
		
		public function get Result():Boolean
		{
			return m_bResult;
		}
		
		public function set Result(value:Boolean):void
		{
			m_bResult = value;
		}
		
		public function get SearchPendingBillsResults():SearchPendingBillsResultList
		{
			return m_oSearchPendingBillsResults;
		}
		
		public function set SearchPendingBillsResults(value:SearchPendingBillsResultList):void
		{
			m_oSearchPendingBillsResults = value;
		}
		
		public function get SearchClaimResults():SearchClaimResultsList
		{
			return m_oSearchClaimResults;
		}
		
		public function set SearchClaimResults(value:SearchClaimResultsList):void
		{
			m_oSearchClaimResults = value;
		}
		
		public function get SearchClaimTransactionResults():SearchClaimTransactionResultsList
		{
			return m_oSearchClaimTransactionResults;
		}
		
		public function set SearchClaimTransactionResults(value:SearchClaimTransactionResultsList):void
		{
			m_oSearchClaimTransactionResults = value;
		}
		
		public function get SearchClaimMissingTransactionResults():SearchClaimTransactionResultsList
		{
			return m_oSearchClaimMissingTransactionResults;
		}
		
		public function set SearchClaimMissingTransactionResults(value:SearchClaimTransactionResultsList):void
		{
			m_oSearchClaimMissingTransactionResults = value;
		}
		
		public function get SearchClaimDiagnoses():String
		{
			return m_sSearchClaimDiagnoses;
		}
		
		public function set SearchClaimDiagnoses(value:String):void
		{
			m_sSearchClaimDiagnoses = value;
		}
		
		public function updateModel(loggedInUserId:int, loggedInUserProviderId:int, loggedInUserProviderTypeId:int, loggedInUserSelectedBranchId:int, userSelectedPracticeName:String, stationName:String, stationId:int, authentication:ObjectProxy, IsloggedInUserProvider:Boolean):void
		{
			//if(IsloggedInUserProvider)
				this.LoggedInUserProviderId			= loggedInUserId;
			//else
				//this.LoggedInUserProviderId			= loggedInUserProviderId //to bo done......
					
			this.LoggedInUserId						= loggedInUserId;			
			this.LoggedInUserProviderTypeId			= loggedInUserProviderTypeId;
			this.LoggedInUserSelectedBranchId		= loggedInUserSelectedBranchId;
			this.LoggedInUserSelectedPracticeName	= userSelectedPracticeName; 
			this.LoggedInUserSelectedStationName 	= stationName; 
		}
		
		public function resetModel():void
		{
			this.LoggedInUserId						= undefined;
			this.LoggedInUserProviderId				= undefined;
			this.LoggedInUserProviderTypeId			= undefined;
			this.LoggedInUserSelectedBranchId		= undefined;
			this.LoggedInUserSelectedPracticeName	= undefined; 
			this.LoggedInUserSelectedStationName 	= undefined; 
			
			this.CurrentPageNo						= 1 ;
			this.TotalRecords						= 0 ;
			this.FirstRecord						= 0 ;
			this.LastRecord							= 0 ;
			this.TotalPageNo						= 0 ;
		}
		
		
		public function get LoggedInUserSelectedBranchId():int
		{
			return m_iLoggedInUserSelectedBranchId;
		}

		public function set LoggedInUserSelectedBranchId(value:int):void
		{
			m_iLoggedInUserSelectedBranchId = value;
		}

		
		public function get LoggedInUserId():int
		{
			return m_iLoggedInUserId;
		}

		public function set LoggedInUserId(value:int):void
		{
			m_iLoggedInUserId = value;
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
			return m_sUserSelectedPracticeName;
		}

		public function set LoggedInUserSelectedPracticeName(value:String):void
		{
			m_sUserSelectedPracticeName = value;
		}

		
		public function get LoggedInUserSelectedStationName():String
		{
			return m_sStationName;
		}

		public function set LoggedInUserSelectedStationName(value:String):void
		{
			m_sStationName = value;
		}

		
		public function get TotalRecords():int
		{
			return m_iTotalRecords;
		}

		public function set TotalRecords(value:int):void
		{
			m_iTotalRecords = value;
		}

		
		public function get FirstRecord():int
		{
			return m_iFirstRecord;
		}

		public function set FirstRecord(value:int):void
		{
			m_iFirstRecord = value;
		}

		
		public function get LastRecord():int
		{
			return m_iLastRecord;
		}

		public function set LastRecord(value:int):void
		{
			m_iLastRecord = value;
		}

		
		public function get TotalPageNo():int
		{
			return m_iTotalPageNo;
		}

		public function set TotalPageNo(value:int):void
		{
			m_iTotalPageNo = value;
		}

		
		public function get CurrentPageNo():int
		{
			return m_iCurrentPageNo;
		}

		public function set CurrentPageNo(value:int):void
		{
			m_iCurrentPageNo = value;
		}

		
		//########################### Gazuntite Configuration ##########################
		private var _ConfigXML							:XML;
		
		public function get ConfigXML():XML
		{
			return _ConfigXML;
		}
		
		public function set ConfigXML(value:XML):void
		{
			_ConfigXML = value;
			
			BillingConstants.RESTFULL_SERVICE_BASE_URL 			= XmlUtils.getPropertyValueByName( 'BILLING_RESTFUL_SERVICE', value );
			BillingConstants.BILLING_REPORT_BASE_URL 			= XmlUtils.getPropertyValueByName( 'BILLING_REPORT_BASE_URL', value );
			BillingConstants.USER_RESTFULL_SERVICE_BASE_URL 	= XmlUtils.getPropertyValueByName( 'EPRESCRIPTION_USER_SERVICE', value );
			
			//log it 
			logger.debug( "BILLING_RESTFUL_SERVICE URL: " + BillingConstants.RESTFULL_SERVICE_BASE_URL  );
			logger.debug( "BILLING_REPORT_BASE_URL URL: " + BillingConstants.BILLING_REPORT_BASE_URL  );
			logger.debug( "EPRESCRIPTION_USER_SERVICE URL: " + BillingConstants.USER_RESTFULL_SERVICE_BASE_URL  );
		}

		public function get InsuranceListByID():ArrayCollection
		{
			return _InsuranceListByID;
		}

		public function set InsuranceListByID(value:ArrayCollection):void
		{
			_InsuranceListByID = value;
		}

		//............................................................................................//
		
		private var _insuranceDto				:AddInsuranceDTO;
		
		public function get insuranceDto():AddInsuranceDTO
		{
			return _insuranceDto;
		}
		
		public function set insuranceDto(value:AddInsuranceDTO):void
		{
			_insuranceDto = value;
		}
		
		private var _InsList:ArrayCollection;
		public function get InsList():ArrayCollection
		{
			return _InsList;
		}

		public function set InsList(value:ArrayCollection):void
		{
			_InsList = value;
		}

		
		//############################ DATA MEMBERS ###########################################
		
		//Logged In User info members...
		private var //m_iLoggedInUserId:int = 610,//42934,//610, 
			        m_iLoggedInUserId:int = 	42984, //for local
					m_iLoggedInUserSelectedBranchId:int = 7, 
					//m_iLoggedInUserProviderId:int =  610,//42934,//610, 
					m_iLoggedInUserProviderId:int = 42984,  //for local
					m_iLoggedInUserProviderTypeId:int = 3,
					m_sUserSelectedPracticeName:String, 
					m_sStationName:String;
		
	    private var m_iTotalRecords:int,
			        m_iFirstRecord:int,
				    m_iLastRecord:int,
				    m_iTotalPageNo:int,
		            m_iCurrentPageNo:int;
					
		
		

		
		//######################### DATA MEMBERS GETTERS SETTERS END ##########################################
	}
}