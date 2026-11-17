package com.adobe.Quivus.command.staticData.addressBook
{
	import com.adobe.Quivus.delegate.staticData.addressBook.LoadZipcodesByStateIdAndCityNameDelegate;
	import com.adobe.Quivus.events.staticData.addressBook.LoadZipcodesByStateIdAndCityNameEvent;
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

	
	public class LoadZipcodesByStateIdAndCityNameCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		private var loadFor : String;
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadZipcodesByStateIdAndCityNameDelegate = new LoadZipcodesByStateIdAndCityNameDelegate( this );
				
				var LE:LoadZipcodesByStateIdAndCityNameEvent = cgEvent as LoadZipcodesByStateIdAndCityNameEvent;
				var stateId:int = LE.stateId;
				var cityName:String = LE.cityName;
				loadFor = LE.loadFor;
				if(loadFor!=null && loadFor.length>0 && stateId>0 && cityName!=null && cityName.length>0)
				{
					delegate.loadZipcodesByStateIdAndCityName(stateId,cityName,model.sessionDTO);
				}
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var zipcodesResponceDTO:ZipCodeResponse = re.result as ZipCodeResponse;
				if(zipcodesResponceDTO!=null){
					if(zipcodesResponceDTO.ResponseStatus){
						
						if(zipcodesResponceDTO.ResponseData!=null){
							if(loadFor == Constants.PERSONAL){
								/*if(model.zipcodeList!=null ){
									model.zipcodeList.removeAll();
								}
								
								model.zipcodeList = zipcodesResponceDTO.ResponseData;*/
							}else if(loadFor == Constants.GUARANTOR)
							{
								if(model.zipcodeListG!=null ){
									model.zipcodeListG.removeAll();
								}
								
								model.zipcodeListG = zipcodesResponceDTO.ResponseData;
							}
						}else{
							Alert.show("No zipcodes found.");
						}
					}
				}
				else
				{
					Alert.show("LoadZipcodesByStateIdAndCityName"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadZipcodesByStateIdAndCityNameCommand.";
			//	Alert.show("Fault occured in LoadZipcodesByStateIdAndCityNameCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadZipcodesByStateIdAndCityNameCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}