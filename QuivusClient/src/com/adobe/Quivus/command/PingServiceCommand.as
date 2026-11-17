package com.adobe.Quivus.command
{
	import com.adobe.Quivus.delegate.PingServiceDelegate;
	import com.adobe.Quivus.events.PingServiceEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.common.util.exceptionAlert.QSExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.managers.PopUpManager;
	import mx.rpc.IResponder;

	public class PingServiceCommand implements Command, IResponder 
	{
		private var logger:ILogger = Log.getLogger("com.adobe.Quivus.command.LogInCombinedCommand");
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		private var CE:PingServiceEvent;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			
			var delegate : PingServiceDelegate = new PingServiceDelegate( this );
			CE = cgEvent as PingServiceEvent;
			
			delegate.PingService();
			
		}
		
		
		public function result( rpcEvent : Object ) : void 
		{
			
		}
		
		public function fault( rpcEvent : Object ) : void 
		{
			//if(model.isUserManagerServiceOnline){
			model.errorStatus = "Fault occured in LogInCombinedCommand.";
			//	Alert.show("Fault occured in UpdateUserSessionCommand.\n"+rpcEvent.toString());*/
			//}
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			cAlert.Show(rpcEvent.toString(),"Fault occured in LogInCombinedCommand ","",userId);
			PopUpManager.centerPopUp(cAlert); */
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
			
			
		}
	}
}