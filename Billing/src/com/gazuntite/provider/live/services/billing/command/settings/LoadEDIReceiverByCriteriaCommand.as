package com.gazuntite.provider.live.services.billing.command.settings
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.delegate.settings.LoadEDIReceiverByCriteriaDelegate;
	import com.gazuntite.provider.live.services.billing.dto.settings.EDIReceiverDTO;
	import com.gazuntite.provider.live.services.billing.event.settings.LoadEDIReceiverByCriteriaEvent;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	
	import flash.display.Sprite;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class LoadEDIReceiverByCriteriaCommand implements Command
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadEDIReceiverByCriteriaDelegate;		
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadEDIReceiverByCriteriaDelegate( responder );			
			
			var LE:LoadEDIReceiverByCriteriaEvent = cgEvent as LoadEDIReceiverByCriteriaEvent;
			
			callBack = LE.callBack;						
			delegate.SearchEDIReceiverList(LE.searchType, LE.searchString, LE.pageNo  );
						
		}
		
		private function onSuccess(event:ResultEvent):void
		{			
			var list:ArrayCollection = new ArrayCollection();
			
			var ResultXml:XML = event.result as XML
			var xEDIReceivers:XMLList = ResultXml.EDIReceivers.EDIReceiver;
			var i:int = 0;					
			for( i = 0; i < xEDIReceivers.length(); i++ )
			{
				var ct:EDIReceiverDTO = new EDIReceiverDTO();
				ct.FromXML( xEDIReceivers[i][0] );
				list.addItem( ct );
			}
			
			model.totalrecords_ER = event.result.Paging.@['Total'];
			model.firstRecord_ER = event.result.Paging.@['First'];
			model.lastRecord_ER = event.result.Paging.@['Last'];
			
			if(model.totalrecords_ER < BillingConstants.PAGE_SIZE)
				model.EDIReceiverTotalPageNo = 1;
			else
			{
				var num:int = model.totalrecords_ER % BillingConstants.PAGE_SIZE;
				if(num == 0)
				{
					model.EDIReceiverTotalPageNo = model.totalrecords_ER / BillingConstants.PAGE_SIZE;
				}
				else
				{
					model.EDIReceiverTotalPageNo = model.totalrecords_ER / BillingConstants.PAGE_SIZE + 1;
				}
			}
			
			if(model.totalrecords_ER > 0)
				model.totalRecordMessage_ER = "Total Records ("+ model.totalrecords_ER.toString() +")";
			else
				model.totalRecordMessage_ER = "No record found";			
			
			if(model.isEDIReceiverGeneralList == true)
			{
				model.EDIReceiverList = list;	
				model.EDIReceiverListForSetup = list;
			}
			else
				model.EDIReceiverListForSetup = list;
			
			if( null != callBack )
				callBack();			
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show("Received In LoadEDIReceiverByCriteriaCommand.\n" + event.toString(), BillingConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
		}
	}
}