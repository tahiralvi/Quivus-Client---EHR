package com.adobe.Quivus.command.visit
{
	import com.adobe.Quivus.delegate.visit.UpdateVisitDelegate;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.common.util.exceptionAlert.QSExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class UpdateVisitCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : UpdateVisitDelegate = new UpdateVisitDelegate( this );
				
				if(model.visitDTO!=null){
					//model.visitDTO.EncounterTypeId = model.encounterTypeId;
					model.visitDTO 							= model.visitDTO;
					model.visitDTO.TemplateId 				= 2;//model.generalTemplateId;
					model.visitDTO.PlaceOfServiceTypeID 	= model.placeOfServiceID;
					model.visitDTO.PlaceOfServiceTypeName   = model.placeOfServiceName;
					model.visitDTO.OwnerId   				= model.VisitProviderSelectedUserID;
					model.visitDTO.OwnerUserType.UserTypeId	= model.VisitProviderOwnerUSerTypeID;
					
					delegate.UpdateVisit(model.visitDTO,model.loggedInUserDTO.UserId,model.userSelectedRoleDTO.UserTypeRole.UserTypeId,model.sessionDTO);
				}
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var serviceResponse:ServiceResponse  = re.result as ServiceResponse ;
				if(serviceResponse!=null)
				{
					if(serviceResponse.ResponseStatus)
					{
										
					}
					else
					{
						model.errorStatus = serviceResponse.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(serviceResponse.ResponseCode);
						if(valid)
							Alert.show("UpdateVisit"+"\n"+serviceResponse.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("UpdateVisit"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in UpdateVisitCommand.";
			//	Alert.show("Fault occured in UpdateVisitCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in UpdateVisitCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}