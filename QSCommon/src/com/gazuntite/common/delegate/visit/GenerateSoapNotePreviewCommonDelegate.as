package com.gazuntite.common.delegate.visit
{
	import com.gazuntite.common.util.QSConstants;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	/**
	 * Author : Tahir Alvi
	 * Date   : 17 jan, 2013
	 * Module : for Viewing Soap Note
	 * */
	
	public class GenerateSoapNotePreviewCommonDelegate
	{
		private var responder : IResponder;
		private var service : HTTPService;
		
		public function GenerateSoapNotePreviewCommonDelegate(responder:IResponder)
		{
			this.responder = responder;
			var url:String 		= QSConstants.EPRESCRIPTION_QM_SERVICE + 'GenerateSoapNoteByVisitID';			
			service 			= new HTTPService(url);
			service.url 		= url;	
			service.method 		= 'POST';	
			service.contentType = 'text/xml';	
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);	
		}
		
		public function GenerateSoapNotePreview(visitID:int, userSessionID:String, userSelectedBranchId:int , userSelectedStationID:int, isAllSelected:Boolean, isMale:Boolean, isTemplateVisit:Boolean, gaxenID:String, visitProvider:String, encounterName:String, placeOfServiecName:String):void
		{
			if(gaxenID == '')
				gaxenID = '0';
			
			var soapNoteXML:XML 				= <SoapNote/>;
			soapNoteXML.@VisitID 				= visitID;
			soapNoteXML.@sessionID 				= userSessionID;
			soapNoteXML.@clinicbranchId 		= userSelectedBranchId;
			soapNoteXML.@stationId 				= userSelectedStationID;
			soapNoteXML.@isAllSelected 			= isAllSelected;
			soapNoteXML.@isMale 				= isMale;
			soapNoteXML.@isTemp 				= isTemplateVisit;
			soapNoteXML.@GaxenID 				= gaxenID;
			soapNoteXML.@ProviderName 			= visitProvider;
			soapNoteXML.@EncounterTypeName 		= encounterName;
			soapNoteXML.@PlaceofService 		= placeOfServiecName;
			
			service.url = service.url ;
			service.resultFormat = "e4x";
			service.send(soapNoteXML);	
			trace(soapNoteXML);
			
			trace( "GenerateSoapNotePreviewCommonDelegate", service.url );
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