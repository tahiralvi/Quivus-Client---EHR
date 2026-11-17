package com.gazuntite.provider.live.services.administration.command.locationManagement
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.provider.live.services.administration.delegate.locationManagement.LoadClinicRoomByStationIdDelegate;
	import com.gazuntite.provider.live.services.administration.dto.locationManagement.ClinicRoomDTO;
	import com.gazuntite.provider.live.services.administration.event.locationManagement.LoadClinicRoomByStationIdEvent;
	import com.gazuntite.provider.live.services.administration.model.AdminAppModelLocator;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.collections.XMLListCollection;
	import mx.managers.CursorManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;
	
	public class LoadClinicRoomByStationIdCommand implements Command
	{
		private var model:AdminAppModelLocator = AdminAppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadClinicRoomByStationIdDelegate;
		
		public function execute(cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadClinicRoomByStationIdDelegate( responder );	
			
			var LE:LoadClinicRoomByStationIdEvent = cgEvent as LoadClinicRoomByStationIdEvent;
			
			delegate.LoadClinicRoomByStationId(LE.stationId );
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			var re:ResultEvent = event as ResultEvent;
			var op:ObjectProxy = (re.result as ObjectProxy);
			var responce:ObjectProxy = new ObjectProxy();
			if(op)
				responce  =  op.ArrayOfClinicRoomDTO ;
			
			if(model.allRoomsList)	{
				model.allRoomsList.removeAll();
				model.allRoomsList = null;
			}
			model.allRoomsList = new ArrayCollection();
			
			/*var list:XMLList = re.result.ClinicRoomDTO;
			if(list)
			model.allRoomsList = list;*/
			
			if(responce != null)
			{
				try
				{
					model.allRoomsList = responce.ClinicRoomDTO;
				}
				catch(e:Error)
				{
					trace('exception on room load in Administartion Module')
				}
			}
			CursorManager.removeBusyCursor();
		}
		
		private function onError(event:FaultEvent):void
		{
			CursorManager.removeBusyCursor();
			var errorStatus:String = "Fault occured in LoadClinicRoomByStationIdCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserId )? -1:model.loggedInUserId;
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, event.toString(), userId);
		}
	}
}