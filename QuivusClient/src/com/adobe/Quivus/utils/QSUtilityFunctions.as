package com.adobe.Quivus.utils
{
	import com.adobe.Quivus.command.patientProfileCustomization.ManageUserPatientProfileBarSettingCommand;
	import com.adobe.Quivus.events.authenticate.SignOutEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.patient.visit.model.QIModelLocator;
	import com.gazuntite.utils.UtilityFunctions;
	
	import flash.utils.ByteArray;
	
	import flashx.textLayout.tlf_internal;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	
	import valueObjects.AssessmentDTO;
	import valueObjects.ClinicBranchDTO;
	import valueObjects.ComprehensiveHistoryDTO;
	import valueObjects.FamilyHistoryDTO;
	import valueObjects.FamilyHistoryTypeDTO;
	import valueObjects.FollowUpMethodTypeDTO;
	import valueObjects.HPITypeDTO;
	import valueObjects.LabNatureTypeDTO;
	import valueObjects.LanguageAbilityModeDTO;
	import valueObjects.LanguageTypeDTO;
	import valueObjects.MaritalStatusTypeDTO;
	import valueObjects.MedicalHistoryDTO;
	import valueObjects.MedicalHistoryTypeDTO;
	import valueObjects.ModuleDictationDTO;
	import valueObjects.ModuleNoteDTO;
	import valueObjects.ModuleTypeDTO;
	import valueObjects.PMHDTO;
	import valueObjects.PageDTO;
	import valueObjects.PatientLanguageDTO;
	import valueObjects.PhoneDTO;
	import valueObjects.PhysicalDTO;
	import valueObjects.PhysicalMainCategoryTypeDTO;
	import valueObjects.PhysicalSubCategoryTypeDTO;
	import valueObjects.PhysicalsDTO;
	import valueObjects.QuickInputDTO;
	import valueObjects.ROSDTO;
	import valueObjects.SocialHistoryAddictionDTO;
	import valueObjects.SocialHistoryAddictionTypeDTO;
	import valueObjects.SocialHistoryDTO;
	import valueObjects.SocialHistoryUsageAmountTypeDTO;
	import valueObjects.UserTypeDTO;
	import valueObjects.VisistStakeHolderDTO;
	import valueObjects.VisitDTO;
	
	public class QSUtilityFunctions
	{
		
		
		public function QSUtilityFunctions()
		{
		}
		
		public static function getUsageAmount( UsageAmountId:int ):SocialHistoryUsageAmountTypeDTO
		{
			var i:int;
			var UsageList:ArrayCollection = AppModelLocator.getInstance().usageAmountDTOData.DrugsList;
			for( i = 0; i < UsageList.length; i ++ )
			{
				var dto:SocialHistoryUsageAmountTypeDTO = UsageList.getItemAt( i ) as SocialHistoryUsageAmountTypeDTO;
				if( dto.SocialHistoryUsageAmountID == UsageAmountId )
				{
					return dto;
				}
			}
			
			return null;
		}
		
		private static function getModuleTypeDTOByName(moduleName:String): ModuleTypeDTO
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			var dtoToReturn:ModuleTypeDTO;
			if(model.UserLoggedIn)
			{
				var i:int;
				
				for(i=0;i<model.allModulesDTOList.length;i++)
				{
					var dto:ModuleTypeDTO = model.allModulesDTOList.getItemAt(i) as ModuleTypeDTO ; 
					if(moduleName == dto.ModuleName)
					{
						dtoToReturn = dto;
						break;
					}
					
				}
				
			}
			return dtoToReturn;
		}
		
		
		
		public static function makePhoneDTO(value:Object, isPrimary:Boolean, ownerTypeID:int):PhoneDTO
		{
			var phDTO:PhoneDTO = new PhoneDTO();	
			
			if (value.hasOwnProperty("phoneNumber"))
				phDTO.PhoneNumber = value.phoneNumber;
			
			if (value.hasOwnProperty("phoneExtension"))
				phDTO.Extension = value.phoneExtension;
			
			if (value.hasOwnProperty("phoneNumberKind"))
			{
				phDTO.NumberTypeID   = value.phoneNumberKind.NumberTypeID;
				phDTO.NumberTypeName = value.phoneNumberKind.NumberTypeName;
			}
			
			if (value.hasOwnProperty("phoneID"))
				phDTO.PhoneID = value.phoneID;
			
			phDTO.IsPrimary = isPrimary;
			phDTO.OwnerTypeID = ownerTypeID;
			phDTO.CreatedAt = new Date();
			phDTO.UpdatedAt = new Date();
			
			return phDTO;
		}
		public static function makePatientLanguageDTO(value:Object):PatientLanguageDTO
		{
			var patientLangDTO:PatientLanguageDTO = new PatientLanguageDTO();

			if (value.hasOwnProperty("language") && value.language)
			{
				var langTypeDTO:LanguageTypeDTO = LanguageTypeDTO(value.language);
				patientLangDTO.LanguageID = langTypeDTO.LanguageID;
				patientLangDTO.IsDirty = true;
				//patientLangDTO.LanguageCode = langTypeDTO.LanguageCode;
				//patientLangDTO.LanguageName = langTypeDTO.LanguageName;
			}
			
			if(value.hasOwnProperty('PatientLanguageId'))
			{
				patientLangDTO.PatientLanguageId = value.PatientLanguageId;
			}
			
			if (value.hasOwnProperty("country") && value.country)
			{
				patientLangDTO.Country = value.country;//CountryDTO(value.country);
			}
			
			if (value.hasOwnProperty("abilityMode") && value.abilityMode)
			{
				patientLangDTO.PatientLanguageAbilityMode = LanguageAbilityModeDTO(value.abilityMode);
			}
			
			if (value.hasOwnProperty("isPreferred"))
			{
				patientLangDTO.IsPreffered = value.isPreferred;
			}
			
			return patientLangDTO;
		}
		public static function getModuleNoteDTO(moduleName:String): ModuleNoteDTO
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			var dtoToReturn:ModuleNoteDTO;
			if(model.UserLoggedIn)
			{
				
				
				var module:ModuleTypeDTO = getModuleTypeDTOByName(moduleName);
				if(model.quickInputDTO!=null && model.quickInputDTO.ModuleNotes!=null && model.quickInputDTO.ModuleNotes.length>0)
				{
					var i:int;
					var found:Boolean=false;
					for(i=0;i<model.quickInputDTO.ModuleNotes.length>0;i++)
					{
						var dto:ModuleNoteDTO = model.quickInputDTO.ModuleNotes.getItemAt(i) as ModuleNoteDTO ; 
						if(module.ModuleTypeId == dto.ModuleTypeId)
						{
							dtoToReturn = dto;
							found= true;
							break;
						}
					}
					if(!found)
					{
						dtoToReturn = new ModuleNoteDTO();
						dtoToReturn.ModuleTypeId = module.ModuleTypeId;
						dtoToReturn.ManagedByUserId = model.loggedInUserDTO.UserId;
						dtoToReturn.IsDeleted = false;
						dtoToReturn.VisitID = model.visitId;
						dtoToReturn.VisitDate = model.visitDTO.VisitDate;
						
						if(model.quickInputDTO.ModuleNotes==null)
							model.quickInputDTO.ModuleNotes = new ArrayCollection();
						
						model.quickInputDTO.ModuleNotes.addItem(dtoToReturn);
					}
				}
				else
				{
					dtoToReturn = new ModuleNoteDTO();
					dtoToReturn.ModuleTypeId = module.ModuleTypeId;
					dtoToReturn.ManagedByUserId = model.loggedInUserDTO.UserId;
					dtoToReturn.VisitID = model.visitId;
					dtoToReturn.VisitDate = model.visitDTO.VisitDate;
					dtoToReturn.IsDeleted = false;
					
					if(model.quickInputDTO.ModuleNotes==null)
						model.quickInputDTO.ModuleNotes = new ArrayCollection();
					
					model.quickInputDTO.ModuleNotes.addItem(dtoToReturn);
				}
				
				
				
			}
			return dtoToReturn;
		}
		
		
		public static function getModuleDictationDTO(moduleName:String): ModuleDictationDTO
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			var dtoToReturn:ModuleDictationDTO;
			if(model.UserLoggedIn)
			{
				
				
				var module:ModuleTypeDTO = getModuleTypeDTOByName(moduleName);
				if(model.quickInputDTO!=null && model.quickInputDTO.ModuleDictations!=null && model.quickInputDTO.ModuleDictations.length>0)
				{
					var i:int;
					var found:Boolean=false;
					for(i=0;i<model.quickInputDTO.ModuleDictations.length>0;i++)
					{
						var dto:ModuleDictationDTO = model.quickInputDTO.ModuleDictations.getItemAt(i) as ModuleDictationDTO ; 
						if(module.ModuleTypeId == dto.ModuleTypeID)
						{
							dtoToReturn = dto;
							found= true;
							break;
						}
					}
					if(!found)
					{
						dtoToReturn = new ModuleDictationDTO();
						dtoToReturn.ModuleTypeID = module.ModuleTypeId;
						dtoToReturn.ManagedByUserId = model.loggedInUserDTO.UserId;
						dtoToReturn.IsDeleted = false;
						dtoToReturn.VisitID = model.visitId;
						dtoToReturn.VisitDate = model.visitDTO.VisitDate;
						dtoToReturn.DictationTimeStamp= new Date();
						
						if(model.quickInputDTO.ModuleNotes==null)
							model.quickInputDTO.ModuleNotes = new ArrayCollection();
						
						model.quickInputDTO.ModuleDictations.addItem(dtoToReturn);
					}
				}
				else
				{
					dtoToReturn = new ModuleDictationDTO();
					dtoToReturn.ModuleTypeID = module.ModuleTypeId;
					dtoToReturn.ManagedByUserId = model.loggedInUserDTO.UserId;
					dtoToReturn.VisitID = model.visitId;
					dtoToReturn.VisitDate = model.visitDTO.VisitDate;
					dtoToReturn.DictationTimeStamp= new Date();
					dtoToReturn.IsDeleted = false;
					
					if(model.quickInputDTO.ModuleNotes==null)
						model.quickInputDTO.ModuleDictations = new ArrayCollection();
					
					model.quickInputDTO.ModuleDictations.addItem(dtoToReturn);
				}
				
				
				
			}
			return dtoToReturn;
		}
		
		
		public static function checkSession(code:int): Boolean
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			var valid:Boolean =true;
			if(code == Constants.SESSION_INVALID_CODE)
			{
				valid=false;
				
			}
			
			if(model.UserLoggedIn && !valid)
			{
				model.UserLoggedIn=false;
				model.quicklinkEnabled =false;
				Alert.show(Messages.SESSION_ID_VALID,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				//signOut();
				FlexGlobals.topLevelApplication.mainContainer.SignOutApplication();
			}
			return valid;
		}
		public static function signOutDueToAnotherUserLoggedIn(): void
		{	
			var model : AppModelLocator = AppModelLocator.getInstance();
			if(model!=null && model.UserLoggedIn)
			{
				model.UserLoggedIn=false;
				model.quicklinkEnabled =false;
				FlexGlobals.topLevelApplication.mainContainer.id_topBar.dispatchSignOutEvent();
			}
		}
		public static function signOut(): void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			if(!model.setAsDefault && model.userPatientProfileBarSettingTemp!=null)
			{
				ManageUserPatientProfileBarSettingCommand.setFirstSectionOldData();
				ManageUserPatientProfileBarSettingCommand.setSecondSectionOldData();
				ManageUserPatientProfileBarSettingCommand.setThirdSectionOldData();
				
				
			}
			var lpsdEvent : SignOutEvent = new SignOutEvent(model.sessionDTO);
			CairngormEventDispatcher.getInstance().dispatchEvent( lpsdEvent );
			
			model.UserLoggedIn=false;
			model.quicklinkEnabled =false;
			//FlexGlobals.topLevelApplication.mainContainer.id_topBar.dispatchSignOutEvent();
			//AppModelLocator.reSetModelInstance();
		}
		
		
		
		
		
		
		
		
		// user for comprehensive history
		public static function getGeneralSectionMedicaHistoryTypeDTOByName(name:String): MedicalHistoryTypeDTO
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			var obj:MedicalHistoryTypeDTO ;		 
			if(model.UserLoggedIn)
			{
				if(model.allGeneralHistoryTypeDTOList!=null && model.allGeneralHistoryTypeDTOList.length>0)
				{
					var i:int;
					for(i=0;i<model.allGeneralHistoryTypeDTOList.length;i++)
					{
						var dto:MedicalHistoryTypeDTO = model.allGeneralHistoryTypeDTOList.getItemAt(i) as MedicalHistoryTypeDTO ; 
						if(dto.MedicalHistoryTypeName == name)
						{
							obj = dto;
							break;
						}
					}			 
				}
			}
			return obj;
		}
		
		//##################################### for Comprehensive history NEW IMPL ########################################
		//#################################################################################################################
		//#################################################################################################################
		
		public static function getGeneralHistoryDTO(moduleName:String): MedicalHistoryDTO
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			var dtoToReturn:MedicalHistoryDTO;
			if(model.UserLoggedIn)
			{
				var module:MedicalHistoryTypeDTO = getGeneralSectionMedicaHistoryTypeDTOByName(moduleName);
				if( module && model.medicalHistoryList)
				{
					var i:int;
					var found:Boolean=false;
					for(i=0;i<model.medicalHistoryList.length>0;i++)
					{
						var dto:MedicalHistoryDTO = model.medicalHistoryList.getItemAt(i) as MedicalHistoryDTO ; 
						if(module.MedicalHistoryTypeID == dto.MedicalHistoryTypeID)
						{
							dtoToReturn = dto;
							if(dtoToReturn.PatientMedicalHistoryID==0)
							{
								dtoToReturn.CreatedBy = model.loggedInUserDTO.UserId;
								dtoToReturn.CreatedAt = new Date();
							}	
							else if(dtoToReturn.PatientMedicalHistoryID>0)
							{
								dtoToReturn.ModifiedBy = model.loggedInUserDTO.UserId;
								dtoToReturn.ModifiedAt = new Date();
							}
							
							found= true;
							break;
						}
					}
					if(!found)
					{
						dtoToReturn = new MedicalHistoryDTO();
						dtoToReturn.MedicalHistoryTypeID = module.MedicalHistoryTypeID;
						dtoToReturn.CreatedBy = model.loggedInUserDTO.UserId;
						dtoToReturn.CreatedAt = new Date();
						dtoToReturn.VisitID = model.visitId;
						dtoToReturn.ModifiedAt = Constants.NULL_DATE;
						dtoToReturn.DictationID = Constants.GUID_FORMAT;
						
						dtoToReturn.VisitDate	= Constants.NULL_DATE;
						
						//var objICDdto:ICDCodeDTO =new ICDCodeDTO();
						
						dtoToReturn.ICDCodeList =new ArrayCollection();
						
						model.medicalHistoryList.addItem(dtoToReturn);
						
					}
				}
				else if(module)
				{
					if( null == model.medicalHistoryList )
					{
						model.medicalHistoryList = new ArrayCollection();
					}
					dtoToReturn = new MedicalHistoryDTO();
					dtoToReturn.MedicalHistoryTypeID = module.MedicalHistoryTypeID;
					dtoToReturn.CreatedBy = model.loggedInUserDTO.UserId;
					dtoToReturn.CreatedAt = new Date();
					dtoToReturn.VisitID = model.visitId;
					dtoToReturn.ModifiedAt = Constants.NULL_DATE;
					dtoToReturn.DictationID = Constants.GUID_FORMAT;
					
					dtoToReturn.VisitDate	= Constants.NULL_DATE;
					
					dtoToReturn.ICDCodeList =new ArrayCollection();
					model.medicalHistoryList.addItem(dtoToReturn);
				}
				
			}
			
			return dtoToReturn;
		}
		
		public static function getFamilyHistoryDTO(moduleName:String): FamilyHistoryDTO
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			var dtoToReturn:FamilyHistoryDTO;
			if(model.UserLoggedIn)
			{
				var module:FamilyHistoryTypeDTO = getFamilyHistoryTypeDTOByName(moduleName);
				if( module && model.familyHistoryList )
				{
					var i:int;
					var found:Boolean=false;
					for( i=0; i<model.familyHistoryList.length>0; i++ )
					{
						var dto:FamilyHistoryDTO = model.familyHistoryList.getItemAt(i) as FamilyHistoryDTO ; 
						if(module.FamilyHistoryTypeID == dto.FamilyHistoryTypeID)
						{
							dtoToReturn = dto;
							if(dtoToReturn.PatientFamilyHistoryID==0)
							{
								dtoToReturn.CreatedBy = model.loggedInUserDTO.UserId;
								dtoToReturn.CreatedAt = new Date();
							}	
							else if(dtoToReturn.PatientFamilyHistoryID>0)
							{
								dtoToReturn.ModifiedBy = model.loggedInUserDTO.UserId;
								dtoToReturn.ModifiedAt = new Date();
							}
							found= true;
							break;
						}
					}
					if(!found)
					{
						dtoToReturn = new FamilyHistoryDTO();
						dtoToReturn.FamilyHistoryTypeID = module.FamilyHistoryTypeID;
						dtoToReturn.CreatedBy = model.loggedInUserDTO.UserId;
						dtoToReturn.CreatedAt = new Date();
						dtoToReturn.ModifiedAt = Constants.NULL_DATE;
						dtoToReturn.DictationID = Constants.GUID_FORMAT;
						
						dtoToReturn.VisitDate = Constants.NULL_DATE;
						dtoToReturn.PatientDiseaseList =new ArrayCollection();
						model.familyHistoryList.addItem(dtoToReturn);
						
					}
				}
				else
				{
					if( null == model.familyHistoryList )
					{
						model.familyHistoryList = new ArrayCollection();
					}
					dtoToReturn = new FamilyHistoryDTO();
					dtoToReturn.FamilyHistoryTypeID = module.FamilyHistoryTypeID;
					dtoToReturn.CreatedBy = model.loggedInUserDTO.UserId;
					dtoToReturn.CreatedAt = new Date();
					dtoToReturn.ModifiedAt = Constants.NULL_DATE;
					dtoToReturn.DictationID = Constants.GUID_FORMAT;
					
					dtoToReturn.VisitDate = Constants.NULL_DATE;
					
					
					dtoToReturn.PatientDiseaseList =new ArrayCollection();
					model.familyHistoryList.addItem(dtoToReturn);
				}
				
			}
			
			return dtoToReturn;
		}
		
		//#################################################################################################################
		//#################################################################################################################
		//##################################### for Comprehensive history NEW IMPL ######################################## 
		// for Comprehensive history general section 
		public static function getGeneralHistoryDTO_old(moduleName:String): MedicalHistoryDTO
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			var dtoToReturn:MedicalHistoryDTO;
			if(model.UserLoggedIn)
			{
				var module:MedicalHistoryTypeDTO = getGeneralSectionMedicaHistoryTypeDTOByName(moduleName);
				if(model.quickInputDTO!=null && model.quickInputDTO.PMH!=null && 
					model.quickInputDTO.PMH.ComprehensiveHistory!=null &&
					model.quickInputDTO.PMH.ComprehensiveHistory.MedicalHistory!=null && 
					model.quickInputDTO.PMH.ComprehensiveHistory.MedicalHistory.length>0)
				{
					var i:int;
					var found:Boolean=false;
					for(i=0;i<model.quickInputDTO.PMH.ComprehensiveHistory.MedicalHistory.length>0;i++)
					{
						var dto:MedicalHistoryDTO = model.quickInputDTO.PMH.ComprehensiveHistory.MedicalHistory.getItemAt(i) as MedicalHistoryDTO ; 
						if(module.MedicalHistoryTypeID == dto.MedicalHistoryTypeID)
						{
							dtoToReturn = dto;
							if(dtoToReturn.PatientMedicalHistoryID==0)
							{
								dtoToReturn.CreatedBy = model.loggedInUserDTO.UserId;
								dtoToReturn.CreatedAt = new Date();
							}	
							else if(dtoToReturn.PatientMedicalHistoryID>0)
							{
								dtoToReturn.ModifiedBy = model.loggedInUserDTO.UserId;
								dtoToReturn.ModifiedAt = new Date();
							}
							
							found= true;
							break;
						}
					}
					if(!found)
					{
						dtoToReturn = new MedicalHistoryDTO();
						dtoToReturn.MedicalHistoryTypeID = module.MedicalHistoryTypeID;
						dtoToReturn.CreatedBy = model.loggedInUserDTO.UserId;
						dtoToReturn.CreatedAt = new Date();
						dtoToReturn.VisitID = model.visitId;
						dtoToReturn.ModifiedAt = Constants.NULL_DATE;
						dtoToReturn.DictationID = Constants.GUID_FORMAT;
						
						dtoToReturn.VisitDate	= Constants.NULL_DATE;
						
						
						//M 4 Apr 2011
						//dtoToReturn.VisitDate = model.createdVisitDate;
						
						//dtoToReturn.VisitID  =  model.visitDTO.VisitId;
						if(model.quickInputDTO.PMH==null)
							model.quickInputDTO.PMH = new PMHDTO();
						
						if(model.quickInputDTO.PMH.ComprehensiveHistory==null)
							model.quickInputDTO.PMH.ComprehensiveHistory = new ComprehensiveHistoryDTO();
						
						if(model.quickInputDTO.PMH.ComprehensiveHistory.MedicalHistory==null)
							model.quickInputDTO.PMH.ComprehensiveHistory.MedicalHistory = new ArrayCollection();
						
						model.quickInputDTO.PMH.ComprehensiveHistory.MedicalHistory.addItem(dtoToReturn);
						
					}
				}
				else
				{
					dtoToReturn = new MedicalHistoryDTO();
					dtoToReturn.MedicalHistoryTypeID = module.MedicalHistoryTypeID;
					dtoToReturn.CreatedBy = model.loggedInUserDTO.UserId;
					dtoToReturn.CreatedAt = new Date();
					dtoToReturn.VisitID = model.visitId;
					dtoToReturn.ModifiedAt = Constants.NULL_DATE;
					dtoToReturn.DictationID = Constants.GUID_FORMAT;
					
					dtoToReturn.VisitDate	= Constants.NULL_DATE;
					
					//M 4 Apr 2011
					//dtoToReturn.VisitDate = model.createdVisitDate;
					
					//dtoToReturn.VisitID  =  model.visitDTO.VisitId;
					if(model.quickInputDTO.PMH==null)
						model.quickInputDTO.PMH = new PMHDTO();
					
					if(model.quickInputDTO.PMH.ComprehensiveHistory==null)
						model.quickInputDTO.PMH.ComprehensiveHistory = new ComprehensiveHistoryDTO();
					
					if(model.quickInputDTO.PMH.ComprehensiveHistory.MedicalHistory==null)
						model.quickInputDTO.PMH.ComprehensiveHistory.MedicalHistory = new ArrayCollection();
					
					model.quickInputDTO.PMH.ComprehensiveHistory.MedicalHistory.addItem(dtoToReturn);
				}
				
			}
			
			return dtoToReturn;
		}
		
		// user for comprehensive history
		public static function getFamilyHistoryTypeDTOByName(name:String): FamilyHistoryTypeDTO
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			var obj:FamilyHistoryTypeDTO ;		 
			if(model.UserLoggedIn)
			{
				if(model.allFamilyHistoryTypeDTOList!=null && model.allFamilyHistoryTypeDTOList.length>0)
				{
					var i:int;
					for(i=0;i<model.allFamilyHistoryTypeDTOList.length;i++)
					{
						var dto:FamilyHistoryTypeDTO = model.allFamilyHistoryTypeDTOList.getItemAt(i) as FamilyHistoryTypeDTO ; 
						if(dto.FamilyHistoryTypeName == name)
						{
							obj = dto;
							break;
						}
					}			 
				}
			}
			return obj;
		}
		public static function getFamilyHistoryTypeDTOById(id:int): FamilyHistoryTypeDTO
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			var obj:FamilyHistoryTypeDTO ;		 
			if(model.UserLoggedIn)
			{	
				if(model.allFamilyHistoryTypeDTOList!=null && model.allFamilyHistoryTypeDTOList.length>0)
				{
					var i:int;
					for(i=0;i<model.allFamilyHistoryTypeDTOList.length;i++)
					{
						var dto:FamilyHistoryTypeDTO = model.allFamilyHistoryTypeDTOList.getItemAt(i) as FamilyHistoryTypeDTO ; 
						if(dto.FamilyHistoryTypeID == id)
						{
							obj = dto;
							break;
						}
					}			 
				}
			}
			return obj;
		}
		
		// for Comprehensive history family section 
		public static function getFamilyHistoryDTO_old(moduleName:String): FamilyHistoryDTO
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			var i:int;
			var dtoToReturn:FamilyHistoryDTO;
			if(model.UserLoggedIn)
			{
				var module:FamilyHistoryTypeDTO = getFamilyHistoryTypeDTOByName(moduleName);
				if(model.quickInputDTO!=null && model.quickInputDTO.PMH!=null && model.quickInputDTO.PMH.ComprehensiveHistory!=null &&
					model.quickInputDTO.PMH.ComprehensiveHistory.FamilyHistory!=null && model.quickInputDTO.PMH.ComprehensiveHistory.FamilyHistory.length>0)
				{
					var i:int;
					var found:Boolean=false;
					for(i=0;i<model.quickInputDTO.PMH.ComprehensiveHistory.FamilyHistory.length>0;i++)
					{
						var dto:FamilyHistoryDTO = model.quickInputDTO.PMH.ComprehensiveHistory.FamilyHistory.getItemAt(i) as FamilyHistoryDTO ; 
						if(module.FamilyHistoryTypeID == dto.FamilyHistoryTypeID)
						{
							dtoToReturn = dto;
							if(dtoToReturn.PatientFamilyHistoryID==0)
							{
								dtoToReturn.CreatedBy = model.loggedInUserDTO.UserId;
								dtoToReturn.CreatedAt = new Date();
							}	
							else if(dtoToReturn.PatientFamilyHistoryID>0)
							{
								dtoToReturn.ModifiedBy = model.loggedInUserDTO.UserId;
								dtoToReturn.ModifiedAt = new Date();
							}
							found= true;
							break;
						}
					}
					if(!found)
					{
						dtoToReturn = new FamilyHistoryDTO();
						dtoToReturn.FamilyHistoryTypeID = module.FamilyHistoryTypeID;
						dtoToReturn.CreatedBy = model.loggedInUserDTO.UserId;
						dtoToReturn.CreatedAt = new Date();
						dtoToReturn.ModifiedAt = Constants.NULL_DATE;
						dtoToReturn.DictationID = Constants.GUID_FORMAT;
						
						//M 4 Apr 2011
						//dtoToReturn.VisitDate = model.createdVisitDate;
						
						//dtoToReturn.VisitID = model.visitDTO.VisitId;
						dtoToReturn.VisitDate = Constants.NULL_DATE;
						if(model.quickInputDTO.PMH==null)
							model.quickInputDTO.PMH = new PMHDTO();
						
						if(model.quickInputDTO.PMH.ComprehensiveHistory==null)
							model.quickInputDTO.PMH.ComprehensiveHistory = new ComprehensiveHistoryDTO();
						
						if(model.quickInputDTO.PMH.ComprehensiveHistory.FamilyHistory==null)
							model.quickInputDTO.PMH.ComprehensiveHistory.FamilyHistory = new ArrayCollection();
						
						model.quickInputDTO.PMH.ComprehensiveHistory.FamilyHistory.addItem(dtoToReturn);
						
					}
				}
				else
				{
					dtoToReturn = new FamilyHistoryDTO();
					//Todo: commited by baber to get rid fo the exception for the time being
					dtoToReturn.FamilyHistoryTypeID = module.FamilyHistoryTypeID;
					dtoToReturn.CreatedBy = model.loggedInUserDTO.UserId;
					dtoToReturn.CreatedAt = new Date();
					dtoToReturn.ModifiedAt = Constants.NULL_DATE;
					dtoToReturn.DictationID = Constants.GUID_FORMAT;
					//dtoToReturn.VisitID = model.visitDTO.VisitId;
					
					
					
					dtoToReturn.VisitDate = Constants.NULL_DATE;
					
					//M 4 Apr 2011
					//dtoToReturn.VisitDate = model.createdVisitDate;
					
					if(model.quickInputDTO.PMH==null)
						model.quickInputDTO.PMH = new PMHDTO();
					
					if(model.quickInputDTO.PMH.ComprehensiveHistory==null)
						model.quickInputDTO.PMH.ComprehensiveHistory = new ComprehensiveHistoryDTO();
					
					if(model.quickInputDTO.PMH.ComprehensiveHistory.FamilyHistory==null)
						model.quickInputDTO.PMH.ComprehensiveHistory.FamilyHistory = new ArrayCollection();
					
					model.quickInputDTO.PMH.ComprehensiveHistory.FamilyHistory.addItem(dtoToReturn);
				}
				
			}
			
			return dtoToReturn;
		}
		
		
		
		public static function getLabNatureTypeDTOByName(name:String): LabNatureTypeDTO
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			var objToReturn:LabNatureTypeDTO ;		 
			if(model.UserLoggedIn)
			{
				if(model.labNatureTypeDTOList!=null && model.labNatureTypeDTOList.length>0)
				{
					var i:int;
					for(i=0;i<model.labNatureTypeDTOList.length;i++)
					{
						var dto:LabNatureTypeDTO = model.labNatureTypeDTOList.getItemAt(i) as LabNatureTypeDTO ; 
						if(dto.LabTestNatureName == name)
						{
							objToReturn = dto;
							break;
						}
					}			 
				}
			}
			return objToReturn;
		}
		
		public static function getFollowupMethodTypeDTOByName(name:String): FollowUpMethodTypeDTO
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			var objToReturn:FollowUpMethodTypeDTO;		 
			if(model.UserLoggedIn)
			{
				if(model.followUpMethodTypeList !=null && model.followUpMethodTypeList.length>0)
				{
					var i:int;
					for(i=0;i<model.followUpMethodTypeList.length;i++)
					{
						var dto:FollowUpMethodTypeDTO = model.followUpMethodTypeList.getItemAt(i) as FollowUpMethodTypeDTO ; 
						if(dto.MethodName == name)
						{
							objToReturn = dto;
							break;
						}
					}			 
				}
			}
			return objToReturn;
		}
		
		
		public static function getHPIDetailTypeIdByName(name:String): int
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			var idToReturn:int ;		 
			if(model.UserLoggedIn)
			{
				if(model.hpiDetailTypesList!=null && model.hpiDetailTypesList.length>0)
				{
					var i:int;
					for(i=0;i<model.hpiDetailTypesList.length;i++)
					{
						var dto:HPITypeDTO = model.hpiDetailTypesList.getItemAt(i) as HPITypeDTO ; 
						if(dto.DataControlName == name)
						{
							idToReturn = dto.HPIDataControlTypeID;
							break;
						}
					}			 
				}
			}
			return idToReturn;
		}
		
		
		
		public static function getSocialHistoryAddictionDTOByName(name:String): SocialHistoryAddictionDTO
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			var obj:SocialHistoryAddictionTypeDTO ;		 
			var dtoToReturn:SocialHistoryAddictionDTO ;
			if(model.UserLoggedIn)
			{
				if(model.allSocialHistoryAddictionTypeDTOList!=null && model.allSocialHistoryAddictionTypeDTOList.length>0)
				{
					var i:int;
					for(i=0;i<model.allSocialHistoryAddictionTypeDTOList.length;i++)
					{
						var dto:SocialHistoryAddictionTypeDTO = model.allSocialHistoryAddictionTypeDTOList.getItemAt(i) as SocialHistoryAddictionTypeDTO ; 
						if(dto.AddictionName == name)
						{
							obj = dto;
							break;
						}
					}			 
				}
				
				if(obj!=null)
				{
					
					if(model.socialHistoryDTO!=null && model.socialHistoryDTO.SocialHistoryAddictionList!=null && model.socialHistoryDTO.SocialHistoryAddictionList.length>0)
					{
						
						var i:int;
						var found:Boolean=false;
						for(i=0;i<model.socialHistoryDTO.SocialHistoryAddictionList.length;i++)
						{
							var listDTO:SocialHistoryAddictionDTO = model.socialHistoryDTO.SocialHistoryAddictionList.getItemAt(i) as SocialHistoryAddictionDTO;
							if(obj.SocialHistoryAddictionTypeID == listDTO.SocialHistoryAddictionTypeID)
							{
								dtoToReturn = listDTO;
								found= true;
								break;
							}
							
						}
						if(!found)
						{
							dtoToReturn = new SocialHistoryAddictionDTO();
							dtoToReturn.SocialHistoryAddictionTypeID = obj.SocialHistoryAddictionTypeID;
							dtoToReturn.CreatedBy = model.loggedInUserDTO.UserId;
							dtoToReturn.CreatedAt = new Date();
							dtoToReturn.ModifiedAt = Constants.NULL_DATE;
							//dtoToReturn.VisitId = model.visitDTO.VisitId;
							dtoToReturn.DictationId = Constants.GUID_FORMAT;
							
							if(model.socialHistoryDTO.SocialHistoryAddictionList==null)
								model.socialHistoryDTO.SocialHistoryAddictionList= new ArrayCollection();
							
							
							model.socialHistoryDTO.SocialHistoryAddictionList.addItem(dtoToReturn);
							
						}
						
					}
					else
					{
						dtoToReturn = new SocialHistoryAddictionDTO();
						dtoToReturn.SocialHistoryAddictionTypeID = obj.SocialHistoryAddictionTypeID;
						dtoToReturn.CreatedBy = model.loggedInUserDTO.UserId;
						dtoToReturn.CreatedAt = new Date();
						dtoToReturn.ModifiedAt = Constants.NULL_DATE;
						//dtoToReturn.VisitId = model.visitDTO.VisitId;
						dtoToReturn.DictationId = Constants.GUID_FORMAT;
						
						if(model.socialHistoryDTO.SocialHistoryAddictionList==null)
							model.socialHistoryDTO.SocialHistoryAddictionList= new ArrayCollection();
						
						model.socialHistoryDTO.SocialHistoryAddictionList.addItem(dtoToReturn);
					}
					
					
				}
			}
			return dtoToReturn;
		}
		
		[Deprecated(replacement="setROSMainCategoryToNormal( setNotesToNormal:Boolean )", since="3.13.2012")]
		public static function setROSMainCategoryToNormal_old(mainCategoryId:int,setNotesToNormal:Boolean,subCategoryId:int=-1): void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();		
			
			if(model.UserLoggedIn)
			{
				if(model.rosDTOList !=null && model.rosDTOList.length>0)
				{
					var i:int;
					for(i=0;i<model.rosDTOList.length;i++)
					{
						var dto:ROSDTO = model.rosDTOList.getItemAt(i) as ROSDTO ; 
						if(dto.ROSMainCategoryTypeID == mainCategoryId && subCategoryId==-1)
						{
							dto.IsNormal = Constants.STRING_TRUE ;
							var j:int;
							for(j=0;j<dto.children.length;j++)
							{
								var child:ROSDTO = dto.children.getItemAt(j) as ROSDTO ;
								child.IsNormal=Constants.STRING_TRUE ;
								child.IsDirty = true;
								if(setNotesToNormal)
								{
									child.Notes = Constants.EMPTY_STRING;
								}
							}
							dto.IsDirty = true;
							
							
							
							for(j=0;j<dto.children.length;j++)
							{
								var child:ROSDTO = dto.children.getItemAt(j) as ROSDTO ; 
								child.IsNormal= Constants.STRING_TRUE ;
								child.IsDirty = true;
								if(setNotesToNormal)
								{
									child.Notes = Constants.EMPTY_STRING;
								}
								
								if(child.children!=null && child.children.length>0)
								{
									
									child.IsNormal = Constants.STRING_TRUE ;
									child.IsDirty = true;
									var k:int;
									for(k=0;k<child.children.length;k++)
									{
										var subChild:ROSDTO = child.children.getItemAt(k) as ROSDTO ;
										subChild.IsNormal= Constants.STRING_TRUE ;
										subChild.IsDirty = true;
										if(setNotesToNormal)
										{
											subChild.Notes = Constants.EMPTY_STRING;
										}
									}
									
								}
							}
						}
						else if(dto.ROSMainCategoryTypeID == mainCategoryId && subCategoryId!=-1)
						{
							var j:int;
							for(j=0;j<dto.children.length;j++)
							{
								var child:ROSDTO = dto.children.getItemAt(j) as ROSDTO ;
								if(child.children!=null && child.children.length>0)
								{
									if(subCategoryId == child.ROSSubCategoryTypeID)
									{
										child.IsNormal = Constants.STRING_TRUE ;
										child.IsDirty = true;
										var k:int;
										for(k=0;k<child.children.length;k++)
										{
											var subChild:ROSDTO = child.children.getItemAt(k) as ROSDTO ;
											subChild.IsNormal= Constants.STRING_TRUE ;
											subChild.IsDirty = true;
											if(setNotesToNormal)
											{
												subChild.Notes = Constants.EMPTY_STRING;
											}
										}
									}
								}
							}
						}
					}			 
				}		
			}
		}
		
		public static function checkROSMainCategoryNotes(mainCategoryId:int, SubCatID:int = -1): Boolean
		{
			var model : AppModelLocator = AppModelLocator.getInstance();		
			var notesExists:Boolean		= false;
			if(model.UserLoggedIn)
			{
				if(model.rosDTOList !=null && model.rosDTOList.length>0)
				{
					var i:int;
					for(i=0;i<model.rosDTOList.length;i++)
					{
						var dto:ROSDTO = model.rosDTOList.getItemAt(i) as ROSDTO ; 
						if(dto.ROSMainCategoryTypeID == mainCategoryId)
						{
							var j:int;
							for(j=0;j<dto.children.length;j++)
							{
								var child:ROSDTO = dto.children.getItemAt(j) as ROSDTO ;
								//if(child.Notes!=null && child.Notes.length>0)
								//Tahir Alvi - only check notes in Abnormal case, if notes exsist in Normal ignore
								if(child.Notes!=null && child.Notes.length>0)
								{
									notesExists=true;
									break;
								}
								
								if(child.DictationID!=null && child.DictationID.length>0 && child.DictationID != Constants.GUID_FORMAT )
								{
									notesExists=true;
									break;
								}
								
								if( SubCatID != -1 && child.ROSSubCategoryTypeID == SubCatID )
								{
									if(child.children!=null && child.children.length>0)
									{
										var k:int;
										for(k=0;k<child.children.length;k++)
										{
											var subChild:ROSDTO = child.children.getItemAt(k) as ROSDTO ;
											
											//if(subChild.Notes!=null && subChild.Notes.length>0)
											//Tahir Alvi - only check notes in Abnormal case, if notes exsist in Normal ignore
											if(subChild.Notes!=null && subChild.Notes.length>0 )
											{
												notesExists=true;
												break;
											}
											
											if(subChild.DictationID!=null && subChild.DictationID.length>0  && child.DictationID != Constants.GUID_FORMAT )
											{
												notesExists=true;
												break;
											}
										}
									}
								}
								else if(SubCatID == -1 && child.children!=null && child.children.length>0)
								{
									var k:int;
									for(k=0;k<child.children.length;k++)
									{
										var subChild:ROSDTO = child.children.getItemAt(k) as ROSDTO ;
										
										//if(subChild.Notes!=null && subChild.Notes.length>0)
										//Tahir Alvi - only check notes in Abnormal case, if notes exsist in Normal ignore
										if(subChild.Notes!=null && subChild.Notes.length>0 )
										{
											notesExists=true;
											break;
										}

										if(subChild.DictationID!=null && subChild.DictationID.length>0 && subChild.DictationID != Constants.GUID_FORMAT )
										{
											notesExists=true;
											break;
										}
									}
								}
								if( notesExists )
									break;
							}
							if( notesExists )
								break;
						}
						if( notesExists )
							break;
					}			 
				}		
			}
			return notesExists;
		}
		
		public static function checkROSMainCategoryNotesForAbnormal(mainCategoryId:int, SubCatID:int = -1): Boolean
		{
			var model : AppModelLocator = AppModelLocator.getInstance();		
			var notesExists:Boolean		= false;
			if(model.UserLoggedIn)
			{
				if(model.rosDTOList !=null && model.rosDTOList.length>0)
				{
					var i:int;
					for(i=0;i<model.rosDTOList.length;i++)
					{
						var dto:ROSDTO = model.rosDTOList.getItemAt(i) as ROSDTO ; 
						if(dto.ROSMainCategoryTypeID == mainCategoryId)
						{
							var j:int;
							for(j=0;j<dto.children.length;j++)
							{
								var child:ROSDTO = dto.children.getItemAt(j) as ROSDTO ;
								//if(child.Notes!=null && child.Notes.length>0)
								//Tahir Alvi - only check notes in Abnormal case, if notes exsist in Normal ignore
								if(child.Notes!=null && child.Notes.length>0 && child.IsAbNormal == Constants.STRING_TRUE)
								{
									notesExists=true;
									break;
								}
								
								if(child.DictationID!=null && child.DictationID.length>0 && child.DictationID != Constants.GUID_FORMAT && child.IsAbNormal == Constants.STRING_TRUE)
								{
									notesExists=true;
									break;
								}
								
								if( SubCatID != -1 && child.ROSSubCategoryTypeID == SubCatID )
								{
									if(child.children!=null && child.children.length>0)
									{
										var k:int;
										for(k=0;k<child.children.length;k++)
										{
											var subChild:ROSDTO = child.children.getItemAt(k) as ROSDTO ;
											
											//if(subChild.Notes!=null && subChild.Notes.length>0)
											//Tahir Alvi - only check notes in Abnormal case, if notes exsist in Normal ignore
											if(subChild.Notes!=null && subChild.Notes.length>0 && subChild.IsAbNormal == Constants.STRING_TRUE)
											{
												notesExists=true;
												break;
											}
											
											if(subChild.DictationID!=null && subChild.DictationID.length>0  && child.DictationID != Constants.GUID_FORMAT && subChild.IsAbNormal == Constants.STRING_TRUE)
											{
												notesExists=true;
												break;
											}
										}
									}
								}
								else if(SubCatID == -1 && child.children!=null && child.children.length>0)
								{
									var k:int;
									for(k=0;k<child.children.length;k++)
									{
										var subChild:ROSDTO = child.children.getItemAt(k) as ROSDTO ;
										
										//if(subChild.Notes!=null && subChild.Notes.length>0)
										//Tahir Alvi - only check notes in Abnormal case, if notes exsist in Normal ignore
										if(subChild.Notes!=null && subChild.Notes.length>0 && subChild.IsAbNormal == Constants.STRING_TRUE)
										{
											notesExists=true;
											break;
										}

										if(subChild.DictationID!=null && subChild.DictationID.length>0 && subChild.DictationID != Constants.GUID_FORMAT && subChild.IsAbNormal == Constants.STRING_TRUE)
										{
											notesExists=true;
											break;
										}
									}
								}
								if( notesExists )
									break;
							}
							if( notesExists )
								break;
						}
						if( notesExists )
							break;
					}			 
				}		
			}
			return notesExists;
		}
		
		public static function setROSMainCategoryToNormal(mainCategoryId:int,setNotesToNormal:Boolean, subCategoryId:int=-1): Boolean
		{
			var model : AppModelLocator = AppModelLocator.getInstance();		
			var retVal:Boolean;
			
			if(model.UserLoggedIn)
			{
				if(model.rosDTOList !=null && model.rosDTOList.length>0)
				{
					var i:int;
					for(i=0;i<model.rosDTOList.length;i++)
					{
						var dto:ROSDTO = model.rosDTOList.getItemAt(i) as ROSDTO ; 
						var forceNormal:Boolean = ! IsROSAllChildNormal( dto );
						if(dto.ROSMainCategoryTypeID == mainCategoryId && subCategoryId==-1)
						{
							var j:int;
							for(j=0;j<dto.children.length;j++)
							{
								var child:ROSDTO = dto.children.getItemAt(j) as ROSDTO ;
								if(child.children!=null && child.children.length>0)
								{
									var k:int;
									for(k=0;k<child.children.length;k++)
									{
										var subChild:ROSDTO  = child.children.getItemAt(k) as ROSDTO;
										retVal = ROSToggleNormal( subChild, forceNormal );
									} //end for --- subChild
								}
								retVal = ROSToggleNormal( child, forceNormal );
							} //end for --- Child
							retVal = ROSToggleNormal( dto, forceNormal );
							break;//finish on current Node 
						} //end if --- Current Child
						else if(dto.ROSMainCategoryTypeID == mainCategoryId && subCategoryId!=-1)
						{
							var l:int;
							for(l=0;l<dto.children.length;l++)
							{
								var child:ROSDTO = dto.children.getItemAt(l) as ROSDTO ;
								if(child.children!=null && child.children.length>0)
								{
									if(subCategoryId == child.ROSSubCategoryTypeID)
									{
										forceNormal = ! IsROSAllChildNormal( child );
										var m:int;
										for(m=0;m<child.children.length;m++)
										{
											var subChild:ROSDTO  = child.children.getItemAt(m) as ROSDTO;
											retVal = ROSToggleNormal( subChild, forceNormal );
										} 
									}
								}
							}
						}
					}//end for --- dto
				}
			}
			
			return retVal
		}
		
		public static function setROSToNormal( setNotesToNormal:Boolean ): Boolean
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			var retVal:Boolean 	= false;
			if(model.UserLoggedIn)
			{
				if(model.rosDTOList !=null && model.rosDTOList.length>0)
				{
					var dto:ROSDTO = model.rosDTOList.getItemAt(0) as ROSDTO;
					var forceNormal:Boolean = ! IsROSAllChildNormal( dto );
					
					var i:int;
					for(i=0;i<model.rosDTOList.length;i++)
					{
						dto = model.rosDTOList.getItemAt(i) as ROSDTO;
						
						var j:int;
						for(j=0;j<dto.children.length;j++)
						{
							var child:ROSDTO = dto.children.getItemAt(j) as ROSDTO ;
							
							if(child.children!=null && child.children.length>0)
							{
								var k:int;
								for(k=0;k<child.children.length;k++)
								{
									var subChild:ROSDTO  = child.children.getItemAt(k) as ROSDTO;
									retVal = ROSToggleNormal( subChild, forceNormal );
								}//end for subChild
							}
							retVal = ROSToggleNormal( child, forceNormal );
						}//end for Child
						retVal = ROSToggleNormal( dto, forceNormal );
					}//end for dto
				}
			}
			
			return retVal;
		}
		
		private static function ROSToggleNormal( dto:ROSDTO, forceNormal:Boolean = false ):Boolean
		{
			var retVal:Boolean 	= false;
			
			if( UtilityFunctions.IsNullOrEmpty( dto.IsNormal ) || forceNormal  )
			{
				dto.IsNormal = Constants.STRING_TRUE;
				dto.IsDirty = true;
				
				retVal = true;
			}
			else if( dto.IsDirty == false && dto.IsNormal == Constants.STRING_FALSE )
			{
				dto.IsNormal = Constants.STRING_TRUE;
				dto.IsDirty = true;
				
				retVal = true;
			}
			else
			{
				dto.IsNormal 	= Constants.STRING_FALSE;
				dto.IsDirty 	= false;
			}
			
			dto.Notes 		= Constants.EMPTY_STRING;
			dto.DictationID = Constants.GUID_FORMAT;
			dto.IsAbNormal 	= Constants.STRING_FALSE;
			
			return retVal;
		}
		
		// all normal .....
		[Deprecated(replacement="setROSToNormal( setNotesToNormal:Boolean )", since="3.13.2012")]
		public static function setROSToNormal_old(setNotesToNormal:Boolean): void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			var notesExists:Boolean 	= false;
			if(model.UserLoggedIn)
			{
				if(model.rosDTOList !=null && model.rosDTOList.length>0)
				{
					var i:int;
					for(i=0;i<model.rosDTOList.length;i++)
					{
						var dto:ROSDTO = model.rosDTOList.getItemAt(i) as ROSDTO ; 
						dto.IsNormal = Constants.STRING_TRUE ;
						var j:int;
						for(j=0;j<dto.children.length;j++)
						{
							var child:ROSDTO = dto.children.getItemAt(j) as ROSDTO ;
							child.IsNormal	 = Constants.STRING_TRUE ;
							child.IsDirty = true;
							if(setNotesToNormal)
							{
								child.Notes = Constants.EMPTY_STRING;
							}
							
							if(child.children!=null && child.children.length>0)
							{
								var k:int;
								for(k=0;k<child.children.length;k++)
								{
									var subChild:ROSDTO  = child.children.getItemAt(k) as ROSDTO;
									subChild.IsNormal=Constants.STRING_TRUE ;
									subChild.IsDirty = true;
									if(setNotesToNormal)
									{
										subChild.Notes = Constants.EMPTY_STRING;
									}
								}
								
							}
						}
						dto.IsDirty = true;
					}			 
				}		
			}	
		}
		
		public static function IsROSAllChildNormal( dto:ROSDTO ):Boolean
		{
			var retVal:Boolean = true;
			var i:int;
			for( i = 0; i < dto.children.length; i++ )
			{
				var child:ROSDTO = dto.children.getItemAt(i) as ROSDTO ;
				retVal = child.IsNormal == Constants.STRING_TRUE ;
				if( ! retVal )
					break;
				if( child.Notes )
				{
					retVal = child.Notes.length == 0;
					if( ! retVal )
						break;
				}
			}
			
			return retVal;
		}
		
		public static function checkROSNormal(): Boolean
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			var retVal:Boolean = true;
			
			if(model.UserLoggedIn)
			{
				if(model.rosDTOList !=null && model.rosDTOList.length>0)
				{
					var i:int;
					for(i=0;i<model.rosDTOList.length;i++)
					{
						var dto:ROSDTO = model.rosDTOList.getItemAt(i) as ROSDTO ;
						retVal = IsROSAllChildNormal( dto );
						if( ! retVal )
							break;
					}
				}
			}
			return retVal;
		}
		
		public static function checkROSNotes(): Boolean
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			var notesExists:Boolean 	= false;
			if(model.UserLoggedIn)
			{
				if(model.rosDTOList !=null && model.rosDTOList.length>0)
				{
					var i:int;
					for(i=0;i<model.rosDTOList.length;i++)
					{
						var dto:ROSDTO = model.rosDTOList.getItemAt(i) as ROSDTO ; 
						
						var j:int;
						for(j=0;j<dto.children.length;j++)
						{
							var child:ROSDTO = dto.children.getItemAt(j) as ROSDTO ;
							if( ! UtilityFunctions.IsNullOrEmpty( child.Notes ) || (! UtilityFunctions.IsNullOrEmpty( child.DictationID ) && child.DictationID != Constants.GUID_FORMAT) )
							{
								notesExists=true;
								break;
							}
							
							if(child.children!=null && child.children.length>0)
							{
								var k:int;
								for(k=0;k<child.children.length;k++)
								{
									var subChild:ROSDTO  = child.children.getItemAt(k) as ROSDTO;
									if( ! UtilityFunctions.IsNullOrEmpty( subChild.Notes ) || (! UtilityFunctions.IsNullOrEmpty( subChild.DictationID ) && child.DictationID != Constants.GUID_FORMAT) )
									{
										notesExists=true;
										break;
									}
								}//end for subChild
							}
							
						}//end for Child
						
					}//end for parent		 
				}		
			}	
			return notesExists;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		/////////////////////////////////////Physicals Starts///////////////////////////////////////////////////////////////
		
		
		
		public static function setPhysicalsDTOMainCategoryToNormal(mainCategoryId:int,setNotesToNormal:Boolean, subCategoryId:int=-1): Boolean
		{
			var model : AppModelLocator = AppModelLocator.getInstance();		
			var retVal:Boolean;
			
			if(model.UserLoggedIn)
			{
				if(model.physicalsDTOList !=null && model.physicalsDTOList.length>0)
				{
					var i:int;
					for(i=0;i<model.physicalsDTOList.length;i++)
					{
						var dto:PhysicalsDTO = model.physicalsDTOList.getItemAt(i) as PhysicalsDTO ; 
						var forceNormal:Boolean = ! IsPhysicalsAllChildNormal( dto );
						if(dto.PhysicalMainCategoryTypeID == mainCategoryId && subCategoryId==-1)
						{
							var j:int;
							for(j=0;j<dto.children.length;j++)
							{
								var child:PhysicalsDTO = dto.children.getItemAt(j) as PhysicalsDTO ;
								if(child.children!=null && child.children.length>0)
								{
									var k:int;
									for(k=0;k<child.children.length;k++)
									{
										var subChild:PhysicalsDTO  = child.children.getItemAt(k) as PhysicalsDTO;
										retVal = PhysicalsToggleNormal( subChild, forceNormal );
									} //end for --- subChild
								}
								retVal = PhysicalsToggleNormal( child, forceNormal );
							} //end for --- Child
							retVal = PhysicalsToggleNormal( dto, forceNormal );
							break;//finish on current Node 
						} //end if --- Current Child
						else if(dto.PhysicalMainCategoryTypeID == mainCategoryId && subCategoryId!=-1)
						{
							var l:int;
							for(l=0;l<dto.children.length;l++)
							{
								var child:PhysicalsDTO = dto.children.getItemAt(l) as PhysicalsDTO ;
								if(child.children!=null && child.children.length>0)
								{
									if(subCategoryId == child.PhysicalSubCategoryTypeID)
									{
										forceNormal = ! IsPhysicalsAllChildNormal( child );
										var m:int;
										for(m=0;m<child.children.length;m++)
										{
											var subChild:PhysicalsDTO  = child.children.getItemAt(m) as PhysicalsDTO;
											retVal = PhysicalsToggleNormal( subChild, forceNormal );
										} 
									}
								}
							}
						}
					}//end for --- dto
				}
			}
			
			return retVal
		}
		
		public static function setPhysicalsToNormal( setNotesToNormal:Boolean ): Boolean
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			var retVal:Boolean 	= false;
			if(model.UserLoggedIn)
			{
				if(model.physicalsDTOList !=null && model.physicalsDTOList.length>0)
				{
					var dto:PhysicalsDTO = model.physicalsDTOList.getItemAt(0) as PhysicalsDTO;
					var forceNormal:Boolean = ! IsPhysicalsAllChildNormal( dto );
					
					var i:int;
					for(i=0;i<model.physicalsDTOList.length;i++)
					{
						dto = model.physicalsDTOList.getItemAt(i) as PhysicalsDTO;
						
						var j:int;
						for(j=0;j<dto.children.length;j++)
						{
							var child:PhysicalsDTO = dto.children.getItemAt(j) as PhysicalsDTO ;
							
							if(child.children!=null && child.children.length>0)
							{
								var k:int;
								for(k=0;k<child.children.length;k++)
								{
									var subChild:PhysicalsDTO  = child.children.getItemAt(k) as PhysicalsDTO;
									retVal = PhysicalsToggleNormal( subChild, forceNormal );
								}//end for subChild
							}
							retVal = PhysicalsToggleNormal( child, forceNormal );
						}//end for Child
						retVal = PhysicalsToggleNormal( dto, forceNormal );
					}//end for dto
				}
			}
			
			return retVal;
		}
		
		private static function PhysicalsToggleNormal( dto:PhysicalsDTO, forceNormal:Boolean = false ):Boolean
		{
			var retVal:Boolean 	= false;
			
			if( UtilityFunctions.IsNullOrEmpty( dto.IsNormal ) || forceNormal  )
			{
				dto.IsNormal = Constants.STRING_TRUE;
				dto.IsDirty = true;
				
				retVal = true;
			}
			else if( dto.IsDirty == false && dto.IsNormal == Constants.STRING_FALSE )
			{
				dto.IsNormal = Constants.STRING_TRUE;
				dto.IsDirty = true;
				
				retVal = true;
			}
			else
			{
				dto.IsNormal 	= Constants.STRING_FALSE;
				dto.IsDirty 	= false;
			}
			
			dto.Notes 		= Constants.EMPTY_STRING;
			dto.DictationID = Constants.GUID_FORMAT;
			
			return retVal;
		}
		
		
		/////////////////////////////////////Physicals Ends/////////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private static function IsPhysicalsAllChildNormal( dto:PhysicalsDTO ):Boolean
		{
			var retVal:Boolean = true;
			var i:int;
			for( i = 0; i < dto.children.length; i++ )
			{
				var child:PhysicalsDTO = dto.children.getItemAt(i) as PhysicalsDTO ;
				retVal = child.IsNormal == Constants.STRING_TRUE ;
				
				if( ! retVal )
					break;
				
				if( child.Notes )
				{
					retVal = child.Notes.length == 0;
					if( ! retVal )
						break;
				}
			}
			
			return retVal;
		}
		
		public static function checkPhysicalsNormal(): Boolean
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			var retVal:Boolean = true;
			
			if(model.UserLoggedIn)
			{
				if(model.physicalsDTOList !=null && model.physicalsDTOList.length>0)
				{
					var i:int;
					for(i=0;i<model.physicalsDTOList.length;i++)
					{
						var dto:PhysicalsDTO = model.physicalsDTOList.getItemAt(i) as PhysicalsDTO ;
						retVal = IsPhysicalsAllChildNormal( dto );
						if( ! retVal )
							break;
					}
				}
			}
			return retVal;
		}
		
		
		
		[Depricated ]
		public static function setPhysicalsDTOMainCategoryToNormal_old(mainCategoryId:int,setNotesToNormal:Boolean,subCategoryId:int=-1): void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			if(model.UserLoggedIn)
			{
				
				if(model.physicalsDTOList !=null && model.physicalsDTOList.length>0)
				{
					var i:int;
					for(i=0;i<model.physicalsDTOList.length;i++)
					{
						var dto:PhysicalsDTO = model.physicalsDTOList.getItemAt(i) as PhysicalsDTO ; 
						
						if(dto.PhysicalMainCategoryTypeID == mainCategoryId && subCategoryId==-1)
						{
							dto.IsNormal = Constants.STRING_TRUE ;
							dto.IsDirty = true;
							var j:int;
							for(j=0;j<dto.children.length;j++)
							{
								var child:PhysicalsDTO = dto.children.getItemAt(j) as PhysicalsDTO ; 
								child.IsNormal= Constants.STRING_TRUE ;
								child.IsDirty = true;
								if(setNotesToNormal)
								{
									child.Notes = Constants.EMPTY_STRING;
								}
								
								if(child.children!=null && child.children.length>0)
								{
									
									child.IsNormal = Constants.STRING_TRUE ;
									child.IsDirty = true;
									var k:int;
									for(k=0;k<child.children.length;k++)
									{
										var subChild:PhysicalsDTO = child.children.getItemAt(k) as PhysicalsDTO ;
										subChild.IsNormal= Constants.STRING_TRUE ;
										subChild.IsDirty = true;
										if(setNotesToNormal)
										{
											subChild.Notes = Constants.EMPTY_STRING;
										}
									}
									
								}
							}
							dto.IsDirty = true;
						}
						else if(dto.PhysicalMainCategoryTypeID == mainCategoryId && subCategoryId!=-1)
						{
							var j:int;
							for(j=0;j<dto.children.length;j++)
							{
								var child:PhysicalsDTO = dto.children.getItemAt(j) as PhysicalsDTO ;
								if(child.children!=null && child.children.length>0)
								{
									if(subCategoryId == child.PhysicalSubCategoryTypeID)
									{
										child.IsNormal = Constants.STRING_TRUE ;
										child.IsDirty = true;
										var k:int;
										for(k=0;k<child.children.length;k++)
										{
											var subChild:PhysicalsDTO = child.children.getItemAt(k) as PhysicalsDTO ;
											subChild.IsNormal= Constants.STRING_TRUE ;
											subChild.IsDirty = true;
											if(setNotesToNormal)
											{
												subChild.Notes = Constants.EMPTY_STRING;
											}
										}
									}
								}
							}
						}
						
					}			 
				}	
			}
		}
		
		public static function checkPhysicalsDTOMainCategoryNotes(mainCategoryId:int,subCategory:int=-1): Boolean
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			var notesExists:Boolean		= false;
			if(model.UserLoggedIn)
			{
				
				if(model.physicalsDTOList !=null && model.physicalsDTOList.length>0)
				{
					var i:int;
					for(i=0;i<model.physicalsDTOList.length;i++)
					{
						var dto:PhysicalsDTO = model.physicalsDTOList.getItemAt(i) as PhysicalsDTO ; 
						
						if(dto.PhysicalMainCategoryTypeID == mainCategoryId && subCategory==-1)
						{
							var j:int;
							for(j=0;j<dto.children.length;j++)
							{
								var child:PhysicalsDTO = dto.children.getItemAt(j) as PhysicalsDTO ; 
								if( child.Notes != null && child.Notes.length > 0 )
								{
									notesExists = true ;
									break;
								}
								
								if( child.DictationID != null && child.DictationID != Constants.GUID_FORMAT)
								{
									notesExists = true ;
									break;
								}
								
								if(child.children!=null && child.children.length>0)
								{
									
									var k:int;
									for(k=0;k<child.children.length;k++)
									{
										var subChild:PhysicalsDTO = child.children.getItemAt(k) as PhysicalsDTO;
										
										if(subChild.Notes!=null && subChild.Notes.length>0 )
										{
											notesExists = true ;
											break;
										}
										
										if( subChild.DictationID != null && subChild.DictationID != Constants.GUID_FORMAT )
										{
											notesExists = true ;
											break;
										}
										
									}
								}
							}
						}
						else if(dto.PhysicalMainCategoryTypeID == mainCategoryId && subCategory!=-1)
						{
							var j:int;
							for(j=0;j<dto.children.length;j++)
							{
								var child:PhysicalsDTO = dto.children.getItemAt(j) as PhysicalsDTO ;
								if(child.children!=null && child.children.length>0)
								{
									if(subCategory == child.PhysicalSubCategoryTypeID)
									{
										var k:int;
										for(k=0;k<child.children.length;k++)
										{
											var subChild:PhysicalsDTO = child.children.getItemAt(k) as PhysicalsDTO;
											
											if(subChild.Notes!=null && subChild.Notes.length>0 )
											{
												notesExists = true ;
												break;
											}
											
											if( subChild.DictationID != null && subChild.DictationID != Constants.GUID_FORMAT )
											{
												notesExists = true ;
												break;
											}
										}
									}
								}
							}
						}
					}			 
				}	
			}
			return notesExists;
		}
		
		public static function checkPhysicalsDTOMainCategoryNotesForAbnormal(mainCategoryId:int,subCategory:int=-1): Boolean
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			var notesExists:Boolean		= false;
			if(model.UserLoggedIn)
			{
				
				if(model.physicalsDTOList !=null && model.physicalsDTOList.length>0)
				{
					var i:int;
					for(i=0;i<model.physicalsDTOList.length;i++)
					{
						var dto:PhysicalsDTO = model.physicalsDTOList.getItemAt(i) as PhysicalsDTO ; 
						
						if(dto.PhysicalMainCategoryTypeID == mainCategoryId && subCategory==-1)
						{
							var j:int;
							for(j=0;j<dto.children.length;j++)
							{
								var child:PhysicalsDTO = dto.children.getItemAt(j) as PhysicalsDTO ; 
								if( child.Notes != null && child.Notes.length > 0 && child.IsAbNormal == Constants.STRING_TRUE)
								{
									notesExists = true ;
									break;
								}
								
								if( child.DictationID != null && child.DictationID != Constants.GUID_FORMAT && child.IsAbNormal == Constants.STRING_TRUE)
								{
									notesExists = true ;
									break;
								}
								
								if(child.children!=null && child.children.length>0)
								{
									
									var k:int;
									for(k=0;k<child.children.length;k++)
									{
										var subChild:PhysicalsDTO = child.children.getItemAt(k) as PhysicalsDTO;
										
										if(subChild.Notes!=null && subChild.Notes.length>0 && subChild.IsAbNormal == Constants.STRING_TRUE)
										{
											notesExists = true ;
											break;
										}
										
										if( subChild.DictationID != null && subChild.DictationID != Constants.GUID_FORMAT && subChild.IsAbNormal == Constants.STRING_TRUE)
										{
											notesExists = true ;
											break;
										}
										
									}
								}
							}
						}
						else if(dto.PhysicalMainCategoryTypeID == mainCategoryId && subCategory!=-1)
						{
							var j:int;
							for(j=0;j<dto.children.length;j++)
							{
								var child:PhysicalsDTO = dto.children.getItemAt(j) as PhysicalsDTO ;
								if(child.children!=null && child.children.length>0)
								{
									if(subCategory == child.PhysicalSubCategoryTypeID)
									{
										var k:int;
										for(k=0;k<child.children.length;k++)
										{
											var subChild:PhysicalsDTO = child.children.getItemAt(k) as PhysicalsDTO;
											
											if(subChild.Notes!=null && subChild.Notes.length>0 && subChild.IsAbNormal == Constants.STRING_TRUE)
											{
												notesExists = true ;
												break;
											}
											
											if( subChild.DictationID != null && subChild.DictationID != Constants.GUID_FORMAT && subChild.IsAbNormal == Constants.STRING_TRUE)
											{
												notesExists = true ;
												break;
											}
										}
									}
								}
							}
						}
					}			 
				}	
			}
			return notesExists;
		}
		
		
		[Depricated]
		public static function setPhysicalsToNormal_old(setNotesToNormal:Boolean): void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			if(model.UserLoggedIn)
			{
				
				if(model.physicalsDTOList !=null && model.physicalsDTOList.length>0)
				{
					var i:int;
					for(i=0;i<model.physicalsDTOList.length;i++)
					{
						var dto:PhysicalsDTO = model.physicalsDTOList.getItemAt(i) as PhysicalsDTO ; 
						dto.IsNormal = Constants.STRING_TRUE ;		
						var j:int;
						for(j=0;j<dto.children.length;j++)
						{
							var child:PhysicalsDTO = dto.children.getItemAt(j) as PhysicalsDTO ; 
							child.IsNormal=Constants.STRING_TRUE ;
							child.IsDirty = true;
							if(setNotesToNormal)
							{
								child.Notes = Constants.EMPTY_STRING;
							}
							
							if(child.children!=null && child.children.length>0)
							{
								var k:int;
								for(k=0;k<child.children.length;k++)
								{
									var subChild:PhysicalsDTO = child.children.getItemAt(k) as PhysicalsDTO;
									subChild.IsNormal=Constants.STRING_TRUE ;
									subChild.IsDirty = true;
									if(setNotesToNormal)
									{
										subChild.Notes = Constants.EMPTY_STRING;
									}
									
								}
							}
							
						}
						dto.IsDirty = true;
					}			 
				}	
			}
		}
		
		public static function checkPhysicalsNotes( ): Boolean
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			var notesExists:Boolean		= false;
			if(model.UserLoggedIn)
			{
				
				if(model.physicalsDTOList !=null && model.physicalsDTOList.length>0)
				{
					var i:int;
					for(i=0;i<model.physicalsDTOList.length;i++)
					{
						var dto:PhysicalsDTO = model.physicalsDTOList.getItemAt(i) as PhysicalsDTO ; 
						
						var j:int;
						for(j=0;j<dto.children.length;j++)
						{
							var child:PhysicalsDTO = dto.children.getItemAt(j) as PhysicalsDTO ; 
							if(child.children!=null && child.children.length>0)
							{
								var k:int;
								for(k=0;k<child.children.length;k++)
								{
									var subChild:PhysicalsDTO = child.children.getItemAt(k) as PhysicalsDTO ; 
									if(subChild.Notes!=null && subChild.Notes.length>0 && ! UtilityFunctions.IsNullOrEmpty( subChild.DictationID ) && subChild.DictationID != Constants.GUID_FORMAT)
									{
										notesExists =true;
										break;
									}
									
									
								}
								
								
							}
							else
							{
								if(child.Notes!=null && child.Notes.length>0 && ! UtilityFunctions.IsNullOrEmpty( child.DictationID ) && child.DictationID != Constants.GUID_FORMAT)
								{
									notesExists =true;
									break;
								}
							}
						}
						
					}			 
				}	
			}
			return notesExists;
		}
		
		public static function canCoSignCheck(): void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			if(model.UserLoggedIn)
			{
				if(model.visitStakeHolderDTOList!=null)
				{
					var i:int;
					var found:Boolean= false;
					for(i=0;i<model.visitStakeHolderDTOList.length;i++)
					{
						var obj:VisistStakeHolderDTO = model.visitStakeHolderDTOList.getItemAt(i) as VisistStakeHolderDTO;
						
						if(model.loggedInUserDTO.UserId == obj.ActionByUserID && !model.canSign)
						{
							model.canCoSign	=true;
							model.canSign	=false;
							found			=true;
							break;
						}
						
					}
					if(!found)
					{
						model.canCoSign=false;
					}	
				}
			}
		}
		
		public static function canSignCheck(): void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			var i:int;
			var found:Boolean= false;
			if(model.UserLoggedIn)
			{
				if(model.quickInputDTO!=null)
				{
					if(model.loggedInUserDTO.UserId == model.quickInputDTO.Visit.OwnerId)
					{
						model.canSign	= true;
						model.canCoSign	= false;
					}
					else
					{
						model.canSign	= false;
					}
				}
			}
		}
		
		public static function getMeritalStatusTypeIdByName(name:String): int
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			var i:int;
			var idToReturn:int;
			if(model.UserLoggedIn)
			{
				var found:Boolean= false;
				if(model.registrationStaticDataDTO!=null && model.registrationStaticDataDTO.MaritalStatusTypes!=null)
				{
					for(i=0;i< model.registrationStaticDataDTO.MaritalStatusTypes.length;i++)
					{
						var obj:MaritalStatusTypeDTO =  model.registrationStaticDataDTO.MaritalStatusTypes.getItemAt(i) as MaritalStatusTypeDTO;
						
						if(name == obj.MaritalStatusName)
						{
							idToReturn = obj.MaritalStatusId;
							break;
						}
						
					}
					
				}
			}
			return idToReturn;
		}
		
		/*
		* Mansoor : 20 May 2011
		* for View background section level dictation & notes grid
		*/
		
		public static function getModuleNoteListForViewBackGround(moduleName:String): ArrayCollection
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			var listToReturn:ArrayCollection = new ArrayCollection();
			
			if(model.UserLoggedIn)
			{	
				var module:ModuleTypeDTO = getModuleTypeDTOByName(moduleName);
				
				if(module != null && model.moduleNoteDTOListByPatient != null && model.moduleNoteDTOListByPatient.length > 0)
				{
					var i:int;
					for(i=0; i < model.moduleNoteDTOListByPatient.length; i++)
					{
						var dto:ModuleNoteDTO = model.moduleNoteDTOListByPatient.getItemAt(i) as ModuleNoteDTO ;
						
						if(module.ModuleTypeId == dto.ModuleTypeId)
						{
							listToReturn.addItem(dto);							
						}
					}
				}
			}
			return listToReturn;
		}
		
		
		public static function getModuleDictationListForViewBackGround(moduleName:String): ArrayCollection
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			var listToReturn:ArrayCollection = new ArrayCollection();
			
			if(model.UserLoggedIn)
			{	
				var module:ModuleTypeDTO = getModuleTypeDTOByName(moduleName);
				
				if(module != null && model.moduleDictationDTOListByPatient != null && model.moduleDictationDTOListByPatient.length > 0)
				{
					var i:int;
					for(i=0; i < model.moduleDictationDTOListByPatient.length; i++)
					{
						var dto:ModuleDictationDTO = model.moduleDictationDTOListByPatient.getItemAt(i) as ModuleDictationDTO ; 
						
						if(module.ModuleTypeId == dto.ModuleTypeID)						
						{
							listToReturn.addItem(dto);							
						}
					}
				}
			}
			return listToReturn;
		}
		
		/**
		 * Ayesha: 21st April 2011
		 * */
		
		public static function getMaritalStatusNameById(value:int):String
		{
			switch( value )
			{
				case Constants.MARRIED_MERITAL_STATUS_ID:
					return "Married";
				case Constants.SINGLE_MERITAL_STATUS_ID:
					return "Single";
				case Constants.DIVORCED_MERITAL_STATUS_ID:
					return "Divorced";
				case Constants.WIDOWED_MERITAL_STATUS_ID:
					return "Widow";
					
				default:
					return "";
			}
		}
		
		public static function clearQuickInput(): void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			model.visitDTO 					= new VisitDTO();
			model.createdVisitDate			= null;
			model.visitId					= undefined;
			model.patientPreviousVitalsList = null;
			model.socialHistoryDTO 			= null;
			model.quickInputDTO 			= new QuickInputDTO();
			model.socialHistoryDTO			= new SocialHistoryDTO();
			model.canCoSign					= false;
			model.canSign					= false;
			model.quickInputDataLoadedFlag = false;
			//model.patientPreviousVitalsList = new ArrayCollection();
			
			//Tahir Alvi - Clear Associated Visit
			model.CHistoryAssociatedVisit     = null;
			model.ImmonizationAssociatedVisit = null;
			model.DiagnosisAssociatedVisit    = null;
			
			if( model.medicalHistoryList )
				model.medicalHistoryList.removeAll();
			if( model.familyHistoryList )
				model.familyHistoryList.removeAll();
			if( model.socialHistoryList )
				model.socialHistoryList.removeAll();
			
			model.medicalHistoryList	= null;
			model.familyHistoryList		= null;
			model.socialHistoryList		= null;
			
			
		}
		
		public static function closeQuickInput(): void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			clearQuickInput();
			
			//no need to call it on close
			//QuivusCombineEventDispatcher.loadROSPhysicalStaticDataEvents(false);
			
		}
		
		public static function clone( source:Object ) :*
		{
			var myBA:ByteArray = new ByteArray();
			myBA.writeObject( source );
			myBA.position = 0;
			return( myBA.readObject() );
		}
		
		//Mansoor		
		public static function normalizeQueryString(value:String):String
		{
			value = value.replace("'", "''");
			
			return value;
		}
		
		public static function doesSocialHistoryHasDataForQI():Boolean
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			
			
			var hasData:Boolean = false;
			
			if(model.socialHistoryDTO.IsDirty)
			{
				hasData = true;	
			}
			else if(model.socialHistoryDTO==null)
			{
				hasData = false;				
			}
			else
			{
				if(model.socialHistoryDTO.SocialHistoryAddictionList!=null && model.socialHistoryDTO.SocialHistoryAddictionList.length>0)
				{
					//hasData = true;	
					var i:int;
					for(i=0;i<model.socialHistoryDTO.SocialHistoryAddictionList.length;i++)
					{
						var listDTO:SocialHistoryAddictionDTO = model.socialHistoryDTO.SocialHistoryAddictionList.getItemAt(i) as SocialHistoryAddictionDTO;
						if(listDTO.IsDirty)
						{
							hasData = true;
							break;
						}
						else 
						{	
							if(listDTO.IsYesSelected!=null && listDTO.IsYesSelected.length>0)
							{
								hasData = true;
								break;
							}
							else if(listDTO.IsNoSelected!=null && listDTO.IsNoSelected.length>0)
							{
								hasData = true;
								break;
							}
							else if(listDTO.IsUnknown)
							{
								hasData = true;
								break;
							}
							
						}
					}
					
				}
				else
				{
					if(model.socialHistoryDTO.IsOtherYesSelected!=null && model.socialHistoryDTO.IsOtherYesSelected.length>0)
					{
						hasData = true;	
						
					}
					else if(model.socialHistoryDTO.IsWorkStatusYesSelected!=null && model.socialHistoryDTO.IsWorkStatusYesSelected.length>0)
					{
						hasData = true;						
					}
					else if(model.socialHistoryDTO.MaritalStatusID>0)
					{
						hasData = true;						
					}
					else if(model.socialHistoryDTO.NoteSubject!=null && model.socialHistoryDTO.NoteSubject.length>0)
					{
						hasData = true;						
					}
						
					else if(model.socialHistoryDTO.OtherDictationID!=null && model.socialHistoryDTO.OtherDictationID.length>0)
					{
						hasData = true;						
					}
					else if(model.socialHistoryDTO.OtherNotes!=null && model.socialHistoryDTO.OtherNotes.length>0)
					{
						hasData = true;						
					}
					else if(model.socialHistoryDTO.WorkStatusDictationID!=null && model.socialHistoryDTO.WorkStatusDictationID.length>0)
					{
						hasData = true;						
					}
					else if(model.socialHistoryDTO.WorkStatusNotes!=null && model.socialHistoryDTO.WorkStatusNotes.length>0)
					{
						hasData = true;						
					}
					
				}
			}
			
			return hasData;		
		}
		
		// 3 Feb, 2012
		//Tahir - Set Associated VisitDate & ID for QI Comprehensive History
		public static function setAssociatedVisitWithDateAndID():void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			//Assign Associated Visitdate and VisitID for MedicalHistory
			if(model.quickInputDTO.PMH.ComprehensiveHistory)
			{
				if(model.quickInputDTO.PMH.ComprehensiveHistory.MedicalHistory)
					if(model.quickInputDTO.PMH.ComprehensiveHistory.MedicalHistory != null && model.quickInputDTO.PMH.ComprehensiveHistory.MedicalHistory.length > 0)
					{
						for(var i:int =0; i < model.quickInputDTO.PMH.ComprehensiveHistory.MedicalHistory.length>0; i++)
						{
							var MHdto:MedicalHistoryDTO = model.quickInputDTO.PMH.ComprehensiveHistory.MedicalHistory.getItemAt(i) as MedicalHistoryDTO ; 
							if(model.CHistoryAssociatedVisit != null){
								MHdto.VisitDate = model.CHistoryAssociatedVisit.VisitDate;
								MHdto.VisitID   = model.CHistoryAssociatedVisit.ID;
							}else{
								MHdto.VisitDate = model.visitDTO.VisitDate;
								MHdto.VisitID   = model.visitDTO.VisitId;
							}
						}
					}
			}
			
			
			//Assign Associated Visitdate and VisitID for SocialHistory
			if(model.quickInputDTO.PMH.ComprehensiveHistory)
			{
				if(model.quickInputDTO.PMH.ComprehensiveHistory.SocialHistory)
					if(model.quickInputDTO.PMH.ComprehensiveHistory.SocialHistory != null && model.quickInputDTO.PMH.ComprehensiveHistory.SocialHistory.length > 0)
					{
						for(var j:int =0; j < model.quickInputDTO.PMH.ComprehensiveHistory.SocialHistory.length>0; j++)
						{
							var SHdto:SocialHistoryDTO = model.quickInputDTO.PMH.ComprehensiveHistory.SocialHistory.getItemAt(j) as SocialHistoryDTO ; 
							if(model.CHistoryAssociatedVisit != null){
								SHdto.VisitDate = model.CHistoryAssociatedVisit.VisitDate;
								SHdto.VisitID   = model.CHistoryAssociatedVisit.ID;
							}else{
								SHdto.VisitDate = model.visitDTO.VisitDate;
								SHdto.VisitID   = model.visitDTO.VisitId;
							}
						}
					}
			}
			
			//Assign Associated Visitdate and VisitID for FamilyHistory
			if(model.quickInputDTO.PMH.ComprehensiveHistory)
			{
				if(model.quickInputDTO.PMH.ComprehensiveHistory.FamilyHistory)
					if(model.quickInputDTO.PMH.ComprehensiveHistory.FamilyHistory != null && model.quickInputDTO.PMH.ComprehensiveHistory.FamilyHistory.length > 0)
					{
						for(var k:int =0; k < model.quickInputDTO.PMH.ComprehensiveHistory.FamilyHistory.length>0; k++)
						{
							var FHdto:FamilyHistoryDTO = model.quickInputDTO.PMH.ComprehensiveHistory.FamilyHistory.getItemAt(k) as FamilyHistoryDTO ;
							if(model.CHistoryAssociatedVisit != null){
								FHdto.VisitDate = model.CHistoryAssociatedVisit.VisitDate;
								FHdto.VisitID   = model.CHistoryAssociatedVisit.ID;
							}else{
								FHdto.VisitDate =  model.visitDTO.VisitDate;
								FHdto.VisitID   =  model.visitDTO.VisitId;
							}
						}
					}
			}
		}
		
		public static function CheckUserPageOrSetPageToZero(page:PageDTO):void
		{
			if( ! ( page.pageSize > 0 ) )
			{
				page.pageSize 	= 0;
				page.pageNumber = 0;
				page.fromDate 	= Constants.NULL_DATE;
				page.toDate 	= Constants.NULL_DATE;
			}
		}
		
		public static function setNoPagingAndFiltering( page:PageDTO ):void
		{
			page.fromDate 			= Constants.NULL_DATE;;
			page.toDate 			= Constants.NULL_DATE;;
			page.pageSize 			= 0;
			page.LastVisitNumber 	= 0;
		}
		
		public static function setDefaultValues( page:PageDTO ):void
		{
			var model : AppModelLocator = AppModelLocator.getInstance();
			page.fromDate 			= model.defaultFilterAndPaging.fromDate;
			page.toDate 			= model.defaultFilterAndPaging.toDate;
			page.pageSize 			= model.defaultFilterAndPaging.pageSize;
			page.LastVisitNumber 	= model.defaultFilterAndPaging.LastVisitNumber;
		}
	}
}