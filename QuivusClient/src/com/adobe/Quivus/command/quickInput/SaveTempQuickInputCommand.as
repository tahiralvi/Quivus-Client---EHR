package com.adobe.Quivus.command.quickInput
{
	import com.adobe.Quivus.delegate.quickInput.SaveTempQuickInputDelegate;
	import com.adobe.Quivus.events.quickInput.SaveTempQuickInputEvent;
	import com.adobe.Quivus.logging.LoggingUtil;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.Quivus.utils.DTOInitializationUtility;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.logging.ILogger;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;
	
	import valueObjects.*;

	
	public class SaveTempQuickInputCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		private var logger : ILogger = LoggingUtil.getLogger( this )
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : SaveTempQuickInputDelegate = new SaveTempQuickInputDelegate( this );
				
				var LE:SaveTempQuickInputEvent = cgEvent as SaveTempQuickInputEvent;				
				
				var fileName : String;				
				
				fileName =  LE.fileName;
				
				if(model.quickInputDTO!=null)
				{	
					if(model.quickInputDTO.Visit!=null && model.quickInputDTO.Visit.VisitId>0)
					{
						model.quickInputDTO.VisitId = model.quickInputDTO.Visit.VisitId;
						/*if(model.socialHistoryDTO!=null)
						{
							model.socialHistoryDTO.VisitDate = model.quickInputDTO.Visit.VisitDate;
						}*/
					}
					else if(model.visitDTO!=null && model.visitDTO.VisitId>0)
					{
						model.quickInputDTO.VisitId = model.visitDTO.VisitId;
						/*if(model.socialHistoryDTO!=null)
						{
							model.socialHistoryDTO.VisitDate = model.visitDTO.VisitDate;
						}*/
					}
					
					
					
					model.quickInputDTO.PatientId = model.loadedPatientId;
					model.quickInputDTO.ActionDate = new Date();
					model.quickInputDTO.ClinicBranchId = model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq;
					
					setImmunizationDTONullDates();
					
					setHPI_CCDTONullDates();
					
					/*if(model.quickInputDTO.Visit.VisitId == 0)
					{
					// newly created
					}
					else if(model.visitDTO.VisitId > 0) // chnged the visit id check
					{
					//update case ....
					}*/
					
					
					if(model.quickInputDTO.Physical!=null && model.quickInputDTO.Physical.Vitals != null)
					{
						setVitalsMinupilationDates();
					}
					
					if(model.quickInputDTO.PMH != null)
					{
						//CH is removed from quickInput ..... Tj
						model.quickInputDTO.PMH.ComprehensiveHistory = null;
						/*removeEmptyMedicalHistory();
						removeEmptyFamilyHistory();
						setSocialHistoryNullData();*/
					}
					
					
					setROSDTOToQuickInput();
					
					setPhysicalsDTOToQuickInput();
					
					//M if added
					/*if(QSUtilityFunctions.doesSocialHistoryHasDataForQI())
					{
						if(model.socialHistoryDTO!=null)
						{
							if(model.socialHistoryDTO.CreatedAt==null)
								model.socialHistoryDTO.CreatedAt = new Date();
							
							if(model.socialHistoryDTO.ModifiedAt==null)
								model.socialHistoryDTO.ModifiedAt = new Date();
							
							if(model.socialHistoryDTO.VisitDate==null)
								model.socialHistoryDTO.VisitDate = new Date();
							
						}
						model.quickInputDTO.PMH.ComprehensiveHistory.SocialHistory = new ArrayCollection();
						model.quickInputDTO.PMH.ComprehensiveHistory.SocialHistory.addItem(model.socialHistoryDTO);
					}*/
					
					//Mansoor
					setInHouseLabsNullData();
					
					//M
					removeModuleDictationNullData();
					
					//M TODO: chapey
//					setSocialHistoryDummyData();
					
					//M
					setModuleNotesNullData();
					
					DTOInitializationUtility.setQuickInputDTOsToNullIfNoData();
				
					if( null != model.quickInputDTO.Assessment )
					{
						/*if(model.quickInputDTO.Assessment.PatientFollowUp!=null && model.quickInputDTO.Assessment.PatientFollowUp.IsOnCompletion)
						{
						model.quickInputDTO.Assessment.PatientFollowUp = null;
						//model.quickInputDTO.Assessment.PatientFollowUp.FollowUpDate = Constants.NULL_DATE.getDate()+"/"+Constants.NULL_DATE.getMonth()+"/"+Constants.NULL_DATE.getFullYear();
						}*/
						if(model.quickInputDTO.Assessment.PatientFollowUp!=null)
						{
							if(model.quickInputDTO.Assessment.PatientFollowUp.CreatedAt==null)
								model.quickInputDTO.Assessment.PatientFollowUp.CreatedAt = new Date();
							
							if(model.quickInputDTO.Assessment.PatientFollowUp.ModifiedAt==null)
								model.quickInputDTO.Assessment.PatientFollowUp.ModifiedAt = new Date();
							
							if(model.quickInputDTO.Assessment.PatientFollowUp.VisitDate==null)
								model.quickInputDTO.Assessment.PatientFollowUp.VisitDate = new Date();												
						}
					}
					//Tahir - new impl
					if(isNaN(model.quickInputDTO.Visit.ClinicBranch.AvgPatientPerDay))
						model.quickInputDTO.Visit.ClinicBranch.AvgPatientPerDay = 0;
					//Tahir Alvi - check Signdate not null when save temp QI
					if(model.quickInputDTO)
					{
						if(null == model.quickInputDTO.SignedDate)
							model.quickInputDTO.SignedDate = Constants.NULL_DATE;
					}
					delegate.SaveTempQuickInput(model.quickInputDTO, fileName, model.sessionDTO);
				}			
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				//M : TODO
				
				var res:ObjectProxy  = re.result as ObjectProxy ;
				
				
				if(res != null)
				{
					if(res.boolean==true)
					{
						logger.info("TempQuickInput Saved successfully");
					}
					else
					{
						logger.fatal("Unable to save TempQuickInput");
					}
				}				
				else
				{
					//TODO: please provide correct error message, like what went wrong?
					Alert.show("SaveTempQuickInput"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		//Mansoor
		//9 May 2011		
		private function setInHouseLabsNullData():void
		{
			if(model.quickInputDTO.Physical!=null && model.quickInputDTO.Physical.Labs!=null)
			{
				var i:int;
				for(i=0;i<model.quickInputDTO.Physical.Labs.length;i++)
				{
					var labDTO:LabDTO = model.quickInputDTO.Physical.Labs.getItemAt(i) as LabDTO;
					
					if(labDTO.LabID <= 0)
					{
						labDTO.VisitID = model.visitId;
						labDTO.CreatedAt = new Date();
						labDTO.CreatedBy = model.loggedInUserDTO.UserId;
						
						labDTO.ModifiedAt = Constants.NULL_DATE;
					}
					
					if(!labDTO.DictationID)
					{
						labDTO.DictationID = Constants.GUID_FORMAT;
					}						
				}
			}
		}
		
		
		
		
		
		private function setROSDTOToQuickInput():void
		{
			
			if(model.rosDTOList !=null && model.rosDTOList.length>0)
			{
				var i:int;
				for(i=0;i<model.rosDTOList.length;i++)
				{
					var dto:ROSDTO = model.rosDTOList.getItemAt(i) as ROSDTO ; 
					
					var j:int;
					if(dto!=null && dto.children!=null){
						for(j=0;j<dto.children.length;j++)
						{
							var child:ROSDTO = dto.children.getItemAt(j) as ROSDTO ;
							if(child.IsDirty)
							{
								if(model.quickInputDTO.Physical==null)
									model.quickInputDTO.Physical = new PhysicalDTO();
								
								if(model.quickInputDTO.Physical.ReviewOfSystem==null)
									model.quickInputDTO.Physical.ReviewOfSystem = new ArrayCollection();
								
								if(child.children==null || child.children.length==0)
									model.quickInputDTO.Physical.ReviewOfSystem.addItem(child);
							}		
							
							if(child.children!=null && child.children.length>0)
							{
								var k:int;
								for(k=0;k<child.children.length;k++)
								{
									var subChild:ROSDTO = child.children.getItemAt(k) as ROSDTO ; 
									if(subChild.IsDirty)
									{
										if(model.quickInputDTO.Physical==null)
											model.quickInputDTO.Physical = new PhysicalDTO();
										
										if(model.quickInputDTO.Physical.ReviewOfSystem==null)
											model.quickInputDTO.Physical.ReviewOfSystem = new ArrayCollection();
										
										
										
										model.quickInputDTO.Physical.ReviewOfSystem.addItem(subChild);
									}
								}
								
								
							}
						}
					}
					//Mansoor
					if(dto.PatientROSID == 0)
					{	
						dto.VisitID = model.visitId;
						dto.CreatedAt = new Date();
						dto.CreatedBy = model.loggedInUserDTO.UserId;
						
						dto.ModifiedAt = Constants.NULL_DATE;
					}
					
					if(!dto.DictationID)
					{
						dto.DictationID = Constants.GUID_FORMAT;
					}	
				}
			}
		}
		
		private function setPhysicalsDTOToQuickInput():void
		{
			
			if(model.physicalsDTOList !=null && model.physicalsDTOList.length>0)
			{
				var i:int;
				for(i=0;i<model.physicalsDTOList.length;i++)
				{
					var dto:PhysicalsDTO = model.physicalsDTOList.getItemAt(i) as PhysicalsDTO ; 
					var j:int;
					if(dto!=null && dto.children!=null)
					{
						for(j=0;j<dto.children.length;j++)
						{
							var child:PhysicalsDTO = dto.children.getItemAt(j) as PhysicalsDTO ; 
							
								if(child.IsDirty)
								{
									if(model.quickInputDTO.Physical==null)
										model.quickInputDTO.Physical = new PhysicalDTO();
									
									if(model.quickInputDTO.Physical.Physicals==null)
										model.quickInputDTO.Physical.Physicals = new ArrayCollection();
									
									
									if(child.children==null || child.children.length==0)
										model.quickInputDTO.Physical.Physicals.addItem(child);
								}
							
							if(child.children!=null && child.children.length>0)
							{
								var k:int;
								for(k=0;k<child.children.length;k++)
								{
									var subChild:PhysicalsDTO = child.children.getItemAt(k) as PhysicalsDTO ; 
									if(subChild.IsDirty)
									{
										if(model.quickInputDTO.Physical==null)
											model.quickInputDTO.Physical = new PhysicalDTO();
										
										if(model.quickInputDTO.Physical.Physicals==null)
											model.quickInputDTO.Physical.Physicals = new ArrayCollection();
										
										
										
										model.quickInputDTO.Physical.Physicals.addItem(subChild);
									}
								}
								
								
							}
							
						}
					}
					//Mansoor
					if(dto.PatientPhysicalID == 0)
					{	
						dto.VisitID = model.visitId;
						dto.CreatedAt = new Date();
						dto.CreatedBy = model.loggedInUserDTO.UserId;
						
						dto.ModifiedAt = Constants.NULL_DATE;
					}
					
					if(!dto.DictationID)
					{
						dto.DictationID = Constants.GUID_FORMAT;
					}	
				}
				
			}
			
		}
		
		
		private function setVitalsMinupilationDates():void
		{
			//model.quickInputDTO.Physical.Vitals.VisitDate =
			if(model.quickInputDTO.Visit!=null && model.quickInputDTO.Visit.VisitId>0)
			{
				model.quickInputDTO.Physical.Vitals.VisitDate = model.quickInputDTO.Visit.VisitDate;
				
			}
			else if(model.visitDTO!=null && model.visitDTO.VisitId>0)
			{
				model.quickInputDTO.Physical.Vitals.VisitDate = model.visitDTO.VisitDate;
			}				
			
			
			//model.quickInputDTO.Physical.Vitals.DictationID = Constants.GUID_FORMAT;
			
			//Mansoor
			if(!model.quickInputDTO.Physical.Vitals.DictationID)
			{
				model.quickInputDTO.Physical.Vitals.DictationID = Constants.GUID_FORMAT;
			}
			
			if(model.quickInputDTO.Physical.Vitals.PatientVitalID == 0)
			{
				model.quickInputDTO.Physical.Vitals.VisitID = model.visitId;
				
				model.quickInputDTO.Physical.Vitals.CreatedAt = new Date();
				model.quickInputDTO.Physical.Vitals.CreatedBy = model.loggedInUserDTO.UserId;
				
				model.quickInputDTO.Physical.Vitals.ModifiedAt = Constants.NULL_DATE;
			}
			else
			{
				model.quickInputDTO.Physical.Vitals.VisitID = model.visitId;
				
				model.quickInputDTO.Physical.Vitals.ModifiedAt = new Date();					
				model.quickInputDTO.Physical.Vitals.ModifiedBy = model.loggedInUserDTO.UserId;
				
				model.quickInputDTO.Physical.Vitals.CreatedAt = Constants.NULL_DATE;
			}	
		}
		
		private function setHPI_CCDTONullDates():void
		{
			if(model.quickInputDTO.Physical!=null)
			{
				if(model.quickInputDTO.Physical.HPI_CC!=null)
				{	
					var i:int;
					for(i=0;i<model.quickInputDTO.Physical.HPI_CC.length;i++)
					{
						var hpi_ccDTO:HPI_CCDTO = model.quickInputDTO.Physical.HPI_CC.getItemAt(i) as HPI_CCDTO;
						
						/*if(hpi_ccDTO.HPIFields != null && hpi_ccDTO.HPIFields.Onset == null)
						{
						hpi_ccDTO.HPIFields.Onset = Constants.NULL_DATE.toDateString();
						}	*/	
						
						//Mansoor
						if(hpi_ccDTO.VisitID <= 0)
						{
							hpi_ccDTO.VisitID = model.visitId;
							
							hpi_ccDTO.CreatedAt = new Date();
							hpi_ccDTO.CreatedBy = model.loggedInUserDTO.UserId;
							
							hpi_ccDTO.ModifiedAt = Constants.NULL_DATE;
						}
						
						if(!hpi_ccDTO.DictationID)
						{
							hpi_ccDTO.DictationID = Constants.GUID_FORMAT;
						}
					}
				}
			}
		}
		
		private function setImmunizationDTONullDates():void
		{
			if(model.quickInputDTO.PMH!=null && model.quickInputDTO.PMH.Immunization!=null)
			{
				var i:int;
				for(i=0;i<model.quickInputDTO.PMH.Immunization.length;i++)
				{
					var immDTO:ImmunizationDTO = model.quickInputDTO.PMH.Immunization.getItemAt(i) as ImmunizationDTO;
					
					/*if(immDTO.DateAdmin == null)
					{
					immDTO.DateAdmin= Constants.NULL_DATE.toDateString();
					}
					if(immDTO.NextDoseDue == null)
					{
					immDTO.NextDoseDue= Constants.NULL_DATE.toDateString();
					}*/
					if(immDTO.VisitDate == null)
					{
						immDTO.VisitDate= Constants.NULL_DATE;
					}
					/*if(immDTO.ExpiryDate == null)
					{
					immDTO.ExpiryDate = Constants.NULL_DATE.toDateString();
					}*/
					//Mansoor
					
					if(immDTO.VisitId <= 0)
					{
						immDTO.VisitId = model.visitId;
						immDTO.CreatedAt = new Date();
						immDTO.CreatedBy = model.loggedInUserDTO.UserId;
						
						immDTO.ModifiedAt = Constants.NULL_DATE;
					}
					
					if(!immDTO.DictationID)
					{
						immDTO.DictationID = Constants.GUID_FORMAT;
					}						
				}
			}
		}
		//Mansoor 
		//Date 19 Mar 2011
		/*private function removeEmptyMedicalHistory():void
		{		
			if(model.quickInputDTO.PMH == null)
				return;
			if(model.quickInputDTO.PMH.ComprehensiveHistory == null)
				return;
			if(model.quickInputDTO.PMH.ComprehensiveHistory.MedicalHistory == null)
				return;
			
			for(var index:int = 0; model.quickInputDTO.PMH.ComprehensiveHistory.MedicalHistory && index < model.quickInputDTO.PMH.ComprehensiveHistory.MedicalHistory.length && index >=0 ; index++ )
			{
				var mh:MedicalHistoryDTO;
				
				mh = model.quickInputDTO.PMH.ComprehensiveHistory.MedicalHistory.getItemAt(index) as MedicalHistoryDTO;
				
				if(mh.MedicalHistoryNote == null || mh.MedicalHistoryNote.length == 0 || (ValidationUtils.TrimString(mh.MedicalHistoryNote)).length == 0 )
				{
					model.quickInputDTO.PMH.ComprehensiveHistory.MedicalHistory.removeItemAt(index);
					index--;
				}
					//Mansoor
				else if(mh.PatientMedicalHistoryID == 0)
				{	
					mh.VisitID = model.visitId;
					mh.CreatedBy = model.loggedInUserDTO.UserId;					
				}
				
				if(!mh.DictationID)
				{
					mh.DictationID = Constants.GUID_FORMAT;
				}
				
				if(mh.VisitDate==null)
				{
					mh.VisitDate = Constants.NULL_DATE;
				}
				if(mh.CreatedAt==null)
				{
					mh.CreatedAt = Constants.NULL_DATE;
				}
				if(mh.ModifiedAt==null)
				{
					mh.ModifiedAt = Constants.NULL_DATE;
				}
			}
		}
		
		//Mansoor 
		//Date 19 Mar 2011
		private function removeEmptyFamilyHistory() :void
		{
			if(model.quickInputDTO.PMH == null)
				return;
			
			if(model.quickInputDTO.PMH.ComprehensiveHistory == null)
				return;
			
			if(model.quickInputDTO.PMH.ComprehensiveHistory.FamilyHistory == null)
				return;
			
			for(var index:int = 0; model.quickInputDTO.PMH.ComprehensiveHistory.FamilyHistory && index < model.quickInputDTO.PMH.ComprehensiveHistory.FamilyHistory.length && index >=0 ; index++ )
			{
				var fh:FamilyHistoryDTO;
				
				fh = model.quickInputDTO.PMH.ComprehensiveHistory.FamilyHistory.getItemAt(index) as FamilyHistoryDTO;
				
				if( (fh.FamilyHistoryNote == null 
					|| fh.FamilyHistoryNote.length == 0 ||
					(ValidationUtils.TrimString(fh.FamilyHistoryNote)).length == 0)
					&& fh.DiseaseID == 0
					&& fh.ReletionshipTypeID == 0
					&& fh.IsYesSelected == null
				)
				{
					model.quickInputDTO.PMH.ComprehensiveHistory.FamilyHistory.removeItemAt(index);
					index--;
				}
					//Mansoor
				else if(fh.PatientFamilyHistoryID == 0)
				{	
					fh.VisitID = model.visitId;
					fh.CreatedAt = new Date();
					fh.CreatedBy = model.loggedInUserDTO.UserId;
					
					fh.ModifiedAt = Constants.NULL_DATE;
				}
				
				if(!fh.DictationID)
				{
					fh.DictationID = Constants.GUID_FORMAT;
				}
			}
		}
		
		//Mansoor 
		//Date 24 Mar 2011
		private function setSocialHistoryNullData():void
		{	
			if(model.socialHistoryDTO.SocialHistoryAddictionList != null)
			{
				for(var index:int = 0; model.socialHistoryDTO && index < model.socialHistoryDTO.SocialHistoryAddictionList.length && index >=0 ; index++ )
				{
					var sh:SocialHistoryAddictionDTO;
					
					sh = model.socialHistoryDTO.SocialHistoryAddictionList.getItemAt(index) as SocialHistoryAddictionDTO;
					
					//both date are strings now no need to set "null date
					/*if(sh.OnSet  == null)
					{
						sh.OnSet = Constants.NULL_DATE.toDateString();
					}
					
					if(sh.EndDate  == null)
					{
						sh.EndDate = Constants.NULL_DATE.toDateString();
					}*   /
				}
			}
		}*/
		
		//Mansoor
		//Date 24 5 2011
		private function setModuleNotesNullData():void
		{
			if(model.quickInputDTO.ModuleNotes == null)
				return;
				
			var index:int;
			for(index = 0; model.quickInputDTO.ModuleNotes && index < model.quickInputDTO.ModuleNotes.length && index >=0 ; index++ )
			{
				var mn:ModuleNoteDTO;
				
				mn = model.quickInputDTO.ModuleNotes.getItemAt(index) as ModuleNoteDTO;
				
				if(mn.VisitDate  == null)
				{
					mn.VisitDate = Constants.NULL_DATE;
				}
			}
		}
		
		//Mansoor
		//Date 24 5 2011
		private function removeModuleDictationNullData():void
		{
			if(model.quickInputDTO.ModuleDictations == null)
				return;
			var index:int;
			for(index = 0; model.quickInputDTO.ModuleDictations && index < model.quickInputDTO.ModuleDictations.length && index >=0 ; index++ )
			{
				var md:ModuleDictationDTO;
				
				md = model.quickInputDTO.ModuleDictations.getItemAt(index) as ModuleDictationDTO;
				
				if(md.DictationID  == null || md.DictationID == Constants.GUID_FORMAT)
				{
					model.quickInputDTO.ModuleDictations.removeItemAt(index);
					index--;
				}
			}
		}
		
		//Mansoor
		//Date 24 5 2011
		private function setSocialHistoryDummyData():void
		{	
			if(model.quickInputDTO.PMH == null)
				return;
			if(model.quickInputDTO.PMH.ComprehensiveHistory == null)
				return;
			if(model.quickInputDTO.PMH.ComprehensiveHistory.SocialHistory == null)
				return;
			var index:int;
			for(index = 0; model.quickInputDTO.PMH.ComprehensiveHistory.SocialHistory && index < model.quickInputDTO.PMH.ComprehensiveHistory.SocialHistory.length && index >=0 ; index++ )
			{
				var sh:SocialHistoryDTO;
				
				sh = model.quickInputDTO.PMH.ComprehensiveHistory.SocialHistory.getItemAt(index) as SocialHistoryDTO;
				
				if(!sh.OtherDictationID)
					sh.OtherDictationID  = Constants.GUID_FORMAT;
				
				if(!sh.WorkStatusDictationID)
					sh.WorkStatusDictationID = Constants.GUID_FORMAT; 
				
			}
		}
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in SaveTempQuickInput.";
				//Alert.show("Fault occured in SaveTempQuickInput.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in SaveTempQuickInput ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}