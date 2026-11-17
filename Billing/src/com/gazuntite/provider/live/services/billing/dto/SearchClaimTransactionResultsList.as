package com.gazuntite.provider.live.services.billing.dto
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class SearchClaimTransactionResultsList
	{
		private var m_oClaimTransactions:ArrayCollection;
		
		public function SearchClaimTransactionResultsList()
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
		
		public function FromXML(x:XML):void
		{
			var xClaimTransactions:XMLList = x.ClaimTransactions.Transaction;
			var i:int = 0;					
			for( i = 0; i < xClaimTransactions.length(); i++ )
			{
				var ct:ClaimTransactionDTO = new ClaimTransactionDTO();
				ct.FromXML( xClaimTransactions[i][0] );
				ClaimTransactions.addItem( ct );
			}
		}
		
		/*public function ToXML():XML
		{
			var xml:XML = XmlUtils.getNodeByTagName( "search" );
			var i:int = 0;
			for( i = 0; i < ClaimTransactions.length; i++ )
			{
				var ct:ClaimTransactionDTO = ClaimTransactions.getItemAt( i ) as ClaimTransactionDTO;
				xml.appendChild( ct.ToXML() );
			}
			
			return xml;
		}*/
	}
}