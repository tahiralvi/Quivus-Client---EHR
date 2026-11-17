package com.gazuntite.provider.live.services.billing.dto
{
	import com.gazuntite.common.util.xml.XmlConstants;
	import com.gazuntite.common.util.xml.XmlUtils;
	
	[Bindable]
	public class ClaimTransactionDTO
	{
		private var m_sID:String;
		private var m_sClaimID:String;
		private var m_sProcedureID:String;
		private var m_sProcedureCode:String;
		private var m_sDateFrom:String;
		private var m_sDateTo:String;
		private var m_sAmount:String;
		private var m_sDocument:String;
		private var m_sIns1Resp:String;
		private var m_sIns2Resp:String;
		private var m_sIns3Resp:String;		
		
		public function ClaimTransactionDTO()
		{
			
		}
		
		public function FromXML( x:XML ):void
		{
			ID 							= x.@[XmlConstants.TID];
			ClaimID 					= x.@[XmlConstants.CLAIMTID];
			ProcedureID 				= x.@[XmlConstants.PROCEDUREID];			
			ProcedureCode 				= x.@[XmlConstants.PROCEDURECODE];
			DateFrom 					= x.@[XmlConstants.DATEFROM];			
			DateTo 						= x.@[XmlConstants.DATETO];
			Amount 						= x.@[XmlConstants.AMOUNT];
			Document					= x.@[XmlConstants.DOCUMENT];
			Ins1Resp						= x.@[XmlConstants.INS1RESP];	
			Ins2Resp					= x.@[XmlConstants.INS2RESP];	
			Ins3Resp					= x.@[XmlConstants.INS3RESP];	
			
		}		
		
		public function ToXML():XML
		{
			var x:XML = XmlUtils.getNodeByTagName( "Transaction" );
			
			x.@[XmlConstants.ID]						= ID;			
			x.@[XmlConstants.CLAIMTID]					= ClaimID;
			x.@[XmlConstants.PROCEDUREID]				= ProcedureID;
			x.@[XmlConstants.PROCEDURECODE]				= ProcedureCode;
			x.@[XmlConstants.DATEFROM]					= DateFrom;			
			x.@[XmlConstants.DATETO]					= DateTo;
			x.@[XmlConstants.AMOUNT]					= Amount;
			x.@[XmlConstants.DOCUMENT]					= Document;
			x.@[XmlConstants.INS1RESP]					= Ins1Resp;	
			x.@[XmlConstants.INS2RESP]					= Ins2Resp;	
			x.@[XmlConstants.INS3RESP]					= Ins3Resp;	
			
			return x;
		}
		
		public function get ClaimID():String
		{
			return m_sClaimID;
		}
		
		public function set ClaimID(value:String):void
		{
			m_sClaimID = value;
		}
		
		public function get ProcedureID():String
		{
			return m_sProcedureID;
		}
		
		public function set ProcedureID(value:String):void
		{
			m_sProcedureID = value;
		}
		
		public function get ID():String
		{
			return m_sID;
		}
		
		public function set ID(value:String):void
		{
			m_sID = value;
		}
		
		public function get ProcedureCode():String
		{
			return m_sProcedureCode;
		}
		
		public function set ProcedureCode(value:String):void
		{
			m_sProcedureCode = value;
		}
		
		public function get DateFrom():String
		{
			return m_sDateFrom;
		}
		
		public function set DateFrom(value:String):void
		{
			value = value.substr(0,10);
			m_sDateFrom = value;
		}
		
		public function get DateTo():String
		{
			return m_sDateTo;
		}
		
		public function set DateTo(value:String):void
		{
			value = value.substr(0,10);
			m_sDateTo = value;
		}
		
		public function get Amount():String
		{
			return m_sAmount;
		}
		public function set Amount(value:String):void
		{
			m_sAmount = value;
		}
		
		public function get Document():String
		{
			return m_sDocument;
		}
		
		public function set Document(value:String):void
		{
			m_sDocument = value;
		}
		
		public function get Ins1Resp():String
		{
			return m_sIns1Resp;
		}
		
		public function set Ins1Resp(value:String):void
		{
			m_sIns1Resp = value;
		}
		
		public function get Ins2Resp():String
		{
			return m_sIns2Resp;
		}
		
		public function set Ins2Resp(value:String):void
		{			
			m_sIns2Resp = value;
		}
		
		public function get Ins3Resp():String
		{
			return m_sIns3Resp;
		}
		
		public function set Ins3Resp(value:String):void
		{
			m_sIns3Resp = value;
		}
	}
}