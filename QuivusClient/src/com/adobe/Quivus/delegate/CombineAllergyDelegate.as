package com.adobe.Quivus.delegate
{
	import com.adobe.Quivus.utils.Constants;
	import com.gazuntite.common.util.QSConstants;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class CombineAllergyDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		public function CombineAllergyDelegate(responder : IResponder)
		{
			this.responder 		= responder;			
			var url:String 		= QSConstants.QI_PATIENT_ALLERGY_RESTFUL_SERVICE;
			service 			= new HTTPService(url);
			service.url 		= url;
			
			service.contentType = "Text/Xml";
			service.method		= "POST";
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
		}
		
		public function GetAllergiesList(parameterType:int, allergyParameter:* ):void
		{
			var eusername:String =  "TESTUSER"; 
			var epassword:String =  "TESTPASS";
			
			var securityHeaderXML:XML   	= <Header />;					
			securityHeaderXML.@EUserName	= eusername;
			securityHeaderXML.@EPassword	= epassword;
			securityHeaderXML.@ClinicID		= "sad";
			
			service.showBusyCursor = true;
			if(parameterType == 1)
				service.url = service.url + QSConstants.ALLERGY_RESTFUL_SERVICE_METHOD_GetAllergies + "/" + allergyParameter;
			else if(parameterType == 2)
				service.url = service.url + QSConstants.ALLERGY_RESTFUL_SERVICE_METHOD_GetPatientAllergies + "/" + allergyParameter;
			else if(parameterType == 3)
				service.url = service.url + QSConstants.ALLERGY_RESTFUL_SERVICE_METHOD_AddAllergies;
			else if(parameterType == 4)
				service.url = service.url + QSConstants.ALLERGY_RESTFUL_SERVICE_METHOD_DeletePatientAllergies;
			
			//service.resultFormat = "e4x";
			if(parameterType == 3 || parameterType == 4)
				service.send(allergyParameter.appendChild(securityHeaderXML));
			else
				service.send(securityHeaderXML);
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