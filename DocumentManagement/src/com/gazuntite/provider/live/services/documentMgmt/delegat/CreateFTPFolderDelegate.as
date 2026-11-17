package com.gazuntite.provider.live.services.documentMgmt.delegat
{
	import com.gazuntite.provider.live.services.documentMgmt.util.DMConstant;
	import com.gazuntite.provider.live.services.documentMgmt.util.DMRServiceMethod;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class CreateFTPFolderDelegate extends BaseDelegate
	{
		private var responder	:IResponder;
		private var ser			:HTTPService;
	
		public function CreateFTPFolderDelegate(  command : IResponder )
		{		
			this.responder    = command;
			var url:String = DMConstant.RESTFULL_SERVICE_BASE_URL + DMRServiceMethod.CREATE_FOLDER_FTP;
			ser = new HTTPService(url);
			ser.url = url;
			ser.useProxy = false;			
		}
		
		public function CreateFTPFolder(path:String):void
		{
			ser.addEventListener(FaultEvent.FAULT,onFault);
			ser.addEventListener(ResultEvent.RESULT,onResult);
			
			ser.url = ser.url+"/"+path;
			
			ser.send();	
			trace( ser.url );
		}
		
		private function onResult(event:ResultEvent):void
		{
			responder.result(event);
		}
		
		private function onFault(event:FaultEvent):void
		{
			responder.fault(event);			
		}		

	}
}