package com.adobe.Quivus.delegate.staticData.immunization
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadImmunizationDoseStaticDataDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadImmunizationDoseStaticDataDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadImmunizationDoseStaticData(searchCreatria:String, clinicBranchId:int,session:UserSessionDTO) : void {
			var token:AsyncToken = (service ).LoadImmunizationDoseByClinicId(searchCreatria,clinicBranchId,session);			
			token.addResponder( command );
		}		

	}
}