package com.gazuntite.provider.live.services.documentMgmt.view.itemRenderer
{
	import mx.controls.Label;
	
	public class MyCustomHeader extends Label {
		
		public function MyCustomHeader(): void
		{
			setStyle('fontWeight', 'bold');
			setStyle('textAlign', 'center');
			setStyle('color',  0x333333);
			setStyle('fontFamily', 'Calibri Bold');
		}
	}
}