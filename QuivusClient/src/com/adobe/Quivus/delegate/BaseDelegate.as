package com.adobe.Quivus.delegate
{
	import air.net.URLMonitor;
	
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	import com.adobe.Quivus.utils.Constants;
	
	import flash.events.StatusEvent;
	import flash.net.URLRequest;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	public class BaseDelegate
	{
		public static var quivusManagerServiceAvailability	:Boolean;
		public static var streamingServiceAvailability		:Boolean;
		
		private static var monitor							:URLMonitor;
		
		
		public static function checkQuivusManagerServiceAvailability( ) : void {
			var req:URLRequest =  new URLRequest(Constants.QUIVUS_MANAGER_SERVICE_WSDL);
			req.useCache=false;
			
			monitor = new URLMonitor(req);
			monitor.addEventListener(StatusEvent.STATUS, announceQuivusManagerServiceStatus);
			monitor.start();
		}
		
		private  static function announceQuivusManagerServiceStatus(e:StatusEvent):void {
			if (e.target.available) {
				quivusManagerServiceAvailability= true;
			} else {
				quivusManagerServiceAvailability= false;
			}
		}
		
		
		
		
		public static function checkStreamingServiceAvailability( ) : void {
			var req:URLRequest =  new URLRequest(Constants.STREAMING_SERVICE_WSDL);
			req.useCache=false;
			
			monitor = new URLMonitor(req);
			monitor.addEventListener(StatusEvent.STATUS, announceStreamingServiceStatus);
			monitor.start();
		}
		
		private  static function announceStreamingServiceStatus(e:StatusEvent):void {
			if (e.target.available) {
				streamingServiceAvailability= true;
			} else {
				streamingServiceAvailability= false;
			}
		}
	}
}