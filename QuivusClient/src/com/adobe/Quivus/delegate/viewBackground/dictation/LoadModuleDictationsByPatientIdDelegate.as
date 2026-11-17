package com.adobe.Quivus.delegate.viewBackground.dictation
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	import valueObjects.VisitDTO;
	
	public class LoadModuleDictationsByPatientIdDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadModuleDictationsByPatientIdDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadModuleDictationsByPatientId(patientId:int,cbId:int, sessionDTO:UserSessionDTO,stationIds:ArrayCollection,isallSelected:Boolean) : void {			
			
			var token:AsyncToken = (service ).LoadModuleDictationByPatientId(patientId,cbId,sessionDTO,stationIds,isallSelected);			
			token.addResponder( command );
		}		

	}
}