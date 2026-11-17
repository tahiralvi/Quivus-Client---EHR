package com.adobe.Quivus.events.authenticate 
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class VerifyUserMainEvent extends CairngormEvent 
	{
		public var password 		: String;
		public var visitId 			: int;
		
		public var functionName 	: Function;
		
		public var originName		:String; // calling function name ---- Constants.VIEW_BACKGROUND_MODULE_NAME
		public var actionName		:String; // Sign/Cosign ---- Constants.VISIT_COSIGNED / Constants.VISIT_SIGNE 
		
		public function VerifyUserMainEvent( password : String, visitId: int,functionName : Function, originName:String = null, actionName:String = null ) 
		{
			super( AppController.VERIFY_USER_MAIN_EVENT);
			this.visitId 		= visitId;
			this.password		= password;
			this.functionName 	= functionName;
			
			this.originName = originName;
			this.actionName = actionName;
		}
	}
}