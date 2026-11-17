package com.adobe.Quivus.delegate.viewBackground.vital
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
	
	public class LoadPatientVitalsByPatientIdDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadPatientVitalsByPatientIdDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadPatientVitalsByPatientId(patientId:int,cbId:int,session:UserSessionDTO,stationIds:ArrayCollection,isallSelected:Boolean, Page:PageDTO ) : void {
			var token:AsyncToken =( service ).LoadVitalsByPatientId(patientId,cbId,session,stationIds,isallSelected, Page);			
			token.addResponder( command );
		}
		
		/*public function LoadVitalsByPatientIdCriteria(PatientId:int , ClinicBranchId:int, userSession:UserSessionDTO , stationIDs:ArrayCollection, isAllSelected:Boolean, Page:PageDTO ):void
		{
			var token:AsyncToken =( service ).LoadVitalsByPatientIdCriteria(PatientId, ClinicBranchId, userSession, stationIDs, isAllSelected, Page );			
			token.addResponder( command );
		}*/


	}
}