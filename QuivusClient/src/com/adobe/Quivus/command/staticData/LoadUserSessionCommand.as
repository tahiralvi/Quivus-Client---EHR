package com.adobe.Quivus.command.staticData
{
	import com.adobe.Quivus.delegate.staticData.LoadUserSessionDelegate;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.UserSessionTypeDTO;

	public class LoadUserSessionCommand implements Command, IResponder {
			
			private var model : AppModelLocator = AppModelLocator.getInstance();
			
			public function execute( cgEvent:CairngormEvent ) : void 
			{
					var delegate:LoadUserSessionDelegate =new LoadUserSessionDelegate(this);
					delegate.LoadSearchByTypeStaticData();
			}
			
			
			public function result( rpcEvent : Object ) : void 
			{
				
					var re:ResultEvent = rpcEvent as ResultEvent;
					
					//var userSession:UserSessionTypeDTO = re.result as UserSessionTypeDTO;
					var counter:int=0;
					model.UserSessionStatus=new ArrayCollection();
					for(counter;re.result.source.length > counter; counter++)
					//if(re.result.source.length  > 0)
						{
						var userSession:UserSessionTypeDTO = new UserSessionTypeDTO();
							userSession.userSessionStatusID = re.result[counter].userSessionStatusID;	
							userSession.Description = re.result[counter].Description; 	


							model.UserSessionStatus.addItem(userSession); 
						}

					/*else
					{
						Alert.show("LoadUserSessionStaticData"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}*/
					
			}
			
			
			public function fault( rpcEvent : Object ) : void 
			{
				model.errorStatus = "Fault occured in LoadUserSessionStaticDataCommand.";
				//Alert.show("Fault occured in LoadUserSessionStaticDataCommand.\n"+rpcEvent.toString());

				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				var userID:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )  ? 0:model.loggedInUserDTO.UserId;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadUserSessionStaticDataCommand ","",userID);
				PopUpManager.centerPopUp(cAlert);*/ 
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
			}
			
		
	}
}