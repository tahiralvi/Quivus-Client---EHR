package com.gazuntite.provider.live.services.billing.dto
{
	import com.gazuntite.common.util.xml.XmlUtils;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class SearchClaimResultsList
	{
		private var m_oClaims:ArrayCollection;
		
		public function SearchClaimResultsList()
		{
			Claims = new ArrayCollection();
		}
		
		public function get Claims():ArrayCollection
		{
			return m_oClaims;
		}
		
		public function set Claims(value:ArrayCollection):void
		{
			m_oClaims = value;
		}
		
		public function FromXML(x:XML):void
		{
			var xClaims:XMLList = x.Claims.Claim;
			var i:int = 0;					
			for( i = 0; i < xClaims.length(); i++ )
			{
				var c:SearchClaimDTO = new SearchClaimDTO();
				c.FromXML( xClaims[i][0] );
				Claims.addItem( c );
			}
		}
		
		public function ToXML():XML
		{
			var xml:XML = XmlUtils.getNodeByTagName( "search" );
			var i:int = 0;
			for( i = 0; i < Claims.length; i++ )
			{
				var c:SearchClaimDTO = Claims.getItemAt( i ) as SearchClaimDTO;
				xml.appendChild( c.ToXML() );
			}
			
			return xml;
		}
	}
}