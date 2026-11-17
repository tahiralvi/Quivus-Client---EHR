package com.adobe.Quivus.command.search
{
	import com.adobe.Quivus.delegate.search.SearchAllergyTypeByNameDelegate;
	import com.adobe.Quivus.events.search.SearchAllergyTypeByNameEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class SearchAllergyTypeByNameCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : SearchAllergyTypeByNameDelegate = new SearchAllergyTypeByNameDelegate( this );
				
				var LE:SearchAllergyTypeByNameEvent = cgEvent as SearchAllergyTypeByNameEvent;
				
				if(LE.allergyTypeName!=null && LE.allergyTypeName.length>0)
				{
					delegate.SearchAllergyTypeByName(LE.allergyTypeName,model.sessionDTO);
				}
			}
			
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var allergyTypeResponse:AllergyTypeResponse = re.result as AllergyTypeResponse;
				if(allergyTypeResponse!=null)
				{
					if(allergyTypeResponse.ResponseStatus){
						
						if(allergyTypeResponse.ResponseData!=null){
							model.allergyDTOList = allergyTypeResponse.ResponseData;
						} 
					}
				}
				else
				{
					Alert.show("SearchAllergyTypeByName"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in SearchAllergyTypeByNameCommand.";
			//	Alert.show("Fault occured in SearchAllergyTypeByNameCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in SearchAllergyTypeByNameCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}