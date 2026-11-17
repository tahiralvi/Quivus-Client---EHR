package com.adobe.Quivus.events.quickInput.reviewhistroy
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class LoadReviewHistroyEvent extends CairngormEvent
	{
		public var VisitId      	:int;
		public var SessionId  		:String;
		public var ProviderId 		:int;
		public var callBackFunction :Function;
		
		public function LoadReviewHistroyEvent(SessionId:String,VisitId:int,ProviderId:int,callBackFunction :Function)
		{
			super(AppController.Load_Review_Histroy_Event);
			this.SessionId 			=  SessionId ;
			this.VisitId    		=  VisitId ;
			this.ProviderId 		=  ProviderId ;
			this.callBackFunction 	=  callBackFunction
		}
	}
}