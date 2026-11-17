package com.gazuntite.provider.live.services.billing.dto.report
{
	import com.gazuntite.common.util.xml.XmlConstants;
	import com.gazuntite.common.util.xml.XmlUtils;
	import com.gazuntite.utils.UtilityFunctions;

	public class PaymentClaimDTO
	{
		private var _PaymentClaimID:String;
		private var _PaymentTransactionID:String;
		private var _ClaimID:String;
		private var _ICN:String;
		private var _VisitDate:String;
		private var _Charges:String;
		private var _Payments:String;
		private var _PatientResponsibility:String;
		private var _PatientFirstName:String;
		private var _PatientLastName:String;
		private var _ServiceTypeID:String;
		private var _ServiceTypeCode:String;
		private var _POSDescription:String;
		private var _Patient:String;
		private var _CrossoverCarrierName:String;
		
		

		public function get CrossoverCarrierName():String
		{
			return _CrossoverCarrierName;
		}

		public function set CrossoverCarrierName(value:String):void
		{
			_CrossoverCarrierName = value;
		}

		public function FromXML( x:XML ):void
		{
			
			PaymentClaimID				=  x.@[XmlConstants.PAYMENTCLAIMID];
			PaymentTransactionID		=  x.@[XmlConstants.PAYMENTTRANSACTIONID];
			ClaimID				 		=  x.@[XmlConstants.CLAIMID];
			ICN				 			=  x.@[XmlConstants.ICN];
			VisitDate					=  x.@[XmlConstants.VISITDATE];
			Charges						=  x.@[XmlConstants.CHARGES];
			Payments				 	=  x.@[XmlConstants.PAYMENTS];
			PatientResponsibility		=  x.@[XmlConstants.PATIENTRESPONSIBILITY];
			PatientFirstName			=  x.@[XmlConstants.PATIENTFIRSTNAME];
			PatientLastName				=  x.@[XmlConstants.PATIENTLASTNAME];
			ServiceTypeID				=  x.@[XmlConstants.SERVICETYPEID];
			ServiceTypeCode				=  x.@[XmlConstants.POSCODE];
			CrossoverCarrierName		=  x.@[XmlConstants.CROSSOVERCARRIERNAME];
			POSDescription				=  x.@[XmlConstants.POSDESCRIPTION];
			Patient 					=  PatientFirstName + " " + PatientLastName;
			
		}
		public function ToXML():XML
		{
			var x:XML = XmlUtils.getNodeByTagName("PaymentClaim");
			
			x.@[XmlConstants.PAYMENTCLAIMID]		    = PaymentClaimID;
			x.@[XmlConstants.PAYMENTTRANSACTIONID]		= PaymentTransactionID;
			x.@[XmlConstants.CLAIMID]					= ClaimID;
			x.@[XmlConstants.ICN]						= ICN;
			x.@[XmlConstants.VISITDATE]					= UtilityFunctions.FormatDate(VisitDate);
			x.@[XmlConstants.CHARGES]					= Charges;
			x.@[XmlConstants.PAYMENTS]					= Payments;
			x.@[XmlConstants.PATIENTRESPONSIBILITY]		= PatientResponsibility;
			x.@[XmlConstants.PATIENTFIRSTNAME]			= PatientFirstName;
			x.@[XmlConstants.PATIENTLASTNAME]			= PatientLastName;
			x.@[XmlConstants.SERVICETYPEID]				= ServiceTypeID;
			x.@[XmlConstants.POSCODE]					= ServiceTypeCode;
			x.@[XmlConstants.CROSSOVERCARRIERNAME]		= CrossoverCarrierName;
			x.@[XmlConstants.POSDESCRIPTION]			= POSDescription;
			
			return x;
		}
		
		public function get ICN():String
		{
			return _ICN;
		}
		
		public function set ICN(value:String):void
		{
			_ICN = value;
		}
		
		public function get Patient():String
		{
			return _Patient;
		}
		
		public function set Patient(value:String):void
		{
			_Patient = value;
		}
		
		
		public function get POSDescription():String
		{
			return _POSDescription;
		}

		public function set POSDescription(value:String):void
		{
			_POSDescription = value;
		}

		public function get ServiceTypeID():String
		{
			return _ServiceTypeID;
		}

		public function set ServiceTypeID(value:String):void
		{
			_ServiceTypeID = value;
		}

		public function get ServiceTypeCode():String
		{
			return _ServiceTypeCode;
		}

		public function set ServiceTypeCode(value:String):void
		{
			_ServiceTypeCode = value;
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
		
		public function get PatientResponsibility():String
		{
			return _PatientResponsibility;
		}

		public function set PatientResponsibility(value:String):void
		{
			_PatientResponsibility = String(Number(value).toFixed(2));
		}

		public function get Payments():String
		{
			return _Payments;
		}

		public function set Payments(value:String):void
		{
			_Payments = String(Number(value).toFixed(2));
		}

		public function get Charges():String
		{
			return _Charges;
		}

		public function set Charges(value:String):void
		{
			_Charges = String(Number(value).toFixed(2));
		}

		public function get VisitDate():String
		{
			return _VisitDate;
		}

		public function set VisitDate(value:String):void
		{
			_VisitDate = UtilityFunctions.FormatDate(value.substring(0,10),"MM/DD/YYYY");
		}

		public function get ClaimID():String
		{
			return _ClaimID;
		}

		public function set ClaimID(value:String):void
		{
			_ClaimID = value;
		}

		public function get PaymentTransactionID():String
		{
			return _PaymentTransactionID;
		}

		public function set PaymentTransactionID(value:String):void
		{
			_PaymentTransactionID = value;
		}

		public function get PaymentClaimID():String
		{
			return _PaymentClaimID;
		}

		public function set PaymentClaimID(value:String):void
		{
			_PaymentClaimID = value;
		}

	}
}