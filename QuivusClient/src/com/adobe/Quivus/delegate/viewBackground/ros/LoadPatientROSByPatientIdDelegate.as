package com.adobe.Quivus.delegate.viewBackground.ros
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.PageDTO;
	import valueObjects.UserSessionDTO;
	import valueObjects.VisitDTO;
	
	public class LoadPatientROSByPatientIdDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadPatientROSByPatientIdDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadPatientROSByPatientId(patientId:int,cbId:int,session:UserSessionDTO,stationIds:ArrayCollection,isallSelected:Boolean, Page:PageDTO ) : void {
			var token:AsyncToken =( service ).LoadROSByPatientId(patientId,cbId,session,stationIds,isallSelected, Page);			
			token.addResponder( command );
		}		

	}
}