package com.gazuntite.provider.live.services.elab.util
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.provider.live.services.elab.event.LoadLabResultsByClinicBranchIdEvent;
	import com.gazuntite.provider.live.services.elab.event.LoadPatientLabOrdersByClinicIdEvent;
	import com.gazuntite.provider.live.services.elab.event.LoadeLabsStaticDataEvent;
	import com.gazuntite.provider.live.services.elab.event.SearchLabsByClinicEvent;
	import com.gazuntite.provider.live.services.elab.model.ELabsAppModelLocator;

	public class ELabsQuivusCombineEventDispatcher
	{
		public function ELabsQuivusCombineEventDispatcher()
		{
		}
		
		
		public static function LoadDMStaticData():void
		{
			
			var model : ELabsAppModelLocator = ELabsAppModelLocator.getInstance();
			
			if(model.LabOrderListDto == null)
			{
				/*var eve:LoadDocumentTypeStaticDataEvent = new LoadDocumentTypeStaticDataEvent();
				CairngormEventDispatcher.getInstance().dispatchEvent( eve );*/
				
			}
			
		}
			
		
		public static function LoadELabStaticData():void
		{
			var lsfo:LoadeLabsStaticDataEvent = new LoadeLabsStaticDataEvent();
			CairngormEventDispatcher.getInstance().dispatchEvent( lsfo );
		}
		
		public static function LoadLabOrderAndResultData(pageNo:int):void
		{
			LoadLabOrdersListByClinic(pageNo);
			LoadLabResultListByClinic(pageNo);
		}
		
		public static function LoadLabOrdersListByClinic(pageNo:int):void
		{
			var ll:LoadPatientLabOrdersByClinicIdEvent = new LoadPatientLabOrdersByClinicIdEvent( pageNo );
			CairngormEventDispatcher.getInstance().dispatchEvent( ll );
		}
		public static function LoadLabResultListByClinic(pageNo:int):void
		{
			var lr:LoadLabResultsByClinicBranchIdEvent = new LoadLabResultsByClinicBranchIdEvent( pageNo );
			CairngormEventDispatcher.getInstance().dispatchEvent( lr );
		}
		
		public static function SearchResultListByClinic(query:String, pageNo:int, fieldID:int):void
		{
			var se:SearchLabsByClinicEvent = new SearchLabsByClinicEvent( query, pageNo, fieldID, true );
			CairngormEventDispatcher.getInstance().dispatchEvent( se );
		}
		
		public static function SearchOrdersListByClinic(query:String, pageNo:int, fieldID:int):void
		{
			var se:SearchLabsByClinicEvent = new SearchLabsByClinicEvent( query, pageNo, fieldID, false );
			CairngormEventDispatcher.getInstance().dispatchEvent( se );
		}
		
	}
}