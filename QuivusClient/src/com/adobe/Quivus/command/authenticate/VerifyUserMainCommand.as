package com.adobe.Quivus.command.authenticate
{
	import com.adobe.Quivus.delegate.authenticate.VerifyUserMainDelegate;
	import com.adobe.Quivus.events.authenticate.VerifyUserMainEvent;
	import com.adobe.Quivus.events.quickInput.ManageQuickInputEvent;
	import com.adobe.Quivus.events.visit.CoSignVisitMainEvent;
	import com.adobe.Quivus.events.visit.SignVisitMainEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class VerifyUserMainCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		public var visitId 	: int;
		
		public var functionName 	: Function;
		
		public var originName		:String; // calling function name
		public var actionName		:String; // Sign/Cosign
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : VerifyUserMainDelegate = new VerifyUserMainDelegate( this );
				
				var LE:VerifyUserMainEvent = cgEvent as VerifyUserMainEvent;
				this.functionName	   = LE.functionName;
				this.visitId = LE.visitId;
				var password:String = LE.password;
				
				this.originName = LE.originName;
				this.actionName = LE.actionName;
				
				if( password!=null && password.length>0 && this.visitId>0){
					delegate.VerifyUser(model.loggedInUserDTO.UserId,password,model.sessionDTO);
				}
			}
		}
		
		
		public function result( rpcEvent : Object ) : void 
		{
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:ServiceResponse  = re.result as ServiceResponse;
				
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						var mqiEvent:ManageQuickInputEvent = new ManageQuickInputEvent( false);
						CairngormEventDispatcher.getInstance().dispatchEvent( mqiEvent );
						
						
						if(this.originName != null && this.originName == Constants.VIEW_BACKGROUND_MODULE_NAME)
						{
							if(this.actionName != null && this.actionName == Constants.VISIT_SIGNE)
							{
								var svEvent : SignVisitMainEvent = new SignVisitMainEvent(this.visitId,this.functionName);
								CairngormEventDispatcher.getInstance().dispatchEvent( svEvent );
							}
							else if(this.actionName != null && this.actionName == Constants.VISIT_COSIGNED)
							{
								var csvEvent : CoSignVisitMainEvent = new CoSignVisitMainEvent(this.visitId,this.functionName);
								CairngormEventDispatcher.getInstance().dispatchEvent( csvEvent );
							}
						}						
						else
						{
							//New logic for QI Sign vidsit
							if(model.loggedInUserDTO.UserId == model.quickInputDTO.Visit.OwnerId)
							{
								var svEvent : SignVisitMainEvent = new SignVisitMainEvent(this.visitId,this.functionName);
								CairngormEventDispatcher.getInstance().dispatchEvent( svEvent );
							}
							else
							{
								var csvEvent : CoSignVisitMainEvent = new CoSignVisitMainEvent(this.visitId,this.functionName);
								CairngormEventDispatcher.getInstance().dispatchEvent( csvEvent );
							}
							
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
							this.functionName(Constants.INVALID_CREDENTIALS);
						}
					}
				}
				else
				{
					Alert.show("VerifyUser"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  "info",4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in VerifyUserCommand.";
				//Alert.show("Fault occured in VerifyUserCommand.\n"+rpcEvent.toString());*/
			//}
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(rpcEvent.toString(),"Fault occured in UpdateUserSessionCommand ","",model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert); */
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}