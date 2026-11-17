package com.adobe.Quivus.view.controls.skins
{
	import mx.skins.RectangularBorder;
	
	public class RoundedSkin extends RectangularBorder
	{
		public function RoundedSkin()
		{
			super();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			var cr:Number = getStyle("cornerRadius");
			var bc:Number = getStyle("backgroundColor");
			
			graphics.clear();
			graphics.beginFill(bc, 1);
			
			// Draw the rectangle manually, rounding only the top two corners
			graphics.drawRoundRectComplex(0, 0, unscaledWidth, unscaledHeight, cr, cr, 0, 0);
			graphics.endFill();
		}
	}
}