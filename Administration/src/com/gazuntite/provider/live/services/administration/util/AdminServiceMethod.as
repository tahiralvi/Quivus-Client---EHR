package com.gazuntite.provider.live.services.administration.util
{
	[Bindable]
	public class AdminServiceMethod
	{
		public static const LOAD_ALL_ROLES							:String = "LoadAllUserTypes";
		
		public static const LOAD_ROLE_ACCESS_RIGHT					:String = "LoadRolesRightByUserTypeID";
		
		public static const MANAGE_ROLE_ACCESS_RIGHT				:String = "SaveRolesRightByUserTypeID";
		
		public static const LOAD_CLINICAL_USERS_GROUPED_BY_TYPES	:String = "LoadClinicalUsersGroupedByTypes";
		
		public static const LOAD_USER_ACCESS_RIGHTS					:String = "LoadUserAccessRight";
		
		public static const MANAGE_USER_ACCESS_RIGHTS				:String = 'SaveUserRightByUserID'; 
		
		public static const LOAD_CLINIC_BRANCH_USERS				:String = "LoadClinicBranchUsers";
		
		public static const UPDATE_USERS_TATUS						:String = "UpdateUserStatus";
		
		public static const LOAD_CLINIC_BRANCH_GENERAL_SETTING		:String = 'LoadClinicGeneralSetting';
		
		public static const MANAGE_GENERAL_SETTING					:String = "ManageGeneralSetting";
		
		public static var LOAD_ALL_USER_TYPE 							:String = "loadallusertype";
		
		public static var LOAD_PROVIDER_INSUANCE_BY_USER_ID 			:String = "LoadProviderInsuanceByUserId";
		
		public static const LOAD_CLINIC_USERS_BASIC_INFO				:String ="LoadClinicUsersBasicInfo";
		
		public static const LOAD_ALL_STATIONS_BY_CLINIC_BRANCH_ID		:String ="LoadAllStationsByClinicBranchID";
		
		public static const LOAD_CLINIC_ROOM_BY_STATION_ID				:String ="LoadClinicRoomByStationId";
		
		public static const LOAD_PRACTICE_DETAILS						:String ="LoadPracticeDetails";
		
		public static const SAVE_ALL_ROOMS_BY_CLINIC_BRANCH_ID			:String ="SaveAllRoomsByClinicBranchID";
		
		public static const SAVE_PRACTICE_DETAILS						:String ="SavePracticeDetails";
		
		public static const SAVE_STATION_DETAILS						:String ="SaveStationDetails";
		
		public static const LOAD_SPECIALITY_TYPES						:String ="LoadSpecialityTypes";
		
		
		
	}
}