package com.adobe.Quivus.delegate.staticData.visit
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadSoapTemplatesDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadSoapTemplatesDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadSoapTemplates(clinicBranchId:int, sessionDTO:UserSessionDTO ) : void {
			var token:AsyncToken = service.LoadSoapTemplateByClinicBranchId(clinicBranchId,sessionDTO);			
			token.addResponder( command );
		}		

	}
}