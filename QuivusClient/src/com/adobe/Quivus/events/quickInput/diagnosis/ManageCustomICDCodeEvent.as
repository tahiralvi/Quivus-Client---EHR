package com.adobe.Quivus.events.quickInput.diagnosis
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.ICDCodeDTO;
	
	public class ManageCustomICDCodeEvent extends CairngormEvent
	{
		public var 	icdCodeDTO:ICDCodeDTO;
		public var 	userID:String;
		public var 	sessionID:String;
		public var 	callback:Function = null
			
		public function ManageCustomICDCodeEvent(_icdCodeDTO:ICDCodeDTO, _userID:String, _sessionID:String, _callback:Function = null)
		{
			super(AppController.MANAGE_CUSTOM_ICD_CODE_EVENT);
			this.icdCodeDTO 	= _icdCodeDTO;
			this.userID 		= _userID;
			this.sessionID 		= _sessionID;
			this.callback 		= _callback;
		}
	}
}