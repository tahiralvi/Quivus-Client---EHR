package com.adobe.Quivus.view.controls.documentViewer
{
	import com.adobe.Quivus.logging.LoggingUtil;
	import com.adobe.Quivus.utils.ChromeUtil;
	import com.gazuntite.utils.UtilityFunctions;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.html.HTMLLoader;
	import flash.html.HTMLPDFCapability;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.events.CloseEvent;
	import mx.logging.ILogger;
	import mx.managers.CursorManager;

	public class DocumentLoader
	{
		
		private var loader:URLLoader;
		private var documentFile:File
		private var documentURL:String
		private var documentName:String
		private var logger : ILogger;
		private var documentWindow:DocumentViewWindow;
		private var tempDir:File;
		public function DocumentLoader()
		{
			loader = new URLLoader();
			logger = LoggingUtil.getLogger( this );
			
			tempDir = File.createTempDirectory();
		}
		
		public function load(name:String, url:String):void
		{
			documentName = name;
			documentURL = url;
			loadDoc();
			
			
		}
		
		public function closeWindow():void
		{
			if( documentWindow )
				documentWindow.close();
		}
		
		private function loadDoc():void
		{
			CursorManager.setBusyCursor();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(Event.COMPLETE, onDocumentLoadingComplete);
			var req:URLRequest = new URLRequest( documentURL );
			loader.load(req);
		}
		
		private function onDocumentLoadingComplete(event:Event):void
		{
			try
			{
				var token:Array = documentURL.split( '.' );
				var type:String = "." + token[ token.length - 1 ];
				
				if( documentName.indexOf( "." ) == -1 )
				{
					documentName += type
				}
				
				documentFile = tempDir.resolvePath( documentName );//File.applicationStorageDirectory.resolvePath("Documents/" + documentName );
				logger.debug("downloaded file from " + documentURL );
				logger.debug("downloaded file saved in " + documentFile.nativePath );
				var fs:FileStream = new FileStream();
				fs.open(documentFile, FileMode.WRITE);
				fs.writeBytes(loader.data);
				fs.close();
				documentFile.downloaded = true;
				
				openDocument();
				
			}
			catch(error:Error)
			{
				/* Alert.show("unable to open file \"" + event.FileName + "\" no default application found, please ask your system administrator for help",
				"Default application not installed" ); */
				Alert.show("unable to open file \"" + documentName + "\" \n" + error.message, "Unknown File Type" );
				logger.debug("No Document Viewer Fond." + error.message);
			}
			CursorManager.removeBusyCursor();
		}
		
		private function openDocument():void
		{
			try
			{
				ChromeUtil.TestConstraintWidth(); // check application size ....
				trace(ChromeUtil.isMaximized, ChromeUtil.isResized, ChromeUtil.isMoved)
				if( ChromeUtil.isMaximized || ChromeUtil.isResized || ChromeUtil.isMoved )
				{
					var oldWidth:Number = Alert.buttonWidth;
					var oldYesLabel:String		= Alert.yesLabel;
					var oldNoLabel:String		= Alert.noLabel;
					Alert.yesLabel="Open it outside the Gazuntite";
					Alert.noLabel="Restore to default and open";
					Alert.buttonWidth = 150;
					var alertWindow:Alert = Alert.show("Gazuntite is not running on its default resolution size, if you want to open document, select one \nof following options:",	
						"Open Document", 
						Alert.YES|Alert.NO|Alert.CANCEL, 
						FlexGlobals.topLevelApplication as Sprite, 
						function( event:CloseEvent):void
						{
							if( event.detail == Alert.YES )//Alert.yesLabel="Open it outside the Gazuntite";
							{
								documentFile.openWithDefaultApplication();
							}
							else if( event.detail == Alert.NO )//Alert.noLabel="Restore to default and open";
							{
								ChromeUtil.restoreDefault();
								openInQuivusViewer();
							}
							else if( event.detail == Alert.CANCEL )
							{
								
							}
							
							//restore old AlertBox setting
							Alert.buttonWidth = oldWidth;
							Alert.yesLabel = oldYesLabel;
							Alert.noLabel = oldNoLabel;
						});
					alertWindow.width = 500;
					//alertWindow.width = 300;
					Alert.buttonWidth = oldWidth;
					Alert.yesLabel = oldYesLabel;
					Alert.noLabel = oldNoLabel;
				}
				else
				{
					logger.debug("Opening In Gazuntite Viewer file " + documentFile.name);
					openInQuivusViewer();
				}
			}
			catch(error:Error)
			{
				trace( error.errorID, error.name, error.message );
				logger.debug("unable to openDocument  ERROR#:" + error.errorID + ", ERROR MESSAGE: " + error.name + ", " + error.message );
			}
			CursorManager.removeBusyCursor();
		}
		
		private function openInQuivusViewer():void
		{
			if( documentFile.type.toLowerCase() == ".txt"  || //text file or any Image File
				documentFile.type.toLowerCase() == ".jpg"  || 
				documentFile.type.toLowerCase() == ".jpeg" ||
				documentFile.type.toLowerCase() == ".gif"  ||
				documentFile.type.toLowerCase() == ".png" )
			{
				loadInPopupWindow( documentFile );
			}
			else if( documentFile.type.toLowerCase() == ".pdf" && HTMLLoader.pdfCapability == HTMLPDFCapability.STATUS_OK )
			{
				loadInPopupWindow( documentFile );
			}
			else if(documentFile.type.toLowerCase() == ".pdf" && (HTMLLoader.pdfCapability == HTMLPDFCapability.ERROR_INSTALLED_READER_NOT_FOUND ||
				HTMLLoader.pdfCapability == HTMLPDFCapability.ERROR_INSTALLED_READER_TOO_OLD ))
			{
				Alert.show("Please install latest version of Adobe Acrobat Reader (8.1 or greater), ask your system administrator for further help.","Adobe Acrobat Reader not installed");
				logger.debug("No Adobe Acrobat Reader Viewer Fond.");
			}
			else
			{
				UtilityFunctions.AskMessage(  "This format is not supported, do you want to open in third party application?", function():void
				{
					documentFile.openWithDefaultApplication();
				});
				
				//throw(new Error("only Adobe Acrobat Document (*.pdf) and images(*.jpg, *.jpeg, *.gif, *.png) files are supported ...") );
			}
		}
		
		private function loadInPopupWindow(file:File):void
		{
			try
			{
				if( documentWindow == null )
				{
					documentWindow 			= new DocumentViewWindow();
				
					documentWindow.addEventListener(Event.CLOSE, function(event:Event):void
					{
						documentWindow 		= null;
					});	
					documentWindow.open();
					/*documentWindow.width 	= 800; //width of the content area
					documentWindow.height 	= 600; //height of the content area
					documentWindow.x 		= FlexGlobals.topLevelApplication.mainContainer.width + 10 ;
					documentWindow.x 		= Capabilities.screenResolutionX /2 ;
					documentWindow.y 		= 60 ;*/
					documentWindow.nativeWindow.x = Capabilities.screenResolutionX /2 ;
					documentWindow.nativeWindow.y = 80;
					
				}
				else
				{
					documentWindow.activate();
				}
				
				documentWindow.LoadDocument( file );
			}
			catch(error:Error)
			{
				trace( error.errorID, error.name, error.message );
				logger.debug("unable to open document In Gazuntite Viewer  ERROR#:" + error.errorID + ", ERROR MESSAGE: " + error.name + ", " + error.message );
				CursorManager.removeBusyCursor();
			}
		}
	}
}