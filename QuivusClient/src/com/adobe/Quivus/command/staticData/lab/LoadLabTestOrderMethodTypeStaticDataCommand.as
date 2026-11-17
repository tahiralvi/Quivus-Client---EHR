package com.adobe.Quivus.command.staticData.lab
{
	
	
	import com.adobe.Quivus.delegate.staticData.lab.LoadLabTestOrderMethodTypeStaticDataDelegate;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.Quivus.utils.sql.PersistanceUtility;
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

	
	public class LoadLabTestOrderMethodTypeStaticDataCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		private var perUtil:PersistanceUtility = new PersistanceUtility();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				 var delegate:LoadLabTestOrderMethodTypeStaticDataDelegate = new  LoadLabTestOrderMethodTypeStaticDataDelegate(this);
				 
				 if(perUtil.isQuickInputLocalDBAvaliable())
				 {
					 // model.labNatureTypeDTOList = new ArrayCollection();
					 
					 perUtil.loadSpecifiedQuickInputData(Constants.LAB_TEST_ORDERMETHOD_TYPE_QUICKINPUT_STATIC_DATA);
				 }
				 else
				 {
					 delegate.LoadLabTestOrderMethodTypeStaticData(model.sessionDTO);
				 }
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var labTestOrderMethodTypeResponse:LabTestOrderMethodTypeResponse = re.result as LabTestOrderMethodTypeResponse;
				
				if(labTestOrderMethodTypeResponse!=null)
				{
					if(labTestOrderMethodTypeResponse.ResponseStatus)
					{
						if(labTestOrderMethodTypeResponse.ResponseList!=null){
	
							model.labTestOrderMethodTypeDTOList = labTestOrderMethodTypeResponse.ResponseList;
							
							perUtil.initializeSpecifiedQuickInputDB(Constants.LAB_TEST_ORDERMETHOD_TYPE_QUICKINPUT_STATIC_DATA);
						}
						else
						{
							var valid:Boolean = QSUtilityFunctions.checkSession(labTestOrderMethodTypeResponse.ResponseCode);
							if(valid)
								Alert.show("LoadLabTestOrderMethodTypeStaticData"+"\n"+Messages.NO_DATA_RETURNED_FROM_SERVICE.toString(),  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
						}
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(labTestOrderMethodTypeResponse.ResponseCode);
						if(valid)
							Alert.show("LoadLabTestOrderMethodTypeStaticData"+"\n"+labTestOrderMethodTypeResponse.ResponseMessage,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadLabTestOrderMethodTypeStaticData"+"\n"+Messages.SERVICE_DIDNOT_RESPOND ,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadLabTestOrderMethodTypeStaticDataCommand.";
			//	Alert.show("Fault occured in LoadLabTestOrderMethodTypeStaticDataCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadLabTestOrderMethodTypeStaticDataCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}