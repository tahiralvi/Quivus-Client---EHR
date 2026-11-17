package com.adobe.Quivus.events.patientProfileCustomization {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class ManageUserPatientProfileBarSettingEvent extends CairngormEvent {
		
		public var userUserProfileCategoryId : int;
		public var sectionNo 				 : int;
		public var userProfileCategoryId 	 : int;
		public var setAsDefault			 	 : Boolean;

		public function ManageUserPatientProfileBarSettingEvent( sectionNo : int, userUserProfileCategoryId : int,userProfileCategoryId : int,setAsDefault	: Boolean ) {
			super( AppController.MANAGE_USER_PATIENT_PROFILE_BAR_SETTING_EVENT);
			this.sectionNo 					= sectionNo;
			this.userUserProfileCategoryId  = userUserProfileCategoryId;
			this.userProfileCategoryId 		= userProfileCategoryId;
			this.setAsDefault 		= setAsDefault;
			}
		}
	}