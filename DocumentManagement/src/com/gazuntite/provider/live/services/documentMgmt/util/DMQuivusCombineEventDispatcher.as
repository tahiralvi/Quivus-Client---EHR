package com.gazuntite.provider.live.services.documentMgmt.util
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.provider.live.services.documentMgmt.event.LoadPatientDocumentByClinicIdEvent;
	import com.gazuntite.provider.live.services.documentMgmt.event.LoadProvidersEvent;
	import com.gazuntite.provider.live.services.documentMgmt.event.staticData.LoadDocumentSectionTypeStaticDataEvent;
	import com.gazuntite.provider.live.services.documentMgmt.event.staticData.LoadDocumentTypeStaticDataEvent;
	import com.gazuntite.provider.live.services.documentMgmt.event.staticData.LoadSearchByStaticDataListEvent;
	import com.gazuntite.provider.live.services.documentMgmt.model.DMAppModelLocator;

	public class DMQuivusCombineEventDispatcher
	{
		public function DMQuivusCombineEventDispatcher()
		{
		}
		
		
		public static function LoadDMStaticData():void
		{
			
			var model : DMAppModelLocator = DMAppModelLocator.getInstance();
			
			if(model.documentTypeDTOList==null)
			{
				var eve:LoadDocumentTypeStaticDataEvent = new LoadDocumentTypeStaticDataEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( eve );
				
			}
			
			if(model.documentSectionTypeDTOList==null)
			{
				var stEve:LoadDocumentSectionTypeStaticDataEvent = new LoadDocumentSectionTypeStaticDataEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( stEve );
			}
			
			if(model.searchFieldTypeDTOList==null)
			{
				
				var stsbEve:LoadSearchByStaticDataListEvent = new LoadSearchByStaticDataListEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( stsbEve );
			}
			
		}
			
		
		public static function LoadDocumentList(pageNo:int):void
		{
			
			var ld:LoadPatientDocumentByClinicIdEvent = new LoadPatientDocumentByClinicIdEvent(pageNo);
			
			CairngormEventDispatcher.getInstance().dispatchEvent( ld );
		}
		
		public static function LoadProviders():void
		{
			
			var lp:LoadProvidersEvent = new LoadProvidersEvent();			
			CairngormEventDispatcher.getInstance().dispatchEvent( lp );
			
			
		}
	}
}