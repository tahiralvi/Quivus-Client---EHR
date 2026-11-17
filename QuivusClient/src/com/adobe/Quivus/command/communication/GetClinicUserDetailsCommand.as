package com.adobe.Quivus.command.communication
{
	import com.adobe.Quivus.delegate.communication.GetClinicUserDetailsDelegate;
	import com.adobe.Quivus.events.communication.GetClinicUserIDEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.provider.search.services.provider.dto.ProviderBasicInfoResult;
	import com.gazuntite.utils.UtilityFunctions;
	
	import flash.xml.XMLDocument;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.xml.SimpleXMLDecoder;
	
	public class GetClinicUserDetailsCommand implements Command
	{
		[Bindable]	private var model : AppModelLocator = AppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:GetClinicUserDetailsDelegate;
		
		private var callBack			: Function;
		private var is4UserImage		: Boolean;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new GetClinicUserDetailsDelegate( responder );			
			
			var LE:GetClinicUserIDEvent = cgEvent as GetClinicUserIDEvent;
			is4UserImage				= LE.is4UserImage;
			
			callBack = LE.resultHandlerFunction;
			delegate.GetProviderDetails(LE.userId,LE.branchId);
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			if(!is4UserImage)
			{
				var xmlStr:String = event.result.toString();
				var xmlDoc:XMLDocument = new XMLDocument(xmlStr);
				var decoder:SimpleXMLDecoder = new SimpleXMLDecoder(true);
				var resultObj:Object = decoder.decodeXML(xmlDoc);
				
				var psl:ProviderBasicInfoResult = new ProviderBasicInfoResult();
				psl.FromXML( event.result as XML );
				model.SearchProviderDetailsResults =psl;
			}
			else if(is4UserImage)//Tahir Alvi - only set image for User
			{
				var _xml:XML		= event.result as XML;
				model.userImageData = _xml.ImageData;
			}
			if( null != callBack )
				callBack();
		}
		
		private function onError(event:FaultEvent):void
		{
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( "Error in GetClinicUserDetailsCommand", event.toString(), userId); 
		}
	}
}