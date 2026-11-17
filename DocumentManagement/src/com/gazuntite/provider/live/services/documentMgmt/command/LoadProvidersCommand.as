package com.gazuntite.provider.live.services.documentMgmt.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.dto.ProviderDTO;
	import com.gazuntite.provider.live.services.documentMgmt.delegat.LoadProvidersDelegate;
	import com.gazuntite.provider.live.services.documentMgmt.model.DMAppModelLocator;
	import com.gazuntite.provider.live.services.documentMgmt.util.DMConstant;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;

	
	public class LoadProvidersCommand  implements com.adobe.cairngorm.commands.Command {
		
		private var model 				: DMAppModelLocator = DMAppModelLocator.getInstance();
		
		private var responder			:Responder;
		private var delegate			:LoadProvidersDelegate;
		
		public function execute( cgEvent:CairngormEvent ) : void {
			
			responder                 	= new Responder(onSuccess, onError);				
			delegate               		= new LoadProvidersDelegate(responder);			
			
			
			
			delegate.LoadProviders(model.loggedInUserSelectedBranchId);
			
		}
		
		
		private function onSuccess(event:ResultEvent):void
		{
			var re:ResultEvent = event as ResultEvent;
			var arr:ObjectProxy = re.result.ArrayOfLProviderDTO as ObjectProxy;
			var array:ArrayCollection = arr.LProviderDTO as ArrayCollection;
			
			if(array!=null)
			{
				model.lProviderDTOList = new ArrayCollection();
				
				
				var i:int;
				for(i=0;i<array.length;i++)
				{
					var obj:ObjectProxy = array.getItemAt(i) as ObjectProxy;
					
					var providerDTO:ProviderDTO = new ProviderDTO();
					
					providerDTO.UserID		= obj.UserId;
					providerDTO.FirstName	= obj.FirstName;
					providerDTO.MiddleName	= obj.MiddleName;
					providerDTO.LastName	= obj.LastName;
					
						
					
					
					model.lProviderDTOList.addItem(providerDTO);
				}
				
			}
			
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show("Received In LoadProvidersCommand.\n"+event.toString(), DMConstant.ERROR,4, FlexGlobals.topLevelApplication.mainContainer);
		}
		
		
	}
}