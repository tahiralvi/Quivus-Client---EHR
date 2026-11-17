package com.gazuntite.provider.live.services.billing.dto
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class SearchPendingBillsResultList
	{
		private var m_oPendingBills:ArrayCollection;
		
		public function SearchPendingBillsResultList()
		{
			PendingBills = new ArrayCollection;
		}

		public function get PendingBills():ArrayCollection
		{
			return m_oPendingBills;
		}
		
		public function set PendingBills(value:ArrayCollection):void
		{
			m_oPendingBills = value;
		}
		
		public function FromXML(x:XML):void
		{
			var xPendingBills:XMLList = x.PendingBills.PendingBill;
			var i:int = 0;					
			for( i = 0; i < xPendingBills.length(); i++ )
			{
				var ct:PendingBillsDTO = new PendingBillsDTO();
				ct.FromXML( xPendingBills[i][0] );
				PendingBills.addItem( ct );
			}
		}
	}
}