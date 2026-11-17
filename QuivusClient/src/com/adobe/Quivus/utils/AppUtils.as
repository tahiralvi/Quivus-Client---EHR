package com.adobe.Quivus.utils
{
	import com.adobe.Quivus.view.controls.custom.patientExamView.quickInput.comprehensiveHistory.renderer.OptionButton;
	import com.gazuntite.controls.extended.components.SelectablePanel;
	import com.gazuntite.utils.UtilityFunctions;
	
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.core.UIComponent;
	import mx.events.CloseEvent;
	import mx.utils.Base64Decoder;
	import mx.utils.Base64Encoder;
	
	import spark.components.Group;
	import spark.components.Panel;
	import spark.components.SkinnableContainer;
	import spark.components.TextInput;
	import spark.components.ToggleButton;
	import spark.components.supportClasses.GroupBase;

	public class AppUtils
	{
		public static function GetDateFromToday( value:int ):Date
		{
			//UtilityFunction
			return UtilityFunctions.GetDateFromToday( value )
		}
		
		public static function EnableTextInput( value:Boolean, parentContainer:GroupBase):void
		{
			for( var i:int = 0; i < parentContainer.numChildren; i++ )
			{
				var elm:UIComponent = parentContainer.getElementAt( i ) as UIComponent;
				if( elm is TextInput )
				{
					elm.enabled = value; 
				}
			}
		}
		
		public static function EnableSelection(fromParent:GroupBase, onButton:OptionButton ):void
		{
			for( var i:int = 0; i < fromParent.numChildren; i++ )
			{
				var elm:OptionButton = fromParent.getElementAt( i ) as OptionButton;
				if( elm == onButton )
				{
					elm.id_MainButton.selected = true; 
				}
				else
				{
					elm.id_MainButton.selected = false; 
				}
			}
		}
		
		public static function getButtonByLabel(fromParent:GroupBase, labe:String ):OptionButton
		{
			for( var i:int = 0; i < fromParent.numChildren; i++ )
			{
				var elm:OptionButton = fromParent.getElementAt( i ) as OptionButton;
				if( elm.Label == labe )
				{
					return elm;
				}
			}
			return null;
		}
		
		public static function setActivePanel(fromParent:SkinnableContainer, onPanel:SelectablePanel ):void
		{
			for( var i:int = 0; i < fromParent.numChildren; i++ )
			{
				var elm:SelectablePanel = fromParent.getElementAt( i ) as SelectablePanel;
				if( elm == onPanel )
				{
					onPanel.percentWidth = 100;
					onPanel.AllowContents = true;
				}
				else
				{
					elm.width = 150;
					elm.AllowContents = false;
				}
			}
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
				
			return ValidationUtils.TrimString( ret );
		}
		
		/*public static function AskMessage(message:String, onYes:Function, yesParam:Array = null, onNo:Function = null, noParams:Function = null):void
		{
			return UtilityFunctions.AskMessage( message, onYes, yesParam, onNo, noParams );
		}*/
		
		public static function IsNullOrEmpty( value:Object ):Boolean
		{
			return UtilityFunctions.IsNullOrEmpty( value );
		}
		
		//********* Tahir Alvi - 15 june, 2012 *************************************
		//Recieve base64 image string as parameter and return Bytearray that directly assign to image source
		public static function getByteArray(val:String):ByteArray
		{
			var base64Dec:Base64Decoder = new Base64Decoder();;
			var byteArr:ByteArray		= new ByteArray();
			base64Dec.decode(val);
			byteArr = base64Dec.toByteArray();
			
			return byteArr;
		}
		//Recieve Bytearray as parameter and return Base64 String to server for save in database
		public static function getBase64String(val:ByteArray):String
		{
			var base64Enco:Base64Encoder = new Base64Encoder();
			base64Enco.encodeBytes(val, 0, val.length);
			
			return base64Enco.toString();
		}

	}
}