package com.adobe.Quivus.command.staticData.lab
{
	
	
	import com.adobe.Quivus.delegate.staticData.lab.LoadInHouseLabTestTypeByClinicIdDelegate;
	import com.adobe.Quivus.events.staticData.lab.LoadInHouseLabTestTypeByClinicIdEvent;
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

	
	public class LoadInHouseLabTestTypeByClinicIdCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		private var func			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate:LoadInHouseLabTestTypeByClinicIdDelegate = new  LoadInHouseLabTestTypeByClinicIdDelegate(this);
				
				var LE:LoadInHouseLabTestTypeByClinicIdEvent = cgEvent as LoadInHouseLabTestTypeByClinicIdEvent;
				
				if(LE.func != null)
					func = LE.func;
				
				delegate.LoadInHouseLabTestTypeByClinicId(model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq,model.sessionDTO);
			}
			 
			
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:InHouseLabTestTypeResponse  = re.result as InHouseLabTestTypeResponse ;
				
				if(resp!=null)
				{
					if(resp.ResponseStatus){
						
						if(resp.ResponseList!=null){
							model.inHouseLabTestTypeDTOList = resp.ResponseList;
						} 
						if(null != func)
							func();
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("LoadInHouseLabTestTypeByClinicId"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadInHouseLabTestTypeByClinicId"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadInHouseLabTestTypeByClinicIdCommand.";
			//	Alert.show("Fault occured in LoadInHouseLabTestTypeByClinicIdCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadInHouseLabTestTypeByClinicIdCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}