package com.gazuntite.provider.live.services.administration.command.userManagement
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSExceptionAlert;
	import com.gazuntite.provider.live.services.administration.delegate.userManagement.GetClinicUserDetailsDelegate;
	import com.gazuntite.provider.live.services.administration.dto.userManagement.ProviderBasicInfoResult;
	import com.gazuntite.provider.live.services.administration.event.userManagement.GetClinicUserDetailsEvent;
	import com.gazuntite.provider.live.services.administration.model.AdminAppModelLocator;
	import com.gazuntite.provider.live.services.administration.util.AdminConstant;
	
	import flash.display.Sprite;
	import flash.xml.XMLDocument;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.CursorManager;
	import mx.managers.PopUpManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.xml.SimpleXMLDecoder;
	
	public class GetClinicUserDetailsCommand implements Command
	{
		private var model : AdminAppModelLocator = AdminAppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:GetClinicUserDetailsDelegate;
		
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new GetClinicUserDetailsDelegate( responder );			
			
			var LE:GetClinicUserDetailsEvent = cgEvent as GetClinicUserDetailsEvent;
			
			callBack = LE.resultHandlerFunction;
			
			//delegate function passed with userID and branchID
			delegate.GetProviderDetails(LE.userId,LE.branchId);				
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			/* Convert XMLNode to XMLDocument. */
			var xmlStr:String = event.result.toString();
			var xmlDoc:XMLDocument = new XMLDocument(xmlStr);
			var decoder:SimpleXMLDecoder = new SimpleXMLDecoder(true);
			var resultObj:Object = decoder.decodeXML(xmlDoc);
			/* Assign the values... */
			
			var psl:ProviderBasicInfoResult = new ProviderBasicInfoResult();
			psl.FromXML( event.result as XML );
			model.SearchProviderDetailsResults =psl;
			
			event.stopImmediatePropagation();
			
			if( null != callBack )
				callBack();
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show("Error in GetUserDetailsCommand", AdminConstant.INFO, 4, FlexGlobals.topLevelApplication.mainContainer);
		}
	}
}