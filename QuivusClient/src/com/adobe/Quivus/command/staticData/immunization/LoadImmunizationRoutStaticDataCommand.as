package com.adobe.Quivus.command.staticData.immunization
{
	import com.adobe.Quivus.delegate.staticData.immunization.LoadImmunizationRoutStaticDataDelegate;
	import com.adobe.Quivus.events.staticData.immunization.LoadImmunizationRoutStaticDataEvent;
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

	
	public class LoadImmunizationRoutStaticDataCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadImmunizationRoutStaticDataDelegate = new LoadImmunizationRoutStaticDataDelegate( this );
				
				
				var LE:LoadImmunizationRoutStaticDataEvent = cgEvent as LoadImmunizationRoutStaticDataEvent;
				
				delegate.LoadImmunizationRoutStaticData(LE.searchCriteria,model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq,model.sessionDTO);
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var immunizationAutoCompleteResponse:ImmunizationAutoCompleteResponse  = re.result as ImmunizationAutoCompleteResponse ;
				
				if(immunizationAutoCompleteResponse!=null)
				{
					if(immunizationAutoCompleteResponse.ResponseStatus)
					{
						model.immunizationRoutList = immunizationAutoCompleteResponse.AutoCompleteList;
						
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(immunizationAutoCompleteResponse.ResponseCode);
						if(valid)
							Alert.show("LoadImmunizationDoseStaticData"+"\n"+immunizationAutoCompleteResponse.ResponseMessage, "Info",4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadImmunizationDoseStaticData"+"\n"+Messages.SERVICE_DIDNOT_RESPOND ,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadImmunizationDoseStaticDataCommand.";
			//	Alert.show("Fault occured in LoadImmunizationDoseStaticDataCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadImmunizationDoseStaticDataCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}