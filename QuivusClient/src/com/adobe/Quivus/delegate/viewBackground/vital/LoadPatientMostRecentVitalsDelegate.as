package com.adobe.Quivus.delegate.viewBackground.vital
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadPatientMostRecentVitalsDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadPatientMostRecentVitalsDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadPatientMostRecentVitals(patientId:int ,  sessionDTO:UserSessionDTO ) : void {
			var token:AsyncToken = service.LoadPatientPreviousVitals(patientId, sessionDTO);			
			token.addResponder( command );
		}		

	}
}