package com.gazuntite.provider.live.services.documentMgmt.model
{
	import com.adobe.cairngorm.model.ModelLocator;
	import com.gazuntite.common.util.xml.XmlUtils;
	import com.gazuntite.provider.live.services.documentMgmt.util.DMConstant;
	
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.utils.ObjectProxy;
	[Bindable]
	public class DMAppModelLocator implements ModelLocator 
	{
		
		private var logger:ILogger = Log.getLogger("com.gazuntite.provider.live.services.documentMgmt.model.DMAppModelLocator");
		
		
		private static var model 							:DMAppModelLocator;
		
		
		public function DMAppModelLocator() : void {
			if ( DMAppModelLocator.model != null )
				throw new Error( "Only one DMAppModelLocator instance should be instantiated" );
		}
		
		
		
		
		public static function getInstance() : DMAppModelLocator {
			if ( model == null )
				model = new DMAppModelLocator();
			return model;
		}

		
		public function updateModel(loggedInUserId:int, loggedInUserProviderId:int, loggedInUserProviderTypeId:int, loggedInUserSelectedBranchId:int, userSelectedPracticeName:String, stationName:String, stationId:int, authentication:ObjectProxy, IsloggedInUserProvider:Boolean):void
		{
			this.loggedInUserId						= loggedInUserId;
			this.loggedInUserProviderId				= loggedInUserProviderId;
			this.loggedInUserProviderTypeId			= loggedInUserProviderTypeId;
			this.loggedInUserSelectedBranchId		= loggedInUserSelectedBranchId;
			this.loggedInUserSelectedPracticeName	= userSelectedPracticeName; 
			this.loggedInUserSelectedStationName 	= stationName; 
		}
		
		public function resetModel():void
		{
			this.loggedInUserId					= undefined;
			this.loggedInUserProviderId			= undefined;
			this.loggedInUserProviderTypeId		= undefined;
			this.loggedInUserSelectedBranchId	= undefined;
			
			this.patientDocumentDTOList			= new ArrayCollection();
			this.lProviderDTOList				= new ArrayCollection();
			this.lPatientSearchDTOList			= new ArrayCollection();
			
			this.patientSearchPageNo			= 1 ;
			this.totalRecord					= 0 ;
			this.firstRecord					= 0 ;
			this.lastRecord						= 0 ;
			this.patientDocumentTotalPageNo		= 0 ;
			this.patientDocSearchPageNo			= 0;
		}
		
		//########################### Gazuntite Configuration ##########################
		private var _ConfigXML							:XML;
		
		public function get ConfigXML():XML
		{
			return _ConfigXML;
		}
		
		public function set ConfigXML(value:XML):void
		{
			_ConfigXML = value;
			
			DMConstant.RESTFULL_SERVICE_BASE_URL 	= XmlUtils.getPropertyValueByName( 'DOCUMENT_MANAGEMENT_RESTFULSERVICE', value );
			DMConstant.FTP_SERVICE_URL 				= XmlUtils.getPropertyValueByName( 'FTP_SERVICE_URL', value );
			DMConstant.FTP_SERVICE_PORT 			= XmlUtils.getPropertyValueByName( 'FTP_SERVICE_PORT', value );
			DMConstant.FTP_SERVICE_USERNAME 		= XmlUtils.getPropertyValueByName( 'FTP_SERVICE_USERNAME', value );
			DMConstant.FTP_SERVICE_PASSWORD 		= XmlUtils.getPropertyValueByName( 'FTP_SERVICE_PASSWORD', value );
			DMConstant.FTP_SERVICE_ROOT_FOLDER_NAME = XmlUtils.getPropertyValueByName( 'FTP_SERVICE_ROOT_FOLDER_NAME', value );

			DMConstant.BUILD_TYPE 					= XmlUtils.getPropertyValueByName( 'BUILD_TYPE', value );
			
			logger.debug( "RESTFULL_SERVICE_BASE_URL: " 	+ DMConstant.RESTFULL_SERVICE_BASE_URL );
			logger.debug( "FTP_SERVICE_URL: " 				+ DMConstant.FTP_SERVICE_URL );
			logger.debug( "FTP_SERVICE_PORT: " 				+ DMConstant.FTP_SERVICE_PORT );
			logger.debug( "FTP_SERVICE_USERNAME: " 			+ DMConstant.FTP_SERVICE_USERNAME );
			//logger.debug( "FTP_SERVICE_PASSWORD: " 			+ DMConstant.FTP_SERVICE_PASSWORD ); //password is not shown in log
			logger.debug( "FTP_SERVICE_ROOT_FOLDER_NAME: " 	+ DMConstant.FTP_SERVICE_ROOT_FOLDER_NAME );
			
		}

		//############################ DATA MEMBERS ###########################################
		
		// LOGGED IN USER DATA - START
		public var loggedInUserId							:int;
		public var loggedInUserProviderId					:int;
		public var loggedInUserProviderTypeId				:int;
		public var loggedInUserSelectedBranchId				:int;
		
		public var loggedInUserSelectedPracticeName			:String;//clinic branch name
		public var loggedInUserSelectedStationName			:String;
		
		// LOGGED IN USER DATA - END
		
		
		
		// STATIC DATA - START
		
		public var documentTypeDTOList						:ArrayCollection;
		
		
		public var documentSectionTypeDTOList				:ArrayCollection; // tree structure
		
		
		public var documentSectionTypeDTOListLinear			:ArrayCollection; // linear structure
		
		public var searchFieldTypeDTOList					:ArrayCollection; // linear structure
		
		// STATIC DATA - END
		
		private var m_bHasAnyOpenSocket								:Boolean=false ;
		
		public var patientDocumentDTOList					:ArrayCollection;
		public var totalRecord								:int=0 ;
		public var firstRecord								:int=0 ;
		public var lastRecord								:int=0 ;
		public var patientDocumentTotalPageNo				:int=0 ;
		private var m_ipatientDocSearchPageNo				:int=1 ;
		public var isPatientDocSearching					:Boolean=false ;
		
		private var m_acProviderDTOList							:ArrayCollection;
		
		public function get lProviderDTOList():ArrayCollection
		{
			return m_acProviderDTOList;
		}
		
		public function set lProviderDTOList(value:ArrayCollection):void
		{
			m_acProviderDTOList = value;
		}
		
		public var lPatientSearchDTOList					:ArrayCollection;
		
		public var patientSearchPageNo						:int=1 ;
		
		
		public function get patientDocSearchPageNo():int
		{
			return m_ipatientDocSearchPageNo;
		}
		
		public function set patientDocSearchPageNo(value:int):void
		{
			if( value <= 0 )
			{
				m_ipatientDocSearchPageNo = 1;
			}
			else if( value >= patientDocumentTotalPageNo )
			{
				m_ipatientDocSearchPageNo = patientDocumentTotalPageNo;
			}
			else
			{
				m_ipatientDocSearchPageNo = value;
			}
		}
		
		
		//######################### DATA MEMBERS END ##########################################
		
		
		
		//############################ DATA MEMBERS GETTERS SETTERS #########################################
		public function get hasAnyOpenSocket():Boolean
		{
			return m_bHasAnyOpenSocket;
		}
		
		public function set hasAnyOpenSocket(value:Boolean):void
		{
			m_bHasAnyOpenSocket = value;
		}

		
		//######################### DATA MEMBERS GETTERS SETTERS END ##########################################
	}
}