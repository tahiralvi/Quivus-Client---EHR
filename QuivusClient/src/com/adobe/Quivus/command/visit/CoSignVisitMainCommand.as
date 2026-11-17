package com.adobe.Quivus.command.visit
{
	import com.adobe.Quivus.delegate.visit.CoSignVisitMainDelegate;
	import com.adobe.Quivus.events.visit.CoSignVisitMainEvent;
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

	
	public class CoSignVisitMainCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		public var functionName 	: Function;
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : CoSignVisitMainDelegate = new CoSignVisitMainDelegate( this );
				
				var LE:CoSignVisitMainEvent = cgEvent as CoSignVisitMainEvent;
				this.functionName	   = LE.functionName;
				var visitId:int = LE.visitId;
				 
				
				if(visitId>0)
				{
					delegate.CoSignVisit(visitId,
												  model.userSelectedRoleDTO.UserTypeProfileID,
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
						//Alert.show(Messages.VISIT_CO_SIGNED, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
						if(this.functionName!=null)
						{
							this.functionName(Constants.VISIT_COSIGNED);
						}				
					}
					else
					{
						model.errorStatus = serviceResponse.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(serviceResponse.ResponseCode);
						if(valid)
							Alert.show("CoSignVisit"+"\n"+serviceResponse.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("CoSignVisit"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in CoSignVisitCommand.";
				//Alert.show("Fault occured in CoSignVisitCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in CoSignVisitCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}