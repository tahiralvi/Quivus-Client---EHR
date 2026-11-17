package com.gazuntite.provider.live.services.billing.dto.accountsAndReceiveables
{
	import com.gazuntite.common.util.xml.XmlConstants;
	import com.gazuntite.provider.live.services.billing.dto.SuperBill.SuperBillDiagnosisInfoDTO;
	import com.gazuntite.provider.live.services.billing.dto.SuperBill.SuperBillProcedureInfoDTO;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;

	public class AccountClaimDTO
	{
		private var _ClaimID:String;
		private var _VisitID:String;
		private var _VisitDate:String;
		private var _PrimaryStatus:String;
		private var _SecondaryStatus:String;
		private var _TertiaryStatus:String;
		private var _ProviderName:String;
		private var _DateCreated:String;
		private var _Note:String;
		private var _TotalCharges:String;
		private var _PrimaryPayment:String;
		private var _SecondaryPayment:String;
		private var _TertiaryPayment:String;
		private var _PatientPayment:String;
		private var _TotalPaidAmount:String;
		private var _TotalAdjustment:String;
		private var _DueAmount:String;
		private var _PlaceOfServiceCode:String;
		
		private var _ClaimDiagnoses:ArrayCollection;
		private var _ClaimCharges:ArrayCollection;
		private var _ClaimPayments:ArrayCollection;

		public function FromXML(x:XML):void
		{
			ClaimID  				= x.@[XmlConstants.CLAIMID];
			VisitID  				= x.@[XmlConstants.VISITID];
			VisitDate  				= x.@[XmlConstants.VISITDATE];
			PrimaryStatus 			= x.@[XmlConstants.PRIMARYSTATUS];
			SecondaryStatus 		= x.@[XmlConstants.SECONDARYSTATUS];
			TertiaryStatus 			= x.@[XmlConstants.TERTIARYSTATUS];
			ProviderName  			= x.@[XmlConstants.PROVIDERNAME];
			DateCreated 			= x.@[XmlConstants.DATECREATED];
			Note 					= x.@[XmlConstants.NOTE];
			TotalCharges 			= x.@[XmlConstants.TOTALCHARGES];
			PrimaryPayment 			= x.@[XmlConstants.PRIMARYPAYMENT];
			SecondaryPayment 		= x.@[XmlConstants.SECONDARYPAYMENT];
			TertiaryPayment 		= x.@[XmlConstants.TERTIARYPAYMENT];
			PatientPayment 			= x.@[XmlConstants.PATIENTPAYMENT];
			TotalPaidAmount 		= x.@[XmlConstants.TOTALPAIDAMOUNT];
			TotalAdjustment 		= x.@[XmlConstants.TOTALADJUSTMENT];
			DueAmount 				= x.@[XmlConstants.DUEAMOUNT];
			PlaceOfServiceCode 		= x.@[XmlConstants.PLACEOFSERVICECODE];
			TotalAdjustment 		= x.@[XmlConstants.TOTALADJUSTMENT];
			DueAmount 				= x.@[XmlConstants.DUEAMOUNT];
						
			ClaimDiagnoses = new ArrayCollection();			
			var xDiagnoses:XMLList = x.ClaimDiagnoses.Diagnosis;
			for(var i:int = 0; i < xDiagnoses.length(); i++)
			{
				var dtod:SuperBillDiagnosisInfoDTO = new SuperBillDiagnosisInfoDTO();
				dtod.FromXML( xDiagnoses[i] );
				ClaimDiagnoses.addItem(dtod);
			}	
			
			ClaimCharges = new ArrayCollection();			
			var xCharges:XMLList = x.ClaimCharges.Procedure;
			for(var ic:int = 0; ic < xCharges.length(); ic++)
			{
				var dtoc:SuperBillProcedureInfoDTO = new SuperBillProcedureInfoDTO();
				dtoc.FromXML( xCharges[ic] );
				ClaimCharges.addItem(dtoc);
			}
			
			ClaimPayments = new ArrayCollection();			
			var xPayments:XMLList = x.ClaimPayments.ClaimPayment;
			for(var ip:int = 0; ip < xPayments.length(); ip++)
			{
				var dtop:ClaimPaymentDTO = new ClaimPaymentDTO();
				dtop.FromXML( xPayments[ip] );
				ClaimPayments.addItem(dtop);
			}
			
		}	
		
		public function get ClaimPayments():ArrayCollection
		{
			return _ClaimPayments;
		}

		public function set ClaimPayments(value:ArrayCollection):void
		{
			_ClaimPayments = value;
		}

		public function get ClaimCharges():ArrayCollection
		{
			return _ClaimCharges;
		}

		public function set ClaimCharges(value:ArrayCollection):void
		{
			_ClaimCharges = value;
		}

		public function get ClaimDiagnoses():ArrayCollection
		{
			return _ClaimDiagnoses;
		}

		public function set ClaimDiagnoses(value:ArrayCollection):void
		{
			_ClaimDiagnoses = value;
		}

		public function get PlaceOfServiceCode():String
		{
			return _PlaceOfServiceCode;
		}

		public function set PlaceOfServiceCode(value:String):void
		{
			_PlaceOfServiceCode = value;
		}

		public function get DueAmount():String
		{
			return _DueAmount;
		}

		public function set DueAmount(value:String):void
		{
			_DueAmount = String(Number(value).toFixed(2));
		}

		public function get TotalAdjustment():String
		{
			return _TotalAdjustment;
		}

		public function set TotalAdjustment(value:String):void
		{
			_TotalAdjustment = String(Number(value).toFixed(2));
		}

		public function get TotalPaidAmount():String
		{
			return _TotalPaidAmount;
		}

		public function set TotalPaidAmount(value:String):void
		{
			_TotalPaidAmount = String(Number(value).toFixed(2));
		}

		public function get PatientPayment():String
		{
			return _PatientPayment;
		}

		public function set PatientPayment(value:String):void
		{
			_PatientPayment = String(Number(value).toFixed(2));
		}

		public function get TertiaryPayment():String
		{
			return _TertiaryPayment;
		}

		public function set TertiaryPayment(value:String):void
		{
			_TertiaryPayment = String(Number(value).toFixed(2));
		}

		public function get SecondaryPayment():String
		{
			return _SecondaryPayment;
		}

		public function set SecondaryPayment(value:String):void
		{
			_SecondaryPayment = String(Number(value).toFixed(2));
		}

		public function get PrimaryPayment():String
		{
			return _PrimaryPayment;
		}

		public function set PrimaryPayment(value:String):void
		{
			_PrimaryPayment = String(Number(value).toFixed(2));
		}

		public function get TotalCharges():String
		{
			return _TotalCharges;
		}

		public function set TotalCharges(value:String):void
		{
			_TotalCharges = String(Number(value).toFixed(2));
		}

		public function get Note():String
		{
			return _Note;
		}

		public function set Note(value:String):void
		{
			_Note = value;
		}

		public function get DateCreated():String
		{
			return _DateCreated;
		}

		public function set DateCreated(value:String):void
		{
			_DateCreated = value;
		}

		public function get ProviderName():String
		{
			return _ProviderName;
		}

		public function set ProviderName(value:String):void
		{
			_ProviderName = value;
		}

		public function get TertiaryStatus():String
		{
			return _TertiaryStatus;
		}

		public function set TertiaryStatus(value:String):void
		{
			_TertiaryStatus = value;
		}

		public function get SecondaryStatus():String
		{
			return _SecondaryStatus;
		}

		public function set SecondaryStatus(value:String):void
		{
			_SecondaryStatus = value;
		}

		public function get PrimaryStatus():String
		{
			return _PrimaryStatus;
		}

		public function set PrimaryStatus(value:String):void
		{
			_PrimaryStatus = value;
		}

		public function get VisitDate():String
		{
			return _VisitDate;
		}

		public function set VisitDate(value:String):void
		{
			_VisitDate = UtilityFunctions.FormatDate(value.substring(0,10) ,"MM/DD/YYYY");
		}

		public function get VisitID():String
		{
			return _VisitID;
		}

		public function set VisitID(value:String):void
		{
			_VisitID = value;
		}

		public function get ClaimID():String
		{
			return _ClaimID;
		}

		public function set ClaimID(value:String):void
		{
			_ClaimID = value;
		}

	}
}