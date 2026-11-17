package com.gazuntite.common.command.followUp
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.delegate.followUp.LoadFollowUpServiceTypeDelegate;
	import com.gazuntite.common.dto.assessment.followUp.FollowUpServiceTypeDTO;
	import com.gazuntite.common.event.followUp.LoadFollowUpServiceTypeEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class LoadFollowUpServiceTypeCommand implements Command , IResponder
	{
		private var model:Object;
			
		private var followUpDataControlTypeID:int;
		
		public function LoadFollowUpServiceTypeCommand()
		{
		}
		
		public function execute(cgEvent:CairngormEvent):void 
		{
			var LE:LoadFollowUpServiceTypeEvent = cgEvent as LoadFollowUpServiceTypeEvent;
			
			model = LE.model;
			
			followUpDataControlTypeID = LE.followupDataControlTypeID;
			
			if (model && model.hasOwnProperty("LoggedInUserId") && model.LoggedInUserId)
			{
				var delegate:LoadFollowUpServiceTypeDelegate = new LoadFollowUpServiceTypeDelegate(this);
				
				delegate.loadServiceType(model.LoggedInUserSessionID, LE.followupDataControlTypeID, model.LoggedInUserSelectedBranchId, LE.searchTerm);
			}
		}
		
		public function result(rpcEvent:Object):void
		{	
			if (model && model.hasOwnProperty("LoggedInUserId") && model.LoggedInUserId)
			{
				var types:ArrayCollection  =new ArrayCollection();
				
				var resultXml:XML = rpcEvent.result as XML
				
				var followUpServiceTypesList:XMLList = resultXml.ResponseData.ServiceTypeDTO;
				
				for (var i:int = 0; i < followUpServiceTypesList.length(); i++ )
				{
					var ct:FollowUpServiceTypeDTO = new FollowUpServiceTypeDTO();
					ct.FromXML(followUpServiceTypesList[i]);
					types.addItem(ct);
				}
				
				if (followUpDataControlTypeID == 1 && model.hasOwnProperty("followUpServiceTypeDTOList"))
				{
					model.followUpServiceTypeDTOList = types;
				}
				else if (followUpDataControlTypeID == 2 && model.hasOwnProperty("followUpServiceDateList"))
				{
					model.followUpServiceTypeDTODateList = types;
				}
			}
		}
			
		public function fault(rpcEvent:Object):void
		{			
			var errorStatus:String = "Fault occured in LoadLabTestStaticCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.LoggedInUserId ) ? -1 : model.LoggedInUserId;
			
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, rpcEvent.toString(), userId); 
		}
	}
}