package com.gazuntite.patient.visit.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.dto.physical.vital.VitalsDTO;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.patient.visit.delegate.LoadVitalsByPatientIdPagedDelegate;
	import com.gazuntite.patient.visit.dto.PageDTO;
	import com.gazuntite.patient.visit.event.LoadVitalsByPatientIdPagedEvent;
	import com.gazuntite.patient.visit.model.VBModelLocator;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class LoadVitalsByPatientIdPagedCommand implements Command, IResponder
	{
		private var model:VBModelLocator = VBModelLocator.getInstance();
		private var LE:LoadVitalsByPatientIdPagedEvent;
		
		public function LoadVitalsByPatientIdPagedCommand()
		{
		}
		
		public function execute(event:CairngormEvent):void
		{
			if (model.LoggedInUserId)
			{
				LE = event as LoadVitalsByPatientIdPagedEvent;
				
				var page:PageDTO = model.vitalCurrentPageByPatient;
				
				if (!page)
					return;
				
				if (page && page.stationIDs && page.stationIDs.length < 1)
					page.stationIDs.addItem(model.LoggedInUserSelectedStationID);
				
				var xml2Send:XML = page.toXML();
				
				var delegate:LoadVitalsByPatientIdPagedDelegate = new LoadVitalsByPatientIdPagedDelegate(this);
				delegate.loadVitalsByPatientIdPaged(xml2Send, model.patientID, model.LoggedInUserSelectedBranchId, model.LoggedInUserSessionID, true);
			}
		}
		
		public function result(rpcEvent:Object):void
		{
			if (model.LoggedInUserId)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				if (re.result)
				{
					var vitalsPageDTO:XML = XML(re.result);
					
					var xList:XMLList = vitalsPageDTO.children();
					
					var vList:XML = xList[0];
					
					var vitalsList:XMLList = vList.children();
					
					if (vitalsList)
					{
						var vitalsDTOList:ArrayCollection = new ArrayCollection();
						
						for each (var x:XML in vitalsList)
						{
							var vitalsDTO:VitalsDTO = new VitalsDTO();
							
							vitalsDTO.FromXML(x);
							
							vitalsDTOList.addItem(vitalsDTO);
						}
						
						model.vitalDTOListByPatient = vitalsDTOList;
					}
					
					var pageDTO:PageDTO = new PageDTO();
					pageDTO.fromXML(xList[1]);
					
					model.vitalCurrentPageByPatient = pageDTO;
				}
			}
			else
			{
				UtilityFunctions.ShowMessage("LoadVitalsByPatientIdPaged \n Service didnot respond.", "Info");
			}
		}
		
		public function fault(rpcEvent:Object):void
		{
			var errorStatus:String = "Fault occured in LoadVitalsByPatientIdPaged.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.LoggedInUserId )? -1:model.LoggedInUserId;
			
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, rpcEvent.toString(), userId); 
		}
	}
}