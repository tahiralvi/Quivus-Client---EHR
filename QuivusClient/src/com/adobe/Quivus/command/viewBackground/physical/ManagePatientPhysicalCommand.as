package com.adobe.Quivus.command.viewBackground.physical
{
	import com.adobe.Quivus.delegate.viewBackground.physical.ManagePatientPhysicalDelegate;
	import com.adobe.Quivus.events.viewBackground.physical.LoadPatientPhysicalsByPatientIdEvent;
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

	
	public class ManagePatientPhysicalCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : ManagePatientPhysicalDelegate = new ManagePatientPhysicalDelegate( this );
				if(model.physicalsDTOListVB!=null)
				{				
					var i:int;
					
					var newList:ArrayCollection = new ArrayCollection();
					for(i=0;i<model.physicalsDTOListVB.length;i++)
					{
						var dto:PhysicalsDTO = model.physicalsDTOListVB.getItemAt(i) as PhysicalsDTO;
						if(dto.IsDeleted == true || dto.IsDirty == true)
						{
							dto.ModifiedBy = model.loggedInUserDTO.UserId;		
							dto.ModifiedAt = new Date();
							newList.addItem(dto);
						}
					}
					if(newList.length>0)
						delegate.ManagePatientPhysical(newList,model.sessionDTO);
				}
				
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:PatientPhysicalResponse    = re.result as PatientPhysicalResponse ;
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						var lpp:LoadPatientPhysicalsByPatientIdEvent = new LoadPatientPhysicalsByPatientIdEvent();
						CairngormEventDispatcher.getInstance().dispatchEvent( lpp );	
					}
					else
					{
						model.errorStatus = resp.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("ManagePatientPhysical"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("ManagePatientPhysical"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in ManagePatientPhysicalCommand.";
			//	Alert.show("Fault occured in ManagePatientPhysicalCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in ManagePatientPhysicalCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}