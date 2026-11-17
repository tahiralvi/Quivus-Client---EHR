package com.adobe.Quivus.command.viewBackground.recommendation
{
	import com.adobe.Quivus.delegate.viewBackground.recommendation.ManagePatientRecommendationDelegate;
	import com.adobe.Quivus.events.viewBackground.recommendation.LoadPatientRecommendationByPatientIdEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.Quivus.view.controls.custom.patientExamView.quickInput.assessment.plan.recommendation.RecommendationView;
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

	
	public class ManagePatientRecommendationCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : ManagePatientRecommendationDelegate = new ManagePatientRecommendationDelegate( this );
				if(model.patientRecommendationDTOListByPatientId!=null)
				{		
					model.patientRecommendationDTOListByPatientId.filterFunction = null;
					model.patientRecommendationDTOListByPatientId.refresh();
					var i:int;
					var newList:ArrayCollection = new ArrayCollection();
					for(i=0;i<model.patientRecommendationDTOListByPatientId.length;i++)
					{
						var dto:PatientRecommendationDTO = model.patientRecommendationDTOListByPatientId.getItemAt(i) as PatientRecommendationDTO;
						if(dto.IsDeleted == true || dto.IsDirty == true)
						{
							dto.ModifiedBy = model.loggedInUserDTO.UserId;		
							dto.ModifiedAt = new Date();
							newList.addItem(dto);
						}
					}
					
					if(newList.length>0)
						delegate.ManagePatientRecommendation(newList,model.sessionDTO);
				}
				
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				var resp:PatientRecommendationResponse    = re.result as PatientRecommendationResponse ;
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						var lprbp:LoadPatientRecommendationByPatientIdEvent = new LoadPatientRecommendationByPatientIdEvent();
						CairngormEventDispatcher.getInstance().dispatchEvent( lprbp );
					}
					else
					{
						model.errorStatus = resp.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("ManagePatientRecommendation"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("ManagePatientRecommendation"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in ManagePatientRecommendationCommand.";
			//	Alert.show("Fault occured in ManagePatientRecommendationCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in ManagePatientRecommendationCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}