package com.adobe.Quivus.command.quickInput.reviewhistroy
{
	import com.adobe.Quivus.delegate.quickInput.reviewhistroy.LoadReviewHistroyDelegate;
	import com.adobe.Quivus.events.quickInput.reviewhistroy.LoadReviewHistroyEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.view.controls.custom.patientExamView.quickInput.signCoSign.reviewAll.reviewcomponents.ReviewAllXML;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class LoadReviewHistroyCommand  implements Command
	{
		var reponder			: Responder ;
		var delegate			:LoadReviewHistroyDelegate;
		var LE					:LoadReviewHistroyEvent;
		var callBackFunction	:Function;
		private var model:AppModelLocator = AppModelLocator.getInstance();
		public function execute(cgEvent:CairngormEvent):void
		{
			reponder = new Responder(onSuccess,onFault);
			delegate = new LoadReviewHistroyDelegate(reponder);
			LE		 = cgEvent as LoadReviewHistroyEvent;
			this.callBackFunction = LE.callBackFunction;
			delegate.LoadHistroy(LE.SessionId,LE.VisitId,LE.ProviderId);
			
		}
		
		private function onSuccess(successEvent:ResultEvent):void
		{   
			model.reviewHistroy = new ReviewAllXML();
			var loadhistroyxml	:XML = successEvent.result as XML ;
			var xmlList:XMLList	= loadhistroyxml.Sections;
			var xml:XML= xmlList[0];
			if(xml != null)
				model.reviewHistroy.fromXML(xml);
			
			if(this.callBackFunction!= null)
				this.callBackFunction();
		}
		
		private function onFault(faultEvent:FaultEvent):void
		{
			Alert.show("Receieved in LoadReviewHistroyCommand"+ faultEvent.toString());
		}
	}
}