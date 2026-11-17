package com.adobe.Quivus.command
{
	import com.adobe.Quivus.delegate.SavePatientAllergyDelegate;
	import com.adobe.Quivus.events.SavePatientAllergyEvent;
	import com.adobe.Quivus.events.patientProfileCustomization.LoadPatientProfileCustomizedSettingEvent;
	import com.adobe.Quivus.events.viewBackground.allergy.LoadPatientAllergyByPatientIdEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.Quivus.utils.QuivusCombineEventDispatcher;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.common.util.exceptionAlert.QSExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class SavePatientAllergyCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		public var patientAllergyDTO : PatientAllergyDTO;
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : SavePatientAllergyDelegate = new SavePatientAllergyDelegate( this );
				var LE:SavePatientAllergyEvent = cgEvent as SavePatientAllergyEvent;
				this.patientAllergyDTO = LE.patientAllergyDTO;
				delegate.SavePatientAllergy(model.loadedPatientId,model.loggedInUserDTO.UserId,LE.patientAllergyDTO,model.sessionDTO);
			}
			
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var serviceResponse:ServiceResponse = re.result as ServiceResponse;
				
				
				if(serviceResponse.ResponseStatus)
				{
					
					var testEvent : LoadPatientProfileCustomizedSettingEvent = new LoadPatientProfileCustomizedSettingEvent(model.loadedPatientId,false);
					CairngormEventDispatcher.getInstance().dispatchEvent( testEvent );
					
					if( UtilityFunctions.IsNullOrEmpty( model.allergyCurrentPageByPatient ) )
					{
						model.allergyCurrentPageByPatient = new PageDTO();
						QSUtilityFunctions.CheckUserPageOrSetPageToZero( model.allergyCurrentPageByPatient );
					}
					
					var lpa : LoadPatientAllergyByPatientIdEvent = new LoadPatientAllergyByPatientIdEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( lpa );
					
				}
			}
			
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in SavePatientAllergyCommand.";
				//Alert.show("Fault occured in SavePatientAllergyCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in SavePatientAllergyCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}