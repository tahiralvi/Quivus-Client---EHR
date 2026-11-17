package com.gazuntite.common.command.procedure
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.delegate.procedure.LoadCPTMedicalTypesDelegate;
	import com.gazuntite.common.dto.typeDTO.CPTMedicalTypeDTO;
	import com.gazuntite.common.event.procedure.LoadCPTMedicalTypesEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import flash.display.Sprite;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class LoadCPTMedicalTypesCommand implements Command, IResponder
	{
		private var model:Object;
		private var callBack:Function;
		private var reqFrom:int;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{	
			var LE:LoadCPTMedicalTypesEvent = cgEvent as LoadCPTMedicalTypesEvent;
			
			model = LE.model;
			callBack = LE.func;
			
			if (model && model.hasOwnProperty("LoggedInUserId") && model.LoggedInUserId && LE.cptName != "")
			{	
				var delegate:LoadCPTMedicalTypesDelegate = new LoadCPTMedicalTypesDelegate(this);		
				delegate.CPTMediacalTypeList(LE.cptName, model.LoggedInUserSessionID);
			}			
		}
		
		public function  result(event:Object):void
		{
			if (model && model.hasOwnProperty("cptMedicalTypeDTOList"))
			{
				model.cptMedicalTypeDTOList =new ArrayCollection();
			
				var ResultXml:XML = event.result as XML;
				
				var xCPTMedicalTypes:XMLList = ResultXml.CPTMedicalTypeDTO;
							
				for (var i:int = 0; i < xCPTMedicalTypes.length(); i++ )
				{
					var ct:CPTMedicalTypeDTO = new CPTMedicalTypeDTO();
					
					ct.FromXML(xCPTMedicalTypes[i]);
					
					model.cptMedicalTypeDTOList.addItem(ct);
				}		
				
				if (callBack)
					callBack();
			}
		}
		
		public function fault(event:Object):void
		{			
			var errorStatus:String = "Fault occured in LoadCPTMedicalTypesCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty(model.LoggedInUserId) ? -1 : model.LoggedInUserId;
			
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, event.toString(), userId); 
		}
	}
}