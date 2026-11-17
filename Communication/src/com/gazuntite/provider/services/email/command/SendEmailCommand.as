/*
*Class: SendEmailCommand
*Created by: zahid mehmood
*Description: 
*Copyright 2011 Zigron Inc. All right reserved
*/
package com.gazuntite.provider.services.email.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSExceptionAlert;
	import com.gazuntite.provider.services.email.delegate.SendMailDelegate;
	import com.gazuntite.provider.services.email.dto.EmailDTO;
	import com.gazuntite.provider.services.email.event.GetEmailEvent;
	import com.gazuntite.provider.services.email.event.SendEmailEvent;
	import com.gazuntite.provider.services.email.model.EmailModelLocator;
	import com.gazuntite.provider.services.email.util.EmailConstant;
	
	import flash.display.Sprite;
	import flash.events.HTTPStatusEvent;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.CursorManager;
	import mx.managers.PopUpManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class SendEmailCommand implements Command 
	{
		private var model : EmailModelLocator = EmailModelLocator.getInstance();
		
		private var responder : Responder;
		private var delegate : SendMailDelegate;
		
		public function SendEmailCommand()
		{
		}
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess,onError);
			delegate = new SendMailDelegate(responder);
			
			//var EV:GetEmailEvent = cgEvent as GetEmailEvent;
			//delegate.GetEmailList(EV.clinicBranchid,EV.userId,EV.stationId);
			
			var SE:SendEmailEvent = cgEvent as SendEmailEvent;
			delegate.SendEmail(SE.objEmailDTO);
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			var result:String = event.result.toString();
			
			Alert.show("Email sent successfully.","Email Sent",4,FlexGlobals.topLevelApplication.mainContainer);
		}
		
		private function onError(event:FaultEvent):void
		{
			var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(event.message.body.toString(),"Error in Sending Email ",event.fault.faultString,model.loggedInUserId);
			PopUpManager.centerPopUp(cAlert); 
			//Alert.show("Error in Sending Mail.");
		}
	}
}