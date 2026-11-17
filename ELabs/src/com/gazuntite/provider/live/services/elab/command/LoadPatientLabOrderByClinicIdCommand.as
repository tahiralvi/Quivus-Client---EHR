package com.gazuntite.provider.live.services.elab.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.common.util.xml.XmlConstants;
	import com.gazuntite.provider.live.services.elab.delegate.LoadPatientLabOdersByClinicIdDelegate;
	import com.gazuntite.provider.live.services.elab.dto.LabListDTO;
	import com.gazuntite.provider.live.services.elab.event.LoadPatientLabOrdersByClinicIdEvent;
	import com.gazuntite.provider.live.services.elab.model.ELabsAppModelLocator;
	import com.gazuntite.provider.live.services.elab.util.ELabsConstant;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class LoadPatientLabOrderByClinicIdCommand implements Command
	{
		private var model:ELabsAppModelLocator = ELabsAppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadPatientLabOdersByClinicIdDelegate;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadPatientLabOdersByClinicIdDelegate( responder );			
		
			var LE:LoadPatientLabOrdersByClinicIdEvent = cgEvent as LoadPatientLabOrdersByClinicIdEvent;
			
			if( LE.pageNo > 0 )
			{
				delegate.LoadPatientLabOdersByClinicId( model.LoggedInUserSelectedBranchId, LE.pageNo );
			}
		}
			
		private function onSuccess(event:ResultEvent):void
		{
			var result:XML = event.result as XML;
			var xStatus:XML = result.Status[0];
			var type:String = xStatus.@[XmlConstants.TYPE];
			if( type.toLowerCase() == "success")
			{
				var lol:LabListDTO = new LabListDTO();
				lol.FromXML( result );
				
				model.LabOrderListDto = lol;
			}
			else
			{
				Alert.show("LoadPatientLabOrderByClinic\nServer Responded with status type " + type + "\n server status message is " + xStatus.@[XmlConstants.MESSAGE], "Response status " + type );
			}
			trace( event.result );
		}
		
		private function onError(event:FaultEvent):void
		{
			//Alert.show("Received In LoadPatientLabOrderByClinicIdCommand.\n" + event.toString(), ELabsConstant.ERROR, 4, FlexGlobals.topLevelApplication.mainContainer );
			
			var errorStatus:String = "Fault occured in LoadPatientLabOrderByClinicIdCommand.";
			
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, event.toString(), model.LoggedInUserId ); 
		}
	}
}