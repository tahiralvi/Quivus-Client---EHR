package com.adobe.Quivus.command.viewBackground.comprehensiveHistory
{
	import com.adobe.Quivus.delegate.viewBackground.comprehensiveHistory.ManagePatientSocialHistoryDelegate;
	import com.adobe.Quivus.events.viewBackground.comprehensiveHistory.LoadSocialHistoryByPatientIdEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
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

	
	public class ManagePatientSocialHistoryCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : ManagePatientSocialHistoryDelegate = new ManagePatientSocialHistoryDelegate( this );
				
				if(model.socialHistoryDTOListByPatient!=null)
				{			
					model.socialHistoryDTOListByPatient.filterFunction =null;
					model.socialHistoryDTOListByPatient.refresh();
					
					var i:int;
					var newList:ArrayCollection = new ArrayCollection();
					for(i=0;i<model.socialHistoryDTOListByPatient.length;i++)
					{
						var dto:SocialhistoryVBDTO = model.socialHistoryDTOListByPatient.getItemAt(i) as SocialhistoryVBDTO;
						//model.socialHistoryDTO.SocialHistoryAddictionList
						
						if(dto!=null){
							
							if(dto.IsDeleted == true || dto.IsDirty == true)
							{
								dto.ModifiedBy = model.loggedInUserDTO.UserId;
								dto.PatientID = model.loadedPatientId;
								dto.ModifiedAt = new Date();
								
								if(dto.CreatedAt==null)
									dto.CreatedAt = new Date();
								
								if(dto.VisitDate==null)
									dto.VisitDate = new Date();
								
								newList.addItem(dto);
							}
						}
					}
					
					if(model.socialHistoryDTO != null)
					{
						if(model.socialHistoryDTO.SocialHistoryAddictionList != null)
						{
							for(i=0;i<model.socialHistoryDTO.SocialHistoryAddictionList.length;i++)
							{
								var dto:SocialhistoryVBDTO = model.socialHistoryDTO.SocialHistoryAddictionList.getItemAt(i) as SocialhistoryVBDTO;
								//
								
								if(dto!=null){
									
									if(dto.IsDeleted == true || dto.IsDirty == true)
									{
										dto.ModifiedBy = model.loggedInUserDTO.UserId;
										dto.PatientID = model.loadedPatientId;
										dto.ModifiedAt = new Date();
										
										if(dto.CreatedAt==null)
											dto.CreatedAt = new Date();
										
										if(dto.VisitDate==null)
											dto.VisitDate = new Date();
										
										newList.addItem(dto);
									}
								}
							}
						}
					}
					
					if(newList.length>0)
						delegate.ManagePatientSocialHistory(newList,model.sessionDTO, model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq, model.loadedPatientId);
				}
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:SocialHistoryResponse  = re.result as SocialHistoryResponse ;
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						var lshvb:LoadSocialHistoryByPatientIdEvent = new LoadSocialHistoryByPatientIdEvent();
						CairngormEventDispatcher.getInstance().dispatchEvent( lshvb );			
					}
					else
					{
						model.errorStatus = resp.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("ManagePatientSocialHistory"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("ManagePatientSocialHistory"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in ManagePatientSocialHistoryCommand.";
			//	Alert.show("Fault occured in ManagePatientSocialHistoryCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in ManagePatientSocialHistoryCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}