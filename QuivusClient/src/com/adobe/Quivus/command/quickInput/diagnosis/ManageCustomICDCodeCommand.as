package com.adobe.Quivus.command.quickInput.diagnosis
{
	import com.adobe.Quivus.delegate.quickInput.soapNote.ManageCustomICDCodeDelegate;
	import com.adobe.Quivus.events.quickInput.diagnosis.ManageCustomICDCodeEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class ManageCustomICDCodeCommand implements Command
	{
		private var model 				: AppModelLocator = AppModelLocator.getInstance();
		
		private var responder			:Responder;
		private var delegate			:ManageCustomICDCodeDelegate;
		
		private var func:Function;
		
		public function execute(cgEvent:CairngormEvent):void
		{
			responder                 	= new Responder(onSuccess, onError);				
			delegate               		= new ManageCustomICDCodeDelegate(responder);
			
			var LE:ManageCustomICDCodeEvent 	= cgEvent as ManageCustomICDCodeEvent;
			this.func = LE.callback;
			delegate.ManageCustomICDCode(LE.icdCodeDTO, LE.userID, LE.sessionID);
		}
		
		public function onSuccess( event :ResultEvent ) : void 
		{
			var re:ResultEvent = event as ResultEvent;
			if(re!=null && re.result!=null )
			{
				/*if(this.func!=null)
				{
					func();
				}*/
			}
		}
		
		public function onError( event : FaultEvent ) : void 
		{
			model.errorStatus = "Fault In ManageCustomICDCodeCommand"
			//Alert.show("Received In ManageCustomICDCodeCommand.\n"+event.toString());
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(event.message.body.toString(),"Fault occured in ManageCustomICDCodeCommand",event.fault.faultString,model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert);*/
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, event.toString(), userId); 
			
		}
	}
	
}