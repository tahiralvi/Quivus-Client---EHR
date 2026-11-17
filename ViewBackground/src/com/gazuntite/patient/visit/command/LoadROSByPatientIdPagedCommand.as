package com.gazuntite.patient.visit.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.dto.physical.ros.ROSDTO;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.patient.visit.delegate.LoadROSByPatientIdPagedDelegate;
	import com.gazuntite.patient.visit.dto.PageDTO;
	import com.gazuntite.patient.visit.event.LoadROSByPatientIdPagedEvent;
	import com.gazuntite.patient.visit.model.VBModelLocator;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class LoadROSByPatientIdPagedCommand implements Command, IResponder
	{
		private var model:VBModelLocator = VBModelLocator.getInstance();
		private var LE:LoadROSByPatientIdPagedEvent;
		
		public function LoadROSByPatientIdPagedCommand()
		{
		}
		
		public function execute(event:CairngormEvent):void
		{
			if (model.LoggedInUserId)
			{
				LE = event as LoadROSByPatientIdPagedEvent;
				
				var page:PageDTO = model.rosCurrentPageByPatient;
				
				if (!page)
					return;
				
				if (page && page.stationIDs && page.stationIDs.length < 1)
					page.stationIDs.addItem(model.LoggedInUserSelectedStationID);
				
				var xml2Send:XML = page.toXML();
				
				var delegate:LoadROSByPatientIdPagedDelegate = new LoadROSByPatientIdPagedDelegate(this);
				delegate.loadROSByPatientIdPaged(xml2Send, model.patientID, model.LoggedInUserSelectedBranchId, model.LoggedInUserSessionID, true);
			}
		}
		
		public function result(rpcEvent:Object):void
		{
			if (model.LoggedInUserId)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				if (re.result)
				{
					var rosPageDTO:XML = XML(re.result);
					
					var xList:XMLList = rosPageDTO.children();
					
					var rList:XML = xList[0];
					
					var rosList:XMLList = rList.children();
					
					if (rosList)
					{
						var rosDTOList:ArrayCollection = new ArrayCollection();
						
						for each (var x:XML in rosList)
						{
							var rosDTO:ROSDTO = new ROSDTO();
							
							rosDTO.FromXML(x);
							
							rosDTOList.addItem(rosDTO);
						}
						
						model.rosDTOList = rosDTOList;
					}
					
					var pageDTO:PageDTO = new PageDTO();
					pageDTO.fromXML(xList[1]);
					
					model.rosCurrentPageByPatient = pageDTO;
				}
			}
			else
			{
				UtilityFunctions.ShowMessage("LoadROSByPatientIdPaged \n Service didnot respond.", "Info");
			}
		}
		
		public function fault(rpcEvent:Object):void
		{
			var errorStatus:String = "Fault occured in LoadROSByPatientIdPaged.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.LoggedInUserId ) ? -1 : model.LoggedInUserId;
			
			QSCombinedExceptionAlert.getInstance().Show(errorStatus, rpcEvent.toString(), userId); 
		}
	}
}