package com.gazuntite.common.command.visit
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.delegate.visit.CoSignVisitDelegate;
	import com.gazuntite.common.event.visit.CoSignVisitEvent;
	import com.gazuntite.common.util.QSConstants;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class CoSignVisitCommand  implements Command, IResponder
	{
		public var functionName 	: Function;
		private var delegate : CoSignVisitDelegate;
		private var LE:CoSignVisitEvent;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			LE = cgEvent as CoSignVisitEvent;
			
			if(LE.LoggedInUserId)
			{
				delegate = new CoSignVisitDelegate( this );
				this.functionName	   = LE.functionName;
				
				var opetationDate:String = new Date().toString();
				
				if(LE.visitId > 0)
				{
					delegate.CoSignVisit(LE.visitId, LE.LoggedInUserProviderId , LE.LoggedInUserId, LE.LoggedInUserProviderTypeId , opetationDate);
				}
			}
		}
		
		
		public function result( rpcEvent : Object ) : void 
		{
			if(LE.LoggedInUserId)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				if(re.result.@Status!=null)
				{
					if(re.result.@Status == "true")
					{
						if(this.functionName!=null)
						{
							this.functionName(QSConstants.VISIT_SIGNED);
						}
					}
					else
					{
						Alert.show("CoSignVisit"+"\n"+re.result.ResponseMessage,"Info",4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("CoSignVisit"+"\n"+ "SERVICE_DIDNOT_RESPOND"+"",  "Info",4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void 
		{
			var errorStatus:String = "Fault occured in CoSignVisitCommand.";
			var userId:int = UtilityFunctions.IsNullOrEmpty( LE.LoggedInUserId )? -1:LE.LoggedInUserId;
			QSCombinedExceptionAlert.getInstance().Show(errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}