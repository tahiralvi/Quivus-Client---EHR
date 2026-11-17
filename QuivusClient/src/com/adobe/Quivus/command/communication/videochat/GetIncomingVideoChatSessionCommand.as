package com.adobe.Quivus.command.communication.videochat
{
	import com.adobe.Quivus.delegate.communication.videochat.GetIncomingVideoChatSessionDelegate;
	import com.adobe.Quivus.events.communication.videochat.GetIncomingVideoChatSessionEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.view.controls.custom.communication.videochat.VideoCallNotification;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.controls.extended.components.PopupWindow;
	
	import flash.xml.XMLDocument;
	
	import mx.controls.Alert;
	import mx.managers.PopUpManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.xml.SimpleXMLDecoder;

	public class GetIncomingVideoChatSessionCommand implements Command
	{
		
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:GetIncomingVideoChatSessionDelegate;
		
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new GetIncomingVideoChatSessionDelegate( responder );			
			
			var GIVCSE:GetIncomingVideoChatSessionEvent = cgEvent as GetIncomingVideoChatSessionEvent;
			
			callBack = GIVCSE.resultHandlerFunction;
			delegate.GetVideoCallDetails(GIVCSE.userId,GIVCSE.branchId);
			
			var d:Date = new Date();
			//trace( "time call sent " + d.minutes, d.seconds )
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