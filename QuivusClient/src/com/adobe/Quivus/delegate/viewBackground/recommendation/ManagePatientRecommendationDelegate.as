package com.adobe.Quivus.delegate.viewBackground.recommendation
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	import valueObjects.VisitDTO;
	
	public class ManagePatientRecommendationDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function ManagePatientRecommendationDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function ManagePatientRecommendation(treatmentList:ArrayCollection,session:UserSessionDTO) : void {
			var token:AsyncToken =( service ).ManagePatientRecommendation(treatmentList,session);			
			token.addResponder( command );
		}		

	}
}