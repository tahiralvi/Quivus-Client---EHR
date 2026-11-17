package com.adobe.Quivus.events
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class CombineAllergyEvent extends CairngormEvent
	{
		public var parameterType			: int;
		public var allergyParameter			: *;
		public var callBack				: Function;
		
		public function CombineAllergyEvent(parameterType:int, allergyParameter:*, callBack:Function = null)
		{
			super(AppController.COMBINE_ALLERGY_EVENT);
			
			this.parameterType		= parameterType;
			this.allergyParameter 	= allergyParameter;
			this.callBack			= callBack;
		}
	}
}