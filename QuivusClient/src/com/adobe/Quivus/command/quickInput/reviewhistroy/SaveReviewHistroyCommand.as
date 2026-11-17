package com.adobe.Quivus.command.quickInput.reviewhistroy
{
	import com.adobe.Quivus.delegate.quickInput.reviewhistroy.SaveReviewHistroyDelegate;
	import com.adobe.Quivus.events.quickInput.reviewhistroy.SaveReviewHistroyEvent;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Fault;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class SaveReviewHistroyCommand implements Command
	{
		private var responder		 :Responder;
		private var callBackFunction :Function ;
		
		
		public function execute(cgEvent:CairngormEvent):void
		{
			responder = new Responder(result,fault)
			var delegate:SaveReviewHistroyDelegate  = new SaveReviewHistroyDelegate(responder);
			var LE:SaveReviewHistroyEvent = cgEvent as SaveReviewHistroyEvent;
			this.callBackFunction         = LE.callBack;
			delegate.SaveHistroy(LE.SessionId ,LE.VisitId,LE.providerId,LE.xmlData)
			
		}
		
		public function result(rpcEvent:ResultEvent):void
		{
			var histroyxml:XML  = rpcEvent.result as XML ; 
			var status:String   = histroyxml.@Status ;
			if(status == "true")
			{
				var message:String  = histroyxml.@Message;
				Alert.show(message,"Fault",4,FlexGlobals.topLevelApplication.mainContainer);
			}
				
			else 
				if(this.callBackFunction!=null)
					this.callBackFunction();
			trace(histroyxml);
		}
		public function fault(rpcEvent:FaultEvent):void
		{
			Alert.show("Fault occured in SaveReviewHistroyCommand.\n"+rpcEvent.toString());
		}
	}
}