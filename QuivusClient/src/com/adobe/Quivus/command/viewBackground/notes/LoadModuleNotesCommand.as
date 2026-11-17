package com.adobe.Quivus.command.viewBackground.notes
{
	import com.adobe.Quivus.delegate.viewBackground.notes.LoadModuleNotesDelegate;
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

	
	public class LoadModuleNotesCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadModuleNotesDelegate = new LoadModuleNotesDelegate( this );
				
				var LE:LoadModuleNotesEvent = cgEvent as LoadModuleNotesEvent;
				
				var visitId:int 		= LE.visitId;
				
				if(visitId>0 )
				{
					delegate.LoadModuleNotes(visitId,model.sessionDTO);
				}
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var visitNotesResponse :VisitNotesResponse   = re.result as VisitNotesResponse ;
				if(visitNotesResponse!=null)
				{
					if(visitNotesResponse.ResponseStatus)
					{
						model.moduleNoteDTOList =  visitNotesResponse.ModuleNoteData;
													
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(visitNotesResponse.ResponseCode);
						if(valid)
							Alert.show("LoadModuleNotes"+"\n"+visitNotesResponse.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadModuleNotes"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadModuleNotesCommand.";
			//	Alert.show("Fault occured in LoadModuleNotesCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadModuleNotesCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}