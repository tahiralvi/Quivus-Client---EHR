package com.adobe.Quivus.command.viewBackground.physical
{
	import com.adobe.Quivus.delegate.viewBackground.physical.LoadPatientPhysicalsByPatientIdDelegate;
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
	import mx.messaging.channels.StreamingAMFChannel;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class LoadPatientPhysicalsByPatientIdCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadPatientPhysicalsByPatientIdDelegate = new LoadPatientPhysicalsByPatientIdDelegate( this );
				
				delegate.LoadPatientPhysicalsByPatientId(model.loadedPatientId,
					model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq,
					model.sessionDTO,
					model.stationIdsForVB,model.isAllStationSelected,
					model.physicalsCurrentPageByPatient);
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				model.physicalsDTOListVB = new ArrayCollection();
				
				var re:ResultEvent = rpcEvent as ResultEvent;				
				var resp:PatientPhysicalResponse    = re.result as PatientPhysicalResponse ;
				
				model.vbEventCounter = model.vbEventCounter - 1;
				
				if(model.vbEventCounter == 0){
					
					model.vbDataLoadedFlag=true;
				}
				
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						
						model.physicalsDTOListVB = resp.ResponseList;
						model.physicalsCurrentPageByPatient = resp.Page;
						//if(resp.ResponseList!=null)
						{
							//setPhysicalsDTOToPhysicalsDTOListVB(resp.ResponseList);
							
							
							if(model.physicalsDTOListVB!=null && model.physicalsDTOListVB.length>0)
							{
								var i:int;
								for(i=0;i<model.physicalsDTOListVB.length;i++)
								{
									var dto:PhysicalsDTO = model.physicalsDTOListVB.getItemAt(i) as PhysicalsDTO;
									
									if(dto.SubLevel3CategoryName!=null && dto.SubLevel3CategoryName.length>0)
									{
										var subCat:String = dto.SubCategoryName;
										var subSubCar:String = dto.SubLevel3CategoryName;
										
										
										(model.physicalsDTOListVB.getItemAt(i) as PhysicalsDTO).MainCategoryName = subCat;
										(model.physicalsDTOListVB.getItemAt(i) as PhysicalsDTO).SubCategoryName = subSubCar;
										
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
							Alert.show("LoadPatientPhysicalsByPatientId"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadPatientPhysicalsByPatientId"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		private function setPhysicalsDTOToPhysicalsDTOListVB(list:ArrayCollection):void
		{
			
			
			var k:int;
			for(k=0;k<list.length;k++)
			{
				var listDTO:PhysicalsDTO = list.getItemAt(k) as PhysicalsDTO ; 
				
				var i:int;
				for(i=0;i<model.physicalsDTOListVB.length;i++)
				{
					var dto:PhysicalsDTO = model.physicalsDTOListVB.getItemAt(i) as PhysicalsDTO ; 
					
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
							break;
						}
					}
				}
				
			}
			
			
		}
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadPatientPhysicalsByPatientIdCommand.";
			//	Alert.show("Fault occured in LoadPatientPhysicalsByPatientIdCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadPatientPhysicalsByPatientIdCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}