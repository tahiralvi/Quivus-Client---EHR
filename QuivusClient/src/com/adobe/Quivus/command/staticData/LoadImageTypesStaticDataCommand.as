package com.adobe.Quivus.command.staticData
{
	
	
	import com.adobe.Quivus.delegate.staticData.LoadImageTypesStaticDataDelegate;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
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

	
	public class LoadImageTypesStaticDataCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				 var delegate:LoadImageTypesStaticDataDelegate = new  LoadImageTypesStaticDataDelegate(this);
				 delegate.LoadImageTypesStaticData(model.sessionDTO);
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var imageTypeResponse:ImageTypeResponse  = re.result as  ImageTypeResponse;
				
				if(imageTypeResponse!=null && imageTypeResponse.ResponseStatus)
				{
					model.imageTypeDTOList = imageTypeResponse.ResponseData;
					
					if(model.imageTypeDTOList!=null && model.imageTypeDTOList.length>0)
					{
						var i:int;
						
						for(i=0;i<model.imageTypeDTOList.length; i++)
						{
							var imageTypeDTO:ImageTypeDTO = model.imageTypeDTOList.getItemAt(i) as ImageTypeDTO;
							
							if(imageTypeDTO.TypeName == Constants.PROFILE_IMAGE_TYPE_NAME)
							{
								model.profileImageTypeDTO =imageTypeDTO;
							}
							else if(imageTypeDTO.TypeName == Constants.INSURANCE_IMAGE_TYPE_NAME)
							{
								model.insuranceImageTypeDTO =imageTypeDTO;
							}
							
						}
						
					}
					
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadImageTypesStaticDataCommand.";
				//Alert.show("Fault occured in LoadImageTypesStaticDataCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadImageTypesStaticDataCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/ 
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}