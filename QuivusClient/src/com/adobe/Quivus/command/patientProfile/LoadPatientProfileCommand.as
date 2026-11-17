package com.adobe.Quivus.command.patientProfile
{
	import com.adobe.Quivus.delegate.patientProfile.LoadPatientProfileDelegate;
	import com.adobe.Quivus.events.patientProfile.LoadPatientProfileEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.AppUtils;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.Quivus.utils.DTOInitializationUtility;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.Quivus.utils.QuivusCombineEventDispatcher;
	import com.adobe.Quivus.utils.ValidationUtils;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;
	
	
	public class LoadPatientProfileCommand  implements com.adobe.cairngorm.commands.Command, IResponder 
	{
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			if(model.UserLoggedIn)
			{
				var delegate : LoadPatientProfileDelegate = new LoadPatientProfileDelegate( this );
				var LE:LoadPatientProfileEvent = cgEvent as LoadPatientProfileEvent;
				
				if(LE!=null && LE.patientId>0)
				{
					delegate.LoadPatientProfile(LE.patientId,
						model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq
						,model.loggedInUserDTO.UserId,model.sessionDTO);
				}
			}
		}
		
		
		public function result( rpcEvent : Object ) : void 
		{
			var re:ResultEvent = rpcEvent as ResultEvent;
			var patientProfileResponse:PatientProfileResponse = re.result as PatientProfileResponse;
			
			DTOInitializationUtility.initializePatientProfileDTOs();//initlize every thing(DTO's & Arrays)
			
			if(patientProfileResponse!=null)
			{
				if(patientProfileResponse.ResponseStatus)
				{
					var patientProfileDTO:PatientProfileDTO 		= patientProfileResponse.PatientProfileResponseData;
					if(patientProfileDTO!=null)
					{
						
						model.patientProfileDTO                     = patientProfileDTO;
						
						//by shahid munir
						if(model.patientProfileDTO.UserDTO.Gender.GenderName.substring(0,1).toUpperCase() == "F" )
							model.isPatientFemale = true;
						else
							model.isPatientFemale = false;
						
						model.EDItimelyFilingIndicator 				= setEDIDelayReason(model.patientProfileDTO._PatientDTO.DelayReasonCodeTypeID);
						model.EDIexceptionCode 						= setEDIExceptionCode(model.patientProfileDTO._PatientDTO.ExceptionCodeTypeID);
						
						model.basicUserDTO		  					= model.patientProfileDTO.UserDTO;
						model.patientDTO							= model.patientProfileDTO._PatientDTO;
						model.patientUserId							= model.patientProfileDTO.UserDTO.UserId;
						model.patientId								= model.patientProfileDTO._PatientDTO.PatientId;
						model.addressBookDTO						= model.patientProfileDTO.PatientAddressBook;
						
						model.healthHX								= new PatientHealthDTO();
						//						model.healthHX.PatientAllergyDTOList 		= model.patientProfileDTO.PatientAllergyList;
						model.healthHX.PatientFamilyHistoryDTOList 	= model.patientProfileDTO.PatientFamilyHistoryList;
						model.healthHX.PatientMedicalHistoryDTOList = model.patientProfileDTO.PatientMedicalHistoryList;
						model.patientLanguageDTOList				= model.patientProfileDTO.PatientLanguageList;
						
						model.patientGuarantorDTOList				= model.patientProfileDTO.PatientGurantor;
						model.patientInsuranceDTOList				= model.patientProfileDTO.PatientInsuranceList;
						model.patientEmergencyContactDTOList		= model.patientProfileDTO.PatientEmergencyContactList ;
						
						if(model.patientProfileDTO.PatientLanguageList.length)
							populatePatientLanguage();
						
						populatePatientAddress();		// populate patient address
						populatePatientPhoneList();		// populate patient phone list
						populatePatientName();			// populate name list
						setPatientSSN();					// set SSN 
						
						model.patientEmergencyContactDTO 			= new PatientEmergencyContactDTO();
						model.patientLanguageDTO 					= new PatientLanguageDTO();
						
						if(model.patientProfileDTO.PatientEmergencyContactList!= null && model.patientProfileDTO.PatientEmergencyContactList.length>0 )
						{
							model.patientEmergencyContactDTO		= model.patientProfileDTO.PatientEmergencyContactList.getItemAt(0) as PatientEmergencyContactDTO;
						}
						
						if(model.patientProfileDTO.PatientLanguageList!=null && model.patientProfileDTO.PatientLanguageList.length>0 )
						{
							model.patientLanguageDTO 				= model.patientProfileDTO.PatientLanguageList.getItemAt(0) as PatientLanguageDTO;
							
							var countryId:int;
							if( model.patientLanguageDTO.Country 	!= null)
							{
								countryId = model.patientLanguageDTO.Country.CountryID;
								
								var i:int;
								if(model.addressBookStaticDataDTO !=	null)
								{
									if(model.addressBookStaticDataDTO.AllCountryList!=null){
										
										for(i=0;i<model.addressBookStaticDataDTO.AllCountryList.length;i++)
										{
											if((model.addressBookStaticDataDTO.AllCountryList.getItemAt(i) as CountryDTO).CountryID == countryId)
											{
												model.patientLanguageDTO.Country.CountryName = (model.addressBookStaticDataDTO.AllCountryList.getItemAt(i) as CountryDTO).CountryName;
												break;
											}
										}
									}
								}
							}// end of country fetching block
						}
						
						QuivusCombineEventDispatcher.dispatchEventsAfterPatientLoad();
						
						if(QuivusCombineEventDispatcher.patientLoadedCallBackFunction())
						{
							QuivusCombineEventDispatcher.patientLoadedCallBackFunction();
						}
					}
					else
					{
						Alert.show("LoadPatientProfile"+"\n"+Messages.NO_DATA_RETURNED_FROM_SERVICE, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					model.errorStatus = patientProfileResponse.ResponseMessage ;
					var valid:Boolean = QSUtilityFunctions.checkSession(patientProfileResponse.ResponseCode);
					if(valid)
						Alert.show("LoadPatientProfile"+"\n"+patientProfileResponse.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
			else
			{
				Alert.show("LoadPatientProfile"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
			}
		}
		// -------------------- Service fault Mathod -------------------------------------------------
		public function fault( rpcEvent : Object ) : void 
		{
			model.errorStatus = "Fault occured in LoadPatientProfileCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
		}
		//------------------- populate data functions ---------------------------------------------------
		public function populatePatientAddress(  ) : void {
			
			if(model.patientProfileDTO.PatientAddressBook!=null)
			{
				if(model.patientProfileDTO.PatientAddressBook.PhoneDTOlist!= null && model.patientProfileDTO.PatientAddressBook.PhoneDTOlist.length>0)
				{
					var i:int;
					for(i=0;i<model.patientProfileDTO.PatientAddressBook.PhoneDTOlist.length;i++)
					{
						var phoneDTO:PhoneDTO = model.patientProfileDTO.PatientAddressBook.PhoneDTOlist.getItemAt(i) as PhoneDTO;
						if(phoneDTO.IsPrimary)
						{
							if(phoneDTO.OwnerTypeID == Constants.SELF_OWNER_TYPE_ID){
								model.patientPrimaryPhoneDTO = phoneDTO;
							}
							else if(phoneDTO.OwnerTypeID == Constants.MOTHER_OWNER_TYPE_ID)
							{
								model.motherPrimaryPhoneDTO = phoneDTO;
							}
							else if(phoneDTO.OwnerTypeID == Constants.FATHER_OWNER_TYPE_ID)
							{
								model.fatherPrimaryPhoneDTO = phoneDTO;
							}
						}
					}
				}
				
				if(model.patientProfileDTO.PatientAddressBook.AddressDTOlist!= null && model.patientProfileDTO.PatientAddressBook.AddressDTOlist.length>0)
				{
					
					model.patientAddressDTO = model.patientProfileDTO.PatientAddressBook.AddressDTOlist.getItemAt(0) as AddressDTO;
				}
			}
		}
		//Add the Patient all personal phone into a list for show in basic section profile popup.
		private function populatePatientPhoneList( ) : void 
		{
			if(model.patientProfileDTO.PatientAddressBook!=null)
			{
				if(model.patientProfileDTO.PatientAddressBook.PhoneDTOlist!= null && model.patientProfileDTO.PatientAddressBook.PhoneDTOlist.length>0)
				{
					model.patientPhoneList = new ArrayCollection();
					for(var i:int=0; i<model.patientProfileDTO.PatientAddressBook.PhoneDTOlist.length; i++)
					{
						var phoneDTO:PhoneDTO = model.patientProfileDTO.PatientAddressBook.PhoneDTOlist.getItemAt(i) as PhoneDTO;
						if(phoneDTO.OwnerTypeID == Constants.SELF_OWNER_TYPE_ID){
							model.patientPhoneList.addItem(phoneDTO);
						}
					}
				}
			}
		}
		//for show in basic section
		private function  populatePatientLanguage():void
		{
			if(model.patientProfileDTO.PatientLanguageList && model.patientProfileDTO.PatientLanguageList.length)
			{
				var pl:PatientLanguageDTO = model.patientProfileDTO.PatientLanguageList.getItemAt( 0 ) as PatientLanguageDTO;
				
				var list:ArrayCollection = model.registrationStaticDataDTO.LanguageTypes;
				
				var i:int;
				for( i = 0; i < list.length; i++ )
				{
					var type:LanguageTypeDTO = list[ i ] as LanguageTypeDTO;
					if( type.LanguageID == pl.LanguageID )
					{
						model.patientlanguage = type.LanguageName;
						break;
					}
				}
				
			}
		}
		
		private function populatePatientName():void
		{
			model.patientName = '';
			if(model.basicUserDTO.FirstName.toLowerCase() != 'null' )
				model.patientName = model.basicUserDTO.FirstName;
			
			if(model.basicUserDTO.MiddleName)
			{
				if(model.basicUserDTO.MiddleName.toLowerCase() != 'null' )
					model.patientName = model.patientName+' '+ model.basicUserDTO.MiddleName;
			}
			
			if(model.basicUserDTO.LastName.toLowerCase() != 'null' )
				model.patientName = model.patientName+' '+model.basicUserDTO.LastName;
		}
		
		//by shahid munir
		private function setEDIDelayReason(typeID:int):String
		{
			var reason:String = "";
			switch(typeID)
			{
				case 1:					
					reason = "1 - Proof of Eligibility Unknown or Unavailable";	break;
				case 2:					
					reason = "2 - Litigation";	break;
				case 3:					
					reason = "3 - Authorization Delays";	break;
				case 4:					
					reason = "4 - Delay in Certifying Provider";	break;
				case 5:					
					reason = "5 - Delay in Supplying Billing Forms";	break;
				case 6:					
					reason = "6 - Delay in Delivery of Custom-made Appliances";	break;
				case 7:					
					reason = "7 - Third Party Processing Delay";	break;
				case 8:					
					reason = "8 - Delay in Eligibility Determination";	break;
				case 9:					
					reason = "9 - Original Claim Rejected or Denied Due to a Reason Unrelated to the Billing Limitation Rules";	break;
				case 10:					
					reason = "10 - Administration Delay in the Prior Approval Process";	break;
				case 11:					
					reason = "11 - Other";	break;
				case 12:					
					reason = "15 - Natural Disaster";	break;			
			}
			
			return reason;
		}
		
		//by shahid munir
		private function setEDIExceptionCode(typeID:int):String
		{
			var exceptionCode:String = "";
			switch(typeID)
			{
				case 1:					
					exceptionCode = "1 - Immediate/Urgent Care";	break;
				case 2:					
					exceptionCode = "2 - Services Rendered in a Retroactive Period";	break;
				case 3:					
					exceptionCode = "3 - Emergency Care";	break;
				case 4:					
					exceptionCode = "4 - Client has Temporary Medicaid";	break;
				case 5:					
					exceptionCode = "5 - Request from County for Second Opinion to Determine if Recipient Can Work";	break;
				case 6:					
					exceptionCode = "6 - Request for Override Pending";	break;
				case 7:					
					exceptionCode = "7 - Special Handling";	break;							
			}
			
			return exceptionCode;
		}
		/**
		 * For Display the SSN or Other ID in Patient Profile Basic Section.
		 * 
		 * */
		protected function setPatientSSN():void
		{
			model.patientSSN = '';
			if( ! AppUtils.IsNullOrEmpty( model.patientProfileDTO.UserDTO.SSN ) || ! AppUtils.IsNullOrEmpty( model.patientProfileDTO.UserDTO.OtherID ))
			{
				if(model.patientProfileDTO.UserDTO.IsSSNSelected)
				{
					var val:String  = model.patientProfileDTO.UserDTO.SSN;
					if(model.patientProfileDTO.UserDTO.SSN.length <= 9)
					{
						model.patientSSN = ValidationUtils.setSSNMasking(model.patientProfileDTO.UserDTO.SSN)
					}else
					{
						model.patientSSN 	= model.patientProfileDTO.UserDTO.SSN;
					}
				}else
				{
					model.patientSSN = model.patientProfileDTO.UserDTO.OtherID;
				}
			}
		}
	}
}