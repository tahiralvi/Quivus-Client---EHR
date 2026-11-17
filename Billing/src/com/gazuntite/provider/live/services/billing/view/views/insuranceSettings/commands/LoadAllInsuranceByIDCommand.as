package com.gazuntite.provider.live.services.billing.view.views.insuranceSettings.commands
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.dto.AddInsuranceDTO;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	import com.gazuntite.provider.live.services.billing.view.views.insuranceSettings.delagates.LoadAllInsuranceByIDDelegate;
	import com.gazuntite.provider.live.services.billing.view.views.insuranceSettings.events.LoadAllInsuranceByIDEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class LoadAllInsuranceByIDCommand implements Command
	{
		public var callbackFunction				:Function;
		public var responder					:Responder ;
		public var delegate						:LoadAllInsuranceByIDDelegate ;
		public var LE							:LoadAllInsuranceByIDEvent ;
		public var model:BillingModelLocator	= BillingModelLocator.getInstance();
		public function execute(cgEvent:CairngormEvent):void
		{	
			
			responder	 			= new Responder(onSuccess,onFault);
			delegate  				= new LoadAllInsuranceByIDDelegate(responder);
			LE 						=  cgEvent as LoadAllInsuranceByIDEvent ;
			delegate.SearchInsurance(LE.index,LE.SearchString,LE.pageNumber);
			this.callbackFunction	= LE.callbackFunction;
		}
		public function onSuccess(successEvent:ResultEvent):void
		{	
			
			var insList:ArrayCollection	= new ArrayCollection()
			var xml	:XML 	= successEvent.result as XML 	;
			var insXmlList	:XMLList = xml.BillingInsurances.BillingInsurance;
						
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
			
			var i :int;
			for (i = 0; i<insXmlList.length(); i++)
			{
				var insuranceDto:AddInsuranceDTO	= new AddInsuranceDTO();
				insuranceDto.FromXML(insXmlList[i][0]);
				insList.addItem(insuranceDto);
			}
			model.InsList = insList ;
			
			if(this.callbackFunction != null)
				this.callbackFunction();
			
		}
		public function onFault(faultEvent:FaultEvent):void
		{
			Alert.show("Receieved in LoadInsuranceCommandByID"+ faultEvent.toString(),"Error",4,FlexGlobals.topLevelApplication.mainContainer);
		}
	}
}