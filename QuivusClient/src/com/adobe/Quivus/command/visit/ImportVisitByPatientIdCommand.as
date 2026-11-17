package com.adobe.Quivus.command.visit
{
	import com.adobe.Quivus.delegate.visit.ImportVisitByPateintIdDelegate;
	import com.adobe.Quivus.events.visit.ImportVisitByPatientIdEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.common.util.exceptionAlert.QSExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class ImportVisitByPatientIdCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : ImportVisitByPateintIdDelegate = new ImportVisitByPateintIdDelegate( this );
				
				var IE:ImportVisitByPatientIdEvent = cgEvent as ImportVisitByPatientIdEvent;
				
				var templateId:int = IE.templateId;
					
				delegate.ImportVisitByPateintId(templateId, model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq, model.loadedPatientId , model.sessionDTO);				
			}			
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				//M TODO
				
				var resp:QuickInputResponse = re.result as QuickInputResponse ;
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						// just swap the new created visitDTO with the imported visitDTO  
						
						var visitDTO:VisitDTO = model.quickInputDTO.Visit;
						var oldVisitDTO:VisitDTO = model.visitDTO;
						
						model.quickInputDTO = resp.ResponseData;
						
						model.quickInputDTO.Visit = visitDTO;
						model.visitDTO = oldVisitDTO;
	
						//UtilityFunctions.canCoSignCheck();
	
					}
					else
					{
						model.errorStatus = resp.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("ImportVisitByPateintId"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("ImportVisitByPateintId"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}				
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadVisitStakeHoldersByVisitIdCommand.";
				//Alert.show("Fault occured in LoadVisitStakeHoldersByVisitIdCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadVisitStakeHoldersByVisitIdCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}