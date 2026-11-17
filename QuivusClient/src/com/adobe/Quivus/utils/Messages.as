package com.adobe.Quivus.utils
{
	public class Messages
	{
		//###### these are for the pop-up headers		
		public static const INFO		 						:String = "Info";
		public static const ERROR		 						:String = "Error";
		
		
		public static const NO_CLINIC_BRANCH_INFO 				:String = "No info. about user clinic branches returned from service.";
		
		//### when service returns responce but the data in the responce is null
		public static const NO_DATA_RETURNED_FROM_SERVICE		:String = "No data returned from service.";
		
		//### when service returns null responce
		public static const NETWORK_ERROR 						:String = "Network Error";
		public static const NETWORK_NOT_AVAILABLE 				:String = "Network not available, please try later ...";
		public static const SERVICE_DIDNOT_RESPOND 				:String = "Service didnot respond.";
		
		
		public static const REGISTRATION_SUCCESSFULL 			:String = "Registration Successful";
		public static const UPDATE_PROFILE_SUCCESSFULL 			:String = "Updated Successfully";
		
		public static const EMAIL_SUCCESSFULL 					:String = "Email Sent Successfully";
		
		public static const UPDATE_SUCCESSFULL		 			:String = "Update Successful.";
		
		public static const VISIT_NOT_SAVED			 			:String = "Visit not saved.";
		
		public static const VISIT_NOT_CREATED		 			:String = "Visit not created.";
		
		/**Ayesha; 2nd May 2011
		 * Changing "Visit saved" to "Visit Signed Successfully."
		 * */
		public static const VISIT_SAVED			 				:String = "Patient Visit successfully saved.";
		
		public static const VISIT_SIGNED			 			:String = "Visit Signed Successfully.";
		
		public static const VISIT_CO_SIGNED			 			:String = "Visit Cosigned Successfully.";
		
		public static const SESSION_ID_VALID		 			:String = "Session id is invalid.";
		
	}
}