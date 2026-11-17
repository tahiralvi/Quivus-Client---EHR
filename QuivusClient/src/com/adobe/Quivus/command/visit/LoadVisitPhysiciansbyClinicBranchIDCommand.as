package com.adobe.Quivus.command.visit
{
	import com.adobe.Quivus.delegate.visit.LoadVisitPhysiciansbyClinicBranchIDDelegate;
	import com.adobe.Quivus.events.visit.LoadVisitPhysiciansbyClinicBranchIDEvent;
	import com.adobe.Quivus.events.visit.ManageVisitOwnerEvent;
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
	import mx.controls.List;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;
	
	
	public class LoadVisitPhysiciansbyClinicBranchIDCommand  implements com.adobe.cairngorm.commands.Command, IResponder 
	{
		[Bindable] private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			if(model.UserLoggedIn)
			{
				model.VisitProviderSelected 		= -1;
				model.VisitProviderOwnerType 		= -1;
				model.VisitProviderSelectedUserID 	= -1;
				model.VisitProviderOwnerUSerTypeID 	= -1;
				var delegate : LoadVisitPhysiciansbyClinicBranchIDDelegate = new LoadVisitPhysiciansbyClinicBranchIDDelegate( this );
				var LE:LoadVisitPhysiciansbyClinicBranchIDEvent = cgEvent as  LoadVisitPhysiciansbyClinicBranchIDEvent;
				delegate.LoadVisitPhysiciansbyClinicBranchID(LE.ClinicBranchID, LE.VisitID, LE.PatientID, LE.isEditMode, LE.loggedinUserID);
			}
		}
		
		public function result( rpcEvent : Object ) : void 
		{
			if(model.UserLoggedIn)
			{
				if(model.VisitProviderDTOList)
					model.VisitProviderDTOList.removeAll();
				else
					model.VisitProviderDTOList = new ArrayCollection();
				
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				for (var i:int = 0; i < re.result.length; i++) 
				{
					var temp:VisitProviderDTO = re.result[i] as VisitProviderDTO;
					
					if(temp.MiddleName != null)
					{
						if(temp.MiddleName.length >0)
							temp.FirstName = temp.FirstName +' '+temp.MiddleName;
					}
					
					if(temp.LastName != null)
					{
						if(temp.LastName.length >0)
							temp.FirstName = temp.FirstName +' '+temp.LastName;
					}
					model.VisitProviderDTOList.addItem(temp);
					
					if(temp.isDefault != null && temp.isDefault.toLowerCase() == 'true')
					{
						model.VisitProviderSelected 						= i;
						model.VisitProviderOwnerType 						= int(temp.VisitOwnerTypeID);//1- primary, 2-atending, 3- consulting
						model.VisitProviderSelectedUserID 					= temp.UserId;
						
						//By Moeen. Old implementation , 
						/*model.quickInputDTO.Visit.OwnerId					= temp.UserId;
						if(model.quickInputDTO.Visit.OwnerUserType == null)
							model.quickInputDTO.Visit.OwnerUserType = new UserTypeDTO();
						model.quickInputDTO.Visit.OwnerUserType.UserTypeId	= int(temp.UserTypeID);*/
						
						model.VisitProviderOwnerUSerTypeID 					= int(temp.UserTypeID);
						
					}
				}
				//Save the defaulr provider if isDefault property is true.
				if(model.VisitProviderSelected != -1 )
				{
					if( model.VisitProviderOwnerType != 1 && model.VisitProviderOwnerType != 2 && model.VisitProviderOwnerType != 3)
						model.VisitProviderOwnerType = 1;
					
					// By Moeen , its throwing exception on load Visit
					
					/*var gueEvent : ManageVisitOwnerEvent = new ManageVisitOwnerEvent(model.VisitProviderSelectedUserID.toString(), 
						model.VisitProviderOwnerUSerTypeID.toString(), model.VisitProviderOwnerType.toString(), model.visitDTO.VisitId.toString(), model.loggedInUserDTO.UserId.toString(), null);
					CairngormEventDispatcher.getInstance().dispatchEvent( gueEvent );*/
				}
			}
		}
		
		public function fault( rpcEvent : Object ) : void 
		{
			model.errorStatus = "Fault occured in LoadVisitPhysiciansbyClinicBranchIDCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
		}
	}
}