package com.adobe.Quivus.view.interfaces
{
	public interface IScrollableView
	{
		function get hasChange():Boolean
		function set hasChange(value:Boolean):void
			
		function ScrollUp():void;
		function ScrollDown():void;
	}
}