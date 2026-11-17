package com.adobe.Quivus.utils.network
{
	import com.adobe.Quivus.customDTO.SyncDTO;
	import com.adobe.Quivus.logging.LoggingUtil;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.Quivus.utils.UploadPostHelper;
	import com.adobe.Quivus.utils.XMLFileReaderWriter;
	import com.gazuntite.utils.UtilityFunctions;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	
	import mx.core.FlexGlobals;
	import mx.logging.ILogger;

	public class DictationSyncUtility
	{
		private var logger : ILogger = LoggingUtil.getLogger( this );
		[Bidable]private var model : AppModelLocator = AppModelLocator.getInstance();
		protected var SyncFile:XMLFileReaderWriter;
		private var callBack:Function;
		private var syncDto:SyncDTO;

		public function DictationSyncUtility(syncDto:SyncDTO)
		{
			this.syncDto = syncDto;
			
			syncDto.ProgressTotal = 100; //checking progress
			syncDto.ProgressValue = 20; //checking progress
			
			SyncFile = new XMLFileReaderWriter( "appSync/dictation.xml" );
			SyncFile.read();
			
			syncDto.ProgressValue = 50; //checking progress
		}
		
		
		public function sync(callBack:Function = null):void
		{
			this.callBack = callBack;
			if( UtilityFunctions.IsNullOrEmpty( SyncFile.content ) )
			{
				if( null != callBack )
				{
					syncDto.ProgressValue = 70; //checking progress
					//aplication doesn't update the UI, delay calling untill next screen update
					FlexGlobals.topLevelApplication.callLater( function():void {
						NothingToSync();
					});
				}
				return;
			}
			var dictationList:XMLList = SyncFile.content.children();
			var i:int = 0;
			var length:int = dictationList.length()
			syncDto.ProgressTotal = length;  //actual progress
			
			if( syncDto.ProgressTotal == 0 )
			{
				if( null != callBack )
				{
					NothingToSync();
				}
				return; //nothing to upload
			}
			
			//model.SyncTotalToSyncCount = totalFilesToUpload;
			
			for( i = 0; i < length; i++ )
			{
				var dictation:XML = dictationList[i];
				upload( dictation );
			}
			
		}
		
		private function NothingToSync():void
		{
			//aplication doesn't update the UI, delay calling untill next screen update
			FlexGlobals.topLevelApplication.callLater( function():void {
				syncDto.ProgressTotal = 100; //checking progress
				syncDto.ProgressValue = 100;
				syncDto.status		  = 'hide';
				syncDto.message		  = "No pending dictations to sync";	
				callBack();
			});
		}
		
		private function upload( xdictation:XML ):void
		{
			var fileName:String 		= xdictation.@['name'];
			var nativePath:String 		= xdictation.@['nativePath'];
			var dictationID:String 		= xdictation.@['ID'] ;
			var recordTimeStamp:String 	= xdictation.@['recordTimeStamp'];
			var sessionID:String 		= xdictation.@['sessionID'];
			var createdAt:String 		= xdictation.@['createdAt'];
			var createdBy:String 		= xdictation.@['createdBy'];
			
			var fileToUpload:File = File.applicationStorageDirectory.resolvePath( nativePath );
			
			var bytesToSend:ByteArray = new ByteArray();
			
			if( fileToUpload.exists )
			{
				var fs:FileStream = new FileStream();
				fs.open(fileToUpload, FileMode.READ);
				fs.readBytes( bytesToSend );
				fs.close();
			}
			
			if( UtilityFunctions.IsNullOrEmpty( bytesToSend ) )
			{
				logger.error( "DICTATION SYNC::dictation Sync file upload failed. " + fileToUpload.nativePath +"<br> Error Report : <br> Unable to read file content"  );
				var ioError:IOErrorEvent = new IOErrorEvent(IOErrorEvent.VERIFY_ERROR, false, false, "dictation Sync file upload failed. Unable to read file content");
				onUploadingError( ioError );
				return;
			}
			
			var uploadPath:String = Constants.DICTATION_SERVER_URL + "UploadDictationFile/"+ dictationID+"/"+recordTimeStamp+"/"+sessionID+"/"+createdAt+"/"+createdBy;			
			
			
			
			var urlRequest:URLRequest = new URLRequest();
			urlRequest.url = uploadPath;

			urlRequest.method = URLRequestMethod.POST;
			urlRequest.contentType = "application/octet-stream";
			urlRequest.data = UploadPostHelper.getPostData(dictationID, bytesToSend); //actual file contents, this must not be null
			urlRequest.requestHeaders.push( new URLRequestHeader( 'Cache-Control', 'no-cache' ) );
			urlRequest.requestHeaders.push( new URLRequestHeader( 'AllowWriteStreamBuffering', 'false' ) );
			urlRequest.requestHeaders.push( new URLRequestHeader( 'SendChunked', 'true' ) );
			
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			
			urlLoader.addEventListener(Event.COMPLETE, function(event:Event):void
			{
				removeSyncInfo(dictationID); //File is uploaded, remove from Sync
				--syncDto.ProgressTotal;
				
				syncDto.ProgressValue = syncDto.ProgressTotal;
				
				if( syncDto.ProgressTotal == 0 )
				{
					//aplication doesn't update the UI, delay calling untill next screen update
					FlexGlobals.topLevelApplication.callLater( function():void {
						callBack();
					});
				}
				
				logger.info( "DICTATION SYNC::dictation Sync file uploaded. <br> Report : <br>" + event.toString() );
				
			});
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onUploadingError);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onUploadingError);
			
			urlLoader.load(urlRequest);
		}
		
		
		protected function onUploadingError(event:IOErrorEvent):void
		{
			--syncDto.ProgressTotal; // will upload remaining files on next login
			
			syncDto.ProgressValue = syncDto.ProgressTotal;
			
			if( syncDto.ProgressTotal == 0 )
			{
				//aplication doesn't update the UI, delay calling untill next screen update
				FlexGlobals.topLevelApplication.callLater( function():void {
					callBack();
				});
			}
			
			logger.error( "DICTATION SYNC::dictation Sync file upload failed. <br> Error Report : <br>" + event.toString() );
			
		}
		
		protected function removeSyncInfo(fileID:String):void
		{
			delete SyncFile.content.dictation.( @['ID'] == fileID )[0];
			SyncFile.write();
		}
	}
}