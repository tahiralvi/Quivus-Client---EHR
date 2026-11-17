package com.gazuntite.provider.live.services.billing.dto.accountsAndReceiveables
{
	import com.gazuntite.common.util.xml.XmlConstants;
	import com.gazuntite.common.util.xml.XmlUtils;

	public class StatementPatientDetailDTO
	{
		private var _PatientID:String;
		private var _GAXENID:String;
		private var _AccountTotals:String;
		private var _InsuranceBilled:String;
		private var _InsurancePaid:String;
		private var _PatientPaid:String;
		private var _TotalPaid:String;
		private var _TotalDue:String;
		private var _SubmissionCount:String;
		private var _LastSubmissionDate:String;
				
		public function get SubmissionCount():String
		{
			return _SubmissionCount;
		}

		public function set SubmissionCount(value:String):void
		{
			_SubmissionCount = value;
		}

		public function FromXML(x:XML):void
		{
			
			PatientID 				= x.@[XmlConstants.PATIENTID];
			GAXENID 				= x.@[XmlConstants.GAXENID];
			AccountTotals 			= x.@[XmlConstants.ACCOUNTTOTALS];
			InsuranceBilled  		= x.@[XmlConstants.INSURANCEBILLED];
			InsurancePaid 			= x.@[XmlConstants.INSURANCEPAID];
			PatientPaid 			= x.@[XmlConstants.PATIENTPAID];
			TotalPaid 				= x.@[XmlConstants.TOTALPAID];			
			TotalDue 				= x.@[XmlConstants.TOTALDUE];	
			SubmissionCount			= x.@[XmlConstants.SUBMISSIONCOUNT];
			LastSubmissionDate		= x.@[XmlConstants.LASTSUBMISSIONDATE];
				
		}
		
		public function ToXML():XML
		{
			var x:XML =  XmlUtils.getNodeByTagName( "StatementPatient" );
			
			x.@[XmlConstants.PATIENTID]			=   PatientID;
			x.@[XmlConstants.GAXENID]			=	GAXENID;
			x.@[XmlConstants.ACCOUNTTOTALS]		=	AccountTotals;
			x.@[XmlConstants.INSURANCEBILLED]	=	InsuranceBilled;
			x.@[XmlConstants.INSURANCEPAID]		=	InsurancePaid;
			x.@[XmlConstants.PATIENTPAID]		=   PatientPaid;
			x.@[XmlConstants.TOTALPAID]			=	TotalPaid;			
			x.@[XmlConstants.TOTALDUE]			=	TotalDue;	
			
			if(SubmissionCount == null || SubmissionCount == "")
				SubmissionCount = "0";	
			
			x.@[XmlConstants.SUBMISSIONCOUNT]	=	SubmissionCount;
			x.@[XmlConstants.LASTSUBMISSIONDATE]=	LastSubmissionDate;
			
			return x;			
		}
		
		public function get LastSubmissionDate():String
		{
			return _LastSubmissionDate;
		}
		
		public function set LastSubmissionDate(value:String):void
		{
			_LastSubmissionDate = value;
		}	
		
		
		public function get PatientID():String
		{
			return _PatientID;
		}

		public function set PatientID(value:String):void
		{
			_PatientID = value;
		}

		public function get GAXENID():String
		{
			return _GAXENID;
		}

		public function set GAXENID(value:String):void
		{
			_GAXENID = value;
		}

		public function get AccountTotals():String
		{
			return _AccountTotals;
		}

		public function set AccountTotals(value:String):void
		{
			_AccountTotals = value;
		}

		public function get InsuranceBilled():String
		{
			return _InsuranceBilled;
		}

		public function set InsuranceBilled(value:String):void
		{
			_InsuranceBilled = value;
		}

		public function get InsurancePaid():String
		{
			return _InsurancePaid;
		}

		public function set InsurancePaid(value:String):void
		{
			_InsurancePaid = value;
		}

		public function get PatientPaid():String
		{
			return _PatientPaid;
		}

		public function set PatientPaid(value:String):void
		{
			_PatientPaid = value;
		}

		public function get TotalPaid():String
		{
			return _TotalPaid;
		}

		public function set TotalPaid(value:String):void
		{
			_TotalPaid = value;
		}

		public function get TotalDue():String
		{
			return _TotalDue;
		}

		public function set TotalDue(value:String):void
		{
			_TotalDue = value;
		}

	}
}