package com.adobe.Quivus.delegate.viewBackground.notes
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	import valueObjects.VisitDTO;
	
	public class LoadModuleNotesByPatientIdDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadModuleNotesByPatientIdDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadModuleNotesByPatientId(patientId:int,cbId:int ,sessionDTO:UserSessionDTO,stationIds:ArrayCollection,isallSelected:Boolean) : void {
			var token:AsyncToken = (service ).LoadModuleNotesByPatientId(patientId,cbId,sessionDTO,stationIds,isallSelected);			
			token.addResponder( command );
		}		

	}
}