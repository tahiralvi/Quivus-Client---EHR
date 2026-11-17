package com.gazuntite.patient.visit.command.compHistory
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.dto.pmh.compHistory.SocialHistoryDTO;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.patient.visit.delegate.compHistory.LoadSocialHistoryByPatientIdPagedDelegate;
	import com.gazuntite.patient.visit.dto.PageDTO;
	import com.gazuntite.patient.visit.event.compHistory.LoadSocialHistoryByPatientIdPagedEvent;
	import com.gazuntite.patient.visit.model.VBModelLocator;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class LoadSocialHistoryByPatientIdPagedCommand implements Command, IResponder
	{
		private var model:VBModelLocator = VBModelLocator.getInstance();
		private var LE:LoadSocialHistoryByPatientIdPagedEvent;
		
		public function LoadSocialHistoryByPatientIdPagedCommand()
		{
		}
		
		public function execute(event:CairngormEvent):void
		{
			if (model.LoggedInUserId)
			{
				LE = event as LoadSocialHistoryByPatientIdPagedEvent;
				
				var page:PageDTO = model.socialHistoryCurrentPageByPatient;
				
				if (!page)
					return;
				
				if (page && page.stationIDs && page.stationIDs.length < 1)
					page.stationIDs.addItem(model.LoggedInUserSelectedStationID);
				
				var pageXml:XML = page.toXML();
				
				var delegate:LoadSocialHistoryByPatientIdPagedDelegate = new  LoadSocialHistoryByPatientIdPagedDelegate(this);
				
				delegate.loadSocialHistoryByPatientIdPaged(pageXml, model.patientID, model.LoggedInUserSelectedBranchId, model.LoggedInUserSessionID, true);
			}
		}
		
		public function result(rpcEvent:Object):void
		{
			if (model.LoggedInUserId)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				if (re.result)
				{
					var socialHistoryPageDTO:XML = re.result as XML;
					
					if (socialHistoryPageDTO)
					{
						var xList:XMLList = socialHistoryPageDTO.children();
						
						var sHistoryListXml:XML = xList[0];
						
						var socialHistoryList:XMLList = sHistoryListXml.children();
						
						if (socialHistoryList)
						{
							var socialHistoryDTOList:ArrayCollection = new ArrayCollection();
							
							for each(var x:XML in socialHistoryList)
							{
								var socialHistoryDTO:SocialHistoryDTO = new SocialHistoryDTO();
								
								socialHistoryDTO.FromXML(x);
								
								socialHistoryDTOList.addItem(socialHistoryDTO);
							}
							
							model.socialHistoryDTOListByPatient = socialHistoryDTOList;
						}
						
						var pageDTO:PageDTO = new PageDTO();
						pageDTO.fromXML(xList[1]);
						
						model.socialHistoryCurrentPageByPatient = pageDTO;
						
					}
				}
			}
			else
			{
				UtilityFunctions.ShowMessage("LoadSocialHistoryByPatientIdPaged \n Service didnot respond.", "Info");
			}
		}
		
		public function fault(rpcEvent:Object):void
		{
			var errorStatus:String = "Fault occured in LoadSocialHistoryByPatientIdPaged.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty(model.LoggedInUserId)? -1:model.LoggedInUserId;
			
			QSCombinedExceptionAlert.getInstance().Show(errorStatus, rpcEvent.toString(), userId); 
		}
	}
}