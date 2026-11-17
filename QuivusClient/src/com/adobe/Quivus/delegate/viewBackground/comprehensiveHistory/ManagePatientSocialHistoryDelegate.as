package com.adobe.Quivus.delegate.viewBackground.comprehensiveHistory
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.SocialHistoryDTO;
	import valueObjects.UserSessionDTO;
	
	public class ManagePatientSocialHistoryDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function ManagePatientSocialHistoryDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function ManagePatientSocialHistory(socialHDTOList:ArrayCollection,session:UserSessionDTO, clinicBrachId:int, patientId:int) : void {
			var token:AsyncToken =( service ).ManagePatientSocialHistory(socialHDTOList,session, clinicBrachId, patientId);			
			token.addResponder( command );
		}		

	}
}