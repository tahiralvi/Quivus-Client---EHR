package com.gazuntite.common.command.visit
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.delegate.visit.SignVisitDelegate;
	import com.gazuntite.common.event.visit.SignVisitEvent;
	import com.gazuntite.common.util.QSConstants;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	public class SignVisitCommand implements Command, IResponder
	{
		private var LE:SignVisitEvent;
		private var delegate : SignVisitDelegate;
		public var functionName 	: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			LE = cgEvent as SignVisitEvent;
			if(LE.LoggedInUserId)
			{
				delegate = new SignVisitDelegate( this );
				
				this.functionName	   = LE.functionName;
				var opetationDate:String = UtilityFunctions.FormatDate( new Date(), "MM-DD-YYYY");
				
				if(LE.visitId>0)
					delegate.SignVisit(LE.visitId , LE.LoggedInUserId, LE.LoggedInUserProviderTypeId , opetationDate, LE.LoggedInUserSessionID);
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
						Alert.show("SignVisit"+"\n"+re.result.ResponseMessage,"Info",4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("SignVisit"+"\n"+ "SERVICE_DIDNOT_RESPOND"+"",  "Info",4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		public function fault( rpcEvent : Object ) : void 
		{
			var errorStatus:String = "Fault occured in SignVisitCommand.";
			var userId:int = UtilityFunctions.IsNullOrEmpty( LE.LoggedInUserId )? -1:LE.LoggedInUserId;
			QSCombinedExceptionAlert.getInstance().Show(errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}