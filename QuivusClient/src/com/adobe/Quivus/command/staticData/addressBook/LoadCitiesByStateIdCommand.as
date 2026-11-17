package com.adobe.Quivus.command.staticData.addressBook
{
	import com.adobe.Quivus.delegate.staticData.addressBook.LoadCitiesByStateIdDelegate;
	import com.adobe.Quivus.events.staticData.addressBook.LoadCitiesByStateIdEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.Quivus.utils.Messages;
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
	
	
	public class LoadCitiesByStateIdCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		private var loadFor : String;
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadCitiesByStateIdDelegate = new LoadCitiesByStateIdDelegate( this );
				var LE:LoadCitiesByStateIdEvent = cgEvent as LoadCitiesByStateIdEvent;
				var stateId:int = LE.stateId;
				loadFor = LE.loadFor;
				if(loadFor!=null && loadFor.length>0 && stateId>0)
				{
					delegate.LoadCitiesByStateId(stateId,model.sessionDTO);
				}
			}
			
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var citiesResponceDTO:CityResponse = re.result as CityResponse;
				if(citiesResponceDTO!=null)
				{				
					
					if(citiesResponceDTO.ResponseStatus){
						
						if(citiesResponceDTO.ResponseData!=null){
							if(loadFor == Constants.PERSONAL){
								//if(model.citiesList!=null ){
								//	model.citiesList.removeAll();
								//}
								
								//model.citiesList = citiesResponceDTO.ResponseData;
							}else if(loadFor == Constants.GUARANTOR)
							{
							/*	if(model.citiesListG!=null ){
									model.citiesListG.removeAll();
								}
								
								model.citiesListG = citiesResponceDTO.ResponseData; */
							}
						}
					}
				}
				else
				{
					Alert.show("LoadCitiesByStateId"+"\n"+Messages.SERVICE_DIDNOT_RESPOND ,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
			model.errorStatus = "Fault occured in LoadCitiesByStateIdCommand.";
			//	Alert.show("Fault occured in LoadCitiesByStateIdCommand.\n"+rpcEvent.toString());
			//}
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(rpcEvent.toString(),"Fault occured in LoadCitiesByStateIdCommand ","",model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert);*/
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}