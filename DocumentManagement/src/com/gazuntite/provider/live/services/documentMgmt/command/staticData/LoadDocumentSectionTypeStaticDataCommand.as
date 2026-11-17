package com.gazuntite.provider.live.services.documentMgmt.command.staticData
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.dto.typeDTO.DocumentSectionTypeDTO;
	import com.gazuntite.provider.live.services.documentMgmt.delegat.staticData.LoadDocumentSectionTypeStaticDataDelegate;
	import com.gazuntite.provider.live.services.documentMgmt.delegat.staticData.LoadDocumentTypeStaticDataDelegate;
	import com.gazuntite.provider.live.services.documentMgmt.model.DMAppModelLocator;
	import com.gazuntite.provider.live.services.documentMgmt.util.DMConstant;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;

	
	public class LoadDocumentSectionTypeStaticDataCommand  implements com.adobe.cairngorm.commands.Command {
		
		private var model 				: DMAppModelLocator = DMAppModelLocator.getInstance();
		
		private var responder			:Responder;
		private var delegate			:LoadDocumentSectionTypeStaticDataDelegate;
		
		public function execute( cgEvent:CairngormEvent ) : void {
			
			responder                 	= new Responder(onSuccess, onError);				
			delegate               		= new LoadDocumentSectionTypeStaticDataDelegate(responder);			
			
			delegate.LoadDocumentSectionTypeStaticData();
		}
		
		
		private function onSuccess(event:ResultEvent):void
		{
			var re:ResultEvent = event as ResultEvent;
			
			var arr:ObjectProxy = re.result.ArrayOfDocumentSectionTypeDTO as ObjectProxy;
			var array:ArrayCollection = arr.DocumentSectionTypeDTO as ArrayCollection;
			
			if(array!=null)
			{
				var i:int;
				for(i=0;i<array.length;i++)
				{
					var obj:ObjectProxy = array.getItemAt(i) as ObjectProxy;
					
					var documentObj:DocumentSectionTypeDTO = new DocumentSectionTypeDTO();
					
					if(model.documentSectionTypeDTOListLinear == null)
						model.documentSectionTypeDTOListLinear = new ArrayCollection();
					
					documentObj.SectionId 			= obj.SectionId;
					documentObj.SectionName 		= obj.SectionName;
					documentObj.ParentId 			= obj.ParentId;
					documentObj.OrderNo 			= obj.OrderNo;
					//dockumentObj.ChildSectionType 	= (obj.ChildSectionType as ArrayCollection);
					model.documentSectionTypeDTOListLinear.addItem(documentObj);
					var arr2:ObjectProxy = obj.ChildSectionType as ObjectProxy;
					var array2:ArrayCollection = arr2.DocumentSectionTypeDTO as ArrayCollection;
					
					if(array2!=null)
					{
						var subArray:ArrayCollection = new ArrayCollection();
						
						
						
						var j:int;
						for(j=0;j<array2.length;j++)
						{
							var obj2:ObjectProxy = array2.getItemAt(j) as ObjectProxy;
							var documentObj2:DocumentSectionTypeDTO = new DocumentSectionTypeDTO();
							
							documentObj2.SectionId 			= obj2.SectionId;
							documentObj2.SectionName 		= obj2.SectionName;
							documentObj2.ParentId 			= obj2.ParentId;
							documentObj2.OrderNo 			= obj2.OrderNo;
							
							subArray.addItem(documentObj2);
							
							if(documentObj2.SectionName=="Other")
							{
								var linerObj2:DocumentSectionTypeDTO = new DocumentSectionTypeDTO();
								
								linerObj2.SectionId 		= obj2.SectionId;
								linerObj2.SectionName 		= documentObj.SectionName +"-"+ documentObj2.SectionName;
								linerObj2.ParentId 			= obj2.ParentId;
								linerObj2.OrderNo 			= obj2.OrderNo;
								
								model.documentSectionTypeDTOListLinear.addItem(linerObj2);
							}
							else
							{
								model.documentSectionTypeDTOListLinear.addItem(documentObj2);
							}
							
							
							
						}
						
						documentObj.ChildSectionType = subArray;
					}
					
					if(model.documentSectionTypeDTOList ==null)
						model.documentSectionTypeDTOList = new ArrayCollection();
					
					
					
					model.documentSectionTypeDTOList.addItem(documentObj);	
				}
				
				
			}
			
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show("Received In LoadDocumentSectionTypeStaticData.\n"+event.toString(), DMConstant.ERROR,4, FlexGlobals.topLevelApplication.mainContainer);
		}
		
		
	}
}