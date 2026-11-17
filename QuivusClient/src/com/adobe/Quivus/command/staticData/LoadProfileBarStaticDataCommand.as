package com.adobe.Quivus.command.staticData
{
	import com.adobe.Quivus.delegate.staticData.LoadProfileBarStaticDataDelegate;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.Quivus.vo.patientProfileCustomization.MainCategoryVO;
	import com.adobe.Quivus.vo.patientProfileCustomization.SubCategoryVO;
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

	
	public class LoadProfileBarStaticDataCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadProfileBarStaticDataDelegate = new LoadProfileBarStaticDataDelegate( this );
				
				delegate.LoadProfileBarStaticData(model.sessionDTO);
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var profileStaticsDataResponse:ProfileStaticDataResponse = re.result as ProfileStaticDataResponse;
				
				if(profileStaticsDataResponse!=null)
				{
					if(profileStaticsDataResponse.ResponseStatus)
					{
						var list:ArrayCollection = (profileStaticsDataResponse.ResponseData) as ArrayCollection;
						
						if(list!=null && list.length>0)
						{
							var i:int = 0;
							var mainCategoryList:ArrayCollection = new ArrayCollection();
							for(;i<list.length;i++)
							{
								var listObj:ProfileStaticDataDTO = list.getItemAt(i) as ProfileStaticDataDTO;
								//if(listObj.MainCategoryName != Constants.MAIN_CATEGORY_HEALTH_INFO_NAME)
								{
									var mainCategoryVO:MainCategoryVO = new MainCategoryVO(listObj.MainCategoryDisplayText,
																						   listObj.MainUserProfileCategoryID,
																						   listObj.MainCategoryName);
									
									
									var subCategoryList:ArrayCollection = new ArrayCollection();
									var j:int = 0;
									for(;j<list.length;j++)
									{
										var listObj2:ProfileStaticDataDTO = list.getItemAt(j) as ProfileStaticDataDTO;
										if(listObj2.MainUserProfileCategoryID == mainCategoryVO.mainCategoryId)
										{
											var subCategoryVO:SubCategoryVO = new SubCategoryVO(listObj2.CategoryDisplayText,
																								listObj2.UserProfileCategoryID,
																								listObj2.CategoryName);
											
											
											subCategoryList.addItem(subCategoryVO);
											list.removeItemAt(j);
											j--;
										}
									}
									i--;
									mainCategoryVO.children = subCategoryList;
									if(mainCategoryVO.mainCategoryName != Constants.MAIN_CATEGORY_HEALTH_INFO_NAME)
									{
										mainCategoryList.addItem(mainCategoryVO);
										
									}
									else if(mainCategoryVO.mainCategoryName == Constants.MAIN_CATEGORY_HEALTH_INFO_NAME)
									{
										if(model.userProfileBarHealthStaticDataList==null)
										{
											model.userProfileBarHealthStaticDataList = new ArrayCollection();
										}
										model.userProfileBarHealthStaticDataList.addItem(mainCategoryVO)
									}
										
									
								}
								
							}
							model.userProfileBarStaticDataList= mainCategoryList;
						}
						
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(profileStaticsDataResponse.ResponseCode);
						if(valid)
							Alert.show("LoadProfileBarStaticData"+"\n"+profileStaticsDataResponse.ResponseMessage,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadProfileBarStaticData"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			
			}
			
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadProfileBarStaticDataCommand.";
			//	Alert.show("Fault occured in LoadProfileBarStaticDataCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadProfileBarStaticDataCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				 
		}
	}
}