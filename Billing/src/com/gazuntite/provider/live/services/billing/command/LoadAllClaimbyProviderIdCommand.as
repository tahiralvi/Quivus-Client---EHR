package com.gazuntite.provider.live.services.billing.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.delegate.LoadAllClaimbyProviderIdDelegate;
	import com.gazuntite.provider.live.services.billing.dto.SearchClaimResultsList;
	import com.gazuntite.provider.live.services.billing.event.LoadAllClaimbyProviderIdEvent;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class LoadAllClaimbyProviderIdCommand implements Command
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadAllClaimbyProviderIdDelegate;		
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadAllClaimbyProviderIdDelegate( responder );			
		
			var LE:LoadAllClaimbyProviderIdEvent = cgEvent as LoadAllClaimbyProviderIdEvent;
			
			callBack = LE.callBack;
			if( LE.providerId > 0 )
			{				
				delegate.SearchClaimList( LE.providerId, LE.clinicBranchId, LE.pageNo  );
			}			
		}
			
		private function onSuccess(event:ResultEvent):void
		{			
			trace( "onSuccess start "  )
			
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
				model.totalRecordMessage_CM = "No record found";
			/*else if (searchType == 0 || searchType == 9)
			{
				model.totalRecordMessage_CM = "No record found";
			}
			else
			{
				model.totalRecordMessage_CM = "No record found against given ";
				switch(searchType)
				{
					case 1:
					{
						model.totalRecordMessage_CM += "patient";
						break;
					}						
					case 2:
					{
						model.totalRecordMessage_CM += "provider";
						break;
					}
					case 3:
					{
						model.totalRecordMessage_CM += "date of service";
						break;
					}
				}
			}*/
			
			model.SearchClaimResults = csl;		
			
			trace( "model updated "  )
			
			if( null != callBack )
				callBack();			
			
			trace( " after callBack() "  )
			
			trace( "on result found record ", csl.Claims.length );
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show("Received In LoadAllClaimbyProviderIdCommand.\n" + event.toString(), BillingConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
		}
	}
}