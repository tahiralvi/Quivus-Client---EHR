package com.adobe.Quivus.delegate.staticData.hpi
{
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	import com.adobe.Quivus.delegate.BaseDelegate;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadHPIStaticDataDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadHPIStaticDataDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadHPIStaticData(hpiId:int,clinicBranchId:int,sessionDTO:UserSessionDTO,searchString:String) : void {
			var token:AsyncToken = (service ).LoadHPIDetailAutoCompleteByTypeIdAndClinicId(hpiId,clinicBranchId,searchString,sessionDTO);			
			token.addResponder( command );
		}		

	}
}