package com.gazuntite.common.command.labs
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.delegate.labs.LoadLabTestTypeStaticDelegate;
	import com.gazuntite.common.dto.assessment.labOut.LabOutTestTypeDTO;
	import com.gazuntite.common.event.labs.LoadLabTestTypeStaticDataEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class LoadLabTestTypeStaticDataCommand implements Command, IResponder
	{
		private var model:Object;
		
		public function LoadLabTestTypeStaticDataCommand()
		{	
		}
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			var LE:LoadLabTestTypeStaticDataEvent = cgEvent as LoadLabTestTypeStaticDataEvent;
			
			model = LE.model;
			
			if (model && model.hasOwnProperty("LoggedInUserId") && model.LoggedInUserId)
			{
				var delegate:LoadLabTestTypeStaticDelegate  = new LoadLabTestTypeStaticDelegate(this);
				
				delegate.laboutTypeList( model.LoggedInUserSessionID );
			}			
		}
		
		public function result(event:Object):void
		{			
			if (model && model.hasOwnProperty("LoggedInUserId") && model.LoggedInUserId)
			{
				var types:ArrayCollection  =new ArrayCollection();
				
				var resultXml:XML = event.result as XML
				
				var labTestTypesList:XMLList = resultXml.ResponseData.LabTest;
				
				for (var i:int = 0; i < labTestTypesList.length(); i++)
				{
					var ct:LabOutTestTypeDTO = new LabOutTestTypeDTO();
					
					ct.FromXML(labTestTypesList[i]);
					
					types.addItem(ct);
				}
				
				if (model.hasOwnProperty("labTestTypeDTOList"))
					model.labTestTypeDTOList = types;
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