package com.adobe.Quivus.command.staticData.lab
{
	
	
	import com.adobe.Quivus.delegate.staticData.lab.LoadLabTestSpecimenTypeStaticDataDelegate;
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

	
	public class LoadLabTestSpecimenTypeStaticDataCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		private var perUtil:PersistanceUtility = new PersistanceUtility();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				 var delegate:LoadLabTestSpecimenTypeStaticDataDelegate = new  LoadLabTestSpecimenTypeStaticDataDelegate(this);
				 if(perUtil.isQuickInputLocalDBAvaliable())
				 {
					 // model.labNatureTypeDTOList = new ArrayCollection();
					 
					 perUtil.loadSpecifiedQuickInputData(Constants.TEST_SPECIMEN_TYPE_QUICKINPUT_STATIC_DATA);
				 }
				 else
				 {
				 	delegate.LoadLabTestSpecimenTypeStaticData(model.sessionDTO);
				 }
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var labTestSpecimenTypeResponse:LabTestSpecimenTypeResponse = re.result as LabTestSpecimenTypeResponse;
				
				if(labTestSpecimenTypeResponse!=null)
				{
					if(labTestSpecimenTypeResponse.ResponseStatus)
					{
						if(labTestSpecimenTypeResponse.ResponseList!=null){
	
							model.labTestSpecimenTypeDTOList = labTestSpecimenTypeResponse.ResponseList;
							
							perUtil.initializeSpecifiedQuickInputDB(Constants.TEST_SPECIMEN_TYPE_QUICKINPUT_STATIC_DATA);
						}
						else
						{
							var valid:Boolean = QSUtilityFunctions.checkSession(labTestSpecimenTypeResponse.ResponseCode);
							if(valid)
								Alert.show("LoadLabTestSpecimenTypeStaticData"+"\n"+Messages.NO_DATA_RETURNED_FROM_SERVICE.toString(),  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
						}
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(labTestSpecimenTypeResponse.ResponseCode);
						if(valid)
							Alert.show("LoadLabTestSpecimenTypeStaticData"+"\n"+labTestSpecimenTypeResponse.ResponseMessage,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadLabTestSpecimenTypeStaticData"+"\n"+Messages.SERVICE_DIDNOT_RESPOND ,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadLabTestSpecimenTypeStaticDataCommand.";
			//	Alert.show("Fault occured in LoadLabTestSpecimenTypeStaticDataCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadLabTestSpecimenTypeStaticDataCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}