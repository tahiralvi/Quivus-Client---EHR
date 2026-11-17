package com.adobe.Quivus.delegate.staticData.recommendation
{
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	import com.adobe.Quivus.delegate.BaseDelegate;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadAllLinksDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadAllLinksDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadAllLinks(clinicBranchId:int, searchString:String,sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = (service ).LoadRecommendationLinksAutoCompleteByClinicId(clinicBranchId,searchString,sessionDTO);			
			token.addResponder( command );
		}		

	}
}