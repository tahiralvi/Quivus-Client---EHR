package com.adobe.Quivus.command.search
{

	import com.adobe.Quivus.delegate.search.SearchICDDelegate;
	import com.adobe.Quivus.events.search.SearchICDEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class SearchICDCommand implements com.adobe.cairngorm.commands.Command, IResponder
	{
		private var model : AppModelLocator = AppModelLocator.getInstance();
		public function SearchICDCommand()
		{
		}
		
		public function execute( cgEvent:CairngormEvent ) : void {
				var delegate : SearchICDDelegate = new SearchICDDelegate( this );
				
				
				var LE:SearchICDEvent = cgEvent as SearchICDEvent;
				
				//if(LE.icdCode!=null && LE.icdCode.length>0){
					delegate.SearchICDCode(LE.icdCode,LE.description);
				//}
			
			
		}
		
		
		public function result( rpcEvent : Object ) : void 
		{
			var re:ResultEvent = rpcEvent as ResultEvent;
			
			if(re.result!=null)
			{
				model.icdCodeList = re.result as ArrayCollection;
			}
			else
			{
				Alert.show("SearchICD"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
			}
			
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			model.errorStatus = "Fault occured in SearchICDCommand ";
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(rpcEvent.toString(),"Fault occured in SearchICD ","",model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert);*/
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}