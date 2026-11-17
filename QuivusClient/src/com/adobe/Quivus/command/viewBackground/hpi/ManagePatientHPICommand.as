package com.adobe.Quivus.command.viewBackground.hpi
{
	import com.adobe.Quivus.delegate.viewBackground.hpi.LoadPatientHPIByPatientIdDelegate;
	import com.adobe.Quivus.delegate.viewBackground.hpi.ManagePatientHPIDelegate;
	import com.adobe.Quivus.events.viewBackground.hpi.LoadPatientHPIByPatientIdEvent;
	import com.adobe.Quivus.events.viewBackground.hpi.LoadPatientHPIByVisitIdEvent;
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

	
	public class ManagePatientHPICommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : ManagePatientHPIDelegate = new ManagePatientHPIDelegate( this );
				
				//var LE:LoadPatientHPIByVisitIdEvent = cgEvent as LoadPatientHPIByVisitIdEvent;
				if(model.HPI_CCDTOListByPatient!=null)
				{				
					var i:int;
					
					var newList:ArrayCollection = new ArrayCollection();
					for(i=0;i<model.HPI_CCDTOListByPatient.length;i++)
					{
						var dto:HPI_CCDTO = model.HPI_CCDTOListByPatient.getItemAt(i) as HPI_CCDTO;
						if(dto.IsDeleted == true || dto.IsDirty == true)
						{
							dto.ModifiedBy = model.loggedInUserDTO.UserId;	
							dto.ModifiedAt = new Date();
							newList.addItem(dto);
						}
					}
					
					if(newList.length>0)
						delegate.ManagePatientHPI(newList,model.sessionDTO);
				}
				
				
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:PatientHPIResponse  = re.result as PatientHPIResponse ;
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						var lphpicc:LoadPatientHPIByPatientIdEvent = new LoadPatientHPIByPatientIdEvent();
						CairngormEventDispatcher.getInstance().dispatchEvent( lphpicc );		
					}
					else
					{
						model.errorStatus = resp.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("ManagePatientHPI"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("ManagePatientHPI"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in ManagePatientHPICommand.";
				//Alert.show("Fault occured in ManagePatientHPICommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in ManagePatientHPICommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}