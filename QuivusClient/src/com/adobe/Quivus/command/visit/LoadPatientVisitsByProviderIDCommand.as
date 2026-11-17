package com.adobe.Quivus.command.visit
{
	import com.adobe.Quivus.delegate.visit.LoadPatientVisitsByProviderIDDelegate;
	import com.adobe.Quivus.events.visit.LoadPatientVisitsByProviderIDEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.PatientEncounterResult;
	import valueObjects.PatientEncountersResponse;
	
	public class LoadPatientVisitsByProviderIDCommand implements Command, IResponder
	{
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			if(model.UserLoggedIn)
			{
				var delegate : LoadPatientVisitsByProviderIDDelegate = new LoadPatientVisitsByProviderIDDelegate( this );
				var LE:LoadPatientVisitsByProviderIDEvent = cgEvent as LoadPatientVisitsByProviderIDEvent;
				//clear previous result
				model.QLpatientEncounterResult = new PatientEncounterResult();
				delegate.LoadPatientVisitsByProviderID(LE.Page, LE.strUserId, LE.strclinicBranchId, LE.strshowAll);
			}
		}
		
		public function result( rpcEvent : Object ) : void 
		{
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var patientEncountersResponse:PatientEncountersResponse  = re.result as PatientEncountersResponse ;
				
				if(patientEncountersResponse.ResponseStatus)
				{
					if(patientEncountersResponse.EncounterResult!=null)
					{
						model.QLpatientEncounterResult 	= patientEncountersResponse.EncounterResult;
					}
					else
					{
					//	Alert.show("LoadPatientVisitsByProviderID"+"\n"+Messages.NO_DATA_RETURNED_FROM_SERVICE, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
					
				}
				else
				{
					model.errorStatus = patientEncountersResponse.ResponseMessage.toString() ;
					var valid:Boolean = QSUtilityFunctions.checkSession(patientEncountersResponse.ResponseCode);
				//	if(valid)
				//		Alert.show("LoadPatientVisitsByProviderID"+"\n"+patientEncountersResponse.ResponseMessage.toString(), Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void 
		{
			model.errorStatus = "Fault occured in LoadPatientVisitsByProviderIDCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}