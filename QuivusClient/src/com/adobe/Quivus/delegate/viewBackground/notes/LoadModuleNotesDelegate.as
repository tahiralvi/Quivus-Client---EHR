package com.adobe.Quivus.delegate.viewBackground.notes
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	import valueObjects.VisitDTO;
	
	public class LoadModuleNotesDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadModuleNotesDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadModuleNotes(visitId:int, sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = service.LoadModuleNotesByVisitId(visitId,sessionDTO);			
			token.addResponder( command );
		}		

	}
}