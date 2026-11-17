package com.gazuntite.provider.live.services.documentMgmt.util
{
	[Bindable]
	public class DMConstant
	{
	
		//public static const RESTFULL_SERVICE_BASE_URL			:String = "http://192.168.0.63:82/LiveProvider/DocumentManager/Service/RestFulService/DocumentManagementRestfulService.svc/";
		//public static const RESTFULL_SERVICE_BASE_URL			:String = "http://quivus.com/QuivusAir/LiveProvider/DocumentManager/Service/RestFulService/DocumentManagementRestfulService.svc/";
		//public static const RESTFULL_SERVICE_BASE_URL		:String = "http://quivus.com/QuivusAir/LiveProvider/DocumentManager/Service/RestFulService/DocumentManagementRestfulService.svc/";
		//public static const RESTFULL_SERVICE_BASE_URL		:String = "http://quivus.com/QuivusAirProduction/QLiveProvider/DocumentManager/Service/RestFulService/DocumentManagementRestfulService.svc/";

		//New URL for Dev....
		//public static RESTFULL_SERVICE_BASE_URL		:String = "http://www.quivus.com/QuivusAirDev/QLiveprovider/DManager/Service/RestFulService/DocumentManagementRestfulService.svc/";
		
		/**
		 * Although its not contant but treat it as constant. please don't modify the value. varification needed 
		 */		
		public static var RESTFULL_SERVICE_BASE_URL		:String ;
		public static var FTP_SERVICE_URL				:String ;
		public static var FTP_SERVICE_USERNAME			:String ;
		public static var FTP_SERVICE_PASSWORD			:String ;
		public static var FTP_SERVICE_ROOT_FOLDER_NAME	:String ;
		public static var FTP_SERVICE_PORT				:int ;

		public static var BUILD_TYPE					:String ;
		
		public static var NATIVE_BUILD					:String  = "Native";
		
		
		public static const ERROR							:String = "Error occured on server";
		
		public static const PAGE_SIZE						:int = 200;
		public static const FIRST_PAGE_NUMBER				:int = 1;
		
		
		
	}
}