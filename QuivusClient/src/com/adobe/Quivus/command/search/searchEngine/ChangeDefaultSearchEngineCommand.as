package com.adobe.Quivus.command.search.searchEngine
{
	import com.adobe.Quivus.delegate.search.searchEngine.ChangeDefaultSearchEngineDelegate;
	import com.adobe.Quivus.events.search.searchEngine.ChangeDefaultSearchEngineEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class ChangeDefaultSearchEngineCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : ChangeDefaultSearchEngineDelegate = new ChangeDefaultSearchEngineDelegate( this );
				var LE:ChangeDefaultSearchEngineEvent = cgEvent as ChangeDefaultSearchEngineEvent;
				var userId:int = LE.userId;
				var clinicBranchId:int = LE.clinicBranchId;
				var searchEngineId:int = LE.searchEngineId;
				if(userId > 0 && clinicBranchId>0 && searchEngineId>0)
				{
					delegate.ChangeDefaultSearchEngine(userId,clinicBranchId,searchEngineId,model.sessionDTO);
				}
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var searchEngineResponseDTO:SearchEngineResponse = re.result as SearchEngineResponse;
			
				if(searchEngineResponseDTO.ResponseStatus)
				{
					//changed ....	
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in ChangeDefaultSearchEngineCommand.";
			//	Alert.show("Fault occured in ChangeDefaultSearchEngineCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in ChangeDefaultSearchEngineCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}