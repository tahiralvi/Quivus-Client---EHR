package com.adobe.Quivus.delegate.viewBackground.notes
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	import valueObjects.VisitDTO;
	
	public class ManageModuleNotesDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function ManageModuleNotesDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function ManageModuleNotes(moduleNoteDTOList:ArrayCollection, sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = service.ManageModuleNotes(moduleNoteDTOList,sessionDTO);			
			token.addResponder( command );
		}		

	}
}