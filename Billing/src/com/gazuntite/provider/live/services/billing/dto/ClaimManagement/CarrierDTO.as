package com.gazuntite.provider.live.services.billing.dto.ClaimManagement
{
	import com.gazuntite.common.util.xml.XmlConstants;
	import com.gazuntite.common.util.xml.XmlUtils;

	[Bindable]
	public class CarrierDTO
	{	
		private var m_sInsuranceID:String;
		private var m_sClaimID:String;
		private var m_sInsOrganizationID:String;
		private var m_sInsuranceTypeId:String;
		private var m_sStatusTypeID:String;
		private var m_sMediaTypeID:String;
		private var m_sFrequencyTypeID:String;
		private var m_sEDIReceiverTypeID:String;
		private var m_sCreatedBy:String;
		private var m_sModifiedBy:String;
		private var m_sIsDeleted:String;
		private var m_sSubmissionCount:String;
		private var m_sBillDate:String;
		private var _bAddedToClaim:Boolean;
		private var _StatementTypeID:String;
		
		public function CarrierDTO()
		{
		}
		
		public function get StatementTypeID():String
		{
			return _StatementTypeID;
		}

		public function set StatementTypeID(value:String):void
		{
			_StatementTypeID = value;
		}

		public function get isAddedToClaim():Boolean
		{
			return _bAddedToClaim;
		}

		public function set isAddedToClaim(value:Boolean):void
		{
			_bAddedToClaim = value;
		}

		public function FromXML( x:XML ):void
		{
			InsuranceID 				= x.@[XmlConstants.INSURANCEID];
			ClaimID 					= x.@[XmlConstants.CLAIMTID];
			InsOrganizationID 			= x.@[XmlConstants.INSORGANIZATIONID];			
			InsuranceTypeId 			= x.@[XmlConstants.INSURANCETYPEID];
			StatusTypeID 				= x.@[XmlConstants.STATUSTYPEID];			
			MediaTypeID 				= x.@[XmlConstants.MEDIATYPEID];
			FrequencyTypeID 			= x.@[XmlConstants.FREQUENCYTYPEID];
			EDIReceiverTypeID			= x.@[XmlConstants.EDIRECEIVERTYPEID];
			CreatedBy					= x.@[XmlConstants.CREATEDBY];	
			ModifiedBy					= x.@[XmlConstants.MODIFIEDBY];	
			IsDeleted					= x.@[XmlConstants.ISDELETED];	
			SubmissionCount				= x.@[XmlConstants.SUBMISSIONCOUNT];
			BillDate					= x.@[XmlConstants.BILLDATE];
			StatementTypeID				= x.@[XmlConstants.STATEMENTTYPEID];
			
			if(InsuranceID != "0")
				isAddedToClaim = true;
			else
				isAddedToClaim = false;
			
		}		
		
		public function ToXML():XML
		{
			var x:XML = XmlUtils.getNodeByTagName( "Carrier" );
			
			x.@[XmlConstants.INSURANCEID]				= InsuranceID;			
			x.@[XmlConstants.CLAIMTID]					= ClaimID;
			x.@[XmlConstants.INSORGANIZATIONID]			= InsOrganizationID;
			x.@[XmlConstants.INSURANCETYPEID]			= InsuranceTypeId;
			x.@[XmlConstants.STATUSTYPEID]				= StatusTypeID;			
			x.@[XmlConstants.MEDIATYPEID]				= MediaTypeID;
			x.@[XmlConstants.FREQUENCYTYPEID]			= FrequencyTypeID;
			x.@[XmlConstants.EDIRECEIVERTYPEID]			= EDIReceiverTypeID;
			x.@[XmlConstants.CREATEDBY]					= CreatedBy;	
			x.@[XmlConstants.MODIFIEDBY]				= ModifiedBy;	
			x.@[XmlConstants.ISDELETED]					= IsDeleted;
			x.@[XmlConstants.SUBMISSIONCOUNT]			= SubmissionCount;
			x.@[XmlConstants.BILLDATE]					= BillDate;
			x.@[XmlConstants.STATEMENTTYPEID]			= StatementTypeID;
			
			return x;
		}
		
		public function get BillDate():String
		{
			return m_sBillDate;
		}
		
		public function set BillDate(value:String):void
		{			
			m_sBillDate = value.substring(0,10);
		}
		
		public function get SubmissionCount():String
		{
			return m_sSubmissionCount;
		}
		
		public function set SubmissionCount(value:String):void
		{
			m_sSubmissionCount = value;
		}
		
		public function get ClaimID():String
		{
			return m_sClaimID;
		}
		
		public function set ClaimID(value:String):void
		{
			m_sClaimID = value;
		}
		
		public function get InsuranceID():String
		{
			return m_sInsuranceID;
		}
		
		public function set InsuranceID(value:String):void
		{
			m_sInsuranceID = value;
		}
		
		public function get InsOrganizationID():String
		{
			return m_sInsOrganizationID;
		}
		
		public function set InsOrganizationID(value:String):void
		{
			m_sInsOrganizationID = value;
		}
		
		public function get InsuranceTypeId():String
		{
			return m_sInsuranceTypeId;
		}
		
		public function set InsuranceTypeId(value:String):void
		{
			m_sInsuranceTypeId = value;
		}
		
		public function get StatusTypeID():String
		{
			return m_sStatusTypeID;
		}
		
		public function set StatusTypeID(value:String):void
		{			
			m_sStatusTypeID = value;
		}
		
		public function get MediaTypeID():String
		{
			return m_sMediaTypeID;
		}
		
		public function set MediaTypeID(value:String):void
		{
			m_sMediaTypeID = value;
		}
		
		public function get FrequencyTypeID():String
		{
			return m_sFrequencyTypeID;
		}
		public function set FrequencyTypeID(value:String):void
		{
			m_sFrequencyTypeID = value;
		}
		
		public function get EDIReceiverTypeID():String
		{
			return m_sEDIReceiverTypeID;
		}
		
		public function set EDIReceiverTypeID(value:String):void
		{
			m_sEDIReceiverTypeID = value;
		}
		
		public function get CreatedBy():String
		{
			return m_sCreatedBy;
		}
		
		public function set CreatedBy(value:String):void
		{
			m_sCreatedBy = value;
		}
		
		public function get ModifiedBy():String
		{
			return m_sModifiedBy;
		}
		
		public function set ModifiedBy(value:String):void
		{			
			m_sModifiedBy = value;
		}
		
		public function get IsDeleted():String
		{
			return m_sIsDeleted;
		}
		
		public function set IsDeleted(value:String):void
		{
			m_sIsDeleted = value;
		}
	}
}