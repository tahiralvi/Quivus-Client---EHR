package com.gazuntite.common.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.delegate.LoadICDCodeDelegate;
	import com.gazuntite.common.dto.assessment.diagnosis.ICDCodeDTO;
	import com.gazuntite.common.event.LoadICDCodeEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	public class LoadICDCodeCommand implements Command , IResponder
	{
		private var model:Object;
		private var func:Function;
		
		public function LoadICDCodeCommand()
		{
		}
		
		public function execute(cgEvent:CairngormEvent):void
		{
			var delegate:LoadICDCodeDelegate = new  LoadICDCodeDelegate(this);
			
			var LE:LoadICDCodeEvent = cgEvent as LoadICDCodeEvent;
			
			if (LE)
			{
				model = LE.model;
				
				if (model.LoggedInUserId)
				{
					if (LE.func != null)
						func = LE.func;
					
					if (LE.icdCode != null && LE.icdCode.length > 0)
					{
						delegate.LoadICDCode(LE.icdCode, model.LoggedInUserSessionID);
					}
				}
			}
		}
		
		public function result(rpcEvent:Object):void 
		{
			if (model && model.LoggedInUserId)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var xml:XMLList = re.result.ResponseData;
				
				if (xml != null)
				{
					var xlist:XMLList = xml.children();
					
					if (xlist != null)
					{
						var DTOlist:ArrayCollection = new ArrayCollection();
						
						for each(var x:XML in xlist)
						{
							var t:ICDCodeDTO = new ICDCodeDTO();
							t.FromXML(x);
							DTOlist.addItem(t);
						}
						
						model.icdCodeDTOList= DTOlist ;
						
						if (null != func)
							func();
					}
				}
				else
				{
					UtilityFunctions.ShowMessage("LoadICDCode \n Service didnot respond.", "Info");
				}
			}
		}
		
		public function fault(rpcEvent:Object):void 
		{
			var errorStatus:String = "Fault occured in LoadICDCodeCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty(model.LoggedInUserId) ? -1 : model.LoggedInUserId;
			
			QSCombinedExceptionAlert.getInstance().Show(errorStatus, rpcEvent.toString(), userId);	
		}
	}
}