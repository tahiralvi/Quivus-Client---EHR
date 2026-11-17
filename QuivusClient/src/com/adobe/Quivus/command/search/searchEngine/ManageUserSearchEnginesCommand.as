package com.adobe.Quivus.command.search.searchEngine
{
	import com.adobe.Quivus.delegate.search.searchEngine.ManageUserSearchEnginesDelegate;
	import com.adobe.Quivus.events.search.searchEngine.LoadUserSearchEngineEvent;
	import com.adobe.Quivus.events.search.searchEngine.ManageUserSearchEnginesEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class ManageUserSearchEnginesCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : ManageUserSearchEnginesDelegate = new ManageUserSearchEnginesDelegate( this );
				
				var LE:ManageUserSearchEnginesEvent = cgEvent as ManageUserSearchEnginesEvent;
				
				if(LE.searchEnginesIdsList!=null ){
					var selectedSearchEnginList:ArrayCollection = LE.searchEnginesIdsList;
				
					var i:int=0;
					if(model.allSearchEngineDTOList!=null && model.allSearchEngineDTOList.length>0){
						for(;i<model.allSearchEngineDTOList.length;i++)
						{
							var se:SearchEngineDTO = model.allSearchEngineDTOList.getItemAt(i) as SearchEngineDTO;
							if(se.IsSystemGenerated)
							{
								var j:int=0;
								for(;j<selectedSearchEnginList.length;j++)
								{
									if(se.SearchEngineTypeID == selectedSearchEnginList.getItemAt(j))
									{
										selectedSearchEnginList.removeItemAt(j);
										j--;
									}
								}
							}
						}
					}
					if(selectedSearchEnginList!=null && selectedSearchEnginList.length>0){
						delegate.ManageUserSearchEngines(model.loggedInUserDTO.UserId,
														model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq,
														selectedSearchEnginList,model.loggedInUserDTO.UserId,
														model.sessionDTO);
					}
					else if(selectedSearchEnginList!=null && selectedSearchEnginList.length==0)
					{
						delegate.ManageUserSearchEnginesDeleteAll(model.loggedInUserDTO.UserId,
																  model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq,
																  model.loggedInUserDTO.UserId
																	,model.sessionDTO);
					}
				}
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var searchEngineResponse:SearchEngineResponse = re.result as SearchEngineResponse;
				
				
				if(searchEngineResponse.ResponseStatus)
				{
					Alert.show(Messages.UPDATE_SUCCESSFULL, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					var seEvent : LoadUserSearchEngineEvent = new LoadUserSearchEngineEvent();
					CairngormEventDispatcher.getInstance().dispatchEvent( seEvent );
				}
				else
				{
					model.errorStatus = searchEngineResponse.ResponseMessage ;
					var valid:Boolean = QSUtilityFunctions.checkSession(searchEngineResponse.ResponseCode);
					if(valid)
						Alert.show("ManageUserSearchEngines"+"\n"+searchEngineResponse.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in ManageUserSearchEnginesCommand.";
			//	Alert.show("Fault occured in ManageUserSearchEnginesCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in ManageUserSearchEnginesCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}