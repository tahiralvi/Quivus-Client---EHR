package com.gazuntite.patient.visit.command.labs
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.dto.physical.labIn.InHouseLabDTO;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.patient.visit.delegate.labs.LoadInHouseLabsByPatientIdPagedDelegate;
	import com.gazuntite.patient.visit.dto.PageDTO;
	import com.gazuntite.patient.visit.event.labs.LoadInHouseLabsByPatientIdPagedEvent;
	import com.gazuntite.patient.visit.model.VBModelLocator;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class LoadInHouseLabsByPatientIdPagedCommand implements Command, IResponder
	{
		private var model:VBModelLocator = VBModelLocator.getInstance();
		private var LE:LoadInHouseLabsByPatientIdPagedEvent;
		
		public function LoadInHouseLabsByPatientIdPagedCommand()
		{
		}
		
		public function execute(event:CairngormEvent):void
		{
			if (model.LoggedInUserId)
			{
				LE = event as LoadInHouseLabsByPatientIdPagedEvent;
				
				var page:PageDTO = model.inHouseLabCurrentPageByPatient;
				
				if (!page)
					return;
				
				if (page && page.stationIDs && page.stationIDs.length < 1)
					page.stationIDs.addItem(model.LoggedInUserSelectedStationID);
				
				var xml2Send:XML = page.toXML();
				
				var delegate:LoadInHouseLabsByPatientIdPagedDelegate = new LoadInHouseLabsByPatientIdPagedDelegate(this);
				delegate.loadPatientInHouseLabsByPatientIdPaged(xml2Send, model.patientID, model.LoggedInUserSelectedBranchId, model.LoggedInUserSessionID, true);
			}
		}
		
		public function result(rpcEvent:Object):void
		{
			if (model.LoggedInUserId)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				if (re.result)
				{
					var inHouseLabPageDTO:XML = XML(re.result);
					
					var xList:XMLList = inHouseLabPageDTO.children();
					
					var lList:XML = xList[0];
					
					var inHouseLabList:XMLList = lList.children();
					
					if (inHouseLabList)
					{
						var inHouseLabDTOList:ArrayCollection = new ArrayCollection();
						
						for each (var x:XML in inHouseLabList)
						{
							var inHouseLabDTO:InHouseLabDTO = new InHouseLabDTO();
							
							inHouseLabDTO.FromXML(x);
							
							inHouseLabDTOList.addItem(inHouseLabDTO);
						}
						
						model.inHouseLabDTOListByPatient = inHouseLabDTOList;
					}
					
					var pageDTO:PageDTO = new PageDTO();
					pageDTO.fromXML(xList[1]);
					
					model.inHouseLabCurrentPageByPatient = pageDTO;
				}
			}
			else
			{
				UtilityFunctions.ShowMessage("LoadInHouseLabsByPatientIdPaged \n Service didnot respond.", "Info");
			}
		}
		
		public function fault(rpcEvent:Object):void
		{
			var errorStatus:String = "Fault occured in LoadInHouseLabsByPatientIdPaged.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.LoggedInUserId ) ? -1 : model.LoggedInUserId;
			
			QSCombinedExceptionAlert.getInstance().Show(errorStatus, rpcEvent.toString(), userId); 
		}
	}
}