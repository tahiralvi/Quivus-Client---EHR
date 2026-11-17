package serviceCustomClasses
{
	import mx.core.ByteArrayAsset;
	import mx.core.mx_internal;
	import mx.rpc.events.WSDLLoadEvent;
	import mx.rpc.soap.mxml.WebService;
	import mx.rpc.wsdl.WSDL;
	
	use namespace mx_internal;
	
	public dynamic class MyQuivusManagerService extends WebService
	{
		[Embed(source="QuivusManagerServiceWSDL.xml", mimeType="application/octet-stream")]
		private static const WSDL_CLASS:Class;
		
		public function MyQuivusManagerService(destination:String=null)
		{
			super(destination);
			loadWSDL();
		}
		
		override public function loadWSDL(uri:String=null):void
		{
			var thing:Object = new WSDL_CLASS();
			var baa:ByteArrayAsset = (thing as ByteArrayAsset);
			var xml:String = baa.readUTFBytes(baa.length);
			
			deriveHTTPService();
			
			var wsdlLoadEvent:WSDLLoadEvent = WSDLLoadEvent.createEvent(new WSDL(new XML(xml)));
			wsdlHandler(wsdlLoadEvent);
		}
	}
}