package com.gazuntite.common.command.followUp
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.delegate.followUp.LoadFollowUpMethodTypeDelegate;
	import com.gazuntite.common.dto.baseDTO.common.GeneralTypeDTO;
	import com.gazuntite.common.event.followUp.LoadFollowUpMethodTypeEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class LoadFollowUpMethodTypeCommand implements Command, IResponder
	{
		private var model:Object;
		
		public function LoadFollowUpMethodTypeCommand()
		{
		}
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			var LE:LoadFollowUpMethodTypeEvent = cgEvent as LoadFollowUpMethodTypeEvent;
			
			model = LE.model;
			
			if (model && model.hasOwnProperty("LoggedInUserId") && model.LoggedInUserId)
			{
				var delegate:LoadFollowUpMethodTypeDelegate = new  LoadFollowUpMethodTypeDelegate(this);
				delegate.loadFollowUpMethodType(model.LoggedInUserSessionID);
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
						
						if (model.hasOwnProperty("generalTypeDTOListForFollowUpMethod"))
							model.generalTypeDTOListForFollowUpMethod = DTOlist;
					}
				}
				
				else
				{
					UtilityFunctions.ShowMessage("FollowUpMethodType \n Service didnot respond.", "Info");
				}
			}
		}
		
		public function fault( rpcEvent : Object ) : void 
		{
			var errorStatus:String = "Fault occured in FollowUpMethodType.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.LoggedInUserId ) ? -1 : model.LoggedInUserId;
			
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, rpcEvent.toString(), userId); 
		}
	}
}