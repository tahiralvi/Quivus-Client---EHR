package com.gazuntite.common.command.recommendation
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.delegate.recommendation.LoadRecommendationLinksAutoCompleteDelegate;
	import com.gazuntite.common.dto.baseDTO.common.GeneralLabelDTO;
	import com.gazuntite.common.event.recommendation.LoadRecommendationLinksAutoCompleteEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;

	public class LoadRecommendationLinksAutoCompleteCommand implements Command, IResponder
	{
		private var model:Object;
		private var LE:LoadRecommendationLinksAutoCompleteEvent;
		
		public function LoadRecommendationLinksAutoCompleteCommand()
		{
		}
		
		public function execute(cgEvent:CairngormEvent) : void 
		{
			LE = cgEvent as LoadRecommendationLinksAutoCompleteEvent;
			
			model = LE.model;
			
			if (model && model.hasOwnProperty("LoggedInUserId") && model.LoggedInUserId)
			{
				var delegate:LoadRecommendationLinksAutoCompleteDelegate = new  LoadRecommendationLinksAutoCompleteDelegate(this);
				
				LE = cgEvent as LoadRecommendationLinksAutoCompleteEvent;
				
				delegate.loadAllLinks(model.LoggedInUserSelectedBranchId, LE.searchString, model.LoggedInUserSessionID);
			}	
		}
		
		public function result( rpcEvent : Object ) : void 
		{
			if (model && model.hasOwnProperty("LoggedInUserId") && model.LoggedInUserId)
			{
				var types:ArrayCollection = new ArrayCollection();
				
				var resultXml:XML = rpcEvent.result as XML;
				
				var followUpServiceTypesList:XMLList = resultXml.ResponseData.string;
				
				for (var i:int = 0; i < followUpServiceTypesList.length(); i++)
				{
					var ct:GeneralLabelDTO = new GeneralLabelDTO();
					
					ct.FromXML(followUpServiceTypesList[i]);
					
					types.addItem(ct);
				}
				
				if (types.length && model.hasOwnProperty("recommendationLinkAutoCompleteDTOList"))
					model.recommendationLinkAutoCompleteDTOList = types;
			}
		}
		
		public function fault(rpcEvent:Object):void 
		{
			var errorStatus:String = "Fault occured in LoadRecommendationLinksAutoComplete.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty(model.LoggedInUserId) ? -1 : model.LoggedInUserId;
			
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, rpcEvent.toString(), userId);
		}
	}
}