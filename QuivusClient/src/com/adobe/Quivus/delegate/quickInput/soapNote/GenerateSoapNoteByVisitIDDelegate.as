package com.adobe.Quivus.delegate.quickInput.soapNote
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class GenerateSoapNoteByVisitIDDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
		
		public function GenerateSoapNoteByVisitIDDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function GenerateSoapNoteByVisitID(VisitID:int , userSession:UserSessionDTO , clinicbranchId:int , stationIds:ArrayCollection, isAllSelected:Boolean ) : void 
		{
			var token:AsyncToken = (service ).GenerateSoapNoteByVisitID( VisitID, userSession, clinicbranchId , stationIds, isAllSelected);			
			token.addResponder( command );
		}
	}
}