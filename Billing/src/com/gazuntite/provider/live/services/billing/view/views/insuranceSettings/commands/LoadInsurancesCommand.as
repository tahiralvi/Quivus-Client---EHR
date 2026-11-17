package com.gazuntite.provider.live.services.billing.view.views.insuranceSettings.commands
{
	
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.dto.AddInsuranceDTO;
	import com.gazuntite.common.util.QSConstants;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	import com.gazuntite.provider.live.services.billing.view.views.insuranceSettings.delagates.LoadInsurancesDelegate;
	import com.gazuntite.provider.live.services.billing.view.views.insuranceSettings.events.LoadInsurancesEvent;
	
	import flash.display.Sprite;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class LoadInsurancesCommand implements Command
	{
		
		public var callBackFunction:Function ;
		public var responder:Responder;
		public var LE:LoadInsurancesEvent ;
		public var delegate:LoadInsurancesDelegate;
		public var model:BillingModelLocator = BillingModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{
			responder = new Responder(onSuccess,onFault);
			delegate = new LoadInsurancesDelegate(responder);
			LE = event as LoadInsurancesEvent;
			this.callBackFunction = LE.callBackFunction ;
			delegate.LoadInsurance(LE.pageNumber);
		}
		public function onSuccess(successEvent:ResultEvent):void
		{
			
			model.InsList 			= new ArrayCollection();
			var xml:XML 			= successEvent.result as  XML;
						
			model.totalrecords_IS = xml.Paging.@['Total'];
			model.firstRecord_IS = xml.Paging.@['First'];
			model.lastRecord_IS = xml.Paging.@['Last'];
			
			if(model.totalrecords_IS < BillingConstants.PAGE_SIZE)
				model.InsuranceSetupTotalPageNo = 1;
			else
			{
				var num:int = model.totalrecords_IS % BillingConstants.PAGE_SIZE;
				if(num == 0)
				{
					model.InsuranceSetupTotalPageNo = model.totalrecords_IS / BillingConstants.PAGE_SIZE;
				}
				else
				{
					model.InsuranceSetupTotalPageNo = model.totalrecords_IS / BillingConstants.PAGE_SIZE + 1;
				}
			}
			
			if(model.totalrecords_IS > 0)
				model.totalRecordMessage_IS = "Total Records ("+ model.totalrecords_IS.toString() +")";
			else
				model.totalRecordMessage_IS = "No record found for given criteria";	
			
			var xmlList:XMLList 	= xml.BillingInsurances.BillingInsurance;
			var i :int;
			for(i=0;i < xmlList.length();i++)
			{
				var insuranceDto:AddInsuranceDTO		= new AddInsuranceDTO();
				insuranceDto.FromXML(xmlList[i][0]);
				model.InsList.addItem(insuranceDto );
				
			}
			
			if(null!= callBackFunction)
				this.callBackFunction();
		}
		public function onFault(faultEvent:FaultEvent):void
		{
			Alert.show("Received In LoadAllInsuranceCommand.\n" + faultEvent.toString(), QSConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
		}
		
		
	}
}