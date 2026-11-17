package com.gazuntite.provider.live.services.billing.dto.report
{
	import com.gazuntite.common.util.xml.XmlConstants;
	import com.gazuntite.common.util.xml.XmlUtils;

	public class PaymentTransactionSearchCriteriaDTO
	{
		private var _ProviderUserID:String;
		private var _ImportDate:String;
		private var _CheckEFTNumber:String;
		private var _CheckEFTIssueDate:String;
		private var _CheckAmount:String;
		private var _PayeeName:String;
		private var _PayeeIDQualifier:String;
		private var _PayeeID:String;		
		private var _InsOrganizationID:String;
		private var _InsuranceName:String;
		private var _PaymentMethodCodeTypeID:String;
		private var _PageNo:String;
		private var _ClaimID:String;
		private var _PatientFirstName:String;
		private var _PatientLastName:String;
		private var _ICN:String;
		private var _VisitDate:String;
		private var _SearchType:String;
		private var _ClinicBranchId:String;
		
		public function get ClinicBranchId():String
		{
			return _ClinicBranchId;
		}

		public function set ClinicBranchId(value:String):void
		{
			_ClinicBranchId = value;
		}

		public function get SearchType():String
		{
			return _SearchType;
		}

		public function set SearchType(value:String):void
		{
			_SearchType = value;
		}

		public function ToXML( ):XML
		{
			var x:XML = XmlUtils.getNodeByTagName("SearchCriteria");
			
			x.@[XmlConstants.PROVIDERUSERID]		= ProviderUserID;
			x.@[XmlConstants.IMPORTDATE]			= ImportDate;
			x.@[XmlConstants.CHECKAMOUNT]			= CheckAmount;
			x.@[XmlConstants.CHECKEFTISSUEDATE]		= CheckEFTIssueDate;
			x.@[XmlConstants.CHECKEFTNUMBER]		= CheckEFTNumber;
			x.@[XmlConstants.PAYEEID]				= PayeeID;
			x.@[XmlConstants.PAYEEIDQUALIFIER]		= PayeeIDQualifier;
			x.@[XmlConstants.PAYEENAME]				= PayeeName;
			x.@[XmlConstants.PAYMENTMETHODCODETYPEID]= PaymentMethodCodeTypeID;
			x.@[XmlConstants.INSORGANIZATIONID]		= InsOrganizationID;
			x.@[XmlConstants.PAGENO]				= PageNo;
			x.@[XmlConstants.CLAIMID]				= ClaimID;
			x.@[XmlConstants.PATIENTFIRSTNAME]		= PatientFirstName;
			x.@[XmlConstants.PATIENTLASTNAME]		= PatientLastName;
			x.@[XmlConstants.ICN]					= ICN;
			x.@[XmlConstants.VISITDATE]				= VisitDate;
			x.@[XmlConstants.SEARCHTYPE]			= SearchType;
			x.@[XmlConstants.CLINICBRANCHID]		= ClinicBranchId;
						
			return x;
		}
		
		
		public function get VisitDate():String
		{
			return _VisitDate;
		}

		public function set VisitDate(value:String):void
		{
			_VisitDate = value;
		}

		public function get ICN():String
		{
			return _ICN;
		}

		public function set ICN(value:String):void
		{
			_ICN = value;
		}

		public function get PatientLastName():String
		{
			return _PatientLastName;
		}

		public function set PatientLastName(value:String):void
		{
			_PatientLastName = value;
		}

		public function get PatientFirstName():String
		{
			return _PatientFirstName;
		}

		public function set PatientFirstName(value:String):void
		{
			_PatientFirstName = value;
		}

		public function get ClaimID():String
		{
			return _ClaimID;
		}

		public function set ClaimID(value:String):void
		{
			_ClaimID = value;
		}

		public function get PageNo():String
		{
			return _PageNo;
		}

		public function set PageNo(value:String):void
		{
			_PageNo = value;
		}

		public function get PaymentMethodCodeTypeID():String
		{
			return _PaymentMethodCodeTypeID;
		}

		public function set PaymentMethodCodeTypeID(value:String):void
		{
			_PaymentMethodCodeTypeID = value;
		}

		
		public function get InsuranceName():String
		{
			return _InsuranceName;
		}

		public function set InsuranceName(value:String):void
		{
			_InsuranceName = value;
		}

		public function get InsOrganizationID():String
		{
			return _InsOrganizationID;
		}

		public function set InsOrganizationID(value:String):void
		{
			_InsOrganizationID = value;
		}

		public function get PayeeID():String
		{
			return _PayeeID;
		}

		public function set PayeeID(value:String):void
		{
			_PayeeID = value;
		}

		public function get PayeeIDQualifier():String
		{
			return _PayeeIDQualifier;
		}

		public function set PayeeIDQualifier(value:String):void
		{
			_PayeeIDQualifier = value;
		}

		public function get PayeeName():String
		{
			return _PayeeName;
		}

		public function set PayeeName(value:String):void
		{
			_PayeeName = value;
		}

		public function get CheckAmount():String
		{
			return _CheckAmount;
		}

		public function set CheckAmount(value:String):void
		{
			_CheckAmount = value;
		}

		public function get CheckEFTIssueDate():String
		{
			return _CheckEFTIssueDate;
		}

		public function set CheckEFTIssueDate(value:String):void
		{
			_CheckEFTIssueDate = value;
		}

		public function get CheckEFTNumber():String
		{
			return _CheckEFTNumber;
		}

		public function set CheckEFTNumber(value:String):void
		{
			_CheckEFTNumber = value;
		}

		public function get ImportDate():String
		{
			return _ImportDate;
		}

		public function set ImportDate(value:String):void
		{
			_ImportDate = value;
		}

		public function get ProviderUserID():String
		{
			return _ProviderUserID;
		}

		public function set ProviderUserID(value:String):void
		{
			_ProviderUserID = value;
		}

	}
}