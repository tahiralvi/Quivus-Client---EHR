package com.gazuntite.provider.live.services.billing.command.ClaimManagement
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.delegate.ClaimManagement.LoadClaimByCriteriaDelegate;
	import com.gazuntite.provider.live.services.billing.dto.SearchClaimResultsList;
	import com.gazuntite.provider.live.services.billing.event.ClaimManagement.LoadClaimByCriteriaEvent;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class LoadClaimByCriteriaCommand implements Command
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadClaimByCriteriaDelegate;		
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadClaimByCriteriaDelegate( responder );			
			
			var LE:LoadClaimByCriteriaEvent = cgEvent as LoadClaimByCriteriaEvent;
			
			callBack = LE.callBack;
							
			delegate.SearchClaimList( LE.searchDetail );
					
		}
		
		private function onSuccess(event:ResultEvent):void
		{			
			var csl:SearchClaimResultsList = new SearchClaimResultsList();
			csl.FromXML( event.result as XML );
			
			model.totalrecords_CM = event.result.Paging.@['Total'];
			model.firstRecord_CM = event.result.Paging.@['First'];
			model.lastRecord_CM = event.result.Paging.@['Last'];
			
			if(model.totalrecords_CM < BillingConstants.PAGE_SIZE)
				model.ClaimManagementTotalPageNo = 1;
			else
			{
				var num:int = model.totalrecords_CM % BillingConstants.PAGE_SIZE;
				if(num == 0)
				{
					model.ClaimManagementTotalPageNo = model.totalrecords_CM / BillingConstants.PAGE_SIZE;
				}
				else
				{
					model.ClaimManagementTotalPageNo = model.totalrecords_CM / BillingConstants.PAGE_SIZE + 1;
				}
			}
			
			if(model.totalrecords_CM > 0)
				model.totalRecordMessage_CM = "Total Records ("+ model.totalrecords_CM.toString() +")";
			else
				model.totalRecordMessage_CM = "No record found for given criteria";			
			
			model.SearchClaimResults = csl;		
			
			if( null != callBack )
				callBack();			
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show("Received In LoadAllClaimbyProviderIdCommand.\n" + event.toString(), BillingConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
		}
	}
}