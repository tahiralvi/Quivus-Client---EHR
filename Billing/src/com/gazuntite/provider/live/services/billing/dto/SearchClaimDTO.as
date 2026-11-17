package com.gazuntite.provider.live.services.billing.dto
{
	import com.gazuntite.common.util.xml.XmlConstants;
	import com.gazuntite.provider.live.services.billing.dto.ClaimManagement.CarrierDTO;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class SearchClaimDTO
	{
		private var m_oClaimTransactions:ArrayCollection;
		
		private var m_sClaimID:String;
		private var m_sPatientID:String;
		private var m_sVisitID:String;
		private var m_sPatientName:String;
		private var m_sQuivusID:String;
		private var m_sCarrier1:String;
		private var m_sStatus1:String;
		private var m_sMedia1:String;
		private var m_sBatch1:String;
		private var m_sBillDate1:String;
		private var m_sEDIReceiver1:String;		
		private var m_sCarrier2:String;
		private var m_sStatus2:String;
		private var m_sMedia2:String;
		private var m_sBatch2:String;
		private var m_sBillDate2:String;
		private var m_sEDIReceiver2:String;		
		private var m_sCarrier3:String;
		private var m_sStatus3:String;
		private var m_sMedia3:String;
		private var m_sBatch3:String;
		private var m_sBillDate3:String;
		private var m_sEDIReceiver3:String;	
		
		private var _PatientStatus:String;
		private var _PatientMedia:String;
		private var _PatientBatch:String;
		private var _PatientBillDate:String;
		
		private var m_sProviderId:String;
		private var m_sProviderName:String;
		private var m_sDateCreated:String;
		private var m_sNote:String;
		
		private var m_oCarrierInfo:ArrayCollection;
		
		public function get PatientBillDate():String
		{
			return _PatientBillDate;
		}

		public function set PatientBillDate(value:String):void
		{
			_PatientBillDate = value;
		}

		public function get PatientBatch():String
		{
			return _PatientBatch;
		}

		public function set PatientBatch(value:String):void
		{
			_PatientBatch = value;
		}

		public function get PatientMedia():String
		{
			return _PatientMedia;
		}

		public function set PatientMedia(value:String):void
		{
			_PatientMedia = value;
		}

		public function get PatientStatus():String
		{
			return _PatientStatus;
		}

		public function set PatientStatus(value:String):void
		{
			_PatientStatus = value;
		}

		public function get CarrierInfo():ArrayCollection
		{
			return m_oCarrierInfo;
		}
		
		public function set CarrierInfo(value:ArrayCollection):void
		{
			m_oCarrierInfo = value;
		}
		
		public function SearchClaimDTO()
		{
			ClaimTransactions = new ArrayCollection();
		}
		
		public function get ClaimTransactions():ArrayCollection
		{
			return m_oClaimTransactions;
		}
		
		public function set ClaimTransactions(value:ArrayCollection):void
		{
			m_oClaimTransactions = value;
		}
		
		private var m_sVisitDate:String;
		
		public function get VisitDate():String
		{
			return m_sVisitDate;
		}
		
		public function set VisitDate(value:String):void
		{			
			value = UtilityFunctions.FormatDate(value.substr(0,10),"MM/DD/YYYY");
			m_sVisitDate = value;
		}
		
		private var m_sSNo:String;
		
		public function get SNo():String
		{
			return m_sSNo;
		}
		
		public function set SNo(value:String):void
		{
			m_sSNo = value;
		}
		
		public function FromXML( x:XML ):void
		{
			SNo					= x.@[XmlConstants.SNO];
			ClaimID 			= x.@[XmlConstants.CLAIMID];
			PatientID 			= x.@[XmlConstants.PATIENTID];
			VisitID 			= x.@[XmlConstants.VISITID];
			VisitDate 			= x.@[XmlConstants.VISITDATE];
			PatientName 		= x.@[XmlConstants.PAIENTNAME];
			QuivusID 			= x.@[XmlConstants.QUIVUSID];			
			Carrier1 			= x.@[XmlConstants.CARRIER1];
			Status1 			= x.@[XmlConstants.STATUS1];
			Media1				= x.@[XmlConstants.MEDIA1];
			Batch1				= x.@[XmlConstants.BATCH1];
			BillDate1  			= x.@[XmlConstants.BILLDATE1];
			EDIReceiver1  		= x.@[XmlConstants.EDIRECEIVER1];
			
			Carrier2 			= x.@[XmlConstants.CARRIER2];
			Status2 			= x.@[XmlConstants.STATUS2];
			Media2				= x.@[XmlConstants.MEDIA2];
			Batch2				= x.@[XmlConstants.BATCH2];
			BillDate2  			= x.@[XmlConstants.BILLDATE2];
			EDIReceiver2  		= x.@[XmlConstants.EDIRECEIVER2];
			
			Carrier3 			= x.@[XmlConstants.CARRIER3];
			Status3 			= x.@[XmlConstants.STATUS3];
			Media3				= x.@[XmlConstants.MEDIA3];
			Batch3				= x.@[XmlConstants.BATCH3];
			BillDate3  			= x.@[XmlConstants.BILLDATE3];
			EDIReceiver3  		= x.@[XmlConstants.EDIRECEIVER3];
			
			PatientStatus  		= x.@[XmlConstants.PATIENTSTATUS];
			PatientMedia  		= x.@[XmlConstants.PATIENTMEDIA];
			PatientBatch  		= x.@[XmlConstants.PATIENTBATCH];
			PatientBillDate  	= x.@[XmlConstants.PATIENTBILLDATE];
			
			ProviderId			= x.@[XmlConstants.PROVIDERID];
			ProviderName		= x.@[XmlConstants.PROVIDERNAME];
			DateCreated			= x.@[XmlConstants.DATECREATED];	
			Note				= x.@[XmlConstants.NOTE];
			
			CarrierInfo = new ArrayCollection();			
			var xCarriers:XMLList = x.Carriers.Carrier;
			var ic:int = 0;
			for(ic = 0; ic < xCarriers.length(); ic++)
			{
				var crd:CarrierDTO = new CarrierDTO();
				crd.FromXML( xCarriers[ic][0] );
				CarrierInfo.addItem(crd);
			}
			
			/*var xClaimTransactions:XMLList = x.ClaimTransactions.Transaction;
			var i:int = 0;					
			for( i = 0; i < xClaimTransactions.length(); i++ )
			{
				var ct:ClaimTransactionDTO = new ClaimTransactionDTO();
				ct.FromXML( xClaimTransactions[i][0] );
				ClaimTransactions.addItem( ct );
			}*/
			
		}
		
		public function ToXML():XML
		{
			var x:XML = super.ToXML();
			
			x.@[XmlConstants.CLAIMID]		=		ClaimID;
			x.@[XmlConstants.PATIENTID]		=		PatientID;
			x.@[XmlConstants.VISITID]		=		VisitID;
			x.@[XmlConstants.PAIENTNAME]		=		PatientName;
			x.@[XmlConstants.QUIVUSID]		=		QuivusID 			
			
			x.@[XmlConstants.CARRIER1]		=		Carrier1;
			x.@[XmlConstants.STATUS1]		=		Status1;
			x.@[XmlConstants.MEDIA1]			=		Media1;
			x.@[XmlConstants.BATCH1]			=		Batch1;
			x.@[XmlConstants.BILLDATE1]		=		BillDate1;
			x.@[XmlConstants.EDIRECEIVER1]	=		EDIReceiver1;
			
			x.@[XmlConstants.CARRIER2]		=		Carrier2;
			x.@[XmlConstants.STATUS2]		=		Status2;
			x.@[XmlConstants.MEDIA2]			=		Media2;
			x.@[XmlConstants.BATCH2]			=		Batch2;
			x.@[XmlConstants.BILLDATE2]		=		BillDate2;
			x.@[XmlConstants.EDIRECEIVER2]	=		EDIReceiver2;
			
			x.@[XmlConstants.CARRIER3]		=		Carrier3;
			x.@[XmlConstants.STATUS3]		=		Status3;
			x.@[XmlConstants.MEDIA3]			=		Media3;
			x.@[XmlConstants.BATCH3]			=		Batch3;
			x.@[XmlConstants.BILLDATE3]		=		BillDate3;
			x.@[XmlConstants.EDIRECEIVER3]	=		EDIReceiver3;
			
			x.@[XmlConstants.PROVIDERID] 	=		ProviderId;
			x.@[XmlConstants.PROVIDERNAME]	=		ProviderName;
			x.@[XmlConstants.DATECREATED]	=		DateCreated;
			
			return x;
		}
//############## GETTER AND SETTER #####################################		
		public function get ClaimID():String
		{
			return m_sClaimID;
		}

		public function set ClaimID(value:String):void
		{
			m_sClaimID = value;
		}

		public function get PatientID():String
		{
			return m_sPatientID;
		}

		public function set PatientID(value:String):void
		{
			m_sPatientID = value;
		}
		
		public function get VisitID():String
		{
			return m_sVisitID;
		}
		
		public function set VisitID(value:String):void
		{
			m_sVisitID = value;
		}

		public function get PatientName():String
		{
			return m_sPatientName;
		}

		public function set PatientName(value:String):void
		{
			m_sPatientName = value;
		}

		public function get QuivusID():String
		{
			return m_sQuivusID;
		}

		public function set QuivusID(value:String):void
		{
			m_sQuivusID = value;
		}

		public function get Carrier1():String
		{
			return m_sCarrier1;
		}

		public function set Carrier1(value:String):void
		{
			m_sCarrier1 = value;
		}

		public function get Status1():String
		{
			return m_sStatus1;
		}

		public function set Status1(value:String):void
		{
			m_sStatus1 = value;
		}

		public function get Media1():String
		{
			return m_sMedia1;
		}

		public function set Media1(value:String):void
		{
			m_sMedia1 = value;
		}

		public function get Batch1():String
		{
			return m_sBatch1;
		}

		public function set Batch1(value:String):void
		{
			m_sBatch1 = value;
		}

		public function get BillDate1():String
		{
			return m_sBillDate1;
		}

		public function set BillDate1(value:String):void
		{
			value = value.substr(0,10);
			m_sBillDate1 = value;
		}

		public function get EDIReceiver1():String
		{
			return m_sEDIReceiver1;
		}

		public function set EDIReceiver1(value:String):void
		{
			m_sEDIReceiver1 = value;
		}
		
		public function get Carrier2():String
		{
			return m_sCarrier2;
		}
		
		public function set Carrier2(value:String):void
		{
			m_sCarrier2 = value;
		}
		
		public function get Status2():String
		{
			return m_sStatus2;
		}
		
		public function set Status2(value:String):void
		{
			m_sStatus2 = value;
		}
		
		public function get Media2():String
		{
			return m_sMedia2;
		}
		
		public function set Media2(value:String):void
		{
			m_sMedia2 = value;
		}
		
		public function get Batch2():String
		{
			return m_sBatch2;
		}
		
		public function set Batch2(value:String):void
		{
			m_sBatch2 = value;
		}
		
		public function get BillDate2():String
		{
			return m_sBillDate2;
		}
		
		public function set BillDate2(value:String):void
		{
			value = value.substr(0,10);
			m_sBillDate2 = value;
		}
		
		public function get EDIReceiver2():String
		{
			return m_sEDIReceiver2;
		}
		
		public function set EDIReceiver2(value:String):void
		{
			m_sEDIReceiver2 = value;
		}
		
		public function get Carrier3():String
		{
			return m_sCarrier3;
		}
		
		public function set Carrier3(value:String):void
		{
			m_sCarrier3 = value;
		}
		
		public function get Status3():String
		{
			return m_sStatus3;
		}
		
		public function set Status3(value:String):void
		{
			m_sStatus3 = value;
		}
		
		public function get Media3():String
		{
			return m_sMedia3;
		}
		
		public function set Media3(value:String):void
		{
			m_sMedia3 = value;
		}
		
		public function get Batch3():String
		{
			return m_sBatch3;
		}
		
		public function set Batch3(value:String):void
		{
			m_sBatch3 = value;
		}
		
		public function get BillDate3():String
		{
			return m_sBillDate3;
		}
		
		public function set BillDate3(value:String):void
		{
			value = value.substr(0,10);
			m_sBillDate3 = value;
		}
		
		public function get EDIReceiver3():String
		{
			return m_sEDIReceiver3;
		}
		
		public function set EDIReceiver3(value:String):void
		{
			m_sEDIReceiver3 = value;
		}

		public function get ProviderId():String
		{
			return m_sProviderId;
		}

		public function set ProviderId(value:String):void
		{
			m_sProviderId = value;
		}

		public function get ProviderName():String
		{
			return m_sProviderName;
		}

		public function set ProviderName(value:String):void
		{
			m_sProviderName = value;
		}

		public function get DateCreated():String
		{
			return m_sDateCreated;
		}

		public function set DateCreated(value:String):void
		{
			value = value.substr(0,10);
			m_sDateCreated = value;
		}
		
		public function get Note():String
		{
			return m_sNote;
		}
		
		public function set Note(value:String):void
		{			
			m_sNote = value;
		}
	}
}