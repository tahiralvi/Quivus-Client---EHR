package com.adobe.Quivus.command.viewBackground.lab
{
	import com.adobe.Quivus.delegate.viewBackground.lab.LoadPatientLabsByPatientIdDelegate;
	import com.adobe.Quivus.delegate.viewBackground.lab.LoadPatientLabsByVisitIdDelegate;
	import com.adobe.Quivus.events.viewBackground.lab.LoadPatientLabsByVisitIdEvent;
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

	
	public class LoadPatientLabsByPatientIdCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadPatientLabsByPatientIdDelegate = new LoadPatientLabsByPatientIdDelegate( this );
				
				//var LE:LoadPatientLabsByVisitIdEvent = cgEvent as LoadPatientLabsByVisitIdEvent;
				
				delegate.LoadPatientLabsByPatientId(model.loadedPatientId,
					model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq,
					model.sessionDTO,model.stationIdsForVB,
					model.isAllStationSelected,
					model.LabOutCurrentPageByPatient
				);
			}
			
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:PatientLabResponse   = re.result as PatientLabResponse ;
				
				model.vbEventCounter= model.vbEventCounter-1;
				
				if(model.vbEventCounter==0){
					
					model.vbDataLoadedFlag=true;
				}
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						model.labDTOListByPatient = resp.ResponseList;
					}
					else
					{
						model.errorStatus = resp.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("LoadPatientLabsByPatientId"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadPatientLabsByPatientId"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadPatientLabsByPatientIdCommand.";
			//	Alert.show("Fault occured in LoadPatientLabsByPatientIdCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadPatientLabsByPatientIdCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}