package com.gazuntite.utils
{
	import com.gazuntite.controls.extended.components.PopupGroup;
	import com.gazuntite.controls.extended.components.PopupWindow;
	import com.gazuntite.controls.extended.skins.popupWindowSkin;
	
	import flash.display.DisplayObject;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Capabilities;
	import flash.ui.ContextMenuItem;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.controls.Image;
	import mx.controls.Label;
	import mx.controls.ProgressBar;
	import mx.controls.SWFLoader;
	import mx.core.ByteArrayAsset;
	import mx.core.FlexGlobals;
	import mx.events.CloseEvent;
	import mx.formatters.DateFormatter;
	import mx.managers.CursorManager;
	import mx.managers.PopUpManager;
	import mx.utils.Base64Decoder;
	import mx.utils.Base64Encoder;
	
	import spark.components.Group;

	public class UtilityFunctions
	{
		private var popGroup:Group;
		
		
		
		public static function ShowStatusMessage( message:String, parent:DisplayObject = null ):PopupWindow
		{
			var win:PopupWindow 	= new PopupWindow();
			
			win.setStyle("skinClass", popupWindowSkin);
			var lbl:Label 			= new Label();
			lbl.text 				= message;
			lbl.percentHeight 		= 100;
			lbl.percentWidth  		= 100;
			win.title 				= "Application status information"; 
			lbl.setStyle( "textAlign", "center" );
			lbl.setStyle( "color", 0xffffff );
			//lbl.setStyle( "fontColor", 0x000000 );
			win.addElement( lbl );
			
			if( null == parent )
				parent = FlexGlobals.topLevelApplication as DisplayObject;
			
			win.ShowPopup( parent );
			
			return win;
		}
		
		public static function ShowProgressBar( message:String, parent:DisplayObject = null ):PopupGroup
		{
			//var win:PopupWindow 	= new PopupWindow();
			
			var win:PopupGroup = new PopupGroup();
			//win.setStyle("skinClass", popupWindowSkin);
			
			//win.titleDisplay.alpha = 0;
					
			/*var lbl:Label 			= new Label();
			lbl.text 				= message;
			lbl.percentHeight 		= 100;
			lbl.percentWidth  		= 100;*/
			
		/*	if(message && message != "")
			{
				win.title 				= message;
			}
			else
			{
				win.title 				= "loading..";	
			}*/
			/*lbl.setStyle( "textAlign", "center" );
			lbl.setStyle( "color", 0xffffff );*/
			
		
			var p1:ProgressBar = new ProgressBar();
			p1.indeterminate = true;			
			//p1.label = "";
			p1.label = message;
			
			var img:Image = new Image();
			[Embed(source="assets/qanim.swf")]
			var QuivusIcon:Class;
			img.source =QuivusIcon; 
			
			//lbl.setStyle( "fontColor", 0x000000 );
			//win.addElement( lbl );
			win.addElement( img );
			win.move((Capabilities.screenResolutionX / 4) - 130, (Capabilities.screenResolutionY/2)-130);
			
			if( null == parent )
				parent = FlexGlobals.topLevelApplication as DisplayObject;
			
			win.ShowPopup( parent );
			
			
			
			return win;
		}
		
		public static function showBusyPointer():void
		{
			/*[Embed(source="assets/loader.swf")]
			var QuivusIcon:Class;
			
			
			 var cursorID:int;
			cursorID = CursorManager.setCursor(QuivusIcon);*/
		}
		public static function removeBusyPointer():void
		{
			//CursorManager.removeBusyCursor();
			CursorManager.removeAllCursors();
		}
		
/*		public function showProgress():void
		{
			trace("SHOW progress");
			var p1:ProgressBar = new ProgressBar();
			p1.indeterminate = true;
			popGroup = new Group();
			popGroup.addElement( p1 );
			
			PopUpManager.addPopUp( popGroup, FlexGlobals.topLevelApplication as DisplayObject );
			
			popGroup.x = Capabilities.screenResolutionX/4;
			popGroup.y = Capabilities.screenResolutionY/2;
		}
		public function removeProgress():void
		{
			//popGroup.removeAllElements();
			trace("remove progress");
			PopUpManager.removePopUp(popGroup);
		}*/
		
		
		public static function AskMessage(message:String, onYes:Function, yesParam:Array = null, onNo:Function = null, noParams:Array = null):void
		{
			Alert.show(message,	"Are you sure?", Alert.YES|Alert.NO, getTopLevelParentContainer(), function( event:CloseEvent):void
			{
				if( event.detail == Alert.YES )
				{
					if (yesParam)
						onYes.call(null, yesParam );
					else
						onYes.call(null);
				}
				else if( event.detail == Alert.NO && onNo != null )
				{
					if (noParams)
						onNo.call( null, noParams );
					else
						onNo.call(null);
				}
			});
		}
		
		public static function ShowMessage(message:String, title:String, callBack:Function = null, callBackParams:Array = null):void
		{
			Alert.show(message,	title, Alert.OK, getTopLevelParentContainer(), function( event:CloseEvent):void
			{
				if( event.detail == Alert.OK && callBack != null)
				{
					callBack.call( callBackParams );
				}
			});
		}
		
		public static function getTopLevelParentContainer():Sprite
		{
			if(FlexGlobals.topLevelApplication.hasOwnProperty("mainContainer"))
			{
				return FlexGlobals.topLevelApplication["mainContainer"] as Sprite;
			}
			
			return FlexGlobals.topLevelApplication as Sprite;
		}
		
		/**
		 * Returns <b>True</b> 
		 * <ul>
		 * <li>if value is null or undefined</li>
		 * <li>if value is Empty string</li>
		 * <li>if value is Not a Number or int/Number is 0 or 0.0</li>
		 * <li>if value array/collection has zero length</li>
		 * </ul>
		 * <br/>
		 * for all other cases returns <b>False</b>
		 * 
		 */		
		public static function IsNullOrEmpty( value:* ):Boolean
		{
			if( value == null || value == undefined)
				return true
				
			else if( value is String )
			{
				if( value.length == 0 || value == '' )
					return true
			}
			else if( value is Number || value is int )
			{
				if( value == 0.0 || value == 0 || isNaN(value ))
					return true
			}
				
			else if( value is Array || value is ArrayCollection || value is ByteArray || value is ByteArrayAsset)
			{
				if( value.length == 0 )
					return true
			}
			
			return false;
		}
		
		/**
		 * Returns <b>True</b> 
		 * <li>if value is not null and have following props:</li>
		 * <ul>
		 * <li>if value is not an empty string with one or more char(s)</li>
		 * <li>if value is a valid Number greater than zero</li>
		 * <li>if value array/collection has one or more items</li>
		 * <li>if value is not null object</li>
		 * </ul>
		 * <br/>
		 * 
		 */
		public static function IsNotNullOrEmpty( value:* ):Boolean
		{
			return ! IsNullOrEmpty( value );
		}
		
		public static function FormatDate( value:*, formatString:String = "YYYY-MM-DD" ):String
		{
			var formatedDate:String;
			var df:DateFormatter = new DateFormatter();
			df.formatString = formatString;
			
			if( value is Date)
			{
				formatedDate = df.format( value );
			}
			else if( value is String )
			{
				var rex:RegExp;
				var dateArray:Array;
				var dat:Date;
				if((value as String).indexOf("/") > -1)
				{
					rex = /\//;
					dateArray = value.split(rex);
					dat = new Date(dateArray[2] , dateArray[0] - 1, dateArray[1]);
				}
				else
				{
					rex = /-/;
					dateArray = value.split(rex);
					dat = new Date(dateArray[0], dateArray[1] - 1, dateArray[2]);
				}
				formatedDate = df.format( dat );
			}
			
			return formatedDate;
		}
		
		public function StringToBoolean(val:String):Boolean
		{
			if(val == "false")
				return false;
				
			else if(val =="true")
				return true;
			
			return true;
		}
		
		public static function TitleCase( value:String ):String
		{
			var s:String = value.toLowerCase();
			var tokens:Array = s.split(' ');
			var ret:String = '';
			for( var i:int = 0; i < tokens.length; i++ )
			{
				var token:String = tokens[ i ];
				var sep:String = (tokens.length == 1 )? '':' ';
				ret += token.charAt().toUpperCase() + token.substr( 1 ) + sep;
			}
			
			return TrimString( ret );
		}
		
		public static function TrimString(text:String):String 
		{
			return text.replace(/^\s+|\s+$/g, "");
		}
		
		public static function GetDateFromToday( value:int ):Date
		{
			return new Date( new Date().getTime() + value * ( 1000 * 60 * 60 * 24 ) )
		}
		
		/**
		 * @auther:	Malik Tamjeed
		 * @dated:  11/04/2011
		 * @param collection:  		ArrayCollection where item will be added
		 * @param item: 			Object to be added in the collection
		 * @param compareField: 	Property in item to identify obj 
		 * @param compareFunction: 	custom user defined function to compare item i.e. compareFunction( item, obj ) where obj is item in collection
		 * @return 					true if item was added to collection, false item was not added in collection.
		 * 
		 */		
		public static function AddUniqueItem(collection:ArrayCollection, item:*, compareField:String = null, compareFunction:Function = null):Boolean 
		{
			var exists:Boolean = false;
			if( ! IsNullOrEmpty( item ) )
			{
				if ( collection.length > 0 )
				{
					if( item is String )
					{
						item = TrimString( item as String );
						exists = compareEachForString( collection, item );
					}
					else if( item is Object && ! IsNullOrEmpty( compareField ) && item.hasOwnProperty( compareField ) )
					{
						AddUniqueItem( collection, item[ compareField ] );
					}
					else if( ! IsNullOrEmpty( compareFunction ) )
					{
						var i:int;
						for(i = 0; i < collection.length; i ++ )
						{
							var obj:Object = collection.getItemAt( i );
							exists = compareFunction( item, obj );
							if( exists )
								break;
						}
					}
				}
				
				if( ! exists )
					collection.addItem( item );
			}
			
			return ! exists;
		}
		
		public static function compareEachForString( collection:ArrayCollection, value:String ):Boolean
		{
			var i:int;
			
			for(i = 0; i < collection.length; i ++ )
			{
				var item:String = collection.getItemAt( i ) as String;
				if( item == value )
				{
					return true;
				}
			}
			
			return true;
		}
		
		private static function compareString( str1:String, str2:String ):Boolean
		{
			if( str1.length == str2.length && str1 == str2 )
				return true
			return false;
		}
		
		public static function CreateSubmenue( menueName:String, ChildItemNames:Array, ChildItemClickHandler:Function ):ContextMenuItem
		{
			var menu:ContextMenuItem = new ContextMenuItem( menueName ); 
			menu.submenu = new NativeMenu();
			
			var i:int;
			for( i = 0; i < ChildItemNames.length; i++ )
			{
				var nmi:NativeMenuItem = menu.submenu.addItem( new NativeMenuItem( ChildItemNames[i] ) ); 
				nmi.addEventListener( Event.SELECT, ChildItemClickHandler );
			}
			
			return menu;
		}

		/**
		 * 
		 * @param val The actual Value first checked if empty and then appended with delimiter
		 * @param attachEmpty if true the Delimiter is returned if Value found empty. Default is true
		 * @param delim The actual Delimiter to be appended, Default is pipe sign i.e |
		 * @return Delimited string
		 * 
		 */		
		public static function getDelimitedValue( val:*, attachEmpty:Boolean = true, delimiter:String="|" ):String
		{
			var retVal:String = "";
			
			if( ! IsNullOrEmpty( val ) )
			{
				retVal += val + delimiter;
			}
			else if( attachEmpty )
			{
				retVal += delimiter;
			}
			
			return retVal;
		}
		
		/**
		 * 
		 * @param val The actual Value first checked if empty
		 * @param dash The actual char to be replace with, Default is pipe sign i.e -
		 * <br />Example: 
		 * <br />the call ReplaceSlashWithDash( 12/12/2012 );// returns 12-12-2012
		 * <br />the call ReplaceSlashWithDash( 12/12/2012 );// returns 12-12-2012
		 * @return Delimited string
		 * 
		 */		
		public static function ReplaceSlashWith( val:String, dash:String="-" ):String
		{
			var retVal:String = val;
			
			if( ! IsNullOrEmpty( retVal ) )
			{
				while( retVal.indexOf( "/" ) != -1 )
				{
					retVal = retVal.replace( "/", dash ); 
				}
			}
			
			
			return retVal;
		}
		/**
		 * This method converts the simple string into  Base 64 Encoded String
		 * Pram: String
		 * Return :Base 64 String
		 *  */
		public static function getEncodedBase64String(text:String):String
		{
			var base64Dec:Base64Encoder = new Base64Encoder();
			
			base64Dec.encode(text);
			
			return base64Dec.toString();
		}
		
		//********* Tahir Alvi - 15 june, 2012 *************************************
		//Recieve base64 image string as parameter and return Bytearray that directly assign to image source
		public static function getByteArray(val:String):ByteArray
		{
			var base64Dec:Base64Decoder = new Base64Decoder();;
			var byteArr:ByteArray;
			base64Dec.decode(val);
			byteArr = base64Dec.toByteArray();
			
			return byteArr;
		}
		//Recieve Bytearray as parameter and return Base64 String to server for save in database
		public static function convertBase64String(val:ByteArray):String
		{
			var base64Enco:Base64Encoder = new Base64Encoder();
			base64Enco.encodeBytes(val, 0, val.length);
			
			return base64Enco.toString();
		}
		//Recieve String as parameter and return Base64 String to server for save in database
		public static function convertStringToBase64String(val:String):String
		{
			var base64Enco:Base64Encoder = new Base64Encoder();
			//base64Enco.encodeBytes(val, 0, val.length);
			base64Enco.encode(val,0,val.length);  
			return base64Enco.toString();
		}
		
		/**
		 * @auther:	Shahid Munir
		 * @dated:  11/19/2011
		 * @param dateString:  		date in String format		 
		 * @return 					date that can be assigned to datefield.selectedDate. 
		 */
		public static function toDate(dateString:String, dateFormat:String = "MM/DD/YYYY"):Date
		{
			var result:Date;
			
			if (dateString.length)
			{
				var delimiter:String = dateFormat.substring(dateFormat.indexOf("MM")+3,2); 
				var dateArray:Array = dateString.split(delimiter);
				var formatArray:Array = dateFormat.split(delimiter);
				
				var dayNumber:int = 0;
				var monthNumber:int = 0;
				var yearNumber:int = 0;
				for(var i:int = 0; i < formatArray.length; i++)
				{
					switch(formatArray[i])
					{
						case "MM":
						{								
							monthNumber = parseInt(dateArray[i]);								
							break;
						}
						case "DD":
						{
							dayNumber = parseInt(dateArray[i]);	
							break;
						}
						case "YYYY":
						{
							yearNumber = parseInt(dateArray[i]);	
							break;
						}							
					}
				}					
				
				result = new Date (yearNumber, monthNumber - 1, dayNumber);
			}
			return result;
		}
		/**
		 * @auther:	Tahir Alvi
		 * @dated:  7 March, 2013
		 * @param dateString:  		date in String format (2013-03-07T00:00:00)		 
		 * @return 					date that can be assigned to datefield.selectedDate. 
		 */
		public static function formatStringDate(date:String):String
		{
			//2012-01-01T00:00:00
			var year:String = date.substr(0, 4);
			var month:String = date.substr(5,2);
			var day:String = date.substr(8,2);
			
			return month +"/"+ day +"/"+ year;
			
		}
		
		public static function compareStringsIgnoringCase(str1:String, str2:String):Boolean
		{
			if (!str1)
				return false;
			
			if (!str2)
				return false;
			
			if (str1.length == str2.length && str1.toLocaleLowerCase() == str2.toLocaleLowerCase())
			{
				return true;
			}
			
			return false;
		}
	}
}