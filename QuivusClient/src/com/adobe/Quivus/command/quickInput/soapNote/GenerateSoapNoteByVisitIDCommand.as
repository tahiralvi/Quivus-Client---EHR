package com.adobe.Quivus.command.quickInput.soapNote
{
	import com.adobe.Quivus.delegate.quickInput.soapNote.GenerateSoapNoteByVisitIDDelegate;
	import com.adobe.Quivus.events.quickInput.soapNote.GenerateSoapNoteByVisitIDEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class GenerateSoapNoteByVisitIDCommand  implements Command, IResponder
	{
		private var model : AppModelLocator = AppModelLocator.getInstance();
		public var callback:Function;
		public var isRestfulCall:Boolean;
		//public function GenerateSoapNoteByVisitIDCommand( cgEvent:CairngormEvent ) : void 
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			if(model.UserLoggedIn)
			{
				var delegate : GenerateSoapNoteByVisitIDDelegate = new GenerateSoapNoteByVisitIDDelegate( this );
				
				var LE:GenerateSoapNoteByVisitIDEvent = cgEvent as GenerateSoapNoteByVisitIDEvent;
				this.callback = LE.callback;
				delegate.GenerateSoapNoteByVisitID(LE.VisitID, LE.userSession, LE.clinicbranchId , LE.stationIds, LE.isAllSelected);
				
			}
		}
		
		public function result( rpcEvent : Object ) : void 
		{
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:String = re.result as String;//   = re.result as QuickInputResponse  ;
				if(resp!=null && callback != null)
				{
					trace( re.result );
					callback( re.result );
				}
			}
		}
		
		public function fault( rpcEvent : Object ) : void 
		{
			model.errorStatus = "Fault occured in GenerateSoapNoteByVisitID "
			//if(model.isUserManagerServiceOnline){
			/*model.errorStatus = "Fault occured in GenerateSoapNoteByVisitID.";
			Alert.show("Fault occured in GenerateSoapNoteByVisitID.\n"+rpcEvent.toString());*/
			//}
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(rpcEvent.toString(),"Fault occured in GenerateSoapNoteByVisitID ","",model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert);*/
				
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
			
		}
					
	}
}