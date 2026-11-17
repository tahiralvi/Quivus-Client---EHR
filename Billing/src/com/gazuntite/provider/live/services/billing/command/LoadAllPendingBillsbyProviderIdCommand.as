package com.gazuntite.provider.live.services.billing.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.delegate.LoadAllPendingBillsbyProviderIdDelegate;
	import com.gazuntite.provider.live.services.billing.dto.SearchPendingBillsResultList;
	import com.gazuntite.provider.live.services.billing.event.LoadAllPendingBillsbyProviderIdEvent;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class LoadAllPendingBillsbyProviderIdCommand implements Command
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadAllPendingBillsbyProviderIdDelegate;		
		private var callBack			: Function;
		
		private var searchType		    : int;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadAllPendingBillsbyProviderIdDelegate( responder );			
			
			var LE:LoadAllPendingBillsbyProviderIdEvent = cgEvent as LoadAllPendingBillsbyProviderIdEvent;
			
			callBack = LE.callBack;
			searchType = LE.searchType;
			if( LE.providerId > 0 )
			{				
				delegate.SearchPendingBillsList(LE.providerId,LE.clinicBranchId );
			}	
			else
			{
				delegate.SearchPendingBillsList(LE.providerId,LE.clinicBranchId,LE.searchType,LE.searchString,LE.pageNumber );
			}
		}
		
		private function onSuccess(event:ResultEvent):void
		{			
			trace( "onSuccess start "  )
			
			var csl:SearchPendingBillsResultList = new SearchPendingBillsResultList();
			csl.FromXML( event.result as XML );
			model.totalrecords_PB = event.result.Paging.@['Total'];
			model.firstRecord_PB = event.result.Paging.@['First'];
			model.lastRecord_PB = event.result.Paging.@['Last'];
			//model.currentRecordNo_PB = model.firstRecord_PB - 2;
			
			if(model.totalrecords_PB > 0)
				model.totalRecordMessage_PB = "Total Records ("+ model.totalrecords_PB.toString() +")";
			else if (searchType == 0 || searchType == 9)
			{
				model.totalRecordMessage_PB = "No record found";
			}
			else
			{
				model.totalRecordMessage_PB = "No record found against given ";
				switch(searchType)
				{
					case 1:
					{
						model.totalRecordMessage_PB += "patient";
						break;
					}						
					case 2:
					{
						model.totalRecordMessage_PB += "provider";
						break;
					}
					case 3:
					{
						model.totalRecordMessage_PB += "date of service";
						break;
					}
				}
			}
			
			
			if(model.totalrecords_PB < BillingConstants.PAGE_SIZE)
				model.PendingBillTotalPageNo = 1;
			else
			{
				var num:int = model.totalrecords_PB % BillingConstants.PAGE_SIZE;
				if(num == 0)
				{
					model.PendingBillTotalPageNo = model.totalrecords_PB / BillingConstants.PAGE_SIZE;
				}
				else
				{
					model.PendingBillTotalPageNo = model.totalrecords_PB / BillingConstants.PAGE_SIZE + 1;
				}
			}
			
			model.SearchPendingBillsResults = csl;		
			
			trace( "model updated "  )
			
			if( null != callBack )
				callBack();			
			
			trace( " after callBack() "  )
			
			trace( "on result found record ", csl.PendingBills.length );
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show("Received In LoadAllPendingBillsbyProviderIdCommand.\n" + event.toString(), BillingConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
		}
	}
}