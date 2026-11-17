package com.adobe.Quivus.command.staticData.registration
{
	import com.adobe.Quivus.delegate.staticData.registration.LoadInsuranceOrganizationDelegate;
	import com.adobe.Quivus.events.staticData.registration.LoadInsuranceOrganizationEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.RegisterationStaticDataDTO;
	import valueObjects.RegistrationStaticDataResponse;
	
	public class LoadInsuranceOrganizationsCommand implements Command, IResponder
	{
		private var model : AppModelLocator = AppModelLocator.getInstance();
		private var dataToLoad:ArrayCollection ;
		
		public function execute(cgEvent:CairngormEvent):void
		{
			if(model.UserLoggedIn)
			{
				var delegate : LoadInsuranceOrganizationDelegate = new LoadInsuranceOrganizationDelegate( this );
				var LE:LoadInsuranceOrganizationEvent = cgEvent as LoadInsuranceOrganizationEvent;
				
				if(LE.dataToLoad!=null && LE.dataToLoad.length>0)
				{
					this.dataToLoad = LE.dataToLoad;
					delegate.LoadInsuranceOrganization(LE.dataToLoad, model.sessionDTO);
				}
			}
		}
		
		public function result(rpcEvent:Object):void
		{
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var regStaticDataResponseDTO:RegistrationStaticDataResponse = re.result as RegistrationStaticDataResponse;
				
				if(regStaticDataResponseDTO.ResponseStatus)
				{
					if(regStaticDataResponseDTO.ResponseData!=null)
					{
						if(model.registrationStaticDataDTO.InsuranceOrganizations)
						{
							if(this.dataToLoad.contains(Constants.INSURANCE_ORGANIZATION_TYPE_REGISTERATION_STATIC_DATA))
							{
								model.registrationStaticDataDTO.InsuranceOrganizations = regStaticDataResponseDTO.ResponseData.InsuranceOrganizations;
							}
						}
					}
					else
					{
						Alert.show(Messages.NO_DATA_RETURNED_FROM_SERVICE, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
			}
		}
		
		public function fault(rpcEvent:Object):void
		{
			model.errorStatus = "Fault occured in LoadInsuranceOrganizationsCommand.";
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}