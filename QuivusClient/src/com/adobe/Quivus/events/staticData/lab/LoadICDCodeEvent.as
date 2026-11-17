package com.adobe.Quivus.events.staticData.lab {
	
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class LoadICDCodeEvent extends CairngormEvent {
		
		public var icdCode:String;
		public var func:Function;
		
		public function LoadICDCodeEvent( icdCode:String, _func:Function = null) {
			super( AppController.LOAD_ICD_CODE_EVENT);
			this.icdCode 	= icdCode;
			this.func 		= _func;
		}
	}
}