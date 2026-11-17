package com.gazuntite.common.command.labs
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.delegate.labs.LoadLabTypeStaticDataDelegate;
	import com.gazuntite.common.dto.baseDTO.common.GeneralTypeDTO;
	import com.gazuntite.common.event.labs.LoadLabTypeStaticDataEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class LoadLabTypeStaticDataCommand implements Command, IResponder
	{
		private var model:Object;
		
		public function LoadLabTypeStaticDataCommand()
		{
		}
		
		public function execute(cgEvent:CairngormEvent):void 
		{
			var LE:LoadLabTypeStaticDataEvent = cgEvent as LoadLabTypeStaticDataEvent;
			
			model = LE.model;
			
			if (model && model.hasOwnProperty("LoggedInUserId") && model.LoggedInUserId)
			{
				var delegate:LoadLabTypeStaticDataDelegate = new LoadLabTypeStaticDataDelegate(this);
				delegate.labOutLabTypelist(model.LoggedInUserSessionID);
			}
		}
		
		public function result(event:Object):void
		{			
			if (model && model.hasOwnProperty("LoggedInUserId") && model.LoggedInUserId)
			{
				var types:ArrayCollection  =new ArrayCollection();
				
				var resultXml:XML = event.result as XML;
				
				var labTestTypesList:XMLList = resultXml.ResponseData.Laboratory;
									
				for (var i:int = 0; i < labTestTypesList.length(); i++)
				{
					var ct:GeneralTypeDTO = new GeneralTypeDTO();
					
					ct.FromXML(labTestTypesList[i]);
					
					types.addItem(ct);
				}
				
				if (model.hasOwnProperty("labTypeDTOList"))
					model.labTypeDTOList = types;
			}
		}
		
		public function fault(event:Object):void
		{			
			var errorStatus:String = "Fault occured in LoadLabTestStaticCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty(model.LoggedInUserId) ? -1 : model.LoggedInUserId;
			
			QSCombinedExceptionAlert.getInstance().Show(errorStatus, event.toString(), userId);
		}
	}
}