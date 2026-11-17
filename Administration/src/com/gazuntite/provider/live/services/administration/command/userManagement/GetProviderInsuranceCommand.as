package com.gazuntite.provider.live.services.administration.command.userManagement
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.delegate.userManagement.GetProviderInsuranceDelegate;
	import com.gazuntite.provider.live.services.administration.dto.userManagement.ProviderInsuranceDTO;
	import com.gazuntite.provider.live.services.administration.event.userManagement.GetProviderInsuranceEvent;
	import com.gazuntite.provider.live.services.administration.model.AdminAppModelLocator;
	import com.gazuntite.provider.live.services.administration.util.AdminConstant;
	import com.gazuntite.provider.search.services.provider.util.PSConstants;
	
	import flash.display.Sprite;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class GetProviderInsuranceCommand implements Command
	{
		private var model :AdminAppModelLocator  = AdminAppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:GetProviderInsuranceDelegate;		
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new GetProviderInsuranceDelegate( responder );			
			
			var LE:GetProviderInsuranceEvent = cgEvent as GetProviderInsuranceEvent;
			
			callBack = LE.callBack;
			
			delegate.GetProviderInsuranceList( LE.userId, LE.clinicBranchId );
		}
		
		private function onSuccess(event:ResultEvent):void
		{			
			var list:ArrayCollection = new ArrayCollection();		
			var x:XML = event.result as XML;
			var xPIs:XMLList = x.ProviderInsurances.ProviderInsurance;
			var i:int = 0;					
			for( i = 0; i < xPIs.length(); i++ )
			{
				var c:ProviderInsuranceDTO = new ProviderInsuranceDTO();
				c.FromXML( xPIs[i][0] );
				list.addItem( c );
			}
			
			model.ProviderInsuranceList = list;		
			
			if( null != callBack )
				callBack();			
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show("Received In GetProviderInsuranceCommand.\n" + event.toString(),  AdminConstant.ERROR, 4, FlexGlobals.topLevelApplication.mainContainer );
		}
	}
}