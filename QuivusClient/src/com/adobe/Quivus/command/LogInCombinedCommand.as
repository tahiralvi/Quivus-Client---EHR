package com.adobe.Quivus.command
{
	import com.adobe.Quivus.customDTO.SyncDTO;
	import com.adobe.Quivus.customDTO.SyncInfo;
	import com.adobe.Quivus.delegate.LogInCombinedDelegate;
	import com.adobe.Quivus.events.LoadLoggedInUserImageEvent;
	import com.adobe.Quivus.events.LogInCombinedEvent;
	import com.adobe.Quivus.events.search.searchEngine.ChangeDefaultSearchEngineEvent;
	import com.adobe.Quivus.events.security.LoadUserAccessRightEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.Quivus.utils.QuivusCombineEventDispatcher;
	import com.adobe.Quivus.utils.network.DictationSyncUtility;
	import com.adobe.Quivus.utils.sql.LocalPatientsListUtility;
	import com.adobe.Quivus.view.controls.custom.loginView.MultiRegUserView;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.common.util.exceptionAlert.QSExceptionAlert;
	import com.gazuntite.provider.live.services.administration.event.generalSetting.LoadClinicGeneralSettingAdminEvent;
	import com.gazuntite.utils.UtilityFunctions;
	
	import flash.utils.Timer;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.managers.PopUpManager;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.LoginDTO;
	import valueObjects.LoginResponse;
	import valueObjects.SearchEngineDTO;
	import valueObjects.StationDTO;
	import valueObjects.UserClinicBranchDTO;
	
	public class LogInCombinedCommand   implements Command, IResponder 
	{
		private var logger:ILogger = Log.getLogger("com.adobe.Quivus.command.LogInCombinedCommand");
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		private var CE:LogInCombinedEvent;
		
		public var callBack    : Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			
			var delegate : LogInCombinedDelegate = new LogInCombinedDelegate( this );
			CE = cgEvent as LogInCombinedEvent;
			
			var username:String = CE.userName;
			var password:String = CE.passwd;
			if(username!=null && username.length>0 && password!=null && password.length>0)
			{
				this.callBack = CE.callBack;
				delegate.LogIn(username, password, CE.KickOutPreviousSession );
			}
			
		}
		
		
		public function result( rpcEvent : Object ) : void 
		{
			var re:ResultEvent = rpcEvent as ResultEvent;
			
			var loginResponceDTO:LoginResponse = re.result as LoginResponse;
			if(loginResponceDTO!=null)
			{
				if(loginResponceDTO.ResponseStatus && loginResponceDTO.ResponseData.isValidUser && !loginResponceDTO.ResponseData.isLocked && loginResponceDTO.ResponseData.isActive && !loginResponceDTO.ResponseData.IsPracticeExpired)
				{
					if( loginResponceDTO.UserSession.IsAlreadyLoggedIn )
					{
						//UtilityFunctions.AskMessage("You are already logged in from IP < " + loginResponceDTO.UserSession.ClientIPAdress + " >, you want to logout and login here?", 
						//	function():void
						//	{
								var lice:LogInCombinedEvent = new LogInCombinedEvent( CE.userName, CE.passwd, callBack );
								lice.KickOutPreviousSession = loginResponceDTO.UserSession.IsAlreadyLoggedIn;
								CairngormEventDispatcher.getInstance().dispatchEvent( lice );
						//	});
						return;
					}
					else
					{
						model.sessionDTO = loginResponceDTO.UserSession;
					}
					
					var loginDTO:LoginDTO  = loginResponceDTO.ResponseData as LoginDTO;
					if(loginDTO!=null)
					{
						model.loggedInUserDTO = loginDTO;
						populateProviderName();
						
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
									
									//Tahir Alvi - 
									// If local DB is not created then create it 
									// otherwise retain it and fetach records from Live DB
									//var patUtil:LocalPatientsListUtility 	= new LocalPatientsListUtility();
									model.SyncingApplication 				= true;
									/*model.SyncHeaderLabel 					= "Syncing Patients";
									model.SyncTotalToSyncLabel 				= "Total Patients to Sync";
									model.SyncSyncedLabel 					= "Patients Synced";*/
									
									/*var syncdto:SyncDTO = new SyncDTO();
									syncdto.message 	= "Checking new patients to synchronize";
									model.syncInfo.addContentByType( syncdto, SyncInfo.PATIENT_DATA );
									
									if(!patUtil.isPatientsDBAvaliable())//if Not alaready esist DB
									{
									patUtil.initializePatientsDB( SyncPendingDictation );//create and call service
									}
									else //If already exsist then find synch time and call service;
									{
									var date:Date = new Date(patUtil.getSyncTime())
									patUtil.callForPatientsList(date, false, SyncPendingDictation );
									}*/
									FlexGlobals.topLevelApplication.callLater( function():void
									{
										SyncPendingDictation();
									});
									//************** Call User Access rights when one station is avialable at Login ***************************
									//Tahir Alvi -Load User Access Rights
									var luiEvent : LoadUserAccessRightEvent = new LoadUserAccessRightEvent();
									CairngormEventDispatcher.getInstance().dispatchEvent( luiEvent );
									
									//Tahir Alvi -Load User Genral Setting
									var lgsEvent : LoadClinicGeneralSettingAdminEvent = new LoadClinicGeneralSettingAdminEvent();
									CairngormEventDispatcher.getInstance().dispatchEvent( lgsEvent );
									//************** Call User Access rights when one station is avialable at Login ***************************
								}
							}
							else if(loginDTO.UserClinicBranchesList.length > 1)
							{
								//this case is not properly handled .... what to do? ----- after performance changes --- June 8, 2012
								var mr:MultiRegUserView = new MultiRegUserView;
								mr.Practice = loginDTO.UserClinicBranchesList;
								mr.LocationLableFunction= clinicBranchLabel;						
								
								mr.Show();
							}
						}
					}
					
					
					//user image
					/*var imageDTO:ImageDTO = loginResponceDTO.UserImage;
					
					
					if(imageDTO!=null)
					{
					if(model!=null && model.loggedInUserDTO!=null)
					model.loggedInUserDTO.Image = imageDTO;
					}*/
					
					
					
					//////////////////////////////////////////////////////////////////////////////////////////////////////////
					//search engine
					//LoadUserSearchEngineEvent.isAlreadyLoaded = true;
					
					if(loginResponceDTO.SearchEngine && loginResponceDTO.SearchEngine.ResponseData!=null)
					{
						model.userSearchEngineDTOList = loginResponceDTO.SearchEngine.ResponseData;
						var i:int =0;
						var isPrefferedPresent:Boolean=false;
						for(;i<loginResponceDTO.SearchEngine.ResponseData.length;i++){
							//trace("searchEngine image byte length::"+(searchEngineResponceDTO.ResponseData.getItemAt(i) as SearchEngineDTO).icon.length);
							if((loginResponceDTO.SearchEngine.ResponseData.getItemAt(i) as SearchEngineDTO).IsPreferred){
								model.userPrefferedSearchEngineDTO = (loginResponceDTO.SearchEngine.ResponseData.getItemAt(i) as SearchEngineDTO);
								isPrefferedPresent=true;
								break;								
							}
							
						}
						if(!isPrefferedPresent && loginResponceDTO.SearchEngine.ResponseData.length>0)
						{
							model.userPrefferedSearchEngineDTO = (loginResponceDTO.SearchEngine.ResponseData.getItemAt(0) as SearchEngineDTO);
							
							var pbsdEvent : ChangeDefaultSearchEngineEvent = new ChangeDefaultSearchEngineEvent(model.loggedInUserDTO.UserId,
								model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq,
								model.userPrefferedSearchEngineDTO.UserSearchEngineID);
							CairngormEventDispatcher.getInstance().dispatchEvent( pbsdEvent );
						}
					}
					else
					{
						Alert.show("LogInCombinedCommand: SearchEngine"+"\n"+ Messages.NO_DATA_RETURNED_FROM_SERVICE +"\n"+ UtilityFunctions.IsNullOrEmpty( loginResponceDTO.SearchEngine )? "no search engines available":loginResponceDTO.SearchEngine.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
					
					
					//////////////////////////////////////////////////////////////////////////////////////////////////////////
					//ModuleType
					if(loginResponceDTO.ModuleType.ModuleTypeData!=null){
						
						model.allModulesDTOList = loginResponceDTO.ModuleType.ModuleTypeData;
					}
					else
					{
						Alert.show("LogInCombinedCommand: ModuleType"+"\n"+Messages.NO_DATA_RETURNED_FROM_SERVICE.toString(),  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
					
					//Tahir Alvi - At successfully Login alert expiry password
					if(loginResponceDTO.ResponseData.isAlertUser)
					{
						Alert.show('You have '+loginResponceDTO.ResponseData.RemainingDaysBeforeExpiry.toString()+' days remaining to expire password', 'Password Expiry Alert');
					}
					
					//Tahir Alvi- show confidentiality text alert to user after every login
					model.isUserLoginSuccessfully = true;
					
					//Tahir Alvi -Load User Access Rights
					//	var luiEvent : LoadUserAccessRightEvent = new LoadUserAccessRightEvent();
					//	CairngormEventDispatcher.getInstance().dispatchEvent( luiEvent );
					
					//Tahir Alvi -Load User Genral Setting
					//	var lgsEvent : LoadGeneralSettingMainEvent = new LoadGeneralSettingMainEvent();
					//	CairngormEventDispatcher.getInstance().dispatchEvent( lgsEvent );
					
				}
				else
				{
					//	if(loginResponceDTO.ResponseData.isValidUser)
					//	{
					//Tahir Alvi -  When user is locked show message
					if(loginResponceDTO.ResponseData.isLocked)
					{
						Alert.show('Your account has been locked'+'\n'+'', 'Account Locked' ,4, FlexGlobals.topLevelApplication.mainContainer);
						return;
					}
					//Tahir Alvi -  When password has been expired show message
					if(loginResponceDTO.ResponseData.isPasswordExpired)
					{
						Alert.show('Your password has been expired '+'\n'+'', 'Password Expired',4, FlexGlobals.topLevelApplication.mainContainer);
						return;
					}
					//Tahir Alvi -  When account has been inactive
					if(!loginResponceDTO.ResponseData.isActive && loginResponceDTO.ResponseData.isValidUser)
					{
						Alert.show('Your account has been inactive'+'\n'+'', 'Account InActive',4, FlexGlobals.topLevelApplication.mainContainer);
						return;
					}
					//}
					
					//loginResponceDTO.ResponseStatus
					//model.errorStatus = loginResponceDTO.ResponseMessage.toString() ;
					
					
					var valid:Boolean = QSUtilityFunctions.checkSession(loginResponceDTO.ResponseCode);
					if(valid)
					{
						//Alert.show("LogInCombinedCommand: ResponseStatus: " + loginResponceDTO.ResponseStatus + "\n"+loginResponceDTO.ResponseMessage.toString(), Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
						//logger.warn( "LogInCombinedCommand: ResponseStatus: " + loginResponceDTO.ResponseStatus + "\n"+loginResponceDTO.ResponseMessage.toString() );
					}
					
					if(this.callBack  != null)
					{
						this.callBack();
					}
				}
			}
			else
			{
				Alert.show("LogInCombinedCommand"+"\n"+Messages.SERVICE_DIDNOT_RESPOND +"\n"+ loginResponceDTO.ModuleType.ResponseMessage,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				logger.error( "LogInCombinedCommand"+"\n"+Messages.SERVICE_DIDNOT_RESPOND +"\n"+ loginResponceDTO.ModuleType.ResponseMessage );
			}
		}
		
		private function populateProviderName():void
		{
			model.providerName = '';
			if(model.loggedInUserDTO.FirstName.toLowerCase() != 'null' )
				model.providerName = model.loggedInUserDTO.FirstName;
			
			if(model.loggedInUserDTO.MiddleName)
			{
				if(model.loggedInUserDTO.MiddleName.toLowerCase() != 'null' )
					model.providerName = model.providerName+' '+ model.loggedInUserDTO.MiddleName;
			}
			
			if(model.loggedInUserDTO.LastName.toLowerCase() != 'null' )
				model.providerName = model.providerName+' '+model.loggedInUserDTO.LastName;
		}
		private function SyncPendingDictation():void
		{
			/*model.SyncHeaderLabel 		= "Uploading Pending Dictations";
			model.SyncTotalToSyncLabel 	= "Total Dictations to Sync";
			model.SyncSyncedLabel 		= "Dictations Synced";
			
			model.SyncSyncedCount 		= 0;
			model.SyncTotalToSyncCount 	= 0;*/
			
			/*var syncDto:SyncDTO 	= model.syncInfo.getContentByType( SyncInfo.PATIENT_DATA );
			syncDto.message			= "Patient data synchronized successfully.";
			syncDto.showProgress 	= false;
			syncDto.status			= "success";*/
			
			var syncdto:SyncDTO = new SyncDTO();
			syncdto.message 	= "Checking pending dictation to synchronize";
			model.syncInfo.addContentByType( syncdto, SyncInfo.DICTATION_DATA );
			FlexGlobals.topLevelApplication.callLater( function():void
			{
				var dictSync:DictationSyncUtility = new DictationSyncUtility( syncdto );
				dictSync.sync( SyncingApplicationComplete );
			});
		}
		
		private function SyncingApplicationComplete():void
		{
			/*var syncDto:SyncDTO 	= model.syncInfo.getContentByType( SyncInfo.PATIENT_DATA );
			syncDto.showProgress 	= false;
			if( syncDto.status == 'fail' )
			{
			syncDto.message			= "There were issues uploading dictation files.";
			}
			else
			{
			syncDto.message			= "Dictation data synchronized successfully.";
			syncDto.status			= "success";
			}*/
			
			
			
			FlexGlobals.topLevelApplication.callLater( function():void //let SyncingApplication view be rendered, if there is nothing to upload
			{
				model.UserLoggedIn			= true;
				model.quicklinkEnabled 		= true;
				model.SyncingApplication 	= false;
				QuivusCombineEventDispatcher.UpdateModel();
			});
			
			var luimEvent : LoadLoggedInUserImageEvent = new LoadLoggedInUserImageEvent();
			CairngormEventDispatcher.getInstance().dispatchEvent( luimEvent );
		}
		
		private function clinicBranchLabel(item: Object): String
		{
			
			var clinicBranch:UserClinicBranchDTO = item as UserClinicBranchDTO;
			return clinicBranch.ClinicBranch.ClinicBranchName;
		}
		
		public function fault( rpcEvent : Object ) : void 
		{
			model.errorStatus = "Fault occured in LogInCombinedCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}