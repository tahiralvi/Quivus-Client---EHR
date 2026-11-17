package com.adobe.Quivus.command.staticData.lab
{
	
	
	import com.adobe.Quivus.delegate.staticData.lab.LoadICDCodeDelegate;
	import com.adobe.Quivus.events.staticData.lab.LoadICDCodeEvent;
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

	
	public class LoadICDCodeCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		private var func			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				 var delegate:LoadICDCodeDelegate = new  LoadICDCodeDelegate(this);
				 
				 var LE:LoadICDCodeEvent = cgEvent as LoadICDCodeEvent;
				 
				 if(LE.func != null)
				 	func = LE.func;
				 
				 if(LE.icdCode!=null && LE.icdCode.length>0){
					 delegate.LoadICDCode(LE.icdCode,model.sessionDTO);
				 }
			 
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var icdCodeResponse:ICDCodeResponse = re.result as ICDCodeResponse;
				
				if(icdCodeResponse!=null)
				{
					if(icdCodeResponse.ResponseStatus){
						
						if(icdCodeResponse.ResponseList!=null){
							model.icdCodeDTOList = icdCodeResponse.ResponseList;
						}
						if(null != func)
							func();
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(icdCodeResponse.ResponseCode);
						if(valid)
							Alert.show("LoadICDCode"+"\n"+icdCodeResponse.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadICDCode"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadICDCodeCommand.";
			//	Alert.show("Fault occured in LoadICDCodeCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadICDCodeCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}