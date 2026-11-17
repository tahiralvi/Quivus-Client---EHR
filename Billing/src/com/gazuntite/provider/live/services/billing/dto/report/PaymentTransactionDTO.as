package com.gazuntite.provider.live.services.billing.dto.report
{
	import com.adobe.gazuntite.skins.chrome.buttonSkins.newAppointmentBtns;
	import com.gazuntite.common.util.xml.XmlConstants;
	import com.gazuntite.common.util.xml.XmlUtils;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	

	public class PaymentTransactionDTO
	{
		private var _SNo:String;
		private var _PaymentTransactionID:String;
		private var _ClinicBranchId:String;
		private var _ProviderUserID:String;
		private var _ImportDate:String;
		private var _CheckEFTNumber:String;
		private var _CheckEFTIssueDate:String;		
		private var _CheckAmount:String;
		private var _PayeeName:String;
		private var _PayeeIDQualifier:String;
		private var _PayeeID:String;
		private var _Claims:String;
		private var _PaymentMethodCodeTypeID:String;
		private var _PaymentMethodCode:String;
		private var _PaymentMethodDescription:String;
		private var _InsOrganizationID:String;
		private var _InsuranceName:String;
		private var _ClaimList:ArrayCollection;
		
		public function get ClinicBranchId():String
		{
			return _ClinicBranchId;
		}

		public function set ClinicBranchId(value:String):void
		{
			_ClinicBranchId = value;
		}

		public function get ClaimList():ArrayCollection
		{
			return _ClaimList;
		}

		public function set ClaimList(value:ArrayCollection):void
		{
			_ClaimList = value;
		}

		public function get InsOrganizationID():String
		{
			return _InsOrganizationID;
		}

		public function set InsOrganizationID(value:String):void
		{
			_InsOrganizationID = value;
		}

		public function get InsuranceName():String
		{
			return _InsuranceName;
		}

		public function set InsuranceName(value:String):void
		{
			_InsuranceName = value;
		}

		public function FromXML( x:XML ):void
		{
			SNo				 			=  x.@[XmlConstants.SNO];
			PaymentTransactionID		=  x.@[XmlConstants.PAYMENTTRANSACTIONID];
			ProviderUserID				=  x.@[XmlConstants.PROVIDERUSERID];
			ImportDate				 	=  x.@[XmlConstants.IMPORTDATE];
			CheckAmount				 	=  x.@[XmlConstants.CHECKAMOUNT];
			CheckEFTIssueDate			=  x.@[XmlConstants.CHECKEFTISSUEDATE];
			CheckEFTNumber				=  x.@[XmlConstants.CHECKEFTNUMBER];
			PayeeID				 		=  x.@[XmlConstants.PAYEEID];
			PayeeIDQualifier		    =  x.@[XmlConstants.PAYEEIDQUALIFIER];
			PayeeName				    =  x.@[XmlConstants.PAYEENAME];
			PaymentMethodCodeTypeID		=  x.@[XmlConstants.PAYMENTMETHODCODETYPEID];
			PaymentMethodCode			=  x.@[XmlConstants.PAYMENTMETHODCODE];
			PaymentMethodDescription	=  x.@[XmlConstants.PAYMENTMETHODDESCRIPTION];
			InsOrganizationID			=  x.@[XmlConstants.INSORGANIZATIONID];
			InsuranceName				=  x.@[XmlConstants.INSURANCENAME];
			ClinicBranchId				=  x.@[XmlConstants.CLINICBRANCHID];
			
			ClaimList = new ArrayCollection();
			
			var xClaims:XMLList = x.PaymentClaims.PaymentClaim;
			//var xClaims:XMLList = x.PaymentClaims;
			
			for (var i:int = 0; i < xClaims.length(); i++) 
			{
				var paymentClaim:PaymentClaimDTO = new PaymentClaimDTO();
				paymentClaim.FromXML(xClaims[i])
					
				ClaimList.addItem(paymentClaim);
			}
		}
		
		public function ToXML():XML
		{
			var x:XML = XmlUtils.getNodeByTagName("PaymentTransaction");
			
			x.@[XmlConstants.PAYMENTTRANSACTIONID]		=  PaymentTransactionID;
			x.@[XmlConstants.PROVIDERUSERID]			=  ProviderUserID;
			x.@[XmlConstants.IMPORTDATE]				=  UtilityFunctions.FormatDate(ImportDate);
			x.@[XmlConstants.CHECKAMOUNT]				=  CheckAmount;
			x.@[XmlConstants.CHECKEFTISSUEDATE]			=  UtilityFunctions.FormatDate(CheckEFTIssueDate);
			x.@[XmlConstants.CHECKEFTNUMBER]			=  CheckEFTNumber;
			x.@[XmlConstants.PAYEEID]					=  PayeeID;
			x.@[XmlConstants.PAYEEIDQUALIFIER]			=  PayeeIDQualifier;
			x.@[XmlConstants.PAYEENAME]					=  PayeeName;
			x.@[XmlConstants.PAYMENTMETHODCODETYPEID]	=  PaymentMethodCodeTypeID;
			x.@[XmlConstants.PAYMENTMETHODCODE]			=  PaymentMethodCode;
			x.@[XmlConstants.PAYMENTMETHODDESCRIPTION]	=  PaymentMethodDescription;
			x.@[XmlConstants.INSORGANIZATIONID]			=  InsOrganizationID;
			x.@[XmlConstants.INSURANCENAME]				=  InsuranceName;
			x.@[XmlConstants.CLINICBRANCHID]				=  ClinicBranchId;
			
			return x;
		}
		
		public function get PaymentMethodDescription():String
		{
			return _PaymentMethodDescription;
		}

		public function set PaymentMethodDescription(value:String):void
		{
			_PaymentMethodDescription = value;
		}

		public function get PaymentMethodCode():String
		{
			return _PaymentMethodCode;
		}

		public function set PaymentMethodCode(value:String):void
		{
			_PaymentMethodCode = value;
		}

		public function get PaymentMethodCodeTypeID():String
		{
			return _PaymentMethodCodeTypeID;
		}

		public function set PaymentMethodCodeTypeID(value:String):void
		{
			_PaymentMethodCodeTypeID = value;
		}

		public function get Claims():String
		{
			return _Claims;
		}

		public function set Claims(value:String):void
		{
			_Claims = value;
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
			_CheckAmount = String(Number(value).toFixed(2));
		}

		public function get CheckEFTIssueDate():String
		{
			return _CheckEFTIssueDate;
		}

		public function set CheckEFTIssueDate(value:String):void
		{
			_CheckEFTIssueDate = UtilityFunctions.FormatDate(value.substring(0,10),"MM/DD/YYYY");
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
			_ImportDate = UtilityFunctions.FormatDate(value.substring(0,10),"MM/DD/YYYY");
		}

		public function get ProviderUserID():String
		{
			return _ProviderUserID;
		}

		public function set ProviderUserID(value:String):void
		{
			_ProviderUserID = value;
		}

		public function get PaymentTransactionID():String
		{
			return _PaymentTransactionID;
		}

		public function set PaymentTransactionID(value:String):void
		{
			_PaymentTransactionID = value;
		}

		public function get SNo():String
		{
			return _SNo;
		}

		public function set SNo(value:String):void
		{
			_SNo = value;
		}
		
	}
}