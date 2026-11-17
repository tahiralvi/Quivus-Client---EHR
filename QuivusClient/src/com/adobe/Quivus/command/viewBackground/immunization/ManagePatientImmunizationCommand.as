package com.adobe.Quivus.command.viewBackground.immunization
{
	import com.adobe.Quivus.delegate.viewBackground.immunization.ManagePatientImmunizationDelegate;
	import com.adobe.Quivus.events.viewBackground.immunization.LoadPatientImmunizationEvent;
	import com.adobe.Quivus.events.viewBackground.immunization.ManagePatientImmunizationEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
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

	// for view-background
	public class ManagePatientImmunizationCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : ManagePatientImmunizationDelegate = new ManagePatientImmunizationDelegate( this );
				//var LE:ManagePatientImmunizationEvent = cgEvent as ManagePatientImmunizationEvent;
						
				
				if(model.immunizationDTOList!=null)
				{				
					
					var i:int;
					for(i=0;i<model.immunizationDTOList.length;i++)
					{
						var immDTO:ImmunizationDTO = model.immunizationDTOList.getItemAt(i) as ImmunizationDTO;
						 
						if(immDTO.DateAdmin == null)
						{
							immDTO.DateAdmin= Constants.NULL_DATE.toDateString();
						}
						if(immDTO.NextDoseDue == null)
						{
							immDTO.NextDoseDue= Constants.NULL_DATE.toDateString();
						}
						if(immDTO.VisitDate == null)
						{
							immDTO.VisitDate= Constants.NULL_DATE;
						}
						if(immDTO.ExpiryDate == null)
						{
							immDTO.ExpiryDate= Constants.NULL_DATE.toDateString();
						}
						immDTO.ModifiedBy = model.loggedInUserDTO.UserId;
						immDTO.ModifiedAt = new Date();
					}
					
					var newList:ArrayCollection = new ArrayCollection();
					
					for(i=0;i<model.immunizationDTOList.length;i++)
					{
						var immDTO:ImmunizationDTO = model.immunizationDTOList.getItemAt(i) as ImmunizationDTO;
						
						if(immDTO.IsDeleted == true || immDTO.IsDirty == true)
						{
							newList.addItem(immDTO);
						}
						
					}
					if(newList.length>0)
						delegate.ManagePatientImmunization(newList,model.sessionDTO, model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq, model.loadedPatientId);
				}
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var immunizationSaveResponse :ImmunizationSaveResponse   = re.result as ImmunizationSaveResponse ;
				if(immunizationSaveResponse!=null){
					if(immunizationSaveResponse.ResponseStatus)
					{
						//Tahir Alvi - New implementation
						Alert.show('Record saved successfully', 'Info',4,FlexGlobals.topLevelApplication.mainContainer);
						var lpviEvent: LoadPatientImmunizationEvent = new LoadPatientImmunizationEvent( model.loadedPatientId ); 
						CairngormEventDispatcher.getInstance().dispatchEvent( lpviEvent );
								
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(immunizationSaveResponse.ResponseCode);
						if(valid)
							Alert.show("ManagePatientImmunization"+"\n"+immunizationSaveResponse.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("ManagePatientImmunization"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in ManagePatientImmunizationCommand.";
				//Alert.show("Fault occured in ManagePatientImmunizationCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in ManagePatientImmunizationCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}