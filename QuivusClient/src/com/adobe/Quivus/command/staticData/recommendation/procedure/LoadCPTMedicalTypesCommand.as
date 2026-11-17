package com.adobe.Quivus.command.staticData.recommendation.procedure
{
	
	
	import com.adobe.Quivus.delegate.staticData.recommendation.procedure.LoadCPTMedicalTypesDelegate;
	import com.adobe.Quivus.events.staticData.recommendation.procedure.LoadCPTMedicalTypesEvent;
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

	
	public class LoadCPTMedicalTypesCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		private var func			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate:LoadCPTMedicalTypesDelegate = new  LoadCPTMedicalTypesDelegate(this);
				var LE:LoadCPTMedicalTypesEvent = cgEvent as LoadCPTMedicalTypesEvent;
				
				if(LE.func != null)
					func = LE.func;
				delegate.LoadCPTMedicalTypes(LE.cptName,model.sessionDTO);
			}
			 
			
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:CPTMedicalTypeResponse = re.result as CPTMedicalTypeResponse;
				
				if(resp!=null)
				{
					if(resp.ResponseStatus){
						
						if(resp.ResponseList!=null){
							model.cptMedicalTypesDTOList = resp.ResponseList;
						} 
						
						if(null != func)
							func();
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("LoadCPTMedicalTypes"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadCPTMedicalTypes"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadCPTMedicalTypesCommand.";
			//	Alert.show("Fault occured in LoadCPTMedicalTypesCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadCPTMedicalTypesCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}