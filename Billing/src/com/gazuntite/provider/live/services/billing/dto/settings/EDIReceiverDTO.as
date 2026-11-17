package com.gazuntite.provider.live.services.billing.dto.settings
{
	import com.gazuntite.common.util.xml.XmlUtils;
	[Bindable]
	public class EDIReceiverDTO
	{
		private var m_sEDIReceiverID:String;
		private var m_sName:String;
		private var m_sAddress:String;
		private var m_sCity:String;
		private var m_sState:String;
		private var m_sZIP:String;
		private var m_sPhone1:String;
		private var m_sExtension:String;
		private var m_sPhone2:String;
		private var m_sFAX:String;
		private var m_sEmail:String;
		private var m_sWebAddress:String;
		private var m_sContactPerson:String;
		private var m_sComment:String;
		private var m_sDialingPrefix:String;
		private var m_sDialingSuffix:String;
		private var m_sDataPhone:String;
		private var m_sSerialPortTypeID:String;
		private var m_sBaudRateTypeID:String;
		private var m_sTransmitProtocolTypeID:String;
		private var m_sParityTypeID:String;
		private var m_sModemInitialization:String;
		private var m_sModemTermination:String;
		private var m_sDataBits:String;
		private var m_sStopBits:String;
		private var m_sFTPAddress:String;
		private var m_sFTPPortNumber:String;
		private var m_sDialingAttempt:String;
		private var m_sTransmissionMode:String;
		private var m_sSubmitterID1:String;
		private var m_sSubmitterID2:String;
		private var m_sSubmitterPassword1:String;
		private var m_sSubmitterPassword2:String;
		private var m_sProgramFile:String;
		private var m_sFilePath:String;
		private var m_sFileName:String;
		private var m_sInterchangeReceiverID:String;
		private var m_sInterchangeSenderID:String;
		private var m_sVendorID:String;
		private var m_sUniqueSubmissionCount:String;
		private var m_sFileNameID:String;
		private var m_sOfficeContact:String;
		private var m_sApplicationReceiverCode:String;
		private var m_sApplicationSenderCode:String;
		private var m_sRegion:String;
		private var m_sReceiverType:String;
		private var m_sReportFileType:String;
		private var m_sJulianDate:String;
		private var m_sParticipating:String;
		private var m_sCodeMatch:String;
		private var m_sExtra1:String;
		private var m_sExtra2:String;
		private var m_sExtra3:String;
		private var m_sGroupCodeTypeID:String;
		private var m_sReasonCodes:String;
		private var m_sCreatedBy:String;
		private var m_sModifiedBy:String;
		private var m_sIsDeleted:String;
		private var m_sInactive:String;
		private var m_sSNo:String;

		public function get SNo():String
		{
			return m_sSNo;
		}

		public function set SNo(value:String):void
		{
			m_sSNo = value;
		}

		public function get TransmitProtocolTypeID():String
		{
			return m_sTransmitProtocolTypeID;
		}

		public function set TransmitProtocolTypeID(value:String):void
		{
			m_sTransmitProtocolTypeID = value;
		}

		public function get Inactive():String
		{
			return m_sInactive;
		}

		public function set Inactive(value:String):void
		{
			m_sInactive = value;
		}

						
		public function get Extension():String
		{
			return m_sExtension;
		}

		public function set Extension(value:String):void
		{
			m_sExtension = value;
		}

		public function FromXML( x:XML ):void
		{
			SNo											= x.@["SNo"];
			EDIReceiverID 							    = x.@["EDIReceiverID"];	
			Address 							    	= x.@["Address"];
			ApplicationReceiverCode 					= x.@["ApplicationReceiverCode"];
			ApplicationSenderCode 					    = x.@["ApplicationSenderCode"];
			BaudRateTypeID 							    = x.@["BaudRateTypeID"];
			City 							    		= x.@["City"];
			CodeMatch 							    	= x.@["CodeMatch"];
			Comment 							   		= x.@["Comment"];
			ContactPerson 							    = x.@["ContactPerson"];
			CreatedBy 							    	= x.@["CreatedBy"];
			DataBits 							    	= x.@["DataBits"];
			DataPhone 							    	= x.@["DataPhone"];
			DialingAttempt 							    = x.@["DialingAttempt"];
			DialingPrefix 							    = x.@["DialingPrefix"];
			DialingSuffix 							    = x.@["DialingSuffix"];
			Email 							    		= x.@["Email"];
			Extension 							    	= x.@["Extension"];
			Extra1 							   	 		= x.@["Extra1"];
			Extra2 							    		= x.@["Extra2"];
			Extra3							    		= x.@["Extra3"];
			FAX 							    		= x.@["FAX"];
			FileName 							    	= x.@["FileName"];
			FileNameID 							    	= x.@["FileNameID"];
			FilePath 							    	= x.@["FilePath"];
			FTPAddress 							    	= x.@["FTPAddress"];
			FTPPortNumber 							    = x.@["FTPPortNumber"];
			GroupCodeTypeID 							= x.@["GroupCodeTypeID"];
			Inactive 							    	= x.@["Inactive"];
			InterchangeReceiverID 						= x.@["InterchangeReceiverID"];
			InterchangeSenderID 						= x.@["InterchangeSenderID"];
			IsDeleted 							    	= x.@["IsDeleted"];
			JulianDate 							    	= x.@["JulianDate"];
			ModifiedBy 							    	= x.@["ModifiedBy"];
			Name 							   	 		= x.@["Name"];
			ParityTypeID 							    = x.@["ParityTypeID"];
			Participating 							    = x.@["Participating"];
			Phone1 							    		= x.@["Phone1"];
			Phone2 							    		= x.@["Phone2"];
			ProgramFile 							    = x.@["ProgramFile"];
			ReasonCodes 							    = x.@["ReasonCodes"];
			ReceiverType 							    = x.@["ReceiverType"];
			Region 							    		= x.@["Region"];
			ReportFileType 							    = x.@["ReportFileType"];
			SerialPortTypeID 							= x.@["SerialPortTypeID"];
			State 							    		= x.@["State"];
			StopBits 							    	= x.@["StopBits"];
			SubmitterID1 							    = x.@["SubmitterID1"];
			SubmitterID2 							    = x.@["SubmitterID2"];
			SubmitterPassword1 							= x.@["SubmitterPassword1"];
			SubmitterPassword2 							= x.@["SubmitterPassword2"];
			TransmissionMode 							= x.@["TransmissionMode"];
			TransmitProtocolTypeID 						= x.@["TransmitProtocolTypeID"];
			UniqueSubmissionCount 					    = x.@["UniqueSubmissionCount"];
			VendorID 							    	= x.@["VendorID"];
			WebAddress 							    	= x.@["WebAddress"];
			ZIP 							    		= x.@["ZIP"];
			ModemInitialization 						= x.@["ModemInitialization"];
			ModemTermination 							= x.@["ModemTermination"];
			OfficeContact 							    = x.@["OfficeContact"];
			
			
		}
		
		public function ToXML():XML
		{
			var x:XML = XmlUtils.getNodeByTagName( "EDIReceiver" );
			
			x.@["EDIReceiverID"] 	 					= EDIReceiverID;
			x.@["Address"] 	 							= Address;
			x.@["ApplicationReceiverCode"] 	 			= ApplicationReceiverCode;
			x.@["ApplicationSenderCode"] 	 			= ApplicationSenderCode;
			x.@["BaudRateTypeID"] 	 					= BaudRateTypeID;
			x.@["City"] 	 							= City;
			x.@["CodeMatch"] 	 						= CodeMatch;
			x.@["Comment"] 	 							= Comment;
			x.@["ContactPerson"] 	 					= ContactPerson;
			x.@["CreatedBy"] 	 						= CreatedBy;
			x.@["DataBits"] 	 						= DataBits;
			x.@["DataPhone"] 	 						= DataPhone;
			x.@["DialingAttempt"] 	 					= DialingAttempt;
			x.@["DialingPrefix"] 	 					= DialingPrefix;
			x.@["DialingSuffix"] 	 					= DialingSuffix;
			x.@["Email"] 	 							= Email;
			x.@["Extension"] 	 						= Extension;
			x.@["Extra1"] 	 							= Extra1;
			x.@["Extra2"] 	 							= Extra2;
			x.@["Extra3	"]								= Extra3;
			x.@["FAX"] 	 								= FAX;
			x.@["FileName"] 	 						= FileName;
			x.@["FileNameID"] 	 						= FileNameID;
			x.@["FilePath"] 	 						= FilePath;
			x.@["FTPAddress"] 	 						= FTPAddress;
			x.@["FTPPortNumber"] 	 					= FTPPortNumber;
			x.@["GroupCodeTypeID"] 	 					= GroupCodeTypeID;
			x.@["Inactive"] 	 						= Inactive;
			x.@["InterchangeReceiverID"] 	 			= InterchangeReceiverID;
			x.@["InterchangeSenderID"] 	 				= InterchangeSenderID;
			x.@["IsDeleted"] 	 						= IsDeleted;
			x.@["JulianDate"] 	 						= JulianDate;
			x.@["ModifiedBy"] 	 						= ModifiedBy;
			x.@["Name"] 	 							= Name;
			x.@["ParityTypeID"] 	 					= ParityTypeID;
			x.@["Participating"] 	 					= Participating;
			x.@["Phone1"] 	 							= Phone1;
			x.@["Phone2"] 	 							= Phone2;
			x.@["ProgramFile"] 	 						= ProgramFile;
			x.@["ReasonCodes"] 	 						= ReasonCodes;
			x.@["ReceiverType"] 	 					= ReceiverType;
			x.@["Region"] 	 							= Region;
			x.@["ReportFileType"] 	 					= ReportFileType;
			x.@["SerialPortTypeID"] 	 				= SerialPortTypeID;
			x.@["State"] 	 							= State;
			x.@["StopBits"] 	 						= StopBits;
			x.@["SubmitterID1"] 	 					= SubmitterID1;
			x.@["SubmitterID2"] 	 					= SubmitterID2;
			x.@["SubmitterPassword1"] 	 				= SubmitterPassword1;
			x.@["SubmitterPassword2"] 	 				= SubmitterPassword2;
			x.@["TransmissionMode"] 	 				= TransmissionMode;
			x.@["TransmitProtocolTypeID"] 	 			= TransmitProtocolTypeID;
			x.@["UniqueSubmissionCount"] 	 			= UniqueSubmissionCount;
			x.@["VendorID"] 	 						= VendorID;
			x.@["WebAddress"] 	 						= WebAddress;
			x.@["ZIP"] 	 								= ZIP;
			x.@["ModemInitialization"] 	 				= ModemInitialization;
			x.@["ModemTermination"] 	 				= ModemTermination;
			x.@["OfficeContact"] 	 					= OfficeContact;
			
			return x
		}
		
		public function get IsDeleted():String
		{
			return m_sIsDeleted;
		}

		public function set IsDeleted(value:String):void
		{
			m_sIsDeleted = value;
		}

		public function get ModifiedBy():String
		{
			return m_sModifiedBy;
		}

		public function set ModifiedBy(value:String):void
		{
			m_sModifiedBy = value;
		}

		public function get CreatedBy():String
		{
			return m_sCreatedBy;
		}

		public function set CreatedBy(value:String):void
		{
			m_sCreatedBy = value;
		}

		public function get ReasonCodes():String
		{
			return m_sReasonCodes;
		}

		public function set ReasonCodes(value:String):void
		{
			m_sReasonCodes = value;
		}

		public function get GroupCodeTypeID():String
		{
			return m_sGroupCodeTypeID;
		}

		public function set GroupCodeTypeID(value:String):void
		{
			m_sGroupCodeTypeID = value;
		}

		public function get Extra3():String
		{
			return m_sExtra3;
		}

		public function set Extra3(value:String):void
		{
			m_sExtra3 = value;
		}

		public function get Extra2():String
		{
			return m_sExtra2;
		}

		public function set Extra2(value:String):void
		{
			m_sExtra2 = value;
		}

		public function get Extra1():String
		{
			return m_sExtra1;
		}

		public function set Extra1(value:String):void
		{
			m_sExtra1 = value;
		}

		public function get CodeMatch():String
		{
			return m_sCodeMatch;
		}

		public function set CodeMatch(value:String):void
		{
			m_sCodeMatch = value;
		}

		public function get Participating():String
		{
			return m_sParticipating;
		}

		public function set Participating(value:String):void
		{
			m_sParticipating = value;
		}

		public function get JulianDate():String
		{
			return m_sJulianDate;
		}

		public function set JulianDate(value:String):void
		{
			m_sJulianDate = value;
		}

		public function get ReportFileType():String
		{
			return m_sReportFileType;
		}

		public function set ReportFileType(value:String):void
		{
			m_sReportFileType = value;
		}

		public function get ReceiverType():String
		{
			return m_sReceiverType;
		}

		public function set ReceiverType(value:String):void
		{
			m_sReceiverType = value;
		}

		public function get Region():String
		{
			return m_sRegion;
		}

		public function set Region(value:String):void
		{
			m_sRegion = value;
		}

		public function get ApplicationSenderCode():String
		{
			return m_sApplicationSenderCode;
		}

		public function set ApplicationSenderCode(value:String):void
		{
			m_sApplicationSenderCode = value;
		}

		public function get ApplicationReceiverCode():String
		{
			return m_sApplicationReceiverCode;
		}

		public function set ApplicationReceiverCode(value:String):void
		{
			m_sApplicationReceiverCode = value;
		}

		public function get OfficeContact():String
		{
			return m_sOfficeContact;
		}

		public function set OfficeContact(value:String):void
		{
			m_sOfficeContact = value;
		}

		public function get FileNameID():String
		{
			return m_sFileNameID;
		}

		public function set FileNameID(value:String):void
		{
			m_sFileNameID = value;
		}

		public function get UniqueSubmissionCount():String
		{
			return m_sUniqueSubmissionCount;
		}

		public function set UniqueSubmissionCount(value:String):void
		{
			m_sUniqueSubmissionCount = value;
		}

		public function get VendorID():String
		{
			return m_sVendorID;
		}

		public function set VendorID(value:String):void
		{
			m_sVendorID = value;
		}

		public function get InterchangeSenderID():String
		{
			return m_sInterchangeSenderID;
		}

		public function set InterchangeSenderID(value:String):void
		{
			m_sInterchangeSenderID = value;
		}

		public function get InterchangeReceiverID():String
		{
			return m_sInterchangeReceiverID;
		}

		public function set InterchangeReceiverID(value:String):void
		{
			m_sInterchangeReceiverID = value;
		}

		public function get FileName():String
		{
			return m_sFileName;
		}

		public function set FileName(value:String):void
		{
			m_sFileName = value;
		}

		public function get FilePath():String
		{
			return m_sFilePath;
		}

		public function set FilePath(value:String):void
		{
			m_sFilePath = value;
		}

		public function get ProgramFile():String
		{
			return m_sProgramFile;
		}

		public function set ProgramFile(value:String):void
		{
			m_sProgramFile = value;
		}

		public function get SubmitterPassword2():String
		{
			return m_sSubmitterPassword2;
		}

		public function set SubmitterPassword2(value:String):void
		{
			m_sSubmitterPassword2 = value;
		}

		public function get SubmitterPassword1():String
		{
			return m_sSubmitterPassword1;
		}

		public function set SubmitterPassword1(value:String):void
		{
			m_sSubmitterPassword1 = value;
		}

		public function get SubmitterID2():String
		{
			return m_sSubmitterID2;
		}

		public function set SubmitterID2(value:String):void
		{
			m_sSubmitterID2 = value;
		}

		public function get SubmitterID1():String
		{
			return m_sSubmitterID1;
		}

		public function set SubmitterID1(value:String):void
		{
			m_sSubmitterID1 = value;
		}

		public function get TransmissionMode():String
		{
			return m_sTransmissionMode;
		}

		public function set TransmissionMode(value:String):void
		{
			m_sTransmissionMode = value;
		}

		public function get DialingAttempt():String
		{
			return m_sDialingAttempt;
		}

		public function set DialingAttempt(value:String):void
		{
			m_sDialingAttempt = value;
		}

		public function get FTPPortNumber():String
		{
			return m_sFTPPortNumber;
		}

		public function set FTPPortNumber(value:String):void
		{
			m_sFTPPortNumber = value;
		}

		public function get FTPAddress():String
		{
			return m_sFTPAddress;
		}

		public function set FTPAddress(value:String):void
		{
			m_sFTPAddress = value;
		}

		public function get StopBits():String
		{
			return m_sStopBits;
		}

		public function set StopBits(value:String):void
		{
			m_sStopBits = value;
		}

		public function get DataBits():String
		{
			return m_sDataBits;
		}

		public function set DataBits(value:String):void
		{
			m_sDataBits = value;
		}

		public function get ModemTermination():String
		{
			return m_sModemTermination;
		}

		public function set ModemTermination(value:String):void
		{
			m_sModemTermination = value;
		}

		public function get ModemInitialization():String
		{
			return m_sModemInitialization;
		}

		public function set ModemInitialization(value:String):void
		{
			m_sModemInitialization = value;
		}

		public function get ParityTypeID():String
		{
			return m_sParityTypeID;
		}

		public function set ParityTypeID(value:String):void
		{
			m_sParityTypeID = value;
		}

		public function get BaudRateTypeID():String
		{
			return m_sBaudRateTypeID;
		}

		public function set BaudRateTypeID(value:String):void
		{
			m_sBaudRateTypeID = value;
		}

		public function get SerialPortTypeID():String
		{
			return m_sSerialPortTypeID;
		}

		public function set SerialPortTypeID(value:String):void
		{
			m_sSerialPortTypeID = value;
		}

		public function get DataPhone():String
		{
			return m_sDataPhone;
		}

		public function set DataPhone(value:String):void
		{
			m_sDataPhone = value;
		}

		public function get DialingSuffix():String
		{
			return m_sDialingSuffix;
		}

		public function set DialingSuffix(value:String):void
		{
			m_sDialingSuffix = value;
		}

		public function get DialingPrefix():String
		{
			return m_sDialingPrefix;
		}

		public function set DialingPrefix(value:String):void
		{
			m_sDialingPrefix = value;
		}

		public function get Comment():String
		{
			return m_sComment;
		}

		public function set Comment(value:String):void
		{
			m_sComment = value;
		}

		public function get ContactPerson():String
		{
			return m_sContactPerson;
		}

		public function set ContactPerson(value:String):void
		{
			m_sContactPerson = value;
		}

		public function get WebAddress():String
		{
			return m_sWebAddress;
		}

		public function set WebAddress(value:String):void
		{
			m_sWebAddress = value;
		}

		public function get Email():String
		{
			return m_sEmail;
		}

		public function set Email(value:String):void
		{
			m_sEmail = value;
		}

		public function get FAX():String
		{
			return m_sFAX;
		}

		public function set FAX(value:String):void
		{
			m_sFAX = value;
		}

		public function get Phone2():String
		{
			return m_sPhone2;
		}

		public function set Phone2(value:String):void
		{
			m_sPhone2 = value;
		}

		public function get Phone1():String
		{
			return m_sPhone1;
		}

		public function set Phone1(value:String):void
		{
			m_sPhone1 = value;
		}

		public function get ZIP():String
		{
			return m_sZIP;
		}

		public function set ZIP(value:String):void
		{
			m_sZIP = value;
		}

		public function get State():String
		{
			return m_sState;
		}

		public function set State(value:String):void
		{
			m_sState = value;
		}

		public function get City():String
		{
			return m_sCity;
		}

		public function set City(value:String):void
		{
			m_sCity = value;
		}

		public function get Address():String
		{
			return m_sAddress;
		}

		public function set Address(value:String):void
		{
			m_sAddress = value;
		}

		public function get Name():String
		{
			return m_sName;
		}

		public function set Name(value:String):void
		{
			m_sName = value;
		}

		public function get EDIReceiverID():String
		{
			return m_sEDIReceiverID;
		}

		public function set EDIReceiverID(value:String):void
		{
			m_sEDIReceiverID = value;
		}

	}
}