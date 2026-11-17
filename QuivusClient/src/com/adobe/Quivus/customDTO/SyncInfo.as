package com.adobe.Quivus.customDTO
{
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class SyncInfo
	{
		public static const DICTATION_DATA	:int 	= 0;
		public static const STATIC_DATA		:int 	= 1;
		
		
		private var _syncDTOList:ArrayCollection;

		public function get syncDTOList():ArrayCollection
		{
			return _syncDTOList;
		}

		public function set syncDTOList(value:ArrayCollection):void
		{
			_syncDTOList = value;
		}

		
		public function SyncInfo()
		{
			syncDTOList = new ArrayCollection();
		}
		
		public function getContentByType( type:int ):SyncDTO
		{
			var retValue:SyncDTO;
			
			if( UtilityFunctions.IsNullOrEmpty( syncDTOList ) )
			{
				retValue = null;
			}
			else
			{
				retValue = syncDTOList.getItemAt( type ) as SyncDTO;
			}
			
			return retValue;
		}
		
		public function addContentByType( value:SyncDTO, type:int ):void
		{
			syncDTOList.addItemAt( value, type );
			/*
			if( UtilityFunctions.IsNullOrEmpty( syncDTOList ) )
			{
			}
			else
			{
				
			}*/
		}
	}
}