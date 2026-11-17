/*
*Class: GetSentEmailListCommand
*Created by: zahid mehmood
*Description: 
*Copyright 2011 Zigron Inc. All right reserved
*/
package com.gazuntite.provider.services.email.command
{
	
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSExceptionAlert;
	import com.gazuntite.provider.services.email.delegate.GetSentEmailListDelegate;
	import com.gazuntite.provider.services.email.dto.EmailDTO;
	import com.gazuntite.provider.services.email.dto.EmailResultList;
	import com.gazuntite.provider.services.email.event.GetSentEmailEvent;
	import com.gazuntite.provider.services.email.model.EmailModelLocator;
	import com.gazuntite.provider.services.email.util.EmailConstant;
	
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.CursorManager;
	import mx.managers.PopUpManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class GetSentEmailListCommand implements Command
	{
		private var model : EmailModelLocator = EmailModelLocator.getInstance();
		
		private var responder : Responder;
		private var delegate : GetSentEmailListDelegate;
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess,onError);
			delegate = new GetSentEmailListDelegate(responder);
			
			var GSEV:GetSentEmailEvent  = cgEvent as GetSentEmailEvent;
			callBack= GSEV.callBack;
			delegate.GetEmailList(GSEV.clinicBranchid,GSEV.userId,GSEV.stationId,GSEV.totalPages,GSEV.currentPage);
		}
		
		
		private function onSuccess(event:ResultEvent):void
		{
			
			/*
			var esl:EmailResultList = new EmailResultList();
			esl.FromXMLSentEmail(event.result as XML);
			model.m_oEmailResultList =esl;
			*/
			
			var esl:EmailResultList = new EmailResultList();
			esl.FromXML(event.result as XML);
			model.m_oEmailResultList =esl;
			
			model.currentPage = EmailConstant.CURRENTPAGE;
			model.totalPage  = EmailConstant.TOTALEMAILS;
			
			if(null != callBack)
				callBack();
		}
		
		
		
		private function onError(event:FaultEvent):void
		{
			var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(event.message.body.toString(),"Error in Getting list of Sent Email",event.fault.faultString,model.loggedInUserId);
			PopUpManager.centerPopUp(cAlert); 
		//	Alert.show("Received In GetEmailListCommand.\n" + event.toString(), EmailConstant.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
		}
	}
}