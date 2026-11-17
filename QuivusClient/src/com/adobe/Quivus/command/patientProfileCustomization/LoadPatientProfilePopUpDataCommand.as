package com.adobe.Quivus.command.patientProfileCustomization
{
	import com.adobe.Quivus.delegate.patientProfileCustomization.LoadPatientProfilePopUpDataDelegate;
	import com.adobe.Quivus.events.patientProfileCustomization.LoadPatientProfilePopUpDataEvent;
	import com.adobe.Quivus.model.AppModelLocator;
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

	
	public class LoadPatientProfilePopUpDataCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadPatientProfilePopUpDataDelegate = new LoadPatientProfilePopUpDataDelegate( this );
				var LE:LoadPatientProfilePopUpDataEvent = cgEvent as LoadPatientProfilePopUpDataEvent;
			
				model.loadedPatientId = LE.patientId;
				if(LE.patientId>0){
					delegate.LoadPatientProfilePopUpData(LE.patientId,
													 model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq,
													 model.loggedInUserDTO.UserId,model.sessionDTO);
				}
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				 
				var patientProfileInfoResposne:PatientProfileInfoResposne = re.result as PatientProfileInfoResposne;			
				
				if(patientProfileInfoResposne!=null)
				{
					if(patientProfileInfoResposne.ResponseStatus)
					{
						model.userPatientProfileBarInfoPopUpData = patientProfileInfoResposne.TaggedProfile;
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(patientProfileInfoResposne.ResponseCode);
						if(valid)
							Alert.show("LoadPatientProfilePopUpData"+"\n"+patientProfileInfoResposne.ResponseMessage, Messages.ERROR,4, FlexGlobals.topLevelApplication.mainContainer);				
					}
				}
				else
				{
					Alert.show("LoadPatientProfilePopUpData"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadPatientProfilePopUpDataCommand.";
		//		Alert.show("Fault occured in LoadPatientProfilePopUpDataCommand.\n"+rpcEvent.toString());*/
			//}
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(rpcEvent.toString(),"Fault occured in LoadPatientProfilePopUpDataCommand ","",model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert);*/
				
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}