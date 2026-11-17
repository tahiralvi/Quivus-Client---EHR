package com.gazuntite.common.command.recommendation
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.delegate.recommendation.LoadAllRecommendationPlanTypesDelegate;
	import com.gazuntite.common.dto.baseDTO.common.GeneralTypeDTO;
	import com.gazuntite.common.event.recommendation.LoadAllRecommendationPlanTypesEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class LoadAllRecommendationPlanTypesCommand implements Command , IResponder 
	{
		private var model:Object;
		
		private var LE:LoadAllRecommendationPlanTypesEvent;
		
		public function LoadAllRecommendationPlanTypesCommand()
		{
		}
		
		public function execute(cgEvent:CairngormEvent) : void 
		{
			LE = cgEvent as LoadAllRecommendationPlanTypesEvent;
			
			model = LE.model;
			
			if (model && model.hasOwnProperty("LoggedInUserId") && model.LoggedInUserId)
			{
				var delegate:LoadAllRecommendationPlanTypesDelegate = new  LoadAllRecommendationPlanTypesDelegate(this);
				
				delegate.loadRecommendationPlanType(model.LoggedInUserSessionID);
			}
		}
		
		public function result(rpcEvent:Object):void 
		{
			if (model && model.hasOwnProperty("LoggedInUserId") && model.LoggedInUserId)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var xml:XMLList = re.result.ResponseData;
				
				if (xml!=null)
				{
					var xlist:XMLList = xml.children();
					
					if (xlist != null)
					{
						var DTOlist:ArrayCollection = new ArrayCollection();
						
						for each (var x:XML in xlist)
						{
							var t:GeneralTypeDTO = new GeneralTypeDTO();
							t.FromXML(x);
							DTOlist.addItem(t);
						}
						
						if (model.hasOwnProperty("recommendationPlanTypeDTOList"))
							model.recommendationPlanTypeDTOList = DTOlist;
					}
				}
				else
				{
					UtilityFunctions.ShowMessage("LoadAllRecommendationPlanTypes \n Service didnot respond.", "Info");
				}
			}
		}
		
		public function fault(rpcEvent:Object):void
		{
			
			var errorStatus:String = "Fault occured in LoadAllRecommendationPlanTypes.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.LoggedInUserId ) ? -1 : model.LoggedInUserId;
			
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, rpcEvent.toString(), userId); 
		}
	}
}