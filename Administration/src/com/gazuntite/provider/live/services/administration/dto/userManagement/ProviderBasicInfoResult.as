package com.gazuntite.provider.live.services.administration.dto.userManagement
{
	///Added by zahid
	import com.gazuntite.common.dto.ProviderSearchDTO;
	import com.gazuntite.common.util.xml.XmlUtils;
	import com.gazuntite.utils.UtilityFunctions;
	
	import flash.utils.ByteArray;
	import flash.xml.XMLDocument;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Image;
	import mx.rpc.xml.SimpleXMLDecoder;
	import mx.utils.Base64Decoder;

	[Bindable]
	public class ProviderBasicInfoResult
	{
		public function ProviderBasicInfoResult()
		{
		}
		
		private var _userID				:int;
		private var _SSN				:String;
		private var _Gender				:String;
		private var _LicenseNumber				:String;
		private var _EIN				:String;
		private var _NPI				:String;
		private var _DAE				:String;
		private var _UPIN				:String;
		private var _TPI				:String;
		private var _WorkDays				:String;
		private var _WorkStart				:String;
		private var _WorkEnd				:String;
		private var _FederalTaxId				:String;
		private var _ImageData				:String;
		private var _Phone				:String;
		private var _State				:String;
		private var _Address				:String;
		private var _City				:String;
		private var _Zip				:String;
		private var _PrefixTypeID				:String;
		private var _FirstName				:String;
		private var _LastName				:String;
		private var _MiddleName				:String;
		private var _Suffix				:String;
		private var _UserEmail				:String;
		private var _Title				:String;
		private var _sessionStatus		:String;
		private var _EUserName: String;
		private var _EPassword: String;
		private var _GAXENID: String;
		private var _FaxNumber:String;
		
		//on 07/04/2012: Shahid Munir, added billing detail fields
		
		private var _CLIANumber:String;
		private var _IsHospice:String;
		private var _SignatureOnFile:String;
		private var _SignatureDate:String;
		private var _IsParticipating:String;
		private var _StopSubmission:String;
		
		public function get CLIANumber():String
		{
			return _CLIANumber;
		}
		
		public function set CLIANumber(value:String):void
		{
			_CLIANumber = value;
		}
		
		public function get IsHospice():String
		{
			return _IsHospice;
		}
		
		public function set IsHospice(value:String):void
		{
			_IsHospice = value;
		}
		
		public function get SignatureOnFile():String
		{
			return _SignatureOnFile;
		}
		
		public function set SignatureOnFile(value:String):void
		{
			_SignatureOnFile = value;
		}
		
		public function get SignatureDate():String
		{
			return _SignatureDate;
		}
		
		public function set SignatureDate(value:String):void
		{
			//_SignatureDate = UtilityFunctions.FormatDate(value.substring(0,10),"MM/DD/YYYY");
			_SignatureDate = value;
		}
		
		public function get IsParticipating():String
		{
			return _IsParticipating;
		}
		
		public function set IsParticipating(value:String):void
		{
			_IsParticipating = value;
		}
		
		public function get StopSubmission():String
		{
			return _StopSubmission;
		}
		
		public function set StopSubmission(value:String):void
		{
			_StopSubmission = value;
		}
		
		
		public function get FaxNumber():String
		{
			return _FaxNumber;
		}

		public function set FaxNumber(value:String):void
		{
			_FaxNumber = value;
		}

		public function get GAXENID():String
		{
			return _GAXENID;
		}

		public function set GAXENID(value:String):void
		{
			_GAXENID = value;
		}

		public function get EPassword():String
		{
			return _EPassword;
		}

		public function set EPassword(value:String):void
		{
			_EPassword = value;
		}

		public function get EUserName():String
		{
			return _EUserName;
		}

		public function set EUserName(value:String):void
		{
			_EUserName = value;
		}

		public function get userID():int
		{
			return _userID;
		}
		
		public function set userID(value:int):void
		{
			_userID = value;
		}
		
		public function get SSN():String
		{
			return _SSN;
		}
		
		public function set SSN(value:String):void
		{
			_SSN = value;
		}
		
		public function get Gender():String
		{
			return _Gender;
		}
		
		public function set Gender(value:String):void
		{
			_Gender = value;
		}
		
		public function get LicenseNumber():String
		{
			return _LicenseNumber;
		}
		
		public function set LicenseNumber(value:String):void
		{
			_LicenseNumber = value;
		}
		
		public function get EIN():String
		{
			return _EIN;
		}
		
		public function set EIN(value:String):void
		{
			_EIN = value;
		}
		
		public function get NPI():String
		{
			return _NPI;
		}
		
		public function set NPI(value:String):void
		{
			_NPI = value;
		}
		
		public function get DAE():String
		{
			return _DAE;
		}
		
		public function set DAE(value:String):void
		{
			_DAE = value;
		}
		
		public function get UPIN():String
		{
			return _UPIN;
		}
		
		public function set UPIN(value:String):void
		{
			_UPIN = value;
		}
		
		public function get TPI():String
		{
			return _TPI;
		}
		
		public function set TPI(value:String):void
		{
			_TPI = value;
		}
		
		public function get WorkDays():String
		{
			return _WorkDays;
		}
		
		public function set WorkDays(value:String):void
		{
			_WorkDays = value;
		}
		
		public function get WorkStart():String
		{
			return _WorkStart;
		}
		
		public function set WorkStart(value:String):void
		{
			_WorkStart = value;
		}
		
		public function get WorkEnd():String
		{
			return _WorkEnd;
		}
		
		public function set WorkEnd(value:String):void
		{
			_WorkEnd = value;
		}
		
		public function get FederalTaxId():String
		{
			return _FederalTaxId;
		}
		
		public function set FederalTaxId(value:String):void
		{
			_FederalTaxId = value;
		}
		
		public function get ImageData():String
		{
			return _ImageData;
		}
		
		public function set ImageData(value:String):void
		{
			_ImageData = value;
		}
		
		public function get Phone():String
		{
			return _Phone;
		}
		
		public function set Phone(value:String):void
		{
			_Phone = value;
		}
		
		public function get State():String
		{
			return _State;
		}
		
		public function set State(value:String):void
		{
			_State = value;
		}
		
		public function get Address():String
		{
			return _Address;
		}
		
		public function set Address(value:String):void
		{
			_Address = value;
		}
		
		public function get City():String
		{
			return _City;
		}
		
		public function set City(value:String):void
		{
			_City = value;
		}
		
		public function get Zip():String
		{
			return _Zip;
		}
		
		public function set Zip(value:String):void
		{
			_Zip = value;
		}
		
		public function get PrefixTypeID():String
		{
			return _PrefixTypeID;
		}
		
		public function set PrefixTypeID(value:String):void
		{
			_PrefixTypeID = value;
		}
		
		public function get FirstName():String
		{
			return _FirstName;
		}
		
		public function set FirstName(value:String):void
		{
			_FirstName = value;
		}
		
		public function get LastName():String
		{
			return _LastName;
		}
		
		public function set LastName(value:String):void
		{
			_LastName = value;
		}
		
		public function get MiddleName():String
		{
			return _MiddleName;
		}
		
		public function set MiddleName(value:String):void
		{
			_MiddleName = value;
		}
		
		public function get Suffix():String
		{
			return _Suffix;
		}
		
		public function set Suffix(value:String):void
		{
			_Suffix = value;
		}
		
		public function get UserEmail():String
		{
			return _UserEmail;
		}
		
		public function set UserEmail(value:String):void
		{
			_UserEmail = value;
		}
		
		public function get Title():String
		{
			return _Title;
		}
		
		public function set Title(value:String):void
		{
			_Title = value;
		}
		
		public function get sessionStatus():String
		{
			return _sessionStatus;
		}
		
		public function set sessionStatus(value:String):void
		{
			_sessionStatus = value;
		}
		
		
		public function FromXML(x:XML):void
		{	
			var xmlDoc:XMLDocument = new XMLDocument(x);
			var decoder:SimpleXMLDecoder = new SimpleXMLDecoder(true);
			var resultObj:Object = decoder.decodeXML(xmlDoc);
			var i:int = 0;
			//var objProviderSearchDetails:ProviderSearchDTO=new ProviderSearchDTO();
			
			/*for( i = 0; i < resultObj.ArrayOfContactSearchDTO.ContactSearchDTO.length; i++ )
			{
			*/
			if(resultObj.ClinicProviderSearchDTO.FirstName != null)
				FirstName=resultObj.ClinicProviderSearchDTO.FirstName;
			else
				FirstName="";
			if(resultObj.ClinicProviderSearchDTO.LastName != null)
				LastName=resultObj.ClinicProviderSearchDTO.LastName;
			else
				LastName="";
			if(resultObj.ClinicProviderSearchDTO.MiddleName != null)
				MiddleName=resultObj.ClinicProviderSearchDTO.MiddleName;
			else
				MiddleName="";
			
			if(resultObj.ClinicProviderSearchDTO.EIN != null)
				EIN = resultObj.ClinicProviderSearchDTO.EIN;
			else
				EIN = "";
			if(resultObj.ClinicProviderSearchDTO.DAE != null)
				DAE = resultObj.ClinicProviderSearchDTO.DAE;
			else
				DAE = "";
			if(resultObj.ClinicProviderSearchDTO.ImageData != null)
			{
				//var arr:ByteArray = new ByteArray();
				//arr.writeObject(resultObj.ClinicProviderSearchDTO.ImageData);
	//Start - Tahir Alvi	
	//No need to convert the base64 string here
	// we convert it when we assign it to an image source as bytearray			
				/*var base64Dec:Base64Decoder;
				base64Dec = new Base64Decoder();
				base64Dec.decode(resultObj.ClinicProviderSearchDTO.ImageData.toString());
				ImageData = base64Dec.toByteArray();*/
				ImageData = resultObj.ClinicProviderSearchDTO.ImageData;
   //End - Tahir Alvi			
				//ImageData = arr;
			}
			
			if(resultObj.ClinicProviderSearchDTO.FederalTaxId != null)
				FederalTaxId=resultObj.ClinicProviderSearchDTO.FederalTaxId;
			else
				FederalTaxId="";
			if(resultObj.ClinicProviderSearchDTO.GenderName != null)
				Gender=resultObj.ClinicProviderSearchDTO.GenderName;
			else
				Gender="";
			if(resultObj.ClinicProviderSearchDTO.City != null)
				City=resultObj.ClinicProviderSearchDTO.City;
			else
				City="";
			if(resultObj.ClinicProviderSearchDTO.State != null)
				State=resultObj.ClinicProviderSearchDTO.State;
			else
				State="";
			if(resultObj.ClinicProviderSearchDTO.Zip != null)
				Zip=resultObj.ClinicProviderSearchDTO.Zip;
			else
				Zip="";
			if(resultObj.ClinicProviderSearchDTO.SSN != null)
				SSN=resultObj.ClinicProviderSearchDTO.SSN;
			else
				SSN="";
			if(resultObj.ClinicProviderSearchDTO.WorkDays != null)
				WorkDays=resultObj.ClinicProviderSearchDTO.WorkDays;
			else
				WorkDays="";
			if(resultObj.ClinicProviderSearchDTO.WorkEnd != null)
				WorkEnd=resultObj.ClinicProviderSearchDTO.WorkEnd;
			else
				WorkEnd="";
			if(resultObj.ClinicProviderSearchDTO.WorkStart != null)
				WorkStart=resultObj.ClinicProviderSearchDTO.WorkStart;
			else
				WorkStart="";
			if(resultObj.ClinicProviderSearchDTO.Address != null)
				Address=resultObj.ClinicProviderSearchDTO.Address;
			else
				Address="";
			if(resultObj.ClinicProviderSearchDTO.UPIN != null)
				UPIN=resultObj.ClinicProviderSearchDTO.UPIN;
			else
				UPIN="";
			if(resultObj.ClinicProviderSearchDTO.TPI != null)
				TPI=resultObj.ClinicProviderSearchDTO.TPI;
			else
				TPI="";
			if(resultObj.ClinicProviderSearchDTO.Phone != null)
				Phone=resultObj.ClinicProviderSearchDTO.Phone;
			else
				Phone="";
			if(resultObj.ClinicProviderSearchDTO.LicenseNumber != null)
				LicenseNumber=resultObj.ClinicProviderSearchDTO.LicenseNumber;
			else
				LicenseNumber="";
			if(resultObj.ClinicProviderSearchDTO.NPI != null)
			NPI = resultObj.ClinicProviderSearchDTO.NPI;// Address;
			else
				NPI="";
			
			if(resultObj.ClinicProviderSearchDTO.UserEmail != null)
				UserEmail=resultObj.ClinicProviderSearchDTO.UserEmail;
			else
				UserEmail="";
			
			if(resultObj.ClinicProviderSearchDTO.UserId != null)
				userID=resultObj.ClinicProviderSearchDTO.UserId;
			
			if(resultObj.ClinicProviderSearchDTO.Title != null)
				Title = resultObj.ClinicProviderSearchDTO.Title;
			
			if(resultObj.ClinicProviderSearchDTO.EUserName != null)
				EUserName = resultObj.ClinicProviderSearchDTO.EUserName;
			
			
			if(resultObj.ClinicProviderSearchDTO.EPassword != null)
				EPassword = resultObj.ClinicProviderSearchDTO.EPassword;
			
			if(resultObj.ClinicProviderSearchDTO.GAXENID != null)
				GAXENID = resultObj.ClinicProviderSearchDTO.GAXENID;
			
			
			if(resultObj.ClinicProviderSearchDTO.FaxNumber != null)
				FaxNumber = resultObj.ClinicProviderSearchDTO.FaxNumber;
			
			if(resultObj.ClinicProviderSearchDTO.Suffix != null)
				Suffix = resultObj.ClinicProviderSearchDTO.Suffix;
			
			
			if(resultObj.ClinicProviderSearchDTO.PrefixTypeID != null)
				PrefixTypeID = resultObj.ClinicProviderSearchDTO.PrefixTypeID;
			
			
			
			if(resultObj.ClinicProviderSearchDTO.USER_STATUS_DESCRIPTION != null)
				sessionStatus = resultObj.ClinicProviderSearchDTO.USER_STATUS_DESCRIPTION;
			else
				sessionStatus = "Offline";
			
			//on 07/04/2012: Shahid Mnuir, provider/nurse practioner billing detail fields
			
			if(resultObj.ClinicProviderSearchDTO.CLIANumber != null)
				CLIANumber = resultObj.ClinicProviderSearchDTO.CLIANumber;
			
			if(resultObj.ClinicProviderSearchDTO.IsHospiceEmployee != null)
				IsHospice = resultObj.ClinicProviderSearchDTO.IsHospiceEmployee;
			
			if(resultObj.ClinicProviderSearchDTO.SignatureOnFile != null)
				SignatureOnFile = resultObj.ClinicProviderSearchDTO.SignatureOnFile;
	
			if(SignatureOnFile == "true" && resultObj.ClinicProviderSearchDTO.SignatureDate != null)
				SignatureDate = resultObj.ClinicProviderSearchDTO.SignatureDate;
			else
				SignatureDate = "";
			
			if(resultObj.ClinicProviderSearchDTO.IsMedicareParticipating != null)
				IsParticipating = resultObj.ClinicProviderSearchDTO.IsMedicareParticipating;
			
			if(resultObj.ClinicProviderSearchDTO.StopSubmission != null)
				StopSubmission = resultObj.ClinicProviderSearchDTO.StopSubmission;
			
			//FirstName = resultObj.ContactSearchDTO.FirstName;
			/*p.UserId= resultObj.ArrayOfContactSearchDTO.ContactSearchDTO[i].UserId;
			p.FirstName 	= resultObj.ArrayOfContactSearchDTO.ContactSearchDTO[i].FirstName;
			p.LastName 	= resultObj.ArrayOfContactSearchDTO.ContactSearchDTO[i].LastName;
			p.MiddleName 	= resultObj.ArrayOfContactSearchDTO.ContactSearchDTO[i].MiddleName
			providers.addItem( p );*/
			//}
			
			
		}
	}
}