package com.gazuntite.provider.live.services.billing.command.accountsAndReceiveables
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.delegate.accountsAndReceiveables.LoadPatientAccountDelegate;
	import com.gazuntite.provider.live.services.billing.dto.accountsAndReceiveables.PatientAccountDTO;
	import com.gazuntite.provider.live.services.billing.event.accountsAndReceiveables.LoadPatientAccountEvent;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class LoadPatientAccountCommand implements Command
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadPatientAccountDelegate;		
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadPatientAccountDelegate( responder );			
			
			var LE:LoadPatientAccountEvent = cgEvent as LoadPatientAccountEvent;
			
			callBack = LE.callback;
			
			delegate.SearchPatientAccount(LE.patientId, LE.clinicBranchId );
			
		}
		
		private function onSuccess(event:ResultEvent):void
		{			
			var xPatientAccountXml:XML = event.result as XML ;		
						
			var patientAccount:PatientAccountDTO =  new PatientAccountDTO();
			patientAccount.FromXML(xPatientAccountXml as XML);	
			model.CurrentPatienAccount = patientAccount;		
			
			if( null != callBack )
				callBack();			
			
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show("Received In LoadPatientAccountCommand.\n" + event.toString(), BillingConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
		}
	}
}