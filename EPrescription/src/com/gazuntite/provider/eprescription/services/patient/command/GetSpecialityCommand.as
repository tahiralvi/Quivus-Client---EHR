package com.gazuntite.provider.eprescription.services.patient.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.eprescription.services.patient.delegate.GetSpecialityDelegate;
	import com.gazuntite.provider.eprescription.services.patient.event.GetSpecialityEvent;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.ResultEvent;
	
	public class GetSpecialityCommand  implements Command 
	{
		private var responder:Responder;
		private var delegate:GetSpecialityDelegate;
		private var LE:GetSpecialityEvent;
		
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(result, fault);				
			delegate  = new GetSpecialityDelegate( responder );			
			
			var LE:GetSpecialityEvent = cgEvent as GetSpecialityEvent;
			
			callBack = LE.resultHandlerFunction;
			delegate.GetSpeciality(LE.data);
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
			Alert.show("Fault occured in GetSpecialityCommand.\n"+rpcEvent.toString(), 'Info', 4, FlexGlobals.topLevelApplication.mainContainer);
		}
	}
}