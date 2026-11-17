package com.gazuntite.provider.live.services.administration.command.locationManagement
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.provider.live.services.administration.delegate.locationManagement.LoadAllStationsByClinicBranchIDDelegate;
	import com.gazuntite.provider.live.services.administration.dto.locationManagement.AdminStationDTO;
	import com.gazuntite.provider.live.services.administration.event.locationManagement.LoadAllStationsByClinicBranchIDEvent;
	import com.gazuntite.provider.live.services.administration.model.AdminAppModelLocator;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.managers.CursorManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;
	
	public class LoadAllStationsByClinicBranchIDCommand implements Command
	{
		private var model:AdminAppModelLocator = AdminAppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadAllStationsByClinicBranchIDDelegate;
		
		public function execute( cgEvent:CairngormEvent):void
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadAllStationsByClinicBranchIDDelegate( responder );	
			
			var LE:LoadAllStationsByClinicBranchIDEvent = cgEvent as LoadAllStationsByClinicBranchIDEvent;
			
			delegate.LoadAllStationsByClinicBranchID(LE.clinicBranchID);
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			var re:ResultEvent = event as ResultEvent;
			var op:ObjectProxy = (re.result as ObjectProxy);
			var responce:ObjectProxy  =  op.ArrayOfStationDTO ;
			
			if(model.allLocationsList)
			{
				model.allLocationsList.removeAll();
				model.allLocationsList = null;
			}
			
			model.allLocationsList = new ArrayCollection();
			
			if(responce != null)
			{
				model.allLocationsList = responce.StationDTO;
			}
			CursorManager.removeBusyCursor();
		}
		
		private function onError(event:FaultEvent):void
		{
			CursorManager.removeBusyCursor();
			var errorStatus:String = "Fault occured in LoadAllStationsByClinicBranchIDCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserId )? -1:model.loggedInUserId;
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, event.toString(), userId);
		}
	}
}