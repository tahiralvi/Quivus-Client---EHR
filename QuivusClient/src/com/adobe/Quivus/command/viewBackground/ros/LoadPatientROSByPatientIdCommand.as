package com.adobe.Quivus.command.viewBackground.ros
{
	import com.adobe.Quivus.delegate.viewBackground.ros.LoadPatientROSByPatientIdDelegate;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.common.util.exceptionAlert.QSExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class LoadPatientROSByPatientIdCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadPatientROSByPatientIdDelegate = new LoadPatientROSByPatientIdDelegate( this );
				
				delegate.LoadPatientROSByPatientId(model.loadedPatientId,
					model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq,
					model.sessionDTO,
					model.stationIdsForVB,
					model.isAllStationSelected,
					model.rosCurrentPageByPatient);
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				model.rosDTOListVB = new ArrayCollection();
				
				var re:ResultEvent = rpcEvent as ResultEvent;				
				var resp:PatientROSResponse   = re.result as PatientROSResponse ;
				model.vbEventCounter = model.vbEventCounter - 1;
				if(model.vbEventCounter == 0){
					
					model.vbDataLoadedFlag = true;
				}
				
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						model.rosDTOListVB = resp.ResponseList;
						model.rosCurrentPageByPatient = resp.Page;
						//if(resp.ResponseList!=null)
						{
							//setROSDTOToROSDTOListVB(resp.ResponseList);
							
							
							if(model.rosDTOListVB!=null && model.rosDTOListVB.length>0)
							{
								var i:int;
								for(i=0;i<model.rosDTOListVB.length;i++)
								{
									var dto:ROSDTO = model.rosDTOListVB.getItemAt(i) as ROSDTO;
									
									if(dto.ROSSubLevel3CategoryName!=null && dto.ROSSubLevel3CategoryName.length>0)
									{
										var subCat:String = dto.SubCategoryName;
										var subSubCar:String = dto.ROSSubLevel3CategoryName;
										
										
										(model.rosDTOListVB.getItemAt(i) as ROSDTO).MainCategoryName = subCat;
										(model.rosDTOListVB.getItemAt(i) as ROSDTO).SubCategoryName = subSubCar;
										
									}
								}
								
								
							}
						}			
					}
					else
					{
						model.errorStatus = resp.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("LoadPatientROSByPatientId"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadPatientROSByPatientId"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		private function setROSDTOToROSDTOListVB(list:ArrayCollection):void
		{
			
			
			
				var k:int;
				for(k=0;k<list.length;k++)
				{
					var listDTO:ROSDTO = list.getItemAt(k) as ROSDTO ; 
					
					var i:int;
					for(i=0;i<model.rosDTOListVB.length;i++)
					{
						var dto:ROSDTO = model.rosDTOListVB.getItemAt(i) as ROSDTO ; 
						
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
								
								
								break;
							}
						}
					}
					
					
				}
				
			
			
		}
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadPatientROSByPatientIdCommand.";
			//	Alert.show("Fault occured in LoadPatientROSByPatientIdCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadPatientROSByPatientIdCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}