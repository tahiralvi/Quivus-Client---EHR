package com.gazuntite.common.command.visit
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.delegate.visit.VerifyUserDelegate;
	import com.gazuntite.common.event.visit.CoSignVisitEvent;
	import com.gazuntite.common.event.visit.SignVisitEvent;
	import com.gazuntite.common.event.visit.VerifyUserEvent;
	import com.gazuntite.common.util.QSConstants;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	public class VerifyUserCommand implements Command, IResponder
	{
		public var visitId 	: int;
		public var functionName 	: Function;
		public var originName		:String; // calling function name
		public var actionName		:String; // Sign/Cosign
		private var LE:VerifyUserEvent;
		private var delegate : VerifyUserDelegate;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			LE = cgEvent as VerifyUserEvent;
			
			if(LE.LoggedInUserId)
			{
				delegate = new VerifyUserDelegate( this );
				
				this.functionName	   = LE.functionName;
				this.visitId = LE.visitId;
				var password:String = LE.password;
				
				this.originName = LE.originName;
				this.actionName = LE.actionName;
				
				if( password!=null && password.length>0 && this.visitId>0)
				{
					delegate.VerifyUser(LE.LoggedInUserId, password,LE.LoggedInUserSessionID);
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
						if(this.originName != null && (this.originName == QSConstants.QUICK_INPUT_MODULE_NAME || this.originName == QSConstants.VIEW_BACKGROUND_MODULE_NAME))
						{
							if(this.actionName != null && this.actionName == QSConstants.VISIT_SIGNED)
							{
								var svEvent : SignVisitEvent = new SignVisitEvent(LE.visitId,LE.LoggedInUserId, LE.LoggedInUserProviderTypeId, LE.LoggedInUserSessionID, this.functionName);
								CairngormEventDispatcher.getInstance().dispatchEvent( svEvent );
							}
							else if(this.actionName != null && this.actionName == QSConstants.VISIT_COSIGNED)
							{
								var csvEvent : CoSignVisitEvent = new CoSignVisitEvent(LE.visitId, LE.LoggedInUserProviderId, LE.LoggedInUserId, LE.LoggedInUserProviderTypeId, functionName);
								CairngormEventDispatcher.getInstance().dispatchEvent( csvEvent );
							}
						}
						else
						{
							/*if(model.canSign)
							{
							var svEvent : SignVisitEvent = new SignVisitEvent(this.visitId,this.functionName);
							CairngormEventDispatcher.getInstance().dispatchEvent( svEvent );
							}
							else if(model.canCoSign)
							{
							var csvEvent : CoSignVisitEvent = new CoSignVisitEvent(this.visitId,this.functionName);
							CairngormEventDispatcher.getInstance().dispatchEvent( csvEvent );
							}*/
						}
					}
					else
					{
						//model.errorStatus = resp.ResponseMessage ;
						//Alert.show("VerifyUser"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
						if(this.functionName!=null)
						{
							this.functionName(QSConstants.INVALID_CREDENTIALS);
						}
					}
				}
				else
				{
					Alert.show("VerifyUser"+"\n"+"Service didnot respond.",  "info",4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		public function fault( rpcEvent : Object ) : void 
		{
			//if(model.isUserManagerServiceOnline){
			var errorStatus:String = "Fault occured in VerifyUserCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( LE.LoggedInUserId )? -1:LE.LoggedInUserId;
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}