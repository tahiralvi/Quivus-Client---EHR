package com.adobe.Quivus.command.staticData.lab
{
	
	
	import com.adobe.Quivus.delegate.staticData.lab.LoadLIONICLabTestTypeDelegate;
	import com.adobe.Quivus.events.staticData.lab.LoadLIONICLabTestTypeEvent;
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

	
	public class LoadLIONICLabTestTypeCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				 var delegate:LoadLIONICLabTestTypeDelegate = new  LoadLIONICLabTestTypeDelegate(this);
				 
				 var LE:LoadLIONICLabTestTypeEvent = cgEvent as LoadLIONICLabTestTypeEvent;
				 trace("labtestTypeID: "+LE.labtestTypeID+ " labTestCodeOrName: "+LE.labTestCodeOrName );
				 if(LE.labtestTypeID > 0 && LE.labTestCodeOrName!=null && LE.labTestCodeOrName.length>0){
					 delegate.LoadLIONICLabTestType(LE.labtestTypeID,LE.labTestCodeOrName,model.sessionDTO);
				 }
			}			 
			
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:LIONICLabTestTypeResponse  = re.result as LIONICLabTestTypeResponse;
				
				if(resp!=null)
				{
					if(resp.ResponseStatus){
						
						if(resp.ResponseList!=null){
							model.lionicLabTestTypeDTOList = resp.ResponseList;
						} 
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("LoadLIONICLabTestType"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadLIONICLabTestType"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadLIONICLabTestTypeCommand.";
			//	Alert.show("Fault occured in LoadLIONICLabTestTypeCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadLIONICLabTestTypeCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}