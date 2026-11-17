package com.gazuntite.provider.live.services.billing.command.ClaimManagement
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.delegate.ClaimManagement.ClaimPatientSearchDelegate;
	import com.gazuntite.provider.live.services.billing.dto.SuperBill.SuperBillPatientInfoDTO;
	import com.gazuntite.provider.live.services.billing.event.ClaimManagement.ClaimPatientSearchEvent;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	
	import flash.display.Sprite;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class ClaimPatientSearchCommand implements Command
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:ClaimPatientSearchDelegate;		
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new ClaimPatientSearchDelegate( responder );			
			
			var LE:ClaimPatientSearchEvent = cgEvent as ClaimPatientSearchEvent;
			
			callBack = LE.callBack;
			if( LE.clinicBranchId > 0 )
			{				
				delegate.SearchClaimPatientList( LE.clinicBranchId  );
			}			
		}
		
		private function onSuccess(event:ResultEvent):void
		{			
			var Types:ArrayCollection =new ArrayCollection();
			
			var ResultXml:XML = event.result as XML
			var xClaimPatients:XMLList = ResultXml.ClaimPatients.Patient;
			var i:int = 0;					
			for( i = 0; i < xClaimPatients.length(); i++ )
			{
				var ct:SuperBillPatientInfoDTO = new SuperBillPatientInfoDTO();
				ct.FromXML( xClaimPatients[i][0] );
				Types.addItem( ct );
			}		
			
			model.ClaimPatientList = Types;
			model.PatienListForAccount = Types;
			
			if( null != callBack )
				callBack();			
			
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show("Received In ClaimPatientSearchCommand.\n" + event.toString(), BillingConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
		}
	}
}