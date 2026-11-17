package com.gazuntite.provider.eprescription.services.patient.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.eprescription.services.patient.delegate.CreateVisitDelegate;
	import com.gazuntite.provider.eprescription.services.patient.event.CreateVisitEvent;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.ResultEvent;
	
	public class CreateVisitCommand  implements Command 
	{
		private var responder:Responder;
		private var delegate:CreateVisitDelegate;
		private var LE:CreateVisitEvent;
		
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(result, fault);				
			delegate  = new CreateVisitDelegate( responder );			
			
			var LE:CreateVisitEvent = cgEvent as CreateVisitEvent;
			
			callBack = LE.functionName;
			var d:Date = new Date();
			
			delegate.CreateVisit(LE.data, LE.userId, d);
		}
		
		public function result(  rpcEvent : ResultEvent ) : void 
		{
			if( null != callBack )
				callBack(new XML(rpcEvent.message.body.toString()) );
		}
		
		public function fault( rpcEvent : Object ) : void 
		{
			Alert.show("Fault occured in CreateVisitCommand.\n"+rpcEvent.toString(), 'Info', 4, FlexGlobals.topLevelApplication.mainContainer);
		}
	}
}