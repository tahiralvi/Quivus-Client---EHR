package com.adobe.Quivus.command.viewBackground.document
{
	import com.adobe.Quivus.delegate.viewBackground.document.LoadPatientDocumentByPatientIdDelegate;
	import com.adobe.Quivus.events.viewBackground.document.LoadPatientDocumentByPatientIdEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
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

	
	public class LoadPatientDocumentByPatientIdCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadPatientDocumentByPatientIdDelegate = new LoadPatientDocumentByPatientIdDelegate( this );
				
				var LE:LoadPatientDocumentByPatientIdEvent = cgEvent as LoadPatientDocumentByPatientIdEvent;
				
				
				delegate.LoadPatientDocumentByPatientId(model.loadedPatientId,
					model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq,
					model.sessionDTO,LE.pageNo);
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				model.PatientDocumentDTOList = new ArrayCollection();
				
				model.patientDocumentTotalPageNo  = 0;
				model.totalPatientDocRec	= 0;
				model.firstPatientDocRec	= 0;
				model.lastPatientDocRec		= 0;
				
				var resp:PatientDocumentResponse  = re.result as PatientDocumentResponse ;
				if(resp!=null)
				{
					model.totalRecords_DM = resp.PatientDocument.TotalRecord;
					if(resp.ResponseStatus)
					{
						var respDTO:PaggingResponseDTO = resp.PatientDocument;
						if(respDTO!=null)
						{
							model.PatientDocumentDTOList = respDTO.PatientDocumentsList;
							model.totalPatientDocRec	= respDTO.TotalRecord;
							model.firstPatientDocRec	= respDTO.FirstRecord;
							model.lastPatientDocRec		= respDTO.LastRecord;
								
							if(model.totalPatientDocRec<Constants.PAGE_SIZE)
								model.patientDocumentTotalPageNo = 1;
							else
							{
								var num:int = model.totalPatientDocRec%Constants.PAGE_SIZE;
								if(num==0)
								{
									model.patientDocumentTotalPageNo = num;
								}
								else
								{
									model.patientDocumentTotalPageNo = num+1;
								}
							}
						}
							
						 			
					}
					else
					{
						model.errorStatus = resp.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("LoadPatientDocumentByPatientId"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadPatientDocumentByPatientId"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadPatientDocumentByPatientIdCommand.";
			//	Alert.show("Fault occured in LoadPatientDocumentByPatientIdCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadPatientDocumentByPatientIdCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}