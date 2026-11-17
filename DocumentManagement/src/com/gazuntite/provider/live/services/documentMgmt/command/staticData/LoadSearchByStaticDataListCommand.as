package com.gazuntite.provider.live.services.documentMgmt.command.staticData
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.dto.typeDTO.SearchFieldTypeDTO;
	import com.gazuntite.provider.live.services.documentMgmt.delegat.staticData.LoadSearchByStaticDataListDelegate;
	import com.gazuntite.provider.live.services.documentMgmt.model.DMAppModelLocator;
	import com.gazuntite.provider.live.services.documentMgmt.util.DMConstant;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;

	
	public class LoadSearchByStaticDataListCommand  implements com.adobe.cairngorm.commands.Command{
		
		private var model 				: DMAppModelLocator = DMAppModelLocator.getInstance();
		
		private var responder			:Responder;
		private var delegate			:LoadSearchByStaticDataListDelegate;
		
		public function execute( cgEvent:CairngormEvent ) : void {
			
			responder                 	= new Responder(onSuccess, onError);				
			delegate               		= new LoadSearchByStaticDataListDelegate(responder);			
			
			delegate.LoadSearchByStaticDataList();
		}
		
		
		private function onSuccess(event:ResultEvent):void
		{
			var re:ResultEvent = event as ResultEvent;
			
			var arr:ObjectProxy = re.result.ArrayOfSearchFieldTypeDTO as ObjectProxy;
			var array:ArrayCollection = arr.SearchFieldTypeDTO as ArrayCollection;
			
			if(array!=null)
			{
				var i:int;
				for(i=0;i<array.length;i++)
				{
					var searchTypeDTO:SearchFieldTypeDTO = new SearchFieldTypeDTO();
					
					var obj:ObjectProxy = array.getItemAt(i) as ObjectProxy;
					
					searchTypeDTO.FieldID 			= obj.FieldID;
					searchTypeDTO.FieldName 		= obj.FieldName;
					
					
					if(model.searchFieldTypeDTOList==null)
						model.searchFieldTypeDTOList = new ArrayCollection();
					
					
					model.searchFieldTypeDTOList.addItem(searchTypeDTO);
				}
				
				
			}
			
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show("Received In LoadSearchByStaticDataListCommand.\n"+event.toString(), DMConstant.ERROR,4, FlexGlobals.topLevelApplication.mainContainer);
		}
		
		
	}
}