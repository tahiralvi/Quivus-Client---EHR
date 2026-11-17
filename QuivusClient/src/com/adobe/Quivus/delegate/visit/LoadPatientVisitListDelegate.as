package com.adobe.Quivus.delegate.visit
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadPatientVisitListDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadPatientVisitListDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadPatientVisitList(patinetId:int , clinicBranchId:int , showAll:Boolean, sessionDTO:UserSessionDTO ) : void {
		//	var token:AsyncToken = service.LoadPatientVisitsByPatientIdAndClinicId(patinetId,clinicBranchId,showAll,sessionDTO);			
		//	token.addResponder( command );
		}		

	}
}