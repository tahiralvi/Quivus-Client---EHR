package com.gazuntite.provider.live.services.waitingRoom.util
{
	public class WRXmlUtils
	{
		public static function getNodeByTagName(tagName:String):XML
		{
			return new XML(  "<" + tagName + "/>" );
		}
		
	}
}