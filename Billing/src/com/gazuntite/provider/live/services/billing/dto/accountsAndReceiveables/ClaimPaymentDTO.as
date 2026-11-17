package com.gazuntite.provider.live.services.billing.dto.accountsAndReceiveables
{
	import com.gazuntite.common.util.xml.XmlConstants;
	import com.gazuntite.common.util.xml.XmlUtils;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;

	public class ClaimPaymentDTO
	{
		private var _ClaimPaymentID:String;
		private var _ClaimID:String;
		private var _InsuranceOrganizationID:String;
		private var _PaymentEntryTypeID:String;
		private var _PaymentEntryTypeName:String;
		private var _EntryDate:String;
		private var _PaymentSourceTypeID:String;
		private var _PaymentSourceName:String;
		private var _PaymentTypeID:String;
		private var _PaymentTypeName:String;
		private var _ChargedProcedure:String;
		private var _PaidProcedure:String;
		private var _Modifier1:String;
		private var _Modifier2:String;
		private var _Modifier3:String;
		private var _Modifier4:String;
		private var _ServiceDateFrom:String;
		private var _ServiceDateTo:String;
		private var _CheckNumber:String;
		private var _FilingDate:String;
		private var _AllowedAmount:String;
		private var _PaidAmount:String;
		private var _Unit:String;
		private var _AdjustedAmount:String;
		private var _RejectedAmount:String;
		private var _CreatedBy:String;
		private var _ModifiedBy:String;
		private var _IsDeleted:String;
		private var _PaymentModeTypeID:String;
		private var _PaymentModeName:String;
						
		private var _PaymentAdjustments:ArrayCollection;

		public function get PaymentModeName():String
		{
			return _PaymentModeName;
		}

		public function set PaymentModeName(value:String):void
		{
			_PaymentModeName = value;
		}

		public function get PaymentModeTypeID():String
		{
			return _PaymentModeTypeID;
		}

		public function set PaymentModeTypeID(value:String):void
		{
			_PaymentModeTypeID = value;
		}

		public function get Unit():String
		{
			return _Unit;
		}

		public function set Unit(value:String):void
		{
			_Unit = String(Number(value).toFixed(2));
		}

		public function get IsDeleted():String
		{
			return _IsDeleted;
		}

		public function set IsDeleted(value:String):void
		{
			_IsDeleted = value;
		}

		public function get RejectedAmount():String
		{
			return _RejectedAmount;
		}

		public function set RejectedAmount(value:String):void
		{
			_RejectedAmount = String(Number(value).toFixed(2));
		}

		public function FromXML(x:XML):void
		{
			ClaimPaymentID  		= x.@[XmlConstants.CLAIMPAYMENTID];
			ClaimID  				= x.@[XmlConstants.CLAIMID];
			InsOrganizationID  		= x.@[XmlConstants.INSORGANIZATIONID];
			PaymentEntryTypeID 		= x.@[XmlConstants.PAYMENTENTRYTYPEID];
			PaymentEntryTypeName 	= x.@[XmlConstants.PAYMENTENTRYTYPENAME];
			EntryDate 				= x.@[XmlConstants.ENTRYDATE];
			PaymentSourceTypeID  	= x.@[XmlConstants.PAYMENTSOURCETYPEID];
			PaymentSourceName 		= x.@[XmlConstants.PAYMENTSOURCENAME];
			PaymentTypeID 			= x.@[XmlConstants.PAYMENTTYPEID];
			PaymentTypeName 		= x.@[XmlConstants.PAYMENTTYPENAME];
			ChargedProcedure 		= x.@[XmlConstants.CHARGEDPROCEDURE];
			PaidProcedure 			= x.@[XmlConstants.PAIDPROCEDURE];
			Modifier1 				= x.@[XmlConstants.MODIFIER1];
			Modifier2 				= x.@[XmlConstants.MODIFIER2];
			Modifier3 				= x.@[XmlConstants.MODIFIER3];
			Modifier4 				= x.@[XmlConstants.MODIFIER4];
			ServiceDateFrom 		= x.@[XmlConstants.SERVICEDATEFROM];
			ServiceDateTo 			= x.@[XmlConstants.SERVICEDATETO];
			CheckNumber 			= x.@[XmlConstants.CHECKNUMBER];
			FilingDate 				= x.@[XmlConstants.FILINGDATE];
			AllowedAmount 			= x.@[XmlConstants.ALLOWEDAMOUNT];
			PaidAmount 				= x.@[XmlConstants.PAIDAMOUNT];
			Unit 					= x.@[XmlConstants.UNIT];
			AdjustedAmount 			= x.@[XmlConstants.ADJUSTEDAMOUNT];
			RejectedAmount 			= x.@[XmlConstants.REJECTEDAMOUNT];
			CreatedBy 				= x.@[XmlConstants.CREATEDBY];
			ModifiedBy 				= x.@[XmlConstants.MODIFIEDBY];
			IsDeleted 				= x.@[XmlConstants.ISDELETED];
			PaymentModeTypeID 		= x.@[XmlConstants.PAYMENTMODETYPEID];
			PaymentModeName 		= x.@[XmlConstants.PAYMENTMODENAME];
			
			PaymentAdjustments = new ArrayCollection();			
			var xAdjustments:XMLList = x.PaymentAdjustments.PaymentAdjustment;
			for(var i:int = 0; i < xAdjustments.length(); i++)
			{
				var dtod:ClaimAdjustmentDTO = new ClaimAdjustmentDTO();
				dtod.FromXML( xAdjustments[i] );
				PaymentAdjustments.addItem(dtod);
			}			
		}
		
		public function ToXML():XML
		{
			var x:XML = XmlUtils.getNodeByTagName( "ClaimPayment" );
			
			x.@[XmlConstants.CLAIMPAYMENTID]			=		ClaimPaymentID;
			x.@[XmlConstants.CLAIMID]					=		ClaimID;
			x.@[XmlConstants.INSORGANIZATIONID]			=		InsOrganizationID;
			x.@[XmlConstants.PAYMENTENTRYTYPEID]		=		PaymentEntryTypeID;
			x.@[XmlConstants.PAYMENTENTRYTYPENAME]		=		PaymentEntryTypeName;
			x.@[XmlConstants.ENTRYDATE]					=		UtilityFunctions.FormatDate(EntryDate);
			x.@[XmlConstants.PAYMENTSOURCETYPEID]		=		PaymentSourceTypeID;
			x.@[XmlConstants.PAYMENTSOURCENAME]			=		PaymentSourceName;
			x.@[XmlConstants.PAYMENTTYPEID]				=		PaymentTypeID;
			x.@[XmlConstants.PAYMENTTYPENAME]			=		PaymentTypeName;
			x.@[XmlConstants.CHARGEDPROCEDURE]			=		ChargedProcedure;
			x.@[XmlConstants.PAIDPROCEDURE]				=		PaidProcedure;
			x.@[XmlConstants.MODIFIER1]					=		Modifier1;
			x.@[XmlConstants.MODIFIER2]					=		Modifier2;
			x.@[XmlConstants.MODIFIER3]					=		Modifier3;
			x.@[XmlConstants.MODIFIER4]					=		Modifier4;
			x.@[XmlConstants.SERVICEDATEFROM]			=		ServiceDateFrom;
			x.@[XmlConstants.SERVICEDATETO]				=		ServiceDateTo;
			x.@[XmlConstants.CHECKNUMBER]				=		CheckNumber;
			x.@[XmlConstants.FILINGDATE]				=		UtilityFunctions.FormatDate(FilingDate);
			x.@[XmlConstants.ALLOWEDAMOUNT]				=		AllowedAmount;
			x.@[XmlConstants.PAIDAMOUNT]				=		PaidAmount;
			x.@[XmlConstants.ADJUSTEDAMOUNT]			=		AdjustedAmount;
			x.@[XmlConstants.REJECTEDAMOUNT]			=		RejectedAmount;		
			x.@[XmlConstants.CREATEDBY]					= 		CreatedBy;
			x.@[XmlConstants.MODIFIEDBY]				= 		ModifiedBy;
			x.@[XmlConstants.ISDELETED]					= 		IsDeleted;
			x.@[XmlConstants.PAYMENTMODETYPEID]			=		PaymentModeTypeID;
			x.@[XmlConstants.PAYMENTMODENAME]			=		PaymentModeName;
			x.@[XmlConstants.UNIT]						=		Unit;
			
			if(PaymentAdjustments != null && PaymentAdjustments.length > 0 )
			{
				var xAdjustments:XML = XmlUtils.getNodeByTagName( "PaymentAdjustments" );
				
				for(var i:int = 0; i < PaymentAdjustments.length; i++)
				{
					var dto:ClaimAdjustmentDTO = PaymentAdjustments[i];				
					xAdjustments.appendChild(dto.ToXML());
				}
				x.appendChild(xAdjustments);
			}
			
			return x;
		}
		
		public function get PaymentAdjustments():ArrayCollection
		{
			return _PaymentAdjustments;
		}

		public function set PaymentAdjustments(value:ArrayCollection):void
		{
			_PaymentAdjustments = value;
		}

		public function get ModifiedBy():String
		{
			return _ModifiedBy;
		}

		public function set ModifiedBy(value:String):void
		{
			_ModifiedBy = value;
		}

		public function get CreatedBy():String
		{
			return _CreatedBy;
		}

		public function set CreatedBy(value:String):void
		{
			_CreatedBy = value;
		}

		public function get AdjustedAmount():String
		{
			return _AdjustedAmount;
		}

		public function set AdjustedAmount(value:String):void
		{
			_AdjustedAmount = String(Number(value).toFixed(2));
		}

		public function get PaidAmount():String
		{
			return _PaidAmount;
		}

		public function set PaidAmount(value:String):void
		{
			_PaidAmount = String(Number(value).toFixed(2));
		}

		public function get AllowedAmount():String
		{
			return _AllowedAmount;
		}

		public function set AllowedAmount(value:String):void
		{
			_AllowedAmount = String(Number(value).toFixed(2));
		}

		public function get FilingDate():String
		{
			return _FilingDate;
		}

		public function set FilingDate(value:String):void
		{
			_FilingDate = UtilityFunctions.FormatDate(value.substring(0,10),"MM/DD/YYYY");
		}

		public function get CheckNumber():String
		{
			return _CheckNumber;
		}

		public function set CheckNumber(value:String):void
		{
			_CheckNumber = value;
		}

		public function get ServiceDateTo():String
		{
			return _ServiceDateTo;
		}

		public function set ServiceDateTo(value:String):void
		{
			_ServiceDateTo = value;
		}

		public function get ServiceDateFrom():String
		{
			return _ServiceDateFrom;
		}

		public function set ServiceDateFrom(value:String):void
		{
			_ServiceDateFrom = value;
		}

		public function get Modifier4():String
		{
			return _Modifier4;
		}

		public function set Modifier4(value:String):void
		{
			_Modifier4 = value;
		}

		public function get Modifier3():String
		{
			return _Modifier3;
		}

		public function set Modifier3(value:String):void
		{
			_Modifier3 = value;
		}

		public function get Modifier2():String
		{
			return _Modifier2;
		}

		public function set Modifier2(value:String):void
		{
			_Modifier2 = value;
		}

		public function get Modifier1():String
		{
			return _Modifier1;
		}

		public function set Modifier1(value:String):void
		{
			_Modifier1 = value;
		}

		public function get PaidProcedure():String
		{
			return _PaidProcedure;
		}

		public function set PaidProcedure(value:String):void
		{
			_PaidProcedure = value;
		}

		public function get ChargedProcedure():String
		{
			return _ChargedProcedure;
		}

		public function set ChargedProcedure(value:String):void
		{
			_ChargedProcedure = value;
		}

		public function get PaymentTypeName():String
		{
			return _PaymentTypeName;
		}

		public function set PaymentTypeName(value:String):void
		{
			_PaymentTypeName = value;
		}

		public function get PaymentTypeID():String
		{
			return _PaymentTypeID;
		}

		public function set PaymentTypeID(value:String):void
		{
			_PaymentTypeID = value;
		}

		public function get PaymentSourceName():String
		{
			return _PaymentSourceName;
		}

		public function set PaymentSourceName(value:String):void
		{
			_PaymentSourceName = value;
		}

		public function get PaymentSourceTypeID():String
		{
			return _PaymentSourceTypeID;
		}

		public function set PaymentSourceTypeID(value:String):void
		{
			_PaymentSourceTypeID = value;
		}

		public function get EntryDate():String
		{
			return _EntryDate;
		}

		public function set EntryDate(value:String):void
		{
			_EntryDate = UtilityFunctions.FormatDate(value.substring(0,10),"MM/DD/YYYY");
		}

		public function get PaymentEntryTypeName():String
		{
			return _PaymentEntryTypeName;
		}

		public function set PaymentEntryTypeName(value:String):void
		{
			_PaymentEntryTypeName = value;
		}

		public function get PaymentEntryTypeID():String
		{
			return _PaymentEntryTypeID;
		}

		public function set PaymentEntryTypeID(value:String):void
		{
			_PaymentEntryTypeID = value;
		}

		public function get InsOrganizationID():String
		{
			return _InsuranceOrganizationID;
		}

		public function set InsOrganizationID(value:String):void
		{
			_InsuranceOrganizationID = value;
		}

		public function get ClaimID():String
		{
			return _ClaimID;
		}

		public function set ClaimID(value:String):void
		{
			_ClaimID = value;
		}

		public function get ClaimPaymentID():String
		{
			return _ClaimPaymentID;
		}

		public function set ClaimPaymentID(value:String):void
		{
			_ClaimPaymentID = value;
		}

	}
}