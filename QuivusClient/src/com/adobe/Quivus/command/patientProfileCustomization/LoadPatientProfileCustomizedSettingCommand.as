package com.adobe.Quivus.command.patientProfileCustomization
{
	import com.adobe.Quivus.delegate.patientProfileCustomization.LoadPatientProfileCustomizedSettingDelegate;
	import com.adobe.Quivus.events.LoadUserMostRecentPatientEvent;
	import com.adobe.Quivus.events.patientProfileCustomization.LoadPatientProfileCustomizedSettingEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;
	
	
	public class LoadPatientProfileCustomizedSettingCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		public var overrideTemp			: Boolean;
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadPatientProfileCustomizedSettingDelegate = new LoadPatientProfileCustomizedSettingDelegate( this );
				
				var LE:LoadPatientProfileCustomizedSettingEvent = cgEvent as LoadPatientProfileCustomizedSettingEvent;
				this.overrideTemp = LE.overrideTemp;
				
				if(LE.patientId>0){
					delegate.LoadPatientProfileCustomizedSetting(model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq,
						model.loggedInUserDTO.UserId,LE.patientId,model.sessionDTO);
				}
			}
			
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var patientProfileSettingResponse:PatientProfileSettingResponse = re.result as PatientProfileSettingResponse;
				
				if(patientProfileSettingResponse!=null){
					if(patientProfileSettingResponse.ResponseStatus)
					{
						model.userPatientProfileBarSetting = patientProfileSettingResponse;
						
						if(this.overrideTemp)
						{
							model.userPatientProfileBarSettingTemp = patientProfileSettingResponse;
						}
						
						var mrpEvent : LoadUserMostRecentPatientEvent = new LoadUserMostRecentPatientEvent();
						CairngormEventDispatcher.getInstance().dispatchEvent( mrpEvent );
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(patientProfileSettingResponse.ResponseCode);
						if(valid)
							Alert.show("LoadPatientProfileCustomizedSetting"+"\n"+patientProfileSettingResponse.ResponseMessage, Messages.ERROR,4, FlexGlobals.topLevelApplication.mainContainer);				
					}
				}
				else
				{
					Alert.show("LoadPatientProfileCustomizedSetting"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		public function fault( rpcEvent : Object ) : void 
		{
			model.errorStatus = "Fault occured in LoadPatientProfileCustomizedSettingCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}