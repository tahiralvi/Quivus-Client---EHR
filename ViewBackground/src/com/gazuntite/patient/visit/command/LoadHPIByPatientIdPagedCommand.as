package com.gazuntite.patient.visit.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.dto.physical.ccHpi.HPI_CCDTO;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.patient.visit.delegate.LoadHPIByPatientIdPagedDelegate;
	import com.gazuntite.patient.visit.dto.PageDTO;
	import com.gazuntite.patient.visit.event.LoadHPIByPatientIdPagedEvent;
	import com.gazuntite.patient.visit.event.LoadVitalsByPatientIdPagedEvent;
	import com.gazuntite.patient.visit.model.VBModelLocator;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class LoadHPIByPatientIdPagedCommand implements Command, IResponder
	{
		private var model:VBModelLocator = VBModelLocator.getInstance();
		private var LE:LoadHPIByPatientIdPagedEvent;
		
		public function LoadHPIByPatientIdPagedCommand()
		{
		}
		
		public function execute(event:CairngormEvent):void
		{
			if (model.LoggedInUserId)
			{
				LE = event as LoadHPIByPatientIdPagedEvent;
				
				var page:PageDTO = model.HPI_CCCurrentPageByPatient;
				
				if (!page)
					return;
				
				if (page && page.stationIDs && page.stationIDs.length < 1)
					page.stationIDs.addItem(model.LoggedInUserSelectedStationID);
				
				var xml2Send:XML = page.toXML();
				
				var delegate:LoadHPIByPatientIdPagedDelegate = new LoadHPIByPatientIdPagedDelegate(this);
				delegate.loadHPIByPatientIdPaged(xml2Send, model.patientID, model.LoggedInUserSelectedBranchId, model.LoggedInUserSessionID, true);
			}
		}
		
		public function result(rpcEvent:Object):void
		{
			if (model.LoggedInUserId)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				if (re.result)
				{
					var hpiCcPageDTO:XML = XML(re.result);
					
					var xList:XMLList = hpiCcPageDTO.children();
					
					var ccList:XML = xList[0];
					
					var hpiCcList:XMLList = ccList.children();
					
					if (hpiCcList)
					{
						var hpiCcDTOList:ArrayCollection = new ArrayCollection();
						
						for each (var x:XML in hpiCcList)
						{
							var hpiCcDTO:HPI_CCDTO = new HPI_CCDTO();
							
							hpiCcDTO.FromXML(x);
							
							hpiCcDTOList.addItem(hpiCcDTO);
						}
						
						model.HPI_CCDTOListByPatient = hpiCcDTOList;
					}
					
					var pageDTO:PageDTO = new PageDTO();
					pageDTO.fromXML(xList[1]);
					
					model.HPI_CCCurrentPageByPatient = pageDTO;
				}
			}
			else
			{
				UtilityFunctions.ShowMessage("LoadHPIByPatientIdPaged \n Service didnot respond.", "Info");
			}
		}
		
		public function fault(rpcEvent:Object):void
		{
			var errorStatus:String = "Fault occured in LoadHPIByPatientIdPaged.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.LoggedInUserId ) ? -1 : model.LoggedInUserId;
			
			QSCombinedExceptionAlert.getInstance().Show(errorStatus, rpcEvent.toString(), userId);
		}
	}
}