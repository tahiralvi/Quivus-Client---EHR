package com.gazuntite.common.util.upload
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	
	import mx.logging.ILogger;
	import mx.logging.Log;

	public class FileStreamUploader extends EventDispatcher
	{
		
		public static const FILE_STREAM_UPLOAD_COMPLETED_EVENT				:String	= "fileStreamUploadCompleted";
		public static const FILE_STREAM_UPLOAD_FAILED_EVENT					:String	= "fileStreamUploadFailed";
		
		private var urlRequest:URLRequest;
		private var fileReference:FileReference;
		private var logger : ILogger = Log.getLogger("com.gazuntite.common.util.upload.FileStreamUploader");
		
		public function FileStreamUploader( url:String , contentType:String = '')
		{
			urlRequest				= new URLRequest();
			urlRequest.url 			= url;
			urlRequest.method 		= URLRequestMethod.POST;
			if(contentType != '')
				urlRequest.contentType = contentType;
			else
				urlRequest.contentType 	= "application/octet-stream";
			
			urlRequest.requestHeaders.push( new URLRequestHeader( 'Cache-Control', 'no-cache' ) );
			urlRequest.requestHeaders.push( new URLRequestHeader( 'AllowWriteStreamBuffering', 'false' ) );
			urlRequest.requestHeaders.push( new URLRequestHeader( 'SendChunked', 'true' ) );
			
			
		}
		
		public function Browse():void
		{
			fileReference=new FileReference();
			fileReference.addEventListener(Event.SELECT, onFileSelected);
			
			
			var imagesFilter:FileFilter 	= new FileFilter("Images ( *.bmp,*.jpg,*.jpeg,*.tiff,*.gif,*.png )", "*.bmp;*.jpg;*.jpeg;*.tiff;*.gif;*.png"); 
			var docFilter:FileFilter 		= new FileFilter("Documents ( *.pdf )", "*.pdf");
/*			var docFilter:FileFilter 		= new FileFilter("Documents ( *.pdf,*.doc,*.docx,*.wpd )", "*.pdf;*.doc;*.docx;*.wpd");*/
			var allTypeFilter:FileFilter 	= new FileFilter("All Files (Documents, Images)","*.pdf;*.doc;*.docx;*.wpd;*.jpg;*.jpeg;*.tiff;*.gif;*.png");
			
			
			
			fileReference.browse([docFilter, imagesFilter, allTypeFilter]);
		}
		
		protected function onFileSelected(event:Event):void
		{
			try
			{
				fileReference.addEventListener(Event.COMPLETE, onFileLoaded);
				fileReference.load();
			}
			catch(e:Error)
			{
				logger.error("ERROR IN onFileSelected " +  e.errorID + " " + e.name + " " + e.message);
			}
			
		}
		
		protected function onFileLoaded(event:Event):void
		{
			try
			{
				var data:ByteArray = fileReference.data;
				urlRequest.data = UploadPostHelper.getPostData(fileReference.name, fileReference.data);
				
				loadRequest();
			}
			catch(e:Error)
			{
				logger.error("ERROR IN onFileLoaded " +  e.errorID + " " + e.name + " " + e.message);
			}
		}
		
		protected function loadRequest():void
		{
			try
			{
				var urlLoader:URLLoader = new URLLoader();
				urlLoader.dataFormat 	= URLLoaderDataFormat.BINARY;
				
				urlLoader.addEventListener(Event.COMPLETE, onUploadingComplete);
				urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onUploadingError);
				urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onUploadingError);
				
				urlLoader.load(urlRequest);
			}
			catch(e:Error)
			{
				logger.error("ERROR IN loadRequest " +  e.errorID + " " + e.name + " " + e.message);
			}
		}
		
		protected function onUploadingComplete(event:Event):void
		{
			//trace( "file stream upload Completed. <br> Success Report : <br>" + event.toString() );
			logger.info( "file stream upload Completed. <br> Success Report : <br>" + event.toString() );
			
			dispatchEvent( new Event(FILE_STREAM_UPLOAD_COMPLETED_EVENT, true, true) );
		}
		
		protected function onUploadingError(event:IOErrorEvent):void
		{
			//trace( "file stream upload failed. <br> Error Report : <br>" + event.toString() );
			logger.error( "file stream upload failed. <br> Error Report : <br>" + event.toString() );
			
			dispatchEvent( new Event(FILE_STREAM_UPLOAD_FAILED_EVENT, true, true) );
		}
		
	}
}