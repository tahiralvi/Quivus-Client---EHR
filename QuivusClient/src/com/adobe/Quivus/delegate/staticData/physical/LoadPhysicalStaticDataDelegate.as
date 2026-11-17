package com.adobe.Quivus.delegate.staticData.physical
{
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	import com.adobe.Quivus.delegate.BaseDelegate;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadPhysicalStaticDataDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadPhysicalStaticDataDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadPhysicalStaticData(isMale:Boolean,sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = (service ).LoadPhysicalCategoryTypes(isMale,sessionDTO);			
			token.addResponder( command );
		}		

	}
}