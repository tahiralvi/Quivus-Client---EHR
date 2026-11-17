package com.adobe.Quivus.command.staticData
{
	
	
	import com.adobe.Quivus.delegate.staticData.LoadAllSearchEnginesDelegate;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
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

	
	public class LoadAllSearchEnginesCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				 var delegate:LoadAllSearchEnginesDelegate = new  LoadAllSearchEnginesDelegate(this);
				 delegate.LoadAllSearchEngines(model.sessionDTO);
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var searchEngineResponse:SearchEngineResponse = re.result as SearchEngineResponse;
				
				if(searchEngineResponse!=null)
				{
					if(searchEngineResponse.ResponseStatus)
					{
						if(searchEngineResponse.ResponseData!=null){
							if(model.allSearchEngineDTOList!=null){
								model.allSearchEngineDTOList.removeAll();
							}
							
							model.allSearchEngineDTOList = searchEngineResponse.ResponseData;
	
	
							
							
							var i:int = 0;
							var j:int = 0;
							for(i=0;i<model.allSearchEngineDTOList.length;i++)
							{
								(model.allSearchEngineDTOList.getItemAt(i) as SearchEngineDTO).IsActive=false;
							}
							
							
							
							if(model.allSearchEngineDTOList!=null && model.allSearchEngineDTOList.length>0)
							{
								
								 
								for(i=0;i<model.allSearchEngineDTOList.length;i++)
								{
									var allSearchEngineDTO:SearchEngineDTO = model.allSearchEngineDTOList.getItemAt(i) as SearchEngineDTO;
									
									
									var userSearchEngineList:ArrayCollection = model.userSearchEngineDTOList;
									
									for(j=0;j<userSearchEngineList.length;j++)
									{
										var searchEngineDTO:SearchEngineDTO = userSearchEngineList.getItemAt(j) as SearchEngineDTO ;
										if(allSearchEngineDTO.SearchEngineTypeID == searchEngineDTO.SearchEngineTypeID)
										{
											(model.allSearchEngineDTOList.getItemAt(i) as SearchEngineDTO).IsActive= true;
										}
									}
								}						
								
								
								for(j=0;j<userSearchEngineList.length;j++)
								{
									var searchEngineDTO:SearchEngineDTO = userSearchEngineList.getItemAt(j) as SearchEngineDTO ;
									
									for(i=0;i<model.allSearchEngineDTOList.length;i++)
									{
										var allSearchEngineDTO:SearchEngineDTO = model.allSearchEngineDTOList.getItemAt(i) as SearchEngineDTO;
										
										if(allSearchEngineDTO.SearchEngineTypeID == searchEngineDTO.SearchEngineTypeID)
										{
											(model.allSearchEngineDTOList.getItemAt(i) as SearchEngineDTO).IsActive= true;
										}
									}
								}
							}
							
						}
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(searchEngineResponse.ResponseCode);
						if(valid)
							Alert.show("LoadAllSearchEngines"+"\n"+searchEngineResponse.ResponseMessage,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadAllSearchEngines"+"\n"+Messages.SERVICE_DIDNOT_RESPOND ,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadAllSearchEnginesCommand.";
				//Alert.show("Fault occured in LoadAllSearchEnginesCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadAllSearchEnginesCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert); */
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}