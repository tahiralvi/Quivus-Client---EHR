package com.gazuntite.provider.live.services.billing.command.accountsAndReceiveables
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.delegate.accountsAndReceiveables.LoadPatientStatementDelegate;
	import com.gazuntite.provider.live.services.billing.dto.accountsAndReceiveables.PatientStatementDTO;
	import com.gazuntite.provider.live.services.billing.dto.accountsAndReceiveables.StatementPatientDetailDTO;
	import com.gazuntite.provider.live.services.billing.event.accountsAndReceiveables.LoadPatientStatementEvent;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	
	import flash.display.Sprite;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class LoadPatientStatementCommand implements Command
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadPatientStatementDelegate;		
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadPatientStatementDelegate( responder );			
			
			var LE:LoadPatientStatementEvent = cgEvent as LoadPatientStatementEvent;
			
			callBack = LE.callBack;
			
			delegate.SearchStatementList(LE.searchType, LE.searchString, LE.clinicBranchId, LE.pageNo );
			
		}
		
		private function onSuccess(event:ResultEvent):void
		{	
			
			model.totalrecords_PS = event.result.Paging.@['Total'];
			model.firstRecord_PS = event.result.Paging.@['First'];
			model.lastRecord_PS = event.result.Paging.@['Last'];
			
			if(model.totalrecords_PS < BillingConstants.PAGE_SIZE)
				model.PatientStatementTotalPageNo = 1;
			else
			{
				var num:int = model.totalrecords_PS % BillingConstants.PAGE_SIZE;
				if(num == 0)
				{
					model.PatientStatementTotalPageNo = model.totalrecords_PS / BillingConstants.PAGE_SIZE;
				}
				else
				{
					model.PatientStatementTotalPageNo = model.totalrecords_PS / BillingConstants.PAGE_SIZE + 1;
				}
			}
			
			if(model.totalrecords_PS > 0)
				model.totalRecordMessage_PS = "Total Records ("+ model.totalrecords_PS.toString() +")";
			else
				model.totalRecordMessage_PS = "No record found for given criteria";			
			
			var result:XML = event.result as XML ;		
			
			model.PatientStatementList = new ArrayCollection();
			
			var xStatements:XMLList = result.PatientStatements.PatientStatement;
			for(var ic:int = 0; ic < xStatements.length(); ic++)
			{
				var ps:PatientStatementDTO = new PatientStatementDTO();
				ps.FromXML( xStatements[ic] );
				model.PatientStatementList.addItem(ps);
			}
			
			model.StatementPatientDetailList = new ArrayCollection();
			
			var xPatients:XMLList = result.StatementPatients.StatementPatient;
			for(var i:int = 0; i < xPatients.length(); i++)
			{
				var spd:StatementPatientDetailDTO = new StatementPatientDetailDTO();
				spd.FromXML( xPatients[i] );
				model.StatementPatientDetailList.addItem(spd);
			}	
			
			if( null != callBack )
				callBack();			
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show("Received In LoadPatientStatementCommand.\n" + event.toString(), BillingConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
		}
	}
}