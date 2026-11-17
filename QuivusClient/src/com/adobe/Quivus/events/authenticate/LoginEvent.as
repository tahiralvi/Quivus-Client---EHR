package com.adobe.Quivus.events.authenticate {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoginEvent extends CairngormEvent {
		
		public var username : String;
		public var password : String;
		public var callBack    : Function;

		public function LoginEvent( username : String, password : String, callBack:Function) {
			super( AppController.LOGIN_EVENT);
			this.username = username;
			this.password = password;
			this.callBack    = callBack ;
			
			
			}
		}
	}