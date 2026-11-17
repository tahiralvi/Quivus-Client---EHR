package com.adobe.Quivus.delegate.staticData.ros
{
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	import com.adobe.Quivus.delegate.BaseDelegate;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadROSStaticDataDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadROSStaticDataDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadROSStaticData(isMale:Boolean,sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = (service ).LoadROSCategoryTypes(isMale,sessionDTO);			
			token.addResponder( command );
		}		

	}
}