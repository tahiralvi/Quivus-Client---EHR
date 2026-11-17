package com.gazuntite.patient.visit.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.dto.pmh.immunization.ImmunizationDTO;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.patient.visit.delegate.LoadPatientImmunizationsByPatientIdDelegate;
	import com.gazuntite.patient.visit.dto.PageDTO;
	import com.gazuntite.patient.visit.event.LoadPatientImmunizationsByPatientIdEvent;
	import com.gazuntite.patient.visit.model.VBModelLocator;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class LoadPatientImmunizationsByPatientIdCommand implements Command, IResponder
	{
		private var model:VBModelLocator = VBModelLocator.getInstance();
		private var LE:LoadPatientImmunizationsByPatientIdEvent;
		
		public function LoadPatientImmunizationsByPatientIdCommand()
		{
		}
		
		public function execute(event:CairngormEvent):void
		{
			if (model.LoggedInUserId)
			{
				LE = event as LoadPatientImmunizationsByPatientIdEvent;
				
				var page:PageDTO = model.immunizationCurrentPageByPatient;
				
				if (!page)
					return;
				
				if (page && page.stationIDs && page.stationIDs.length < 1)
					page.stationIDs.addItem(model.LoggedInUserSelectedStationID);
				
				var xml2Send:XML = page.toXML();
				
				var delegate:LoadPatientImmunizationsByPatientIdDelegate = new  LoadPatientImmunizationsByPatientIdDelegate(this);
				delegate.loadPatientImmunizationByPatientId(xml2Send, model.patientID, model.LoggedInUserProviderId, model.LoggedInUserProviderTypeId, 
							model.LoggedInUserSelectedBranchId, model.LoggedInUserSessionID, true);
			}
		}
		
		public function result(rpcEvent:Object):void
		{
			if (model.LoggedInUserId)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				if (re.result)
				{
					var immPageDTO:XML = XML(re.result);
					
					var xList:XMLList = immPageDTO.children();
					
					var immList:XML = xList[0];
					
					var immunizationList:XMLList = immList.children();
					
					if (immunizationList)
					{
						var immDTOList:ArrayCollection = new ArrayCollection();
						
						for each (var x:XML in immunizationList)
						{
							var immDTO:ImmunizationDTO = new ImmunizationDTO();
							
							immDTO.FromXML(x);
							
							immDTOList.addItem(immDTO);
						}
						
						model.immunizationDTOList = immDTOList;
					}
					
					var pageDTO:PageDTO = new PageDTO();
					pageDTO.fromXML(xList[1]);
					
					model.immunizationCurrentPageByPatient = pageDTO;
				}
			}
			else
			{
				UtilityFunctions.ShowMessage("LoadPatientImmunicationByPatientIdPaged \n Service didnot respond.", "Info");
			}
		}
		
		public function fault(rpcEvent:Object):void
		{
			var errorStatus:String = "Fault occured in LoadPatientImmunicationByPatientIdPaged.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.LoggedInUserId )? -1:model.LoggedInUserId;
			
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, rpcEvent.toString(), userId); 
		}
	}
}