package com.gazuntite.provider.live.services.documentMgmt.command.staticData
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.dto.typeDTO.DocumentTypeDTO;
	import com.gazuntite.provider.live.services.documentMgmt.delegat.staticData.LoadDocumentTypeStaticDataDelegate;
	import com.gazuntite.provider.live.services.documentMgmt.model.DMAppModelLocator;
	import com.gazuntite.provider.live.services.documentMgmt.util.DMConstant;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;

	
	public class LoadDocumentTypeStaticDataCommand  implements com.adobe.cairngorm.commands.Command{
		
		private var model 				: DMAppModelLocator = DMAppModelLocator.getInstance();
		
		private var responder			:Responder;
		private var delegate			:LoadDocumentTypeStaticDataDelegate;
		
		public function execute( cgEvent:CairngormEvent ) : void {
			
			responder                 	= new Responder(onSuccess, onError);				
			delegate               		= new LoadDocumentTypeStaticDataDelegate(responder);			
			
			delegate.LoadDocumentTypeStaticData();
		}
		
		
		private function onSuccess(event:ResultEvent):void
		{
			var re:ResultEvent = event as ResultEvent;
			
			var arr:ObjectProxy = re.result.ArrayOfDocumentTypeDTO as ObjectProxy;
			var array:ArrayCollection = arr.DocumentTypeDTO as ArrayCollection;
			
			if(array!=null)
			{
				var i:int;
				for(i=0;i<array.length;i++)
				{
					var obj:ObjectProxy = array.getItemAt(i) as ObjectProxy;
					
					var documentObj:DocumentTypeDTO = new DocumentTypeDTO();
					
					
					documentObj.DocumentTypeId 		= obj.DocumentTypeId;
					documentObj.DocumentTypeName 	= obj.DocumentTypeName;
					
					
					if(model.documentTypeDTOList==null)
						model.documentTypeDTOList = new ArrayCollection();
					
					model.documentTypeDTOList.addItem(documentObj);						
				}
				
				
			}
			
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show("Received In LoadDocumentTypeStaticData.\n"+event.toString(), DMConstant.ERROR,4, FlexGlobals.topLevelApplication.mainContainer);
		}
		
		
	}
}