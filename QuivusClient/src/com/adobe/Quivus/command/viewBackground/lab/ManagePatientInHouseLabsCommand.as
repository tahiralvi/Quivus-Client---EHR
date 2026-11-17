package com.adobe.Quivus.command.viewBackground.lab
{
	import com.adobe.Quivus.delegate.viewBackground.lab.ManagePatientInHouseLabsDelegate;
	import com.adobe.Quivus.events.viewBackground.lab.LoadPatientInHouseLabsByPatientIdEvent;
	import com.adobe.Quivus.events.viewBackground.lab.ManagePatientInHouseLabsEvent;
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

	
	public class ManagePatientInHouseLabsCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : ManagePatientInHouseLabsDelegate = new ManagePatientInHouseLabsDelegate( this );
				
				//var LE:ManagePatientInHouseLabsEvent = cgEvent as ManagePatientInHouseLabsEvent;
				if(model.inHouseLabDTOListByPatient!=null)
				{		
					model.inHouseLabDTOListByPatient.filterFunction = null;
					model.inHouseLabDTOListByPatient.refresh();
					var i:int;
					var newList:ArrayCollection = new ArrayCollection();
					for(i=0;i<model.inHouseLabDTOListByPatient.length;i++)
					{
						var dto:InHouseLabDTO = model.inHouseLabDTOListByPatient.getItemAt(i) as InHouseLabDTO;
						if(dto.IsDeleted == true || dto.IsDirty == true)
						{
							dto.ModifiedBy = model.loggedInUserDTO.UserId;		
							dto.ModifiedAt = new Date();
							newList.addItem(dto);
						}
					}
					if(newList.length>0)
						delegate.ManagePatientInHouseLabs(newList, model.sessionDTO);
				}
				
			}
			
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:PatientInHouseLabResponse  = re.result as PatientInHouseLabResponse ;
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						var lpihl:LoadPatientInHouseLabsByPatientIdEvent = new LoadPatientInHouseLabsByPatientIdEvent();
						CairngormEventDispatcher.getInstance().dispatchEvent( lpihl );
					}
					else
					{
						model.errorStatus = resp.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("ManagePatientInHouseLabs"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("ManagePatientInHouseLabs"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in ManagePatientInHouseLabsCommand.";
				//Alert.show("Fault occured in ManagePatientInHouseLabsCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in ManagePatientInHouseLabsCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}