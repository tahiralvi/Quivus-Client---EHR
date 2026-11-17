package com.adobe.Quivus.command.quickInput
{
	import com.adobe.Quivus.delegate.quickInput.LoadQuickInputByVisitIdDelegate;
	import com.adobe.Quivus.events.quickInput.LoadQuickInputByVisitIdEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.Quivus.utils.DTOInitializationUtility;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
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

	
	public class LoadQuickInputByVisitIdCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadQuickInputByVisitIdDelegate = new LoadQuickInputByVisitIdDelegate( this );
				
				var LE:LoadQuickInputByVisitIdEvent = cgEvent as LoadQuickInputByVisitIdEvent;
				
				model.quickInputDTO 			= new QuickInputDTO();
				model.socialHistoryDTO			= new SocialHistoryDTO();
				model.patientPreviousVitalsList = new ArrayCollection();
				
				delegate.LoadQuickInputByVisitId(LE.visitId,model.sessionDTO);
			
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:QuickInputResponse   = re.result as QuickInputResponse  ;
				if(resp!=null){
					
				
					if(resp.ResponseStatus)
					{
						if(resp.ResponseData!=null)
						{
							model.quickInputDTO = resp.ResponseData;
							
							setROSDTOToROSDTOList();
							setPhysicalsDTOToPhysicalsDTOList();
							
							model.visitDTO = model.quickInputDTO.Visit;
							model.visitId = model.quickInputDTO.Visit.VisitId;
							
							QSUtilityFunctions.canSignCheck();
							
							if(model.quickInputDTO!=null && model.quickInputDTO.PMH!=null 
								&& model.quickInputDTO.PMH.ComprehensiveHistory!=null
								&& model.quickInputDTO.PMH.ComprehensiveHistory.SocialHistory!=null 
								&& model.quickInputDTO.PMH.ComprehensiveHistory.SocialHistory.length>0)
							{
								model.socialHistoryDTO = model.quickInputDTO.PMH.ComprehensiveHistory.SocialHistory.getItemAt(0) as SocialHistoryDTO;
								
							}
							else
							{
								model.socialHistoryDTO = new SocialHistoryDTO();
							}
							
							if(model.canSign)
							{
								if(model.quickInputDTO.Assessment!=null)
								{
									if(model.quickInputDTO.Assessment.Diagnosis!=null && model.quickInputDTO.Assessment.Diagnosis.length>0 )
									{
										model.signCosignBtnEnabled=true;
									}
									else
									{
										model.signCosignBtnEnabled=false;
									}
									
								}
								else
								{
									model.signCosignBtnEnabled=false;
								}
								
								model.signCoSignBtnLabel      	= Constants.SIGN_LABEL;
							}
							else
							{
								model.signCoSignBtnLabel      	= Constants.COSIGN_LABEL;
							}
							if(model.canCoSign)
							{
								model.signCosignBtnEnabled=true;
							}
							//Mansoor
							DTOInitializationUtility.initializeOnLoadVisitQuickInputDTO();
							
							model.quickInputDataLoadedFlag = true;
						}
						else
						{
							Alert.show("LoadQuickInputByVisitId"+"\n"+Messages.NO_DATA_RETURNED_FROM_SERVICE,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
						}
								
					}
					else
					{
						model.errorStatus = resp.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("LoadQuickInputByVisitId"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadQuickInputByVisitId"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		private function setROSDTOToROSDTOList():void
		{
			
			if(model.quickInputDTO!= null && model.quickInputDTO.Physical!=null && 
				model.quickInputDTO.Physical.ReviewOfSystem!=null)
			{
				var k:int;
				for(k=0;k<model.quickInputDTO.Physical.ReviewOfSystem.length;k++)
				{
					var listDTO:ROSDTO = model.quickInputDTO.Physical.ReviewOfSystem.getItemAt(k) as ROSDTO ; 
					
					var i:int;
					for(i=0;i<model.rosDTOList.length;i++)
					{
						var dto:ROSDTO = model.rosDTOList.getItemAt(i) as ROSDTO ; 
						
						var j:int;
						for(j=0;j<dto.children.length;j++)
						{
							var child:ROSDTO = dto.children.getItemAt(j) as ROSDTO ;
							if(child.ROSMainCategoryTypeID == listDTO.ROSMainCategoryTypeID && 
							   child.ROSSubCategoryTypeID == listDTO.ROSSubCategoryTypeID)
							{
								//child = listDTO;
								//dto.children.removeItemAt(j);
								//dto.children.addItemAt(listDTO,j);
								(dto.children.getItemAt(j) as ROSDTO).PatientROSID 					= listDTO.PatientROSID;
								(dto.children.getItemAt(j) as ROSDTO).VisitID 						= listDTO.VisitID;
								(dto.children.getItemAt(j) as ROSDTO).PatientID 					= listDTO.PatientID;
								(dto.children.getItemAt(j) as ROSDTO).ROSMainCategoryTypeID 		= listDTO.ROSMainCategoryTypeID;
								(dto.children.getItemAt(j) as ROSDTO).ROSSubCategoryTypeID 			= listDTO.ROSSubCategoryTypeID;
								(dto.children.getItemAt(j) as ROSDTO).MainCategoryName 				= listDTO.MainCategoryName;
								(dto.children.getItemAt(j) as ROSDTO).SubCategoryName 				= listDTO.SubCategoryName;
								(dto.children.getItemAt(j) as ROSDTO).IsNormal 						= listDTO.IsNormal;
								(dto.children.getItemAt(j) as ROSDTO).DictationID 					= listDTO.DictationID;
								(dto.children.getItemAt(j) as ROSDTO).Notes 						= listDTO.Notes;
								(dto.children.getItemAt(j) as ROSDTO).CreatedBy 					= listDTO.CreatedBy;
								(dto.children.getItemAt(j) as ROSDTO).CreatedAt 					= listDTO.CreatedAt;
								(dto.children.getItemAt(j) as ROSDTO).ModifiedBy 					= listDTO.ModifiedBy;
								(dto.children.getItemAt(j) as ROSDTO).ModifiedAt 					= listDTO.ModifiedAt;
								(dto.children.getItemAt(j) as ROSDTO).VisitDate 					= listDTO.VisitDate;
								
								
								//break;
							}
							
							if (child.children!=null && child.children.length>0 && listDTO.ROSSubLevel3CategoryTypeID>0)
							{
								var l:int;
								for(l=0;l<child.children.length;l++)
								{
									var subChild:ROSDTO = child.children.getItemAt(l) as ROSDTO ;
									
									if(subChild.ROSMainCategoryTypeID == listDTO.ROSMainCategoryTypeID &&
										subChild.ROSSubCategoryTypeID == listDTO.ROSSubCategoryTypeID &&
										subChild.ROSSubLevel3CategoryTypeID == listDTO.ROSSubLevel3CategoryTypeID)
									{
										
										
										
										((dto.children.getItemAt(j) as ROSDTO).children.getItemAt(l) as ROSDTO).PatientROSID 				= listDTO.PatientROSID;
										((dto.children.getItemAt(j) as ROSDTO).children.getItemAt(l) as ROSDTO).VisitID 					= listDTO.VisitID;
										((dto.children.getItemAt(j) as ROSDTO).children.getItemAt(l) as ROSDTO).PatientID 					= listDTO.PatientID;
										((dto.children.getItemAt(j) as ROSDTO).children.getItemAt(l) as ROSDTO).ROSMainCategoryTypeID 		= listDTO.ROSMainCategoryTypeID;
										((dto.children.getItemAt(j) as ROSDTO).children.getItemAt(l) as ROSDTO).ROSSubCategoryTypeID 		= listDTO.ROSSubCategoryTypeID;
										((dto.children.getItemAt(j) as ROSDTO).children.getItemAt(l) as ROSDTO).MainCategoryName 			= listDTO.MainCategoryName;
										((dto.children.getItemAt(j) as ROSDTO).children.getItemAt(l) as ROSDTO).SubCategoryName 			= listDTO.SubCategoryName;
										((dto.children.getItemAt(j) as ROSDTO).children.getItemAt(l) as ROSDTO).IsNormal 					= listDTO.IsNormal;
										((dto.children.getItemAt(j) as ROSDTO).children.getItemAt(l) as ROSDTO).DictationID 				= listDTO.DictationID;
										((dto.children.getItemAt(j) as ROSDTO).children.getItemAt(l) as ROSDTO).Notes 						= listDTO.Notes;
										((dto.children.getItemAt(j) as ROSDTO).children.getItemAt(l) as ROSDTO).CreatedBy 					= listDTO.CreatedBy;
										((dto.children.getItemAt(j) as ROSDTO).children.getItemAt(l) as ROSDTO).CreatedAt 					= listDTO.CreatedAt;
										((dto.children.getItemAt(j) as ROSDTO).children.getItemAt(l) as ROSDTO).ModifiedBy 					= listDTO.ModifiedBy;
										((dto.children.getItemAt(j) as ROSDTO).children.getItemAt(l) as ROSDTO).ModifiedAt 					= listDTO.ModifiedAt;
										((dto.children.getItemAt(j) as ROSDTO).children.getItemAt(l) as ROSDTO).VisitDate 					= listDTO.VisitDate;
										
										((dto.children.getItemAt(j) as ROSDTO).children.getItemAt(l) as ROSDTO).ROSSubLevel3CategoryTypeID 	= listDTO.ROSSubLevel3CategoryTypeID;
										
										
										
									}
									
								}
								
							}
						}
					}
					
					
				}
				
			}
			
		}
		
		
		private function setPhysicalsDTOToPhysicalsDTOList():void
		{
			
			if(model.quickInputDTO!= null && model.quickInputDTO.Physical!=null && 
				model.quickInputDTO.Physical.Physicals!=null)
			{
				var k:int;
				for(k=0;k<model.quickInputDTO.Physical.Physicals.length;k++)
				{
					var listDTO:PhysicalsDTO = model.quickInputDTO.Physical.Physicals.getItemAt(k) as PhysicalsDTO ; 
					
					var i:int;
					for(i=0;i<model.physicalsDTOList.length;i++)
					{
						var dto:PhysicalsDTO = model.physicalsDTOList.getItemAt(i) as PhysicalsDTO ; 
						
						var j:int;
						for(j=0;j<dto.children.length;j++)
						{
							var child:PhysicalsDTO = dto.children.getItemAt(j) as PhysicalsDTO ;
							if(child.PhysicalMainCategoryTypeID == listDTO.PhysicalMainCategoryTypeID && 
								child.PhysicalSubCategoryTypeID == listDTO.PhysicalSubCategoryTypeID)
							{
								//child = listDTO;
								//dto.children.removeItemAt(j);
								//dto.children.addItemAt(listDTO,j);
								(dto.children.getItemAt(j) as PhysicalsDTO).PatientPhysicalID  			= listDTO.PatientPhysicalID;
								(dto.children.getItemAt(j) as PhysicalsDTO).VisitID  					= listDTO.VisitID;
								(dto.children.getItemAt(j) as PhysicalsDTO).PatientID  					= listDTO.PatientID;
								(dto.children.getItemAt(j) as PhysicalsDTO).PhysicalMainCategoryTypeID  = listDTO.PhysicalMainCategoryTypeID;
								(dto.children.getItemAt(j) as PhysicalsDTO).PhysicalSubCategoryTypeID  	= listDTO.PhysicalSubCategoryTypeID;
								(dto.children.getItemAt(j) as PhysicalsDTO).MainCategoryName  			= listDTO.MainCategoryName;
								(dto.children.getItemAt(j) as PhysicalsDTO).SubCategoryName 			= listDTO.SubCategoryName;
								(dto.children.getItemAt(j) as PhysicalsDTO).IsNormal  					= listDTO.IsNormal;								
								(dto.children.getItemAt(j) as PhysicalsDTO).DictationID  				= listDTO.DictationID;
								(dto.children.getItemAt(j) as PhysicalsDTO).Notes  						= listDTO.Notes;
								(dto.children.getItemAt(j) as PhysicalsDTO).CreatedBy  					= listDTO.CreatedBy;
								(dto.children.getItemAt(j) as PhysicalsDTO).CreatedAt  					= listDTO.CreatedAt;
								(dto.children.getItemAt(j) as PhysicalsDTO).ModifiedBy  				= listDTO.ModifiedBy;
								(dto.children.getItemAt(j) as PhysicalsDTO).ModifiedAt 					= listDTO.ModifiedAt;
								(dto.children.getItemAt(j) as PhysicalsDTO).VisitDate  					= listDTO.VisitDate;
								//break;
							}
							
							if (child.children!=null && child.children.length>0 && listDTO.PhysicalSubLevel3CategoryTypeID>0)
							{
								var l:int;
								for(l=0;l<child.children.length;l++)
								{
									var subChild:PhysicalsDTO = child.children.getItemAt(l) as PhysicalsDTO ;
									
									if(subChild.PhysicalMainCategoryTypeID == listDTO.PhysicalMainCategoryTypeID &&
										subChild.PhysicalSubCategoryTypeID == listDTO.PhysicalSubCategoryTypeID &&
										subChild.PhysicalSubLevel3CategoryTypeID == listDTO.PhysicalSubLevel3CategoryTypeID)
									{
										
										((dto.children.getItemAt(j) as PhysicalsDTO).children.getItemAt(l) as PhysicalsDTO).PatientPhysicalID  			= listDTO.PatientPhysicalID;
										((dto.children.getItemAt(j) as PhysicalsDTO).children.getItemAt(l) as PhysicalsDTO).VisitID  					= listDTO.VisitID;
										((dto.children.getItemAt(j) as PhysicalsDTO).children.getItemAt(l) as PhysicalsDTO).PatientID  					= listDTO.PatientID;
										((dto.children.getItemAt(j) as PhysicalsDTO).children.getItemAt(l) as PhysicalsDTO).PhysicalMainCategoryTypeID  = listDTO.PhysicalMainCategoryTypeID;
										((dto.children.getItemAt(j) as PhysicalsDTO).children.getItemAt(l) as PhysicalsDTO).PhysicalSubCategoryTypeID  	= listDTO.PhysicalSubCategoryTypeID;
										((dto.children.getItemAt(j) as PhysicalsDTO).children.getItemAt(l) as PhysicalsDTO).MainCategoryName  			= listDTO.MainCategoryName;
										((dto.children.getItemAt(j) as PhysicalsDTO).children.getItemAt(l) as PhysicalsDTO).SubCategoryName 			= listDTO.SubCategoryName;
										((dto.children.getItemAt(j) as PhysicalsDTO).children.getItemAt(l) as PhysicalsDTO).IsNormal  					= listDTO.IsNormal;								
										((dto.children.getItemAt(j) as PhysicalsDTO).children.getItemAt(l) as PhysicalsDTO).DictationID  				= listDTO.DictationID;
										((dto.children.getItemAt(j) as PhysicalsDTO).children.getItemAt(l) as PhysicalsDTO).Notes  						= listDTO.Notes;
										((dto.children.getItemAt(j) as PhysicalsDTO).children.getItemAt(l) as PhysicalsDTO).CreatedBy  					= listDTO.CreatedBy;
										((dto.children.getItemAt(j) as PhysicalsDTO).children.getItemAt(l) as PhysicalsDTO).CreatedAt  					= listDTO.CreatedAt;
										((dto.children.getItemAt(j) as PhysicalsDTO).children.getItemAt(l) as PhysicalsDTO).ModifiedBy  				= listDTO.ModifiedBy;
										((dto.children.getItemAt(j) as PhysicalsDTO).children.getItemAt(l) as PhysicalsDTO).ModifiedAt 					= listDTO.ModifiedAt;
										((dto.children.getItemAt(j) as PhysicalsDTO).children.getItemAt(l) as PhysicalsDTO).VisitDate  					= listDTO.VisitDate;
										((dto.children.getItemAt(j) as PhysicalsDTO).children.getItemAt(l) as PhysicalsDTO).PhysicalSubLevel3CategoryTypeID	= listDTO.PhysicalSubLevel3CategoryTypeID;
										
									}
									
								}
								
							}
						}
					}
					
				}
				
			}
			
		}
		
		
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadQuickInputByVisit.";
				//Alert.show("Fault occured in LoadQuickInputByVisit.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadQuickInputByVisit ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}