package com.adobe.Quivus.events.communication
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class GetClinicUserIDEvent extends CairngormEvent
	{
		public var userId : int;
		public var branchId : int;
		public var is4UserImage : Boolean;
		public var resultHandlerFunction:Function;
		
		public function GetClinicUserIDEvent(_userId : int, _branchId:int , _is4UserImage:Boolean = false, _resultHandlerFunction:Function = null)
		{
			super(AppController.LOAD_CLINIC_USER_BASIC_INFO);
			this.userId 				= _userId;
			this.branchId 				= _branchId;
			this.is4UserImage 			= _is4UserImage;
			this.resultHandlerFunction 	= _resultHandlerFunction;
		}
	}
}