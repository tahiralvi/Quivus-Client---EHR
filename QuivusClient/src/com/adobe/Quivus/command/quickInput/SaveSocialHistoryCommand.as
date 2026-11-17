package com.adobe.Quivus.command.quickInput
{
	import com.adobe.Quivus.delegate.quickInput.SaveSocialHistoryDelegate;
	import com.adobe.Quivus.events.quickInput.SaveSocialHistoryEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class SaveSocialHistoryCommand implements Command
	{
		private var model : AppModelLocator = AppModelLocator.getInstance();
		private var delegate:SaveSocialHistoryDelegate;
		private var responder:Responder;
		private var callBack:Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new SaveSocialHistoryDelegate( responder );			
			
			var LE:SaveSocialHistoryEvent  = cgEvent as SaveSocialHistoryEvent;
			
			callBack = LE.callBack;
			
			delegate.SaveSocialHistoryList(LE.socialHistory,LE.branchId,LE.patientId);
			
			
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			var xmlStr:String = event.result.toString();
			
			if( null != callBack )
			{
				callBack();
				Alert.show("Social history saved successfully \n" );
			}

		}
		
		private function onError(event:FaultEvent):void
		{
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(event.message.body.toString(),"Error Save Medical History Command ",event.fault.faultString,model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert); */
			
			model.errorStatus = "Error in SaveSocialHistoryCommand"
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, event.toString(), userId); 
			
			
		}
	}
}