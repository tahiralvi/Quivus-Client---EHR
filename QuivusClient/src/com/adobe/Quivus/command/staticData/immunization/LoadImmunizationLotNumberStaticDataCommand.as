package com.adobe.Quivus.command.staticData.immunization
{
	import com.adobe.Quivus.delegate.staticData.immunization.LoadImmunizationLotNumberStaticDataDelegate;
	import com.adobe.Quivus.events.staticData.immunization.LoadImmunizationLotNumberStaticDataEvent;
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

	
	public class LoadImmunizationLotNumberStaticDataCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadImmunizationLotNumberStaticDataDelegate = new LoadImmunizationLotNumberStaticDataDelegate( this );
				
				
				var LE:LoadImmunizationLotNumberStaticDataEvent = cgEvent as LoadImmunizationLotNumberStaticDataEvent;
				
				delegate.LoadImmunizationLotNumberStaticData(LE.searchCriteria,model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq,model.sessionDTO);
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
						model.immunizationLotNumberList = immunizationAutoCompleteResponse.AutoCompleteList;
						
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(immunizationAutoCompleteResponse.ResponseCode);
						if(valid)
							Alert.show("LoadImmunizationLotNumberStaticData"+"\n"+immunizationAutoCompleteResponse.ResponseMessage, "Info",4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadImmunizationLotNumberStaticData"+"\n"+Messages.SERVICE_DIDNOT_RESPOND ,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadImmunizationLotNumberStaticDataCommand.";
			//	Alert.show("Fault occured in LoadImmunizationLotNumberStaticDataCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadImmunizationLotNumberStaticDataCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}