package com.gazuntite.patient.visit.command.compHistory
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.dto.pmh.compHistory.FamilyHistoryDTO;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.patient.visit.delegate.compHistory.LoadFamilyHistoryByPatientIdPagedDelegate;
	import com.gazuntite.patient.visit.dto.PageDTO;
	import com.gazuntite.patient.visit.event.compHistory.LoadFamilyHistoryByPatientIdPagedEvent;
	import com.gazuntite.patient.visit.model.VBModelLocator;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class LoadFamilyHistoryByPatientIdPagedCommand implements Command, IResponder
	{
		private var model:VBModelLocator = VBModelLocator.getInstance();
		private var LE:LoadFamilyHistoryByPatientIdPagedEvent;
		
		public function LoadFamilyHistoryByPatientIdPagedCommand()
		{
		}
		
		public function execute(event:CairngormEvent):void
		{
			if (model.LoggedInUserId)
			{
				LE = event as LoadFamilyHistoryByPatientIdPagedEvent;
				
				var page:PageDTO = model.familyHistoryCurrentPageByPatient;
				
				if (!page)
					return;
				
				if (page && page.stationIDs && page.stationIDs.length < 1)
					page.stationIDs.addItem(model.LoggedInUserSelectedStationID);
				
				var pageXml:XML = page.toXML();
				
				var delegate:LoadFamilyHistoryByPatientIdPagedDelegate = new  LoadFamilyHistoryByPatientIdPagedDelegate(this);
				
				delegate.loadFamilyHistoryByPatientIdPaged(pageXml, model.patientID, model.LoggedInUserSelectedBranchId, model.LoggedInUserSessionID, true);
			}
		}
		
		public function result(rpcEvent:Object):void
		{
			if (model.LoggedInUserId)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				if (re.result)
				{
					var familyHistoryPageDTO:XML = re.result as XML;
					
					if (familyHistoryPageDTO)
					{
						var xList:XMLList = familyHistoryPageDTO.children();
						
						var fHistoryListXml:XML = xList[0];
						
						var familyHistoryList:XMLList = fHistoryListXml.children();
						
						if (familyHistoryList)
						{
							var familyHistoryDTOList:ArrayCollection = new ArrayCollection();
							
							for each(var x:XML in familyHistoryList)
							{
								var familyHistoryDTO:FamilyHistoryDTO = new FamilyHistoryDTO();
								
								familyHistoryDTO.FromXML(x);
								
								familyHistoryDTOList.addItem(familyHistoryDTO);
								
							}
							
							model.familyHistoryDTOListByPatient = familyHistoryDTOList;
						}
						
						var pageDTO:PageDTO = new PageDTO();
						pageDTO.fromXML(xList[1]);
						
						model.familyHistoryCurrentPageByPatient = pageDTO;
						
					}
				}
			}
			else
			{
				UtilityFunctions.ShowMessage("LoadFamilyHistoryByPatientIdPaged \n Service didnot respond.", "Info");
			}
		}
		
		public function fault(rpcEvent:Object):void
		{
			var errorStatus:String = "Fault occured in LoadFamilyHistoryByPatientIdPaged.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty(model.LoggedInUserId)? -1:model.LoggedInUserId;
			
			QSCombinedExceptionAlert.getInstance().Show(errorStatus, rpcEvent.toString(), userId); 
		}
	}
}