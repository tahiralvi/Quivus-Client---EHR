package com.gazuntite.patient.visit.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.dto.pmh.immunization.ImmunizationDTO;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.patient.visit.delegate.LoadModuleDictationByPatientIDDelegate;
	import com.gazuntite.patient.visit.event.LoadModuleDictationByPatientIDEvent;
	import com.gazuntite.patient.visit.model.VBModelLocator;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class LoadModuleDictationByPatientIDCommand implements Command, IResponder
	{
		private var model:VBModelLocator = VBModelLocator.getInstance();
		
		public function LoadModuleDictationByPatientIDCommand()
		{
		}
		
		public function execute(event:CairngormEvent):void
		{
			if (model.LoggedInUserId)
			{	
				var delegate:LoadModuleDictationByPatientIDDelegate = new  LoadModuleDictationByPatientIDDelegate(this);
				delegate.loadModuleDictationByPatientID(model.patientID, model.LoggedInUserSessionID);
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
						}
						
					}
				}
			}
			else
			{
				UtilityFunctions.ShowMessage("LoadModuleDictationByPatientID \n Service didnot respond.", "Info");
			}
		}
		
		public function fault(rpcEvent:Object):void
		{
			var errorStatus:String = "Fault occured in LoadModuleDictationByPatientID.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty(model.LoggedInUserId) ? -1 : model.LoggedInUserId;
			
			QSCombinedExceptionAlert.getInstance().Show(errorStatus, rpcEvent.toString(), userId); 
		}
	}
}