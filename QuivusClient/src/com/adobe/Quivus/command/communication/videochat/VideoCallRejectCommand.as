package com.adobe.Quivus.command.communication.videochat
{
	import com.adobe.Quivus.delegate.communication.videochat.VideoCallRejectDelegate;
	import com.adobe.Quivus.events.communication.videochat.VideoCallRejectEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.view.controls.custom.communication.videochat.VideoChatView;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.xml.XMLDocument;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.xml.SimpleXMLDecoder;

	public class VideoCallRejectCommand  implements Command
	{
		
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:VideoCallRejectDelegate;
		
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new VideoCallRejectDelegate( responder );			
			
			var VCRE:VideoCallRejectEvent = cgEvent as VideoCallRejectEvent;
			
			callBack = VCRE.resultHandlerFunction;
			delegate.RejectVideoCallDetails(VCRE.userId,VCRE.branchId,VCRE.videoChatID);
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			/* Convert XMLNode to XMLDocument. */
			var xmlStr:String = event.result.toString();
			var xmlDoc:XMLDocument = new XMLDocument(xmlStr);
			var decoder:SimpleXMLDecoder = new SimpleXMLDecoder(true);
			var resultObj:Object = decoder.decodeXML(xmlDoc);
			/* Assign the values... */
			
			/*var psl:ProviderBasicInfoResult = new ProviderBasicInfoResult();
			psl.FromXML( event.result as XML );
			model.SearchProviderDetailsResults =psl;*/
			model.m_ovideoCallInfo = event.result.toString();
			event.stopImmediatePropagation();
			
			
			
			
			if( null != callBack )
				callBack();
			
			
		}
		
		private function onError(event:FaultEvent):void
		{
			event.stopImmediatePropagation();
			model.m_ovideoCallInfo=null;
			if( null != callBack )
				callBack();
			//Alert.show("Error in Getting Details of Incoming Vide Chat in Communication.");
			
		}
		
	}
}