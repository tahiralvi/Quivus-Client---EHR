package com.adobe.Quivus.command.quickInput
{
	import com.adobe.Quivus.delegate.quickInput.DeleteTempQuickInputDelegate;
	import com.adobe.Quivus.events.quickInput.DeleteTempQuickInputEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class DeleteTempQuickInputCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : DeleteTempQuickInputDelegate = new DeleteTempQuickInputDelegate( this );
				
				var LE:DeleteTempQuickInputEvent = cgEvent as DeleteTempQuickInputEvent;				
				
				var fileName : String;				
				
				fileName =  LE.fileName;
				
				//delegate.LoadQuickInputByVisitId(LE.visitId,model.sessionDTO);
				
				delegate.DeleteTempQuickInput(fileName, model.sessionDTO);
			
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				//M : TODO
				
				/*
				var manageVisitResponse:ManageVisitResponse  = re.result as ManageVisitResponse ;
				if(manageVisitResponse!=null){
					
					
					if(manageVisitResponse.ResponseStatus)
					{
						if(manageVisitResponse.ResultStatus)
						{
							var luiEvent : SyncEPrescriptionEvent = new SyncEPrescriptionEvent(model.quickInputDTO.VisitId);
							CairngormEventDispatcher.getInstance().dispatchEvent( luiEvent );
							
							if(this.clearQuickInput)
							{
								//UtilityFunctions.clearQuickInput();
								
								//Alert.show(Messages.VISIT_SAVED, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
							}
							
							AutoSaveUtility.deleteQuickInput();
						}
						else
						{
							Alert.show(Messages.VISIT_NOT_SAVED, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
						}
						
						if(this.functionName!=null)
						{
							functionName();
						}
						
						var lpvEvent:LoadPatientVisitListEvent = new LoadPatientVisitListEvent( model.loadedPatientId, false );
						CairngormEventDispatcher.getInstance().dispatchEvent( lpvEvent );
					}
					else
					{
						model.errorStatus = manageVisitResponse.ResponseMessage ;
						var valid:Boolean = UtilityFunctions.checkSession(manageVisitResponse.ResponseCode);
						if(valid)
							Alert.show("SaveTempQuickInput"+"\n"+manageVisitResponse.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("SaveTempQuickInput"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}*/
			}
		}
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in DeleteTempQuickInput.";
				//Alert.show("Fault occured in DeleteTempQuickInput.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in DeleteTempQuickInput ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}