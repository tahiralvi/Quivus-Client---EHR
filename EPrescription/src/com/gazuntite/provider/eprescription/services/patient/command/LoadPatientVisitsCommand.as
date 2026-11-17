package com.gazuntite.provider.eprescription.services.patient.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.eprescription.services.patient.delegate.LoadPatientVisitsDelegate;
	import com.gazuntite.provider.eprescription.services.patient.event.LoadPatientVisitsEvent;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.ResultEvent;
	
	public class LoadPatientVisitsCommand  implements Command 
	{
		private var responder:Responder;
		private var delegate:LoadPatientVisitsDelegate;
		private var LE:LoadPatientVisitsEvent;
		
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			
			responder = new Responder(result, fault);				
			delegate  = new LoadPatientVisitsDelegate( responder );			
			
			var LE:LoadPatientVisitsEvent = cgEvent as LoadPatientVisitsEvent;
			
			callBack = LE.resultHandlerFunction;
			
			var d:Date = new Date();
			delegate.GetVisit(LE.userId, LE.clinicBranchId);
		}
		
		public function result( rpcEvent : ResultEvent ) : void 
		{										
			if( null != callBack )
			{
				callBack(new XML(rpcEvent.message.body.toString()));
			}
		}
		
		public function fault( rpcEvent : Object ) : void 
		{
			Alert.show("Fault occured in LoadPatientVisitsCommand.\n"+rpcEvent.toString(), 'info', 4, FlexGlobals.topLevelApplication.mainContainer);
		}
	}
}