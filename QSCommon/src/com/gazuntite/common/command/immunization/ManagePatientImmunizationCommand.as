package com.gazuntite.common.command.immunization
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.delegate.immunization.ManagePatientImmunizationDelegate;
	import com.gazuntite.common.dto.pmh.immunization.ImmunizationDTO;
	import com.gazuntite.common.event.immunization.ManagePatientImmunizationEvent;
	import com.gazuntite.common.util.QSConstants;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	public class ManagePatientImmunizationCommand implements Command , IResponder
	{
		private var model:Object;
		private var callBack:Function;
		
		public function ManagePatientImmunizationCommand()
		{
		}
		
		public function execute(cgEvent:CairngormEvent):void
		{
			var LE:ManagePatientImmunizationEvent = cgEvent as ManagePatientImmunizationEvent;
			
			model = LE.model;
			callBack = LE.callBack;
			
			if (model && model.LoggedInUserId)
			{
				var delegate : ManagePatientImmunizationDelegate = new ManagePatientImmunizationDelegate( this );
				
				if (model.immunizationDTOList!=null)
				{				
					
					var i:int;
					for (i=0; i < model.immunizationDTOList.length; i++)
					{
						var immDTO:ImmunizationDTO = model.immunizationDTOList.getItemAt(i) as ImmunizationDTO;
						
						if (immDTO.DateAdmin == null)
						{
							immDTO.DateAdmin= QSConstants.NULL_DATE.toDateString();
						}
						
						if (immDTO.NextDoseDue == null)
						{
							immDTO.NextDoseDue= QSConstants.NULL_DATE.toDateString();
						}
						
						if (immDTO.VisitDate == null)
						{
							immDTO.VisitDate= QSConstants.NULL_DATE;
						}
						
						if (immDTO.ExpiryDate == null)
						{
							immDTO.ExpiryDate= QSConstants.NULL_DATE.toDateString();
						}
						
						immDTO.ModifiedBy = model.LoggedInUserId;
						immDTO.ModifiedAt = new Date();
					}
					
					var newList:ArrayCollection = new ArrayCollection();
					var actionDate:String = UtilityFunctions.FormatDate( new Date(), "MM-DD-YYYY");
					
					for (i=0; i < model.immunizationDTOList.length; i++)
					{
						var immunizationDTO:ImmunizationDTO = model.immunizationDTOList.getItemAt(i) as ImmunizationDTO;
						
						if (immunizationDTO.IsDeleted == true || immunizationDTO.IsDirty == true)
						{
							newList.addItem(immunizationDTO);
						}
						
					}
					
					if (newList.length > 0)
						delegate.ManagePatientImmunization(newList, model.LoggedInUserId, model.VisitID, actionDate, model.LoggedInUserSessionID);
				}
			}
		}	
		
		public function result(rpcEvent:Object):void
		{
			if (model.LoggedInUserId)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				if(re.result.@Status == "true")
				{
					if (callBack)
						callBack();
					
					/*var lpviEvent:LoadImmunizationByVisitIDEvent = new LoadImmunizationByVisitIDEvent(); 
					CairngormEventDispatcher.getInstance().dispatchEvent( lpviEvent );*/
				}
					
				else
				{
					UtilityFunctions.ShowMessage("ManagePatientImmunization \n\t No data returned from service.\nMesage: \n\t" + re.result.@Message + "\nDetails: \n\t" + re.result.@Details ,"Info");
				}
			}
			else
			{
				/*UtilityFunctions.ShowMessage("ManagePatientImmunization \n\t No data returned from service.\nMesage: \n\t" + re.result.@Message + "\nDetails: \n\t" + re.result.@Details ,"Info");*/
			}
		}
		
		public function fault( rpcEvent : Object ) : void 
		{
			var errorStatus:String = "Fault occured in ManageImmunizationCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty(model.LoggedInUserId) ? -1 : model.LoggedInUserId;
			
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, rpcEvent.toString(), userId);
		}
		
	}
}