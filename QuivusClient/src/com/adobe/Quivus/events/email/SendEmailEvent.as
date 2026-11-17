package com.adobe.Quivus.events.email {

	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.utils.ByteArray;
	import com.adobe.Quivus.appController.AppController;

	public class SendEmailEvent extends CairngormEvent {
		
		public var attatchedFileName 	: String;
		public var attatchment		 	: ByteArray;
		public var subject 				: String;
		public var receiptEmail 		: String;
		public var message 				: String;
		
		public var functionName : Function;
		
		public function SendEmailEvent( subject : String, 
										receiptEmail : String,
										message:String,
										attatchedFileName:String,
										attatchment: ByteArray,functionName : Function) {
			super( AppController.SEND_EMAIL_EVENT);
			
			this.subject = subject;
			this.receiptEmail = receiptEmail;
			this.message = message;
			this.attatchedFileName = attatchedFileName;
			this.attatchment = attatchment;
			this.functionName = functionName;
			}
		}
	}