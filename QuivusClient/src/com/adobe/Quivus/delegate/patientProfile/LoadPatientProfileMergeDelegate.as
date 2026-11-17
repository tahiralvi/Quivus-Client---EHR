package com.adobe.Quivus.delegate.patientProfile
{
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class LoadPatientProfileMergeDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		public function LoadPatientProfileMergeDelegate(responder : IResponder)
		{
			this.responder 			= responder;
			var url:String 			= 'LoadPatientProfileMerge'; 
			service 				= new HTTPService(url);
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
			service.showBusyCursor 	= true;
			service.method			= 'POST';
			service.url 			= url;
		}
		
		public function LoadPatientProfileMerge(UserID:int, PatientID:int, ClinicBranchID:int, isAllSelected:Boolean, ShowAll:Boolean, UserTypeID:int, isTemplateVisit:Boolean, fileName:String, SectionNumber:int):void
		{
			var xml:XML 			= <PatientProfileMergedRequest />;
			xml.@UserID 			= UserID;
			xml.@PatientID 			= PatientID;
			xml.@ClinicBranchID 	= ClinicBranchID;
			xml.@isAllSelected 		= isAllSelected;
			xml.@ShowAll 			= ShowAll;
			xml.@UserTypeID 		= UserTypeID;
			xml.@isTemplateVisit 	= isTemplateVisit;
			xml.@fileName 			= fileName;
			xml.@SectionNumber 		= SectionNumber;
			
			var stationXml:XML 		= <StationIDs />;
			stationXml.int     		= 1;
			
			xml.appendChild(stationXml);
			
			service.url 			= service.url;
			service.resultFormat 	= "e4x";
			service.send(xml);	
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