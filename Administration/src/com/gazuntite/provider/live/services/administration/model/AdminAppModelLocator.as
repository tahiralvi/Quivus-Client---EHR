package com.gazuntite.provider.live.services.administration.model
{
	import com.adobe.cairngorm.model.ModelLocator;
	import com.gazuntite.provider.live.services.administration.dto.userManagement.PharmaciesListDTO;
	import com.gazuntite.provider.live.services.administration.dto.userManagement.ProviderBasicInfoResult;
	import com.gazuntite.provider.live.services.administration.dto.userManagement.ProviderInsuranceDTO;
	import com.gazuntite.provider.live.services.administration.util.AdminConstant;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;

	[Bindable]
	public class AdminAppModelLocator implements ModelLocator 
	{
		private static var model 							:AdminAppModelLocator;
		
		public function AdminAppModelLocator()
		{
			if ( model != null )
				throw new Error( "Only one AdminAppModelLocator instance should be instantiated" );
		}
		
		private var _ProviderInsuranceList:ArrayCollection;	
		private var m_oSearchProviderResults:ProviderBasicInfoResult;
		private var m_oGeneralSetting:ObjectProxy;
		public  var securityProxyObject:ObjectProxy;
		private var m_acUserRoleList:ArrayCollection;
		private var m_acClinicalUserList:ArrayCollection;
		private var m_lAccessRightDTOList:ArrayCollection;
		private var m_lUserAccessRightDTOList:ArrayCollection;
		private var m_acUserGroupedByRoleList:ArrayCollection;
		private var m_PharmacyResults:PharmaciesListDTO;
		//private var _m_serviceLevelResults:ServiceLevelDTO;
		private var _CurrentProviderInsurance:ProviderInsuranceDTO;
		private var _InsuranceOrganizationList:ArrayCollection;
		
		public  var isNewRegistration:Boolean;			//for user management
		public  var selUserID:int;						//for user management
		private var _userTypeList:ArrayCollection; 		//for user management
		
		private var _allLocationsList:ArrayCollection;   	// for location managment
		private var _allRoomsList:ArrayCollection;     		// for location managment
		public  var practiceDetailProxyObj:ObjectProxy;     // for location managment
		public  var _arrSpecialtyTypes:ArrayCollection;     // for location managment
		public  var statscodeList:ArrayCollection;     // for location managment
		public  var citiesList:ArrayCollection;     // for location managment
		public  var zipcodeList:ArrayCollection;     // for location managment
		
		
		//**************** GETTER and SETTERS **************************************
		public function get allRoomsList():ArrayCollection
		{
			return _allRoomsList;
		}
		
		public function set allRoomsList(value:ArrayCollection):void
		{
			_allRoomsList = value;
		}
		
		public function get GeneralSetting():ObjectProxy
		{
			return m_oGeneralSetting;
		}
		public function set GeneralSetting(value:ObjectProxy):void
		{
			m_oGeneralSetting = value;
		}
		public function get UserAccessRightDTOList():ArrayCollection
		{
			return m_lUserAccessRightDTOList;
		}
		public function set UserAccessRightDTOList(value:ArrayCollection):void
		{
			m_lUserAccessRightDTOList = value;
		}
		public static function getInstance() : AdminAppModelLocator
		{
			if ( model == null )
				model = new AdminAppModelLocator();
			return model;
		}
		public function get ProviderInsuranceList():ArrayCollection
		{
			return _ProviderInsuranceList;
		}
		public function set ProviderInsuranceList(value:ArrayCollection):void
		{
			_ProviderInsuranceList = value;
		}
		public function get SearchProviderDetailsResults():ProviderBasicInfoResult
		{
			return m_oSearchProviderResults;
		}
		public function set SearchProviderDetailsResults(value:ProviderBasicInfoResult):void
		{
			m_oSearchProviderResults = value;
		}
		public function get ClinicalUserList():ArrayCollection
		{
			return m_acClinicalUserList;
		}
		public function set ClinicalUserList(value:ArrayCollection):void
		{
			m_acClinicalUserList = value;
		}
		public function get UserRoleList():ArrayCollection
		{
			return m_acUserRoleList;
		}
		public function set UserRoleList(value:ArrayCollection):void
		{
			m_acUserRoleList = value;
		}
		public function get AccessRightDTOList():ArrayCollection
		{
			return m_lAccessRightDTOList;
		}
		
		public function set AccessRightDTOList(value:ArrayCollection):void
		{
			m_lAccessRightDTOList = value;
		}
		public function get UserGroupedByRoleList():ArrayCollection
		{
			return m_acUserGroupedByRoleList;
		}
		
		public function set UserGroupedByRoleList(value:ArrayCollection):void
		{
			m_acUserGroupedByRoleList = value;
		}
		
		public function get PharmacyListDTO():PharmaciesListDTO
		{
			return m_PharmacyResults;
		}
		
		public function set PharmacyListDTO(value:PharmaciesListDTO):void
		{
			m_PharmacyResults = value;
		}
		
		/*public function get serviceLevelsDTO():ServiceLevelDTO
		{
			return _m_serviceLevelResults;
		}
		
		public function set serviceLevelsDTO(value:ServiceLevelDTO):void
		{
			_m_serviceLevelResults = value;
		}*/
		
		public function get CurrentProviderInsurance():ProviderInsuranceDTO
		{
			return _CurrentProviderInsurance;
		}
		
		public function set CurrentProviderInsurance(value:ProviderInsuranceDTO):void
		{
			_CurrentProviderInsurance = value;
		}
		
		public function get InsuranceOrganizationList():ArrayCollection
		{
			return _InsuranceOrganizationList;
		}
		
		public function set InsuranceOrganizationList(value:ArrayCollection):void
		{
			_InsuranceOrganizationList = value;
		}
		public function get userTypeList():ArrayCollection
		{
			return _userTypeList;
		}
		
		public function set userTypeList(value:ArrayCollection):void
		{
			_userTypeList = value;
		}
		
		public function get allLocationsList():ArrayCollection
		{
			return _allLocationsList;
		}
		
		public function set allLocationsList(value:ArrayCollection):void
		{
			_allLocationsList = value;
		}
		
		public function get arrSpecialtyTypes():ArrayCollection
		{
			return _arrSpecialtyTypes;
		}
		
		public function set arrSpecialtyTypes(value:ArrayCollection):void
		{
			_arrSpecialtyTypes = value;
		}
		
		//**************** GETTER and SETTERS **************************************
		
		
		//########################### Quivus Configuration ##########################
		private var _ConfigXML							:XML;
		
		public function get ConfigXML():XML
		{
			return _ConfigXML;
		}
		
		public function set ConfigXML(value:XML):void
		{
			_ConfigXML = value;
			
			AdminConstant.SECURITY_SERVICE_BASE_URL 			= value.property.( @name == 'SECURITY_SERVICE_BASE_URL')[0].@value;
			AdminConstant.QUIVUS_SECURITY_SERVICE_BASE_URL 		= value.property.( @name == 'QUIVUS_SECURITY_SERVICE_BASE_URL')[0].@value;
			AdminConstant.QUIVUS_PROVIDER_SERVICE_BASE_URL  	= value.property.( @name == 'EPRESCRIPTION_PROVIDER_SERVICE')[0].@value;
			AdminConstant.RESTFULL_ADRESSBOOK_SERVICE_BASE_URL  = value.property.( @name == 'EPRESCRIPTION_ADRESSBOOK_SERVICE')[0].@value;
		}
		
		//########################### UPDATE MODEL - LIVE SERVICES ########################################
		public function updateModel(loggedInUserId:int, loggedInUserProviderId:int, loggedInUserProviderTypeId:int, loggedInUserSelectedBranchId:int, userSelectedPracticeName:String, stationName:String, stationId:int, authentication:ObjectProxy, IsloggedInUserProvider:Boolean):void
		{
			this.loggedInUserId						= loggedInUserId;
			this.loggedInUserProviderId				= loggedInUserProviderId;
			this.loggedInUserProviderTypeId			= loggedInUserProviderTypeId;
			this.loggedInUserSelectedBranchId		= loggedInUserSelectedBranchId;
			this.loggedInUserSelectedPracticeName	= userSelectedPracticeName; 
			this.loggedInUserSelectedStationName 	= stationName; 
			this.loggedInUserSelectedStationId		= stationId;
			this.authentication						= authentication;
		}

		//############################ DATA MEMBERS ###########################################
		// LOGGED IN USER DATA - START
		public var loggedInUserId:int 						//= 42;
		public var loggedInUserProviderId:int 				//= 39;
		public var loggedInUserProviderTypeId:int;
		public var loggedInUserSelectedBranchId:int;
		public var loggedInUserSelectedPracticeName:String;//clinic branch name
		public var loggedInUserSelectedStationName:String;
		public var loggedInUserSelectedStationId:int;		//= 1;
		public var authentication:ObjectProxy;
		// LOGGED IN USER DATA - END
				
		private var m_iTotalRecords:int,
		m_iFirstRecord:int,
		m_iLastRecord:int,
		m_iTotalPageNo:int,
		m_iCurrentPageNo:int;
		
		//######################### DATA MEMBERS END ##########################################
	}
}