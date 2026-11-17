package com.adobe.Quivus.command.search.searchEngine
{
	import com.adobe.Quivus.delegate.search.searchEngine.LoadUserSearchEngineDelegate;
	import com.adobe.Quivus.events.search.searchEngine.ChangeDefaultSearchEngineEvent;
	import com.adobe.Quivus.events.search.searchEngine.LoadUserSearchEngineEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class LoadUserSearchEngineCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadUserSearchEngineDelegate = new LoadUserSearchEngineDelegate( this );
				
				var userId:int = model.loggedInUserDTO.UserId;
				var clinicBranchId:int  = model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq;
				if(userId>0 && clinicBranchId>0){
					delegate.LoadUserSearchEngine(userId,clinicBranchId,model.sessionDTO);
				}
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var searchEngineResponceDTO:SearchEngineResponse = re.result as SearchEngineResponse;
				if(searchEngineResponceDTO!=null)
				{
					if(searchEngineResponceDTO.ResponseStatus)
					{
						
						LoadUserSearchEngineEvent.isAlreadyLoaded = true;
						
						if(searchEngineResponceDTO.ResponseData!=null){
							model.userSearchEngineDTOList = searchEngineResponceDTO.ResponseData;
							var i:int =0;
							var isPrefferedPresent:Boolean=false;
							for(;i<searchEngineResponceDTO.ResponseData.length;i++){
								//trace("searchEngine image byte length::"+(searchEngineResponceDTO.ResponseData.getItemAt(i) as SearchEngineDTO).icon.length);
								if((searchEngineResponceDTO.ResponseData.getItemAt(i) as SearchEngineDTO).IsPreferred){
									model.userPrefferedSearchEngineDTO = (searchEngineResponceDTO.ResponseData.getItemAt(i) as SearchEngineDTO);
									isPrefferedPresent=true;
									break;								
								}
								
							}
							if(!isPrefferedPresent && searchEngineResponceDTO.ResponseData.length>0){
								model.userPrefferedSearchEngineDTO = (searchEngineResponceDTO.ResponseData.getItemAt(0) as SearchEngineDTO);
								
								var pbsdEvent : ChangeDefaultSearchEngineEvent = new ChangeDefaultSearchEngineEvent(model.loggedInUserDTO.UserId,
																													model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq,
																													model.userPrefferedSearchEngineDTO.UserSearchEngineID);
								CairngormEventDispatcher.getInstance().dispatchEvent( pbsdEvent );
							}
						}
						else
						{
							Alert.show("LoadUserSearchEngine"+"\n"+Messages.NO_DATA_RETURNED_FROM_SERVICE, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
						}
						
					}
					else
					{
						model.errorStatus = searchEngineResponceDTO.ResponseMessage.toString() ;
						var valid:Boolean = QSUtilityFunctions.checkSession(searchEngineResponceDTO.ResponseCode);
						if(valid)
							Alert.show("LoadUserSearchEngine"+"\n"+searchEngineResponceDTO.ResponseMessage.toString(), Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
						//Tahir Alvi - code for handle null image response
						/*if(!searchEngineResponceDTO.ResponseStatus )
							Alert.show("LoadUserSearchEngine"+"\n"+'Search engine service is down', Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);*/
					}
				
				}
				else
				{
					Alert.show("LoadUserSearchEngine"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadUserSearchEngineCommand.";
				//Alert.show("Fault occured in LoadUserSearchEngineCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadUserSearchEngineCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}