package com.adobe.Quivus.command.staticData.followUp
{
	
	
	import com.adobe.Quivus.delegate.staticData.followUp.LoadInstructionAgeTypeDelegate;
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

	
	public class LoadInstructionAgeTypeCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		private var perUtil:PersistanceUtility = new PersistanceUtility();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				 var delegate:LoadInstructionAgeTypeDelegate = new  LoadInstructionAgeTypeDelegate(this);
				 
				 if(perUtil.isQuickInputLocalDBAvaliable())
				 {
					 
					 perUtil.loadSpecifiedQuickInputData(Constants.INSTRUCTIONAGE_TYPE_QUICKINPUT_STATIC_DATA);
				 }
				 else
				 {
				 	delegate.LoadInstructionAgeType(model.sessionDTO);
				 }
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:InstructionAgeTypeResponse   = re.result as InstructionAgeTypeResponse;
				
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						if(resp.InstructionAgeTypeList!=null){
	
							model.instructionAgeTypeDTOList = resp.InstructionAgeTypeList;
							
							perUtil.initializeSpecifiedQuickInputDB(Constants.INSTRUCTIONAGE_TYPE_QUICKINPUT_STATIC_DATA);
						}
						else
						{
							Alert.show("LoadInstructionAgeType"+"\n"+Messages.NO_DATA_RETURNED_FROM_SERVICE.toString(),  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
						}
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("LoadInstructionAgeType"+"\n"+resp.ResponseMessage,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadInstructionAgeType"+"\n"+Messages.SERVICE_DIDNOT_RESPOND ,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			
				model.errorStatus = "Fault occured in LoadInstructionAgeTypeCommand.";
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}