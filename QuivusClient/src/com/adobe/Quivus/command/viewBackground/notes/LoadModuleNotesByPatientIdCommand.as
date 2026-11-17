package com.adobe.Quivus.command.viewBackground.notes
{
	import com.adobe.Quivus.delegate.viewBackground.notes.LoadModuleNotesByPatientIdDelegate;
	import com.adobe.Quivus.delegate.viewBackground.notes.LoadModuleNotesDelegate;
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

	
	public class LoadModuleNotesByPatientIdCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadModuleNotesByPatientIdDelegate = new LoadModuleNotesByPatientIdDelegate( this );
				
				delegate.LoadModuleNotesByPatientId(model.loadedPatientId,model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq ,model.sessionDTO,model.stationIdsForVB,model.isAllStationSelected);				
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var moduleNotesResponse :ModuleNotesResponse   = re.result as ModuleNotesResponse ;
				if(moduleNotesResponse != null)
				{
					if(moduleNotesResponse.ResponseStatus)
					{
						model.moduleNoteDTOListByPatient =  moduleNotesResponse.ResponseList;
													
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(moduleNotesResponse.ResponseCode);
						if(valid)
							Alert.show("LoadModuleNotesByPatientId"+"\n"+moduleNotesResponse.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadModuleNotesByPatientId"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadModuleNotesByPatientIdCommand.";
			//	Alert.show("Fault occured in LoadModuleNotesByPatientIdCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadModuleNotesByPatientIdCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}