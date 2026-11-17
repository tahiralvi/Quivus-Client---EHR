package com.gazuntite.provider.live.services.elab.dto
{
	import com.gazuntite.common.util.xml.XmlUtils;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class LabOrdersListDTO
	{
		private var m_oLabs:ArrayCollection;

		public function LabOrdersListDTO()
		{
			Labs = new ArrayCollection();
		}
		
		public function get Labs():ArrayCollection
		{
			return m_oLabs;
		}

		public function set Labs(value:ArrayCollection):void
		{
			m_oLabs = value;
		}
		
		public function FromXML(x:XML):void
		{
			var xLabs:XMLList = x.Labs.Lab ;
			var i:int = 0;
			for( i = 0; i < xLabs.length(); i++ )
			{
				var lab:LabDTO = new LabDTO();
				lab.FromXML( xLabs[i] );
				Labs.addItem( lab );
			}
		}
		
		public function ToXML():XML
		{
			var xml:XML = XmlUtils.getNodeByTagName( "Labs" );
			var i:int = 0;
			for( i = 0; i < Labs.length; i++ )
			{
				var lab:LabDTO = Labs.getItemAt( i ) as LabDTO;
				xml.appendChild( lab.ToXML() );
			}
			
			return xml;
		}

	}
}