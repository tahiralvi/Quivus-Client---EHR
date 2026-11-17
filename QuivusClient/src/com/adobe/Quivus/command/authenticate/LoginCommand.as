package com.adobe.Quivus.command.authenticate
{
	import com.adobe.Quivus.delegate.authenticate.LoginDelegate;
	import com.adobe.Quivus.events.authenticate.LoginEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.view.controls.custom.loginView.MultiRegUserView;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class LoginCommand  implements com.adobe.cairngorm.commands.Command, IResponder 
	{
		private var model : AppModelLocator = AppModelLocator.getInstance();
		public var callBack    : Function;

		private var username:String;
		private var password:String;
		
		public function execute( cgEvent:CairngormEvent ) : void {
			
			var delegate : LoginDelegate = new LoginDelegate( this );
			var LE:LoginEvent = cgEvent as LoginEvent
			username = LE.username;
			password = LE.password;
			if(username!=null && username.length>0 && password!=null && password.length>0){
				  this.callBack = LE.callBack;
				delegate.LogIn(username,password );
			}
			
		}
		
		
		public function result( rpcEvent : Object ) : void {
			var re:ResultEvent = rpcEvent as ResultEvent;
			
			var loginResponceDTO:LoginResponse = re.result as LoginResponse;
			
			if(loginResponceDTO!=null)
			{
				if(loginResponceDTO.ResponseStatus)
				{
					var loginDTO:LoginDTO  = loginResponceDTO.ResponseData as LoginDTO;
					if(loginDTO!=null)
					{
						model.loggedInUserDTO = loginDTO;
						
						if(loginDTO.UserClinicBranchesList!=null && loginDTO.UserClinicBranchesList.length!=0)
						{					
													
							if(loginDTO.UserClinicBranchesList.length==1)
							{
								model.userSelectedClinicBranchDTO = loginDTO.UserClinicBranchesList.getItemAt(0) as UserClinicBranchDTO;
								
								if(model.userSelectedClinicBranchDTO.StationList!=null )
								{
									
																		
									model.userSelectedRoleDTO 		  = model.userSelectedClinicBranchDTO.ClinicBranchUserRole;
									
									if(model.userSelectedClinicBranchDTO.StationList.length==1)
									{
										model.userSelectedStationDTO    =   model.userSelectedClinicBranchDTO.StationList.getItemAt(0) as StationDTO;										
									}
									else
									{
										var index:int;
										for(index=0;index<model.userSelectedClinicBranchDTO.StationList.length;index++)
										{
											var dto:StationDTO = model.userSelectedClinicBranchDTO.StationList.getItemAt(index) as StationDTO;
											if(dto.IsDefault)
											{
												model.userSelectedStationDTO    = dto;
												break;
											}
										}
									}
									
									model.UserLoggedIn =true;
									model.quicklinkEnabled =true;		
									
									//Tahir Alvi - 
									// If local DB is not created then create it 
									// otherwise retain it and fetach records from Live DB
									/*var patUtil:LocalPatientsListUtility = new LocalPatientsListUtility();
									if(!patUtil.isPatientsDBAvaliable())//if Not alaready esist DB
									{
										patUtil.initializePatientsDB();//create and call service
									}else //If already exsist then find synch time and call service;
									{
										var date:Date = new Date(patUtil.getSyncTime())
										patUtil.callForPatientsList(date, false);
									}*/
									//moved to LoadUserAccessRightCommand
									//QuivusCombineEventDispatcher.dispatchEventForSessionKey();
								}
								else
								{
									Alert.show("Login"+"\n"+"No Station Info. Received from Server", Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
								}
							}
							else if(loginDTO.UserClinicBranchesList.length > 1)
							{
								
								var mr:MultiRegUserView = new MultiRegUserView;
								mr.Practice = loginDTO.UserClinicBranchesList;
								mr.LocationLableFunction= clinicBranchLabel;						
									
								mr.Show();
							}				
						}
						else
						{
							Alert.show("Login"+"\n"+Messages.NO_CLINIC_BRANCH_INFO, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
						}
					}
					else
					{
						Alert.show("Login"+"\n"+Messages.NO_DATA_RETURNED_FROM_SERVICE, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
					
				}
				else
				{
					model.errorStatus = loginResponceDTO.ResponseMessage ;
					/*Alert.show("Login"+"\n"+loginResponceDTO.ResponseMessage, "",4, FlexGlobals.topLevelApplication.mainContainer);*/
					if(this.callBack  != null)
					{
						this.callBack();
					}

				}
			}
			else
			{
				Alert.show("Login"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
			}
			trace("model in LoginCommand:"+model);
			trace("model in UserLoggedIn :"+model.UserLoggedIn);
		}
		
		private function clinicBranchLabel(item: Object): String
		{
		
			var clinicBranch:UserClinicBranchDTO = item as UserClinicBranchDTO;
			return clinicBranch.ClinicBranch.ClinicBranchName;
		
		}
		
		private function roleLabel(item: Object): String
		{
			
			var role:UserClinicRoleDTO = item as UserClinicRoleDTO;
			return role.UserTypeRole.UserTypeName;
			
		}
		
		public function fault( rpcEvent : Object ) : void {
			model.errorStatus = "Fault occured in LoginCommand.";
			//if(model.isUserManagerServiceOnline){
				//Alert.show("Fault occured in LoginCommand.\n"+rpcEvent.toString());*/
			//}
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(rpcEvent.toString(),"Fault occured in LoginCommand ","",model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert); */
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( "Fault occured in LoginCommand", rpcEvent.toString(), userId); 
				
		}
	}
}