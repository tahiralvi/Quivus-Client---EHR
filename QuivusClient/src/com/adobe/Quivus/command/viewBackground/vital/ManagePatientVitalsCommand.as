package com.adobe.Quivus.command.viewBackground.vital
{
	import com.adobe.Quivus.delegate.viewBackground.vital.ManagePatientVitalsDelegate;
	import com.adobe.Quivus.events.viewBackground.vital.LoadPatientVitalsByPatientIdEvent;
	import com.adobe.Quivus.events.viewBackground.vital.ManagePatientVitalsEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.common.util.exceptionAlert.QSExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class ManagePatientVitalsCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : ManagePatientVitalsDelegate = new ManagePatientVitalsDelegate( this );
				
				//var LE:ManagePatientVitalsEvent = cgEvent as ManagePatientVitalsEvent;
				if(model.vitalDTOListByPatient!=null)
				{		
					model.vitalDTOListByPatient.filterFunction = null;
					model.vitalDTOListByPatient.refresh();
					
					var i:int;
					var newList:ArrayCollection = new ArrayCollection();
					for(i=0;i<model.vitalDTOListByPatient.length;i++)
					{
						var dto:VitalDTO = model.vitalDTOListByPatient.getItemAt(i) as VitalDTO;
						if(dto.IsDeleted == true || dto.IsDirty == true)
						{
							dto.ModifiedBy = model.loggedInUserDTO.UserId;		
							dto.ModifiedAt = new Date();
							newList.addItem(dto);
						}
					}
					
					if(newList.length>0)
						delegate.ManagePatientVitals(newList,model.sessionDTO);
				}
				
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{	
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:PatientVitalResponse = re.result as PatientVitalResponse ;
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						var lpv:LoadPatientVitalsByPatientIdEvent = new LoadPatientVitalsByPatientIdEvent();
						CairngormEventDispatcher.getInstance().dispatchEvent( lpv );				
					}
					else
					{
						model.errorStatus = resp.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("ManagePatientVitals"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("ManagePatientVitals"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in ManagePatientVitalsCommand.";
			//	Alert.show("Fault occured in ManagePatientVitalsCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in ManagePatientVitalsCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}