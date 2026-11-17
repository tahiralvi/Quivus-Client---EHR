package com.adobe.Quivus.command.quickInput.diagnosis
{	
	import com.adobe.Quivus.delegate.quickInput.diagnosis.LoadPatientDiagnosisByVisitIdDelegate;
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
	
	
	public class LoadPatientDiagnosisByVisitIdCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadPatientDiagnosisByVisitIdDelegate = new LoadPatientDiagnosisByVisitIdDelegate( this );
				var vId:int;
				
				if(model.quickInputDTO!=null)
				{	
					if(model.quickInputDTO.Visit!=null && model.quickInputDTO.Visit.VisitId>0)
					{
						vId = model.quickInputDTO.Visit.VisitId;
						
					}
					if(model.visitDTO!=null && model.visitDTO.VisitId>0)
					{
						vId = model.visitDTO.VisitId;
						
					}
				}
				
				
				
				
				delegate.LoadPatientDiagnosisByVisitId(vId, model.sessionDTO);
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:PatientDiagnosisResponse  = re.result as PatientDiagnosisResponse ;
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						model.quickInputDTO.Assessment.Diagnosis = resp.PatientDiagnosisList;
						
					}
					else
					{
						model.errorStatus = resp.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("LoadPatientDiagnosisByVisitId"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadPatientDiagnosisByVisitId"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
			model.errorStatus = "Fault occured in LoadPatientDiagnosisByVisitIdCommand.";
			//Alert.show("Fault occured in LoadPatientDiagnosisByVisitIdCommand.\n"+rpcEvent.toString());*/
			//}
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(rpcEvent.toString(),"Fault occured in LoadPatientDiagnosisByVisitIdCommand ","",model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert);*/
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}