package com.gazuntite.provider.live.services.administration.util
{
	import com.gazuntite.common.util.ValidationUtils;
	import com.gazuntite.common.util.xml.XmlConstants;
	import com.gazuntite.common.util.xml.XmlUtils;
	import com.gazuntite.controls.extended.components.LabelTextInput;
	import com.gazuntite.provider.live.services.administration.dto.locationManagement.AdminStationDTO;
	
	import flash.utils.ByteArray;
	
	import mx.controls.DateField;
	import mx.utils.Base64Decoder;
	import mx.utils.Base64Encoder;
	import mx.utils.ObjectProxy;
	import mx.utils.XMLUtil;
	
	import spark.components.TextInput;
	
	public class AdminUtils
	{
		public function AdminUtils()
		{
			
		}
		//Tahir Alvi -Convert Object proxt to General Setting XMl Node
		public static function ConvertToGeneralSettingXML(dto:ObjectProxy):XML
		{
			var xml:XML = XmlUtils.getNodeByTagName( "GeneralSetting" );
			
			xml.@[XmlConstants.PASSWORD_CHAR_SET_RULE]					= dto.PasswordCharSetRule;
			xml.@[XmlConstants.PASSWORD_MINIMUM_LENGTH]					= dto.PassMinimumLength;
			xml.@[XmlConstants.PASSWORD_EXPIRY_RULE]					= dto.PasswordExpiryRule;
			xml.@[XmlConstants.EXPIRY_AFTER_EVERY_RULE]					= dto.ExpireAfterEveryRule;
			xml.@[XmlConstants.EXPIRY_AFTER_EVERY]						= dto.ExpireAfterEvery;
			xml.@[XmlConstants.ALERT_USER_RESET_PASSWORD_RULE]			= dto.AlertUserResetPasswordRule;
			xml.@[XmlConstants.ALERT_USER_RESET_PASSWORD_DAY_COUNT]		= dto.AlertUserResetPasswordDayCount;
			xml.@[XmlConstants.PASSWORD_HISTORY_RULE]					= dto.PasswordHistoryRule;
			xml.@[XmlConstants.PASSWORD_HISTORY_COUNT]					= dto.PasswordHistoryCount;
			xml.@[XmlConstants.ACCOUNT_LOCK_FAILURE_ATTEMPT_RULE]		= dto.AccountLockFailureAttemptRule;
			xml.@[XmlConstants.ATTEMPT_COUNT] 							= dto.AttemptCount;
			xml.@[XmlConstants.SESSION_IN_ACTIVITY_LOCK_RULE] 			= dto.SessionInActivityLockRule;
			xml.@[XmlConstants.LOCK_SESSION_AFTER] 						= dto.LockSessionAfter;
			xml.@[XmlConstants.CONFI_NOTIFICATION_RULE] 				= dto.ConfidentialityNotificationRule;
			xml.@[XmlConstants.CONFI_TEXT] 								= dto.ConfidentialityText;
			xml.@[XmlConstants.CLINIC_ID] 								= dto.ClinicId;
			xml.@[XmlConstants.MODIFIEDBY] 								= dto.ModifiedBy;
			
			return xml;
		}
		//Tahir Alvi -Convert Object proxt to Clinic Room XMl Node
		public static function ConvertToClinicRoomXML(dto:ObjectProxy):XML
		{
			var parentXml:XML = XmlUtils.getNodeByTagName( "ArrayOfClinicRoomDTO" );
			var xml:XML    = XmlUtils.getNodeByTagName( "ClinicRoomDTO" );
			
			xml.@['IsDeleted']						= dto.IsDeleted;
			xml.@['IsDirty']						= dto.IsDirty;
			xml.@['ClinicRoomId']					= dto.ClinicRoomId;
			xml.@['StationId']						= dto.StationId;
			xml.@['RoomTitle']						= dto.RoomTitle;
			xml.@['Roomtype']						= dto.Roomtype;
			xml.@['RoomStatus']						= dto.RoomStatus;
			xml.@['RoomCode']						= dto.RoomCode;
			xml.@['CreatedBy']						= dto.CreatedBy;
			xml.@['CreatedAt']						= dto.CreatedAt;
			xml.@['ModifiedBy']						= dto.ModifiedBy;
			xml.@['ModifiedAt']						= dto.ModifiedAt;
			
			parentXml.appendChild(xml);
				
			return parentXml;
		}
		//Tahir Alvi -Convert Object proxt to Prescribe XMl Node
		public static function ConvertToPrescribeXML(dto:ObjectProxy):XML
		{
			var xml:XML = XmlUtils.getNodeByTagName( "ClinicBranchDTO" );
			
			xml.@['IsDeleted']						= dto.IsDeleted;
			xml.@['IsDirty']						= dto.IsDirty;
			xml.@['ClinicBranchIdSeq']				= dto.ClinicBranchIdSeq;
			xml.@['ClinicBranchName']				= dto.ClinicBranchName;
			xml.@['Address']						= dto.Address;
			xml.@['FaxNumber']						= dto.FaxNumber;
			xml.@['BranchCode']						= dto.BranchCode;
			xml.@['PhoneNumber']					= dto.PhoneNumber;
			xml.@['State']							= dto.State;
			xml.@['ClinicStatus']					= dto.ClinicStatus;
			xml.@['City'] 							= dto.City;
			xml.@['ContactPerson'] 					= dto.ContactPerson;
			xml.@['ZIP'] 							= dto.ZIP;
			xml.@['SpecialityID'] 					= dto.SpecialityID;
			xml.@['License1'] 						= dto.License1;
			xml.@['License2'] 						= dto.License2;
			xml.@['ContactPersonPhoneNo'] 			= dto.ContactPersonPhoneNo;
			xml.@['SubscriptionStartDate'] 			= dto.SubscriptionStartDate;
			xml.@['SubscriptionEndDate'] 			= dto.SubscriptionEndDate;
			xml.@['Email'] 							= dto.Email;
			xml.@['AvgPatientPerDay'] 				= dto.AvgPatientPerDay;
			
			return xml;
		}
		//Tahir Alvi -Convert Object proxt to Prescribe XMl Node
		public static function ConvertLocationOBJXML(dto:ObjectProxy):XML
		{
			var parentXml:XML = XmlUtils.getNodeByTagName( "ArrayOfStationDTO" );
			var xml:XML = XmlUtils.getNodeByTagName( "StationDTO" );
			
			xml.@['IsDeleted']						= dto.IsDeleted;
			xml.@['IsDirty']						= dto.IsDirty;
			xml.@['StationID']						= dto.StationID;
			xml.@['ClinicBranchID']					= dto.ClinicBranchID;
			xml.@['CreatedAt']						= dto.CreatedAt;
			xml.@['CreatedBy']						= dto.CreatedBy;
			xml.@['ModifiedAt']						= dto.ModifiedAt;
			xml.@['ModifiedBy']						= dto.ModifiedBy;
			xml.@['IsDefault']						= dto.IsDefault;
			xml.@['Address']						= dto.Address;
			xml.@['StationName'] 					= dto.StationName;
			xml.@['City'] 							= dto.City;
			xml.@['PhoneNumber'] 					= dto.PhoneNumber;
			xml.@['FaxNumber'] 						= dto.FaxNumber;
			
			parentXml.appendChild(xml);
			return parentXml;
		}
		//Tahir Alvi -Convert Object proxt to Prescribe XMl Node
		public static function ConvertToLocationXML(dto:AdminStationDTO):XML
		{
			var parentXml:XML = XmlUtils.getNodeByTagName( "ArrayOfStationDTO" );
			var xml:XML = XmlUtils.getNodeByTagName( "StationDTO" );
			
			xml.@['IsDeleted']						= dto.IsDeleted;
			xml.@['IsDirty']						= dto.IsDirty;
			xml.@['StationID']						= dto.StationID;
			xml.@['ClinicBranchID']					= dto.ClinicBranchID;
			xml.@['CreatedAt']						= dto.CreatedAt;
			xml.@['CreatedBy']						= dto.CreatedBy;
			xml.@['ModifiedAt']						= dto.ModifiedAt;
			xml.@['ModifiedBy']						= dto.ModifiedBy;
			xml.@['IsDefault']						= dto.IsDefault;
			xml.@['Address']						= dto.Address;
			xml.@['StationName'] 					= dto.StationName;
			xml.@['City'] 							= dto.City;
			xml.@['PhoneNumber'] 					= dto.PhoneNumber;
			xml.@['FaxNumber'] 						= dto.FaxNumber;
			
			parentXml.appendChild(xml);
			return parentXml;
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
		
		
		public static function getByteArray(val:String):ByteArray
		{
			var base64Dec:Base64Decoder;
			var byteArr:ByteArray;
			base64Dec = new Base64Decoder();
			base64Dec.decode(val);
			byteArr = base64Dec.toByteArray();
			
			return byteArr;
		}
		
		public static function getBase64String(val:ByteArray):String
		{
			var base64Enco:Base64Encoder = new Base64Encoder();
			base64Enco.encodeBytes(val, 0, val.length);
			
			return base64Enco.toString();
		}
		
		
		public static function getToday():String
		{
			var d:Date = new Date();				
			var month:String = (d.month + 1).toString();
			if(month.length == 1)
			{
				month = "0"+month;
			}
			
			var today:String = d.fullYear.toString() +"-"+ month +"-"+ d.date.toString()+"T00:00:00";
			
			
			return today;
			
		}
		
		
		public static function removeDefaultNamespaceFromXML(xml:XML):XML
		{
			var rawXMLString:String = xml.toXMLString();
			
			/* Define the regex pattern to remove the default namespace from the 
			String representation of the XML result. */
			var xmlnsPattern:RegExp = 
				new RegExp("xmlns=[^\"]*\"[^\"]*\"", "gi");
			
			/* Replace the default namespace from the String representation of the 
			result XML with an empty string. */
			var cleanXMLString:String = rawXMLString.replace(xmlnsPattern, "");
			
			// Create a new XML Object from the String just created
			return new XML(cleanXMLString);
		}
		
		public static function Trim(txt:TextInput):void 
		{
			txt.text = txt.text.replace(/^\s+|\s+$/g, "");
		}
		
		public static function isValidAlphaNumericWithSpaces(str:String = ""):Boolean
		{
			var isValid:Boolean = true;
			
			var reg:RegExp = /[a-zA-Z0-9,.'()\/\s]{3,200}/ig;
			var result:Object;
			
			do
			{
				result = reg.exec(str);
				
				if ((result == null) || (result && result.index !=0))
				{
					isValid = false;
					break;
				}
				
			}while (reg.lastIndex < str.length)
			
			return isValid;
		}
		
		public static function isValidDate(dateField:DateField):Boolean
		{
			var isValid:Boolean = true;
			
			if (dateField)
			{
				var dateStr:String = dateField.text;
				
				isValid = isValidDateFormat(dateStr);
				
				if (isValid)
				{
					var initial:Number = new Date(1901, 1, 1).getTime();
					var now:Number = new Date().getTime();
					var dob:Number = Date.parse(dateStr);
					
					if (!(dob >= initial && dob <= now))
						isValid = false;
				}
			}
			else
			{
				isValid = false;
			}
			
			return isValid;
		}
		
		private static function isValidDateFormat(dateStr:String):Boolean
		{
			var isValid:Boolean = true;
			
			if (dateStr.length)
			{
				var regExp:RegExp = new RegExp("[0-9]{2}\/[0-9]{2}\/[0-9]{4}", "ig");
				
				var result:* = regExp.exec(dateStr);
				
				if (result == null || (result && result.index != 0))
					isValid = false;
				
				if (regExp.lastIndex < dateStr.length)
					isValid = false;
				
			}
			else
				isValid = false;
			
			return isValid;
		}
		
		public static function isValidEmail(txt:LabelTextInput):Boolean
		{
			var isValid:Boolean = true;
			
			if (txt.text.length)
			{
				var regExp:RegExp = new RegExp("([0-9a-zA-Z]+[-._+&])*[0-9a-zA-Z]+@([-0-9a-zA-Z]+[.])+[a-zA-Z]{2,6}", "ig");
				var result:* = regExp.exec(txt.text);
				
				if (result == null || (result && result.index))
					isValid = false;
				
				if (regExp.lastIndex < txt.text.length)
					isValid = false;
			}
			else
				isValid = false;
			
			return isValid;
		}
		//Tahir Alvi - examine the two date first one(Start Date) is always lower to end date(Expiry Date)
		public static function validateExpiryDate(date1:Date, date2:Date):Boolean
		{
			//return True  - means that start date is lower than end date
			//return false - means that end date is lower than strat date
			return (date1.time < date2.time);
			
		}
		public static function isValidPhone( txt:String ):Boolean
		{
			if( ! isValidPhoneNoFormat( txt ) )
			{
				/*Alert.show("please provide valid phone number.","phone number", 4, FlexGlobals.topLevelApplication.mainContainer, function(event:Event):void{
				txt.setFocus();
				});*/
				return false;
			}
			return true;
		}
		public static function isValidPhoneNoFormat(txt:String):Boolean
		{
			var objPhone:String = txt;
			var re:RegExp = new RegExp("^\\(?(\\d{3})\\)?[- ]?(\\d{3})[- ]?(\\d{4})$");
			var m:* = re.exec(objPhone);
			
			if (m == null && objPhone != '') 
			{
				re = new RegExp("^[0-9]*$"); // /^\d{20}$/ ^\d{1,5}
				m = re.exec(objPhone);
				
				if (objPhone.length < 10)
					m = null;
			}
			
			return m != null;
		}
	}
}