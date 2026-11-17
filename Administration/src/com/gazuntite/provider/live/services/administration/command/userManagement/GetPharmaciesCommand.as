package com.gazuntite.provider.live.services.administration.command.userManagement
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSExceptionAlert;
	import com.gazuntite.provider.live.services.administration.delegate.userManagement.GetPharmacyDelegate;
	import com.gazuntite.provider.live.services.administration.dto.userManagement.PharmaciesListDTO;
	import com.gazuntite.provider.live.services.administration.event.userManagement.GetPharmacyEvent;
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
	
	public class GetPharmaciesCommand implements Command
	{
		private var model : AdminAppModelLocator = AdminAppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:GetPharmacyDelegate;
		
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new GetPharmacyDelegate( responder );
			
			var LE:GetPharmacyEvent = cgEvent as GetPharmacyEvent;
			
			callBack = LE.resultHandlerFunction;
			
			//delegate function passed with userID and branchID
			//delegate.GetProviderDetails(LE.userId,LE.branchId);
			delegate.GetPharmacies(LE.pageNo, LE.npcid, LE.pharmacyName, LE.address, LE.zipcode, LE.state, LE.city, LE.serviceLevel, LE.phone, LE.status);					
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			var psl:PharmaciesListDTO = new PharmaciesListDTO();
			psl.FromXML(  event.result as XML  );
			
			model.PharmacyListDTO =psl;
			//trace( event.result );
			if( null != callBack )
				callBack();
			
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show("Error in Getting Pharmacies.", AdminConstant.ERROR, 4, FlexGlobals.topLevelApplication.mainContainer);
		}
	}
}