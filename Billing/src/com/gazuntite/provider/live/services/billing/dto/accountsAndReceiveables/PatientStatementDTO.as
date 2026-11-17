package com.gazuntite.provider.live.services.billing.dto.accountsAndReceiveables
{
	import com.gazuntite.common.util.xml.XmlConstants;
	import com.gazuntite.common.util.xml.XmlUtils;
	import com.gazuntite.provider.live.services.billing.dto.SuperBill.SuperBillProcedureInfoDTO;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;

	public class PatientStatementDTO
	{
		private var _SNo:String;
		private var _ClaimID:String;
		private var _VisitID:String;
		private var _VisitDate:String;
		private var _PatientID:String;
		private var _GAXENID:String;
		private var _Status:String;
		private var _Media:String;
		private var _BatchNumber:String;
		private var _BillDate:String;
		private var _ProviderId:String;
		private var _DateCreated:String;
		private var _PatientUserId:String;
		private var _PatientFirstName:String;
		private var _PatientLastName:String;
		private var _PatientAddress:String;
		private var _PatientCity:String;
		private var _PatientState:String;
		private var _PatientZIP:String;
		private var _PatientPhone:String;
		private var _PatientGuarantorID:String;
		private var _GuarantorFirstName:String;
		private var _GuarantorLastName:String;
		private var _GuarantorAddress:String;
		private var _GuarantorCity:String;
		private var _GuarantorState:String;
		private var _GuarantorZIP:String;
		private var _GuarantorPhone:String;
		private var _StatementTypeID:String;
		private var _StatementTypeName:String;
		private var _Remainder:String;
		private var _Balance:String;
		private var _ClinicBranchId:String;
		private var _BranchName:String;
		private var _BranchAddress:String;
		private var _BranchCity:String;
		private var _BranchState:String;
		private var _BranchZIP:String;
		private var _BranchURL:String;
		private var _BranchPhone:String;
		private var _Guarantor:String;
		private var _Phone:String;
		private var _SubmissionCount:String;
		private var _LastSubmissionDate:String;
		private var _Procedures:ArrayCollection;
		
		
		public function get LastSubmissionDate():String
		{
			return _LastSubmissionDate;
		}

		public function set LastSubmissionDate(value:String):void
		{
			_LastSubmissionDate = value;
		}

		public function get SubmissionCount():String
		{
			return _SubmissionCount;
		}

		public function set SubmissionCount(value:String):void
		{
			_SubmissionCount = value;
		}

		public function get VisitDate():String
		{
			return _VisitDate;
		}

		public function set VisitDate(value:String):void
		{
			_VisitDate = UtilityFunctions.FormatDate(value,"MM/DD/YYYY");
		}

		public function get Phone():String
		{
			return _Phone;
		}

		public function set Phone(value:String):void
		{
			_Phone = value;
		}

		public function get Guarantor():String
		{
			return _Guarantor;
		}

		public function set Guarantor(value:String):void
		{
			_Guarantor = value;
		}

		public function FromXML(x:XML):void
		{
			SNo  					= x.@[XmlConstants.SNO];
			ClaimID  				= x.@[XmlConstants.CLAIMID];
			VisitID  				= x.@[XmlConstants.VISITID];
			VisitDate  				= x.@[XmlConstants.VISITDATE];
			PatientID 				= x.@[XmlConstants.PATIENTID];
			GAXENID 				= x.@[XmlConstants.GAXENID];
			Status 					= x.@[XmlConstants.STATUS];
			Media  					= x.@[XmlConstants.MEDIA];
			BatchNumber 			= x.@[XmlConstants.BATCHNUMBER];
			BillDate 				= x.@[XmlConstants.BILLDATE];
			ProviderId 				= x.@[XmlConstants.PROVIDERID];
			DateCreated 			= x.@[XmlConstants.DATECREATED];
			PatientUserId  			= x.@[XmlConstants.PATIENTUSERID];
			PatientFirstName		= x.@[XmlConstants.PATIENTFIRSTNAME];
			PatientLastName			= x.@[XmlConstants.PATIENTLASTNAME];
			PatientAddress			= x.@[XmlConstants.PATIENTADDRESS];
			PatientCity				= x.@[XmlConstants.PATIENTCITY];
			PatientState			= x.@[XmlConstants.PATIENTSTATE];
			PatientZIP				= x.@[XmlConstants.PATIENTZIP];
			PatientPhone			= x.@[XmlConstants.PATIENTPHONE];
			PatientGuarantorID		= x.@[XmlConstants.PATIENTGUARANTORID];
			GuarantorFirstName		= x.@[XmlConstants.GUARANTORFIRSTNAME];
			GuarantorLastName		= x.@[XmlConstants.GUARANTORLASTNAME];			
			GuarantorAddress		= x.@[XmlConstants.GUARANTORADDRESS];
			GuarantorCity			= x.@[XmlConstants.GUARANTORCITY];
			GuarantorState			= x.@[XmlConstants.GUARANTORSTATE];
			GuarantorZIP			= x.@[XmlConstants.GUARANTORZIP];
			GuarantorPhone			= x.@[XmlConstants.GUARANTORPHONE];
			StatementTypeID			= x.@[XmlConstants.STATEMENTTYPEID];
			StatementTypeName		= x.@[XmlConstants.STATEMENTTYPENAME];
			Remainder				= x.@[XmlConstants.REMAINDER];
			Balance					= x.@[XmlConstants.BALANCE];
			ClinicBranchId			= x.@[XmlConstants.CLINICBRANCHID];
			BranchName				= x.@[XmlConstants.BRANCHNAME];
			BranchAddress			= x.@[XmlConstants.BRANCHADDRESS];
			BranchCity				= x.@[XmlConstants.BRANCHCITY];
			BranchState				= x.@[XmlConstants.BRANCHSTATE];
			BranchZIP				= x.@[XmlConstants.BRANCHZIP];
			BranchURL				= x.@[XmlConstants.BRANCHURL];
			BranchPhone				= x.@[XmlConstants.BRANCHPHONE];
			SubmissionCount			= x.@[XmlConstants.SUBMISSIONCOUNT];
			LastSubmissionDate		= x.@[XmlConstants.LASTSUBMISSIONDATE];
			
			if(UtilityFunctions.IsNotNullOrEmpty(GuarantorFirstName))
			{
				Guarantor = GuarantorFirstName + " " + GuarantorLastName;
				Phone = GuarantorPhone;
			}
			else
			{
				Guarantor = PatientFirstName + " " + PatientLastName;
				Phone = PatientPhone;
			}
			
			Procedures = new ArrayCollection();			
			var xProcedures:XMLList = x.Procedures.Procedure;
			for(var ic:int = 0; ic < xProcedures.length(); ic++)
			{
				var cpt:SuperBillProcedureInfoDTO = new SuperBillProcedureInfoDTO();
				cpt.FromXML( xProcedures[ic] );
				Procedures.addItem(cpt);
			}	
		}
		
		public function ToXML():XML
		{
			var x:XML = XmlUtils.getNodeByTagName( "PatientStatement" );
			
			x.@[XmlConstants.SNO]				=	SNo;
			x.@[XmlConstants.CLAIMID]			=	ClaimID;
			x.@[XmlConstants.VISITID]			=	VisitID;
			x.@[XmlConstants.VISITDATE]			=	VisitDate;
			x.@[XmlConstants.PATIENTID]			=	PatientID;
			x.@[XmlConstants.GAXENID]			=	GAXENID;
			x.@[XmlConstants.STATUS]			=	Status;
			x.@[XmlConstants.MEDIA]				=	Media;
			x.@[XmlConstants.BATCHNUMBER]		=	BatchNumber;
			x.@[XmlConstants.BILLDATE]			=	BillDate;
			x.@[XmlConstants.PROVIDERID]		=	ProviderId;
			x.@[XmlConstants.DATECREATED]		=	DateCreated;
			x.@[XmlConstants.PATIENTUSERID]		=	PatientUserId;
			x.@[XmlConstants.PATIENTFIRSTNAME]	=	PatientFirstName;
			x.@[XmlConstants.PATIENTLASTNAME]	=	PatientLastName;
			x.@[XmlConstants.PATIENTADDRESS]	=	PatientAddress;
			x.@[XmlConstants.PATIENTCITY]		=	PatientCity;
			x.@[XmlConstants.PATIENTSTATE]		=	PatientState;
			x.@[XmlConstants.PATIENTZIP]		=	PatientZIP;
			x.@[XmlConstants.PATIENTPHONE]		=	PatientPhone;
			x.@[XmlConstants.PATIENTGUARANTORID]=	PatientGuarantorID;
			x.@[XmlConstants.GUARANTORFIRSTNAME]=	GuarantorFirstName;
			x.@[XmlConstants.GUARANTORLASTNAME]	=	GuarantorLastName;
			x.@[XmlConstants.GUARANTORADDRESS]	=	GuarantorAddress;
			x.@[XmlConstants.GUARANTORCITY]		=	GuarantorCity;
			x.@[XmlConstants.GUARANTORSTATE]	=	GuarantorState;
			x.@[XmlConstants.GUARANTORZIP]		=	GuarantorZIP;
			x.@[XmlConstants.GUARANTORPHONE]	=	GuarantorPhone;
			x.@[XmlConstants.STATEMENTTYPEID]	=	StatementTypeID;
			x.@[XmlConstants.STATEMENTTYPENAME]	=	StatementTypeName;
			x.@[XmlConstants.REMAINDER]			=	Remainder;
			x.@[XmlConstants.BALANCE]			=	Balance;
			x.@[XmlConstants.CLINICBRANCHID]	=	ClinicBranchId;
			x.@[XmlConstants.BRANCHNAME]		=	BranchName;
			x.@[XmlConstants.BRANCHADDRESS]		=	BranchAddress;
			x.@[XmlConstants.BRANCHCITY]		=	BranchCity;
			x.@[XmlConstants.BRANCHSTATE]		=	BranchState;
			x.@[XmlConstants.BRANCHZIP]			=	BranchZIP;
			x.@[XmlConstants.BRANCHURL]			=	BranchURL;
			x.@[XmlConstants.BRANCHPHONE]		=	BranchPhone;
			
			if(SubmissionCount == null || SubmissionCount == "")
				SubmissionCount = "0";	
			
			x.@[XmlConstants.SUBMISSIONCOUNT]	=	SubmissionCount;
			x.@[XmlConstants.LASTSUBMISSIONDATE]=	LastSubmissionDate;
			
			if(Procedures != null && Procedures.length > 0 )
			{
				var xProcedures:XML = XmlUtils.getNodeByTagName("Procedures");
				
				for(var ic:int = 0; ic < Procedures.length; ic++)
				{
					var cpt:SuperBillProcedureInfoDTO = (Procedures[ic] as SuperBillProcedureInfoDTO)
					xProcedures.appendChild(cpt.ToXML());				
				}
				
				x.appendChild(xProcedures);
			}
			return x;
		}
		
		public function get SNo():String
		{
			return _SNo;
		}

		public function set SNo(value:String):void
		{
			_SNo = value;
		}

		public function get ClaimID():String
		{
			return _ClaimID;
		}

		public function set ClaimID(value:String):void
		{
			_ClaimID = value;
		}

		public function get VisitID():String
		{
			return _VisitID;
		}

		public function set VisitID(value:String):void
		{
			_VisitID = value;
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

		public function get Status():String
		{
			return _Status;
		}

		public function set Status(value:String):void
		{
			_Status = value;
		}

		public function get Media():String
		{
			return _Media;
		}

		public function set Media(value:String):void
		{
			_Media = value;
		}

		public function get BatchNumber():String
		{
			return _BatchNumber;
		}

		public function set BatchNumber(value:String):void
		{
			_BatchNumber = value;
		}

		public function get BillDate():String
		{
			return _BillDate;
		}

		public function set BillDate(value:String):void
		{
			_BillDate = value;
		}

		public function get ProviderId():String
		{
			return _ProviderId;
		}

		public function set ProviderId(value:String):void
		{
			_ProviderId = value;
		}

		public function get DateCreated():String
		{
			return _DateCreated;
		}

		public function set DateCreated(value:String):void
		{
			_DateCreated = value;
		}

		public function get PatientUserId():String
		{
			return _PatientUserId;
		}

		public function set PatientUserId(value:String):void
		{
			_PatientUserId = value;
		}

		public function get PatientFirstName():String
		{
			return _PatientFirstName;
		}

		public function set PatientFirstName(value:String):void
		{
			_PatientFirstName = value;
		}

		public function get PatientLastName():String
		{
			return _PatientLastName;
		}

		public function set PatientLastName(value:String):void
		{
			_PatientLastName = value;
		}

		public function get PatientAddress():String
		{
			return _PatientAddress;
		}

		public function set PatientAddress(value:String):void
		{
			_PatientAddress = value;
		}

		public function get PatientCity():String
		{
			return _PatientCity;
		}

		public function set PatientCity(value:String):void
		{
			_PatientCity = value;
		}

		public function get PatientState():String
		{
			return _PatientState;
		}

		public function set PatientState(value:String):void
		{
			_PatientState = value;
		}

		public function get PatientZIP():String
		{
			return _PatientZIP;
		}

		public function set PatientZIP(value:String):void
		{
			_PatientZIP = value;
		}

		public function get PatientPhone():String
		{
			return _PatientPhone;
		}

		public function set PatientPhone(value:String):void
		{
			_PatientPhone = value;
		}

		public function get PatientGuarantorID():String
		{
			return _PatientGuarantorID;
		}

		public function set PatientGuarantorID(value:String):void
		{
			_PatientGuarantorID = value;
		}

		public function get GuarantorFirstName():String
		{
			return _GuarantorFirstName;
		}

		public function set GuarantorFirstName(value:String):void
		{
			_GuarantorFirstName = value;
		}

		public function get GuarantorLastName():String
		{
			return _GuarantorLastName;
		}

		public function set GuarantorLastName(value:String):void
		{
			_GuarantorLastName = value;
		}

		public function get GuarantorAddress():String
		{
			return _GuarantorAddress;
		}

		public function set GuarantorAddress(value:String):void
		{
			_GuarantorAddress = value;
		}

		public function get GuarantorCity():String
		{
			return _GuarantorCity;
		}

		public function set GuarantorCity(value:String):void
		{
			_GuarantorCity = value;
		}

		public function get GuarantorState():String
		{
			return _GuarantorState;
		}

		public function set GuarantorState(value:String):void
		{
			_GuarantorState = value;
		}

		public function get GuarantorZIP():String
		{
			return _GuarantorZIP;
		}

		public function set GuarantorZIP(value:String):void
		{
			_GuarantorZIP = value;
		}

		public function get GuarantorPhone():String
		{
			return _GuarantorPhone;
		}

		public function set GuarantorPhone(value:String):void
		{
			_GuarantorPhone = value;
		}

		public function get StatementTypeID():String
		{
			return _StatementTypeID;
		}

		public function set StatementTypeID(value:String):void
		{
			_StatementTypeID = value;
		}

		public function get StatementTypeName():String
		{
			return _StatementTypeName;
		}

		public function set StatementTypeName(value:String):void
		{
			_StatementTypeName = value;
		}

		public function get Remainder():String
		{
			return _Remainder;
		}

		public function set Remainder(value:String):void
		{
			_Remainder = value;
		}

		public function get Balance():String
		{
			return _Balance;
		}

		public function set Balance(value:String):void
		{
			_Balance = value;
		}

		public function get ClinicBranchId():String
		{
			return _ClinicBranchId;
		}

		public function set ClinicBranchId(value:String):void
		{
			_ClinicBranchId = value;
		}

		public function get BranchName():String
		{
			return _BranchName;
		}

		public function set BranchName(value:String):void
		{
			_BranchName = value;
		}

		public function get BranchAddress():String
		{
			return _BranchAddress;
		}

		public function set BranchAddress(value:String):void
		{
			_BranchAddress = value;
		}

		public function get BranchCity():String
		{
			return _BranchCity;
		}

		public function set BranchCity(value:String):void
		{
			_BranchCity = value;
		}

		public function get BranchState():String
		{
			return _BranchState;
		}

		public function set BranchState(value:String):void
		{
			_BranchState = value;
		}

		public function get BranchZIP():String
		{
			return _BranchZIP;
		}

		public function set BranchZIP(value:String):void
		{
			_BranchZIP = value;
		}

		public function get BranchURL():String
		{
			return _BranchURL;
		}

		public function set BranchURL(value:String):void
		{
			_BranchURL = value;
		}

		public function get BranchPhone():String
		{
			return _BranchPhone;
		}

		public function set BranchPhone(value:String):void
		{
			_BranchPhone = value;
		}

		public function get Procedures():ArrayCollection
		{
			return _Procedures;
		}

		public function set Procedures(value:ArrayCollection):void
		{
			_Procedures = value;
		}

	}
}