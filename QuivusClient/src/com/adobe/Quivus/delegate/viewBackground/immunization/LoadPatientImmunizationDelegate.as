package com.adobe.Quivus.delegate.viewBackground.immunization
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.ImmunizationDTO;
	import valueObjects.PageDTO;
	import valueObjects.UserSessionDTO;
	
	public class LoadPatientImmunizationDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadPatientImmunizationDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadPatientImmunization(patientId:int,providerUserId:int , userTypeId:int ,cbId:int, sessionDTO:UserSessionDTO,stationIds:ArrayCollection,isallSelected:Boolean, Page:PageDTO) : void {
			var token:AsyncToken = (service ).LoadPatientImmunizationsByPatientId(patientId,providerUserId,userTypeId,cbId,sessionDTO,stationIds,isallSelected, Page);			
			token.addResponder( command );
		}		

	}
}