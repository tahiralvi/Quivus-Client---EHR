package com.adobe.Quivus.delegate.registration
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.BaseUserDTO;
	import valueObjects.UserSessionDTO;
	
	public class RegisterUserProfileDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
		
		public function RegisterUserProfileDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function RegisterUserProfile(basicUserDTO: BaseUserDTO ,loggedInUserId:int, sessionDTO:UserSessionDTO) : void {
			basicUserDTO.CreatedBy  = loggedInUserId;
			if(null == basicUserDTO.CreatedDate )
				basicUserDTO.CreatedDate = new Date();
			if(null == basicUserDTO.ModifiedAt )
					basicUserDTO.ModifiedAt = new Date();
			var token:AsyncToken = service.RegisterBaseUser(basicUserDTO,sessionDTO);			
			token.addResponder( command );
		}		
		
	}
}