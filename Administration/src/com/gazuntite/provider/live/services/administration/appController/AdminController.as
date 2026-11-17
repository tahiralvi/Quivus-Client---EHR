package com.gazuntite.provider.live.services.administration.appController
{
	import com.adobe.cairngorm.control.FrontController;
	import com.gazuntite.provider.live.services.administration.command.accessRightManag.LoadSelectedUserAccessRightCommand;
	import com.gazuntite.provider.live.services.administration.command.accessRightManag.LoadUserGroupedByTypesCommand;
	import com.gazuntite.provider.live.services.administration.command.accessRightManag.ManageUserAccessRightCommand;
	import com.gazuntite.provider.live.services.administration.command.generalSetting.LoadClinicGeneralSettingAdminCommand;
	import com.gazuntite.provider.live.services.administration.command.generalSetting.ManageGeneralSettingCommand;
	import com.gazuntite.provider.live.services.administration.command.locationManagement.LoadAllStationsByClinicBranchIDCommand;
	import com.gazuntite.provider.live.services.administration.command.locationManagement.LoadClinicRoomByStationIdCommand;
	import com.gazuntite.provider.live.services.administration.command.locationManagement.LoadPracticeDetailsCommand;
	import com.gazuntite.provider.live.services.administration.command.locationManagement.LoadSpecialityTypesCommand;
	import com.gazuntite.provider.live.services.administration.command.locationManagement.SaveAllRoomsByClinicBranchIDCommand;
	import com.gazuntite.provider.live.services.administration.command.locationManagement.SavePracticeDetailsCommand;
	import com.gazuntite.provider.live.services.administration.command.locationManagement.SaveStationDetailsCommand;
	import com.gazuntite.provider.live.services.administration.command.roleManagement.LoadRoleAccessRightCommand;
	import com.gazuntite.provider.live.services.administration.command.roleManagement.LoadRoleCommand;
	import com.gazuntite.provider.live.services.administration.command.roleManagement.ManageRoleAccessRightCommand;
	import com.gazuntite.provider.live.services.administration.command.userManagement.ChangePasswordCommand;
	import com.gazuntite.provider.live.services.administration.command.userManagement.GetClinicUserDetailsCommand;
	import com.gazuntite.provider.live.services.administration.command.userManagement.GetPharmaciesCommand;
	import com.gazuntite.provider.live.services.administration.command.userManagement.GetProviderInsuranceCommand;
	import com.gazuntite.provider.live.services.administration.command.userManagement.LoadAllUserTypeCommand;
	import com.gazuntite.provider.live.services.administration.command.userManagement.LoadClinicBranchUsersCommand;
	import com.gazuntite.provider.live.services.administration.command.userManagement.LoadSubscriberCommand;
	import com.gazuntite.provider.live.services.administration.command.userManagement.ManageProviderInsuranceCommand;
	import com.gazuntite.provider.live.services.administration.command.userManagement.SaveAddressCommand;
	import com.gazuntite.provider.live.services.administration.command.userManagement.SaveGaxenIdCommand;
	import com.gazuntite.provider.live.services.administration.command.userManagement.SaveQuivusManagerCommand;
	import com.gazuntite.provider.live.services.administration.command.userManagement.SubscribePatientCommand;
	import com.gazuntite.provider.live.services.administration.command.userManagement.UpdateUserStatusCommand;

	public class AdminController extends FrontController
	{
		
		public static const LOAD_USER_ROLES_EVENT : String =	"LOAD_USER_ROLES_EVENT";
		
		public static const LOAD_ROLE_ACCESS_RIGHT_EVENT : String =	"LOAD_ROLE_ACCESS_RIGHT_EVENT";
		
		public static const MANAGE_ROLE_ACCESS_RIGHT_EVENT : String =	"MANAGE_ROLE_ACCESS_RIGHT_EVENT";
		
		public static const LOAD_USER_GROUPED_BY_TYPES_EVENT : String =	"LOAD_USER_GROUPED_BY_TYPES_EVENT";
		
		public static const LOAD_SELECTED_USER_ACCESS_RIGHT_EVENT : String =	"LOAD_SELECTED_USER_ACCESS_RIGHT_EVENT";
		
		public static const MANAGE_USER_ACCESS_RIGHT_EVENT : String =	"MANAGE_USER_ACCESS_RIGHT_EVENT";
		
		public static const LOAD_CLINIC_BRANCH_USERS_EVENT : String =	"LOAD_CLINIC_BRANCH_USERS_EVENT";
		
		public static const UPDATE_USER_STATUS_EVENT : String =	"UPDATE_USER_STATUS_EVENT";
		
		public static const LOAD_CLINIC_GENERAL_SETTING_ADMIN_EVENT : String =	"LOAD_CLINIC_GENERAL_SETTING_ADMIN_EVENT";
		
		public static const MANAGE_GENERAL_SETTING_EVENT : String =	"MANAGE_GENERAL_SETTING_EVENT";
		
		public static const CHANGE_PASSWORD_EVENT : String =	"CHANGE_PASSWORD_EVENT";
		public static const LOAD_USER_BASIC_INFO_EVENT : String =	"LOAD_USER_BASIC_INFO_EVENT";
		public static const LOAD_PHARMACY_INFO_EVENT : String =	"LOAD_PHARMACY_INFO_EVENT";
		public static const GET_PROVIDER_INSURANCE_EVENT : String =	"GET_PROVIDER_INSURANCE_EVENT";
		public static const LOAD_SERVICE_LEVELS_EVENT : String =	"LOAD_SERVICE_LEVELS_EVENT";
		public static const LOAD_PRESCRIBER_EVENT : String =	"LOAD_PRESCRIBER_EVENT";
		public static const MANAGE_PROVIDER_INSURANCE_EVENT : String =	"MANAGE_PROVIDER_INSURANCE_EVENT";
		public static const SAVE_ADDRESS_EVENT : String =	"SAVE_ADDRESS_EVENT";
		public static const SAVE_GAXEN_ID_EVENT : String =	"SAVE_GAXEN_ID_EVENT";
		public static const SAVE_QUIVUS_MANAGER_EVENT : String =	"SAVE_QUIVUS_MANAGER_EVENT";
		public static const ADMIN_SUBSCRIBE_PATIENT_EVENT : String =	"ADMIN_SUBSCRIBE_PATIENT_EVENT";
		public static const LOAD_ALL_USER_TYPE_EVENT : String =	"LOAD_ALL_USER_TYPE_EVENT";
		
		public static const LOAD_ALL_STATIONS_BY_CLINIC_BRANCH_ID_EVENT : String 			=	"LOAD_ALL_STATIONS_BY_CLINIC_BRANCH_ID_EVENT";
		public static const SAVE_STATION_DETAILS_EVENT : String 							=	"SAVE_STATION_DETAILS_EVENT";
		public static const LOAD_PRACTICE_DETAILS_EVENT : String 							=	"LOAD_PRACTICE_DETAILS_EVENT";
		public static const SAVE_PRACTICE_DETAILS_EVENT : String 							=	"SAVE_PRACTICE_DETAILS_EVENT";
		public static const LOAD_CLINIC_ROOM_BY_STATION_ID_EVENT : String 					=	"LOAD_CLINIC_ROOM_BY_STATION_ID_EVENT";
		public static const SAVE_ALL_ROOMS_BY_CLINIC_BRANCH_ID_EVENT : String 				=	"SAVE_ALL_ROOMS_BY_CLINIC_BRANCH_ID_EVENT";
		public static const LOAD_SPECIALITY_TYPES_EVENT : String 							=	"LOAD_SPECIALITY_TYPES";
		
		private static var m_oAdminController:AdminController ;
		
		public static function getInstance():AdminController 
		{
			if ( m_oAdminController == null )
				m_oAdminController = new AdminController(new Lock());
			return m_oAdminController;
		}
		
		public function AdminController(lock:Lock)
		{
			if(null == lock )
				throw("Can't create object. please use getInstance() method instead ... ")
				
			addCommand( LOAD_USER_ROLES_EVENT, LoadRoleCommand );
			addCommand( LOAD_ROLE_ACCESS_RIGHT_EVENT, LoadRoleAccessRightCommand );
			addCommand( MANAGE_ROLE_ACCESS_RIGHT_EVENT, ManageRoleAccessRightCommand );
			addCommand( LOAD_USER_GROUPED_BY_TYPES_EVENT,  LoadUserGroupedByTypesCommand );
			addCommand( LOAD_SELECTED_USER_ACCESS_RIGHT_EVENT,  LoadSelectedUserAccessRightCommand );
			addCommand( MANAGE_USER_ACCESS_RIGHT_EVENT,  ManageUserAccessRightCommand );
			addCommand( LOAD_CLINIC_BRANCH_USERS_EVENT,  LoadClinicBranchUsersCommand );
			addCommand( UPDATE_USER_STATUS_EVENT,   UpdateUserStatusCommand );
			addCommand( LOAD_CLINIC_GENERAL_SETTING_ADMIN_EVENT,   LoadClinicGeneralSettingAdminCommand );
			addCommand( MANAGE_GENERAL_SETTING_EVENT,    ManageGeneralSettingCommand );
			
			addCommand( CHANGE_PASSWORD_EVENT,    ChangePasswordCommand );
			addCommand( LOAD_USER_BASIC_INFO_EVENT,    GetClinicUserDetailsCommand );
			addCommand( LOAD_PHARMACY_INFO_EVENT,    GetPharmaciesCommand );
			addCommand( GET_PROVIDER_INSURANCE_EVENT,    GetProviderInsuranceCommand );
			addCommand( LOAD_PRESCRIBER_EVENT,    LoadSubscriberCommand );
			addCommand( MANAGE_PROVIDER_INSURANCE_EVENT,    ManageProviderInsuranceCommand );
			addCommand( SAVE_ADDRESS_EVENT,    SaveAddressCommand );
			addCommand( SAVE_GAXEN_ID_EVENT,    SaveGaxenIdCommand );
			addCommand( SAVE_QUIVUS_MANAGER_EVENT,    SaveQuivusManagerCommand );
			addCommand( ADMIN_SUBSCRIBE_PATIENT_EVENT,    SubscribePatientCommand );
			addCommand( LOAD_ALL_USER_TYPE_EVENT,    LoadAllUserTypeCommand );
			
			addCommand( LOAD_ALL_STATIONS_BY_CLINIC_BRANCH_ID_EVENT,    LoadAllStationsByClinicBranchIDCommand );
			addCommand( SAVE_STATION_DETAILS_EVENT,    SaveStationDetailsCommand );
			addCommand( LOAD_PRACTICE_DETAILS_EVENT,    LoadPracticeDetailsCommand );
			addCommand( SAVE_PRACTICE_DETAILS_EVENT,    SavePracticeDetailsCommand );
			addCommand( LOAD_CLINIC_ROOM_BY_STATION_ID_EVENT,    LoadClinicRoomByStationIdCommand );
			addCommand( SAVE_ALL_ROOMS_BY_CLINIC_BRANCH_ID_EVENT,    SaveAllRoomsByClinicBranchIDCommand );
			addCommand( LOAD_SPECIALITY_TYPES_EVENT,    LoadSpecialityTypesCommand );
			
			
		}
	}
}
class Lock
{
	//Singlton Lock
}