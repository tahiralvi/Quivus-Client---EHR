package com.gazuntite.common.command.recommendation
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.delegate.recommendation.LoadAllRecommendationDurationTypesDelegate;
	import com.gazuntite.common.dto.baseDTO.common.GeneralTypeDTO;
	import com.gazuntite.common.event.recommendation.LoadAllRecommendationDurationTypesEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class LoadAllRecommendationDurationTypesCommand implements Command , IResponder 
	{
		private var model:Object;
		
		private var LE:LoadAllRecommendationDurationTypesEvent;
		
		public function LoadAllRecommendationDurationTypesCommand()
		{
		}
		
		public function execute(cgEvent:CairngormEvent):void 
		{
			LE = cgEvent as LoadAllRecommendationDurationTypesEvent;
			
			model = LE.model;
			
			if (model && model.hasOwnProperty("LoggedInUserId") && model.LoggedInUserId)
			{
				var delegate:LoadAllRecommendationDurationTypesDelegate = new  LoadAllRecommendationDurationTypesDelegate(this);
				
				delegate.loadRecommendationDurationType(model.LoggedInUserSessionID);
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
					
					if( xlist != null )
					{
						var DTOlist:ArrayCollection = new ArrayCollection();
						
						for each( var x:XML in xlist )
						{
							var t:GeneralTypeDTO = new GeneralTypeDTO();
							t.FromXML( x );
							DTOlist.addItem( t );
						}
						
						if (model.hasOwnProperty("recommendationDurationTypeDTOList"))
							model.recommendationDurationTypeDTOList = DTOlist;
					}
				}
				else
				{
					UtilityFunctions.ShowMessage("LoadAllRecommendationDurationTypes \n Service didnot respond.", "Info");
				}
			}
		}
		
		public function fault(rpcEvent:Object):void
		{
			var errorStatus:String = "Fault occured in LoadAllRecommendationDurationTypes.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty(model.LoggedInUserId) ? -1: model.loggedInUserDTO.UserId;
			
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId);
		}
	}
}