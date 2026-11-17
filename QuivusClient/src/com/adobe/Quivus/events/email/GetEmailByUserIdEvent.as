package com.adobe.Quivus.events.email {

	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.Quivus.appController.AppController;

	public class GetEmailByUserIdEvent extends CairngormEvent {
		
		public var userId : int;
		public var resultHandlerFunction:Function;

		public function GetEmailByUserIdEvent(userId : int, resultHandlerFunction:Function) {
			super( AppController.GET_EMAIL_BY_USER_ID_EVENT);
			this.userId = userId;
			this.resultHandlerFunction = resultHandlerFunction;
			}
		}
	}