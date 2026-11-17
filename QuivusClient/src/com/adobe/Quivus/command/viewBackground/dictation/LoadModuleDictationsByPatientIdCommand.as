package com.adobe.Quivus.command.viewBackground.dictation
{		
	import com.adobe.Quivus.delegate.viewBackground.dictation.LoadModuleDictationsByPatientIdDelegate;
	import com.adobe.Quivus.events.viewBackground.notes.LoadModuleNotesByPatientIdEvent;
	import com.adobe.Quivus.events.viewBackground.notes.LoadModuleNotesEvent;
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

	
	public class LoadModuleDictationsByPatientIdCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadModuleDictationsByPatientIdDelegate = new LoadModuleDictationsByPatientIdDelegate( this );
				
				delegate.LoadModuleDictationsByPatientId(model.loadedPatientId,model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq, model.sessionDTO,model.stationIdsForVB,model.isAllStationSelected);				
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var dictationResponse :ModuleDictationResponse   = re.result as ModuleDictationResponse ;
				if(dictationResponse != null)
				{
					if(dictationResponse.ResponseStatus)
					{
						model.moduleDictationDTOListByPatient =  dictationResponse.ResponseList;
													
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(dictationResponse.ResponseCode);
						if(valid)
							Alert.show("LoadModuleDictationsByPatientId"+"\n"+dictationResponse.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadModuleDictationsByPatientId"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadModuleDictationsByPatientIdCommand.";
			//	Alert.show("Fault occured in LoadModuleDictationsByPatientIdCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadModuleDictationsByPatientIdCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}