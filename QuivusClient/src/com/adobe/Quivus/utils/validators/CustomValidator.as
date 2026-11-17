package com.adobe.Quivus.utils.validators
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.controls.TextInput;
	import mx.controls.ToolTip;
	import mx.events.ValidationResultEvent;
	import mx.managers.ToolTipManager;
	import mx.validators.Validator;
	
	import spark.components.TextInput;
	
	public class CustomValidator extends Validator
	{
		public function CustomValidator()
		{
			super();
			addEventListener(ValidationResultEvent.INVALID,handleInvalid);
			addEventListener(ValidationResultEvent.VALID,handleValid);
		}
		override public function set source(value:Object):void{
			super.source = value;
			if(source){
				source.addEventListener(MouseEvent.ROLL_OVER,handleMouseOver);
				source.addEventListener(MouseEvent.ROLL_OUT,handleMouseOver);
				source.addEventListener(MouseEvent.MOUSE_OVER,handleMouseOver);
				source.addEventListener(MouseEvent.MOUSE_OUT,handleMouseOver);
				source.addEventListener(MouseEvent.MOUSE_MOVE,handleMouseOver);
			}
		}
		private var errorTip:ToolTip ;
		private function handleInvalid(event:ValidationResultEvent):void{
			if(!errorTip){
				var pt:Point = new Point(source.x,source.y);
			
				
				pt = source.localToGlobal(pt);
				var startX:Number = pt.x + source.width + 5;
				var startY:Number = pt.y;
				errorTip = ToolTipManager.createToolTip(requiredFieldError, startX, startY) as ToolTip;
				errorTip.x = startX;
				errorTip.setStyle("styleName", "errorTip");
				errorTip.visible = true;
			}else{
				if(!errorTip.visible)
					errorTip.visible = true;
			}
		}
		private function handleValid(event:ValidationResultEvent):void{
			//once the valid event fires destroy the tooltip so that it will be garbage collected
			if(errorTip && errorTip.visible){
				ToolTipManager.destroyToolTip(errorTip);
				errorTip = null;
			}
		}
		private function handleMouseOver(event:MouseEvent):void{
			event.stopImmediatePropagation();
		}
	}
}