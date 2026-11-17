package com.gazuntite.provider.live.services.billing.view.views.insuranceSettings.commands
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.view.views.insuranceSettings.delagates.ManageAllInsuranceDelegate;
	import com.gazuntite.provider.live.services.billing.view.views.insuranceSettings.events.ManageAllInsuranceEvent;
	
	import mx.controls.Alert;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class ManageAllInsuranceCommand implements Command
	{
		private var responder		 :Responder;
		private var callBackFunction :Function ;
		
		public function execute(cgEvent:CairngormEvent):void
		{
			responder = new Responder(result,fault)
			var delegate:ManageAllInsuranceDelegate = new ManageAllInsuranceDelegate(responder);
			var LE:ManageAllInsuranceEvent = cgEvent as ManageAllInsuranceEvent;
			this.callBackFunction         = LE.callBack;
			delegate.SaveInsurance(LE.xmlData);
		}
		public function result(rpcEvent:ResultEvent):void
		{
				
				if(this.callBackFunction!=null)
					this.callBackFunction(rpcEvent.result.toString().toLowerCase());
			
		}
		public function fault(rpcEvent:FaultEvent):void
		{
			Alert.show("Fault occured in ManageAllInsuranceCommand.\n"+rpcEvent.toString());
		}
	}
}