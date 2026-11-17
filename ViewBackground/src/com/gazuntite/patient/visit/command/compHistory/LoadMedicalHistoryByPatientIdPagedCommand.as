package com.gazuntite.patient.visit.command.compHistory
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.dto.pmh.compHistory.MedicalHistoryDTO;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.patient.visit.delegate.compHistory.LoadMedicalHistoryByPatientIdPagedDelegate;
	import com.gazuntite.patient.visit.dto.PageDTO;
	import com.gazuntite.patient.visit.event.compHistory.LoadMedicalHistoryByPatientIdPagedEvent;
	import com.gazuntite.patient.visit.model.VBModelLocator;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class LoadMedicalHistoryByPatientIdPagedCommand implements Command, IResponder
	{
		private var model:VBModelLocator = VBModelLocator.getInstance();
		private var LE:LoadMedicalHistoryByPatientIdPagedEvent;
		
		public function LoadMedicalHistoryByPatientIdPagedCommand()
		{
		}
		
		public function execute(event:CairngormEvent):void
		{
			if (model.LoggedInUserId)
			{
				LE = event as LoadMedicalHistoryByPatientIdPagedEvent;
				
				var page:PageDTO = model.medicalHistoryCurrentPageByPatient;
				
				if (!page)
					return;
				
				if (page && page.stationIDs && page.stationIDs.length < 1)
					page.stationIDs.addItem(model.LoggedInUserSelectedStationID);
				
				var pageXml:XML = page.toXML();
				
				var delegate:LoadMedicalHistoryByPatientIdPagedDelegate = new  LoadMedicalHistoryByPatientIdPagedDelegate(this);
				
				delegate.loadMedicalHistoryByPatientId(pageXml, model.patientID, model.LoggedInUserSelectedBranchId, model.LoggedInUserSessionID, true);
			}
		}
		
		public function result(rpcEvent:Object):void
		{
			if (model.LoggedInUserId)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				if (re.result)
				{
					var medicalHistoryPageDTO:XML = re.result as XML;
					
					if (medicalHistoryPageDTO)
					{
						var xList:XMLList = medicalHistoryPageDTO.children();
						
						var mHistoryListXml:XML = xList[0];
						
						var medicalHistoryList:XMLList = mHistoryListXml.children();
						
						if (medicalHistoryList)
						{
							var medicalHistoryDTOList:ArrayCollection = new ArrayCollection();
							
							for each(var x:XML in medicalHistoryList)
							{
								var medicalHistoryDTO:MedicalHistoryDTO = new MedicalHistoryDTO();
								
								medicalHistoryDTO.FromXML(x);
								
								medicalHistoryDTOList.addItem(medicalHistoryDTO);
								
							}
							
							model.medicalHistoryDTOListByPatient = medicalHistoryDTOList;
						}
						
						var pageDTO:PageDTO = new PageDTO();
						pageDTO.fromXML(xList[1]);
						
						model.medicalHistoryCurrentPageByPatient = pageDTO;
						
					}
				}
			}
			else
			{
				UtilityFunctions.ShowMessage("LoadMedicalHistoryByPatientIdPaged \n Service didnot respond.", "Info");
			}
		}
		
		public function fault(rpcEvent:Object):void
		{
			var errorStatus:String = "Fault occured in LoadMedicalHistoryByPatientIdPaged.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty(model.LoggedInUserId)? -1:model.LoggedInUserId;
			
			QSCombinedExceptionAlert.getInstance().Show(errorStatus, rpcEvent.toString(), userId); 
		}
	}
}