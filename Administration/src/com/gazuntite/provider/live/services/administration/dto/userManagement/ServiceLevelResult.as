package com.gazuntite.provider.live.services.administration.dto.userManagement
{
	import com.gazuntite.common.util.xml.XmlUtils;
	
	import mx.collections.ArrayCollection;
	import mx.controls.dataGridClasses.DataGridColumn;
	
	
	[Bindable]
	public class ServiceLevelResult
	{
		public function ServiceLevelResult()
		{
		}
		
		private var _code			:int;
		private var _servicename	:String;		
	
	
		
		
		public function get servicename():String
		{
			return _servicename;
		}

		public function set servicename(value:String):void
		{
			_servicename = value;
		}

		public function get code():int
		{
			return _code;
		}

		public function set code(value:int):void
		{
			_code = value;
		}

	
		
		
	
	
		public function FromXML(x:XML):void
		{
			code 					= x.@["ServiceLevelCode"];
			servicename 			= x.@["ServiceLevelName"];
			
			 
		}
		
		public function ToXML():XML
		{
			var xml:XML = XmlUtils.getNodeByTagName( "ServiceLevel" );
			xml.@["ServiceLevelCode"]						= code;
			xml.@["ServiceLevelName"]						= servicename;			
			
			
			return xml;
		}
		
	
	}
}