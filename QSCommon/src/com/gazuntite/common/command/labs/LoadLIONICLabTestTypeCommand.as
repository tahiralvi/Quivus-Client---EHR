package com.gazuntite.common.command.labs
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.delegate.labs.LoadLIONICLabTestTypeDelegate;
	import com.gazuntite.common.dto.assessment.labOut.LabOutLIONICLabTestDTO;
	import com.gazuntite.common.event.labs.LoadLIONICLabTestTypeEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class LoadLIONICLabTestTypeCommand implements Command, IResponder
	{
		private var model:Object;
		
		public function LoadLIONICLabTestTypeCommand()
		{
		}
		
		public function execute(cgEvent:CairngormEvent):void 
		{
			var LE:LoadLIONICLabTestTypeEvent = cgEvent as LoadLIONICLabTestTypeEvent;
			
			model = LE.model;
			
			if (model && model.hasOwnProperty("LoggedInUserId") && model.LoggedInUserId)
			{
				if (LE.labtestTypeID > 0 && LE.labTestCodeOrName)
				{
					var delegate:LoadLIONICLabTestTypeDelegate = new  LoadLIONICLabTestTypeDelegate(this);
					delegate.loadLIONICLabTestType(LE.labtestTypeID, LE.labTestCodeOrName, model.LoggedInUserSessionID);
				}
			}
		}
		
		public function result(event:Object):void
		{
			if (model && model.hasOwnProperty("LoggedInUserId") && model.LoggedInUserId)
			{
				var types:ArrayCollection  =new ArrayCollection();
				
				var resultXml:XML = event.result as XML;
				
				var labTestTypesList:XMLList = resultXml.ResponseData.Test;
				
				for (var i:int = 0; i < labTestTypesList.length(); i++ )
				{
					var ct:LabOutLIONICLabTestDTO = new LabOutLIONICLabTestDTO();
					
					ct.FromXML(labTestTypesList[i]);
					
					types.addItem(ct);
				}
				
				if (model.hasOwnProperty("lionicLabTestTypeDTOList"))
					model.lionicLabTestTypeDTOList = types;
			}
		}
		
		public function fault(event:Object):void
		{			
			var errorStatus:String = "Fault occured in LoadLabTestStaticCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.LoggedInUserId ) ? -1 : model.LoggedInUserId;
			
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, event.toString(), userId); 
		}
	}
}