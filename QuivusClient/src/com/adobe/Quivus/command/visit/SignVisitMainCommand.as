package com.adobe.Quivus.command.visit
{
	import com.adobe.Quivus.delegate.visit.SignVisitMainDelegate;
	import com.adobe.Quivus.events.visit.SignVisitMainEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class SignVisitMainCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		public var functionName 	: Function;
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : SignVisitMainDelegate = new SignVisitMainDelegate( this );
				
				var LE:SignVisitMainEvent = cgEvent as SignVisitMainEvent;
				this.functionName	   = LE.functionName;
				var visitId:int = LE.visitId;
				 
				
				if(visitId>0)
				{
					delegate.SignVisit(visitId,
												  model.loggedInUserDTO.UserId,
												  model.sessionDTO);
				}
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var serviceResponse:ServiceResponse  = re.result as ServiceResponse ;
				if(serviceResponse!=null)
				{
					if(serviceResponse.ResponseStatus)
					{
						//Alert.show(Messages.VISIT_SIGNED, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
						if(this.functionName!=null)
						{
							this.functionName(Constants.VISIT_SIGNE);
						}
											
					}
					else
					{
						model.errorStatus = serviceResponse.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(serviceResponse.ResponseCode);
						if(valid)
							Alert.show("SignVisit"+"\n"+serviceResponse.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("SignVisit"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in SignVisitCommand.";
			//	Alert.show("Fault occured in SignVisitCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in SignVisitCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}