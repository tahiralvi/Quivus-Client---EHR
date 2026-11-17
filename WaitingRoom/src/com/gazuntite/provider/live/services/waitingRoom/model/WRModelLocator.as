package com.gazuntite.provider.live.services.waitingRoom.model
{
	import com.adobe.cairngorm.model.ModelLocator;
	import com.gazuntite.provider.live.services.waitingRoom.dto.AppointmentDTO;
	import com.gazuntite.provider.live.services.waitingRoom.dto.RoomDTO;
	import com.gazuntite.provider.live.services.waitingRoom.dto.StaticDataDTO;
	import com.gazuntite.provider.live.services.waitingRoom.util.WRConstant;
	
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.utils.ObjectProxy;
	
	[Bindable]
	public class WRModelLocator implements ModelLocator 
	{
		private var logger:ILogger = Log.getLogger("com.zigron.provider.live.services.waitingRoom.model.WaitingRoomModelLocator");
		
		private static var model 							:WRModelLocator;
		
		public function WRModelLocator() : void 
		{
			if ( model != null )
				throw new Error( "Only one WaitingRoomModelLocator instance should be instantiated" );
		}
		
		public static function getInstance() : WRModelLocator {
			if ( model == null )
				model = new WRModelLocator();
			return model;
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
			
			WRConstant.RESTFULL_SERVICE_BASE_URL = value.property.( @name == 'SCHEDULER_SERVICE_RESTFULSERVICE' 	)[0].@value;
			
			logger.debug( "RESTFULL_SERVICE_BASE_URL: " 		+ WRConstant.RESTFULL_SERVICE_BASE_URL );
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
		}
		
		//############################ DATA MEMBERS ###########################################
		
		
		// LOGGED IN USER DATA - START
		public var loggedInUserId:int 						//= 42;
		public var loggedInUserProviderId:int 				//= 39;
		public var loggedInUserProviderTypeId:int;
		public var loggedInUserSelectedBranchId:int;
		public var loggedInUserSelectedPracticeName:String;//clinic branch name
		public var loggedInUserSelectedStationName:String;
		public var loggedInUserSelectedStationId:int		//= 1;
		// LOGGED IN USER DATA - END
		
		private var m_oStaticDataList:StaticDataDTO = new StaticDataDTO();
		private var m_oAppointmentsList:ArrayCollection;
		private var m_oClinicRoomList:ArrayCollection;
		private var m_oSelectedRoomDTO:RoomDTO;
		private var m_oSelectedAppointmentDTO:AppointmentDTO;
		private var m_oSelectedRoomList:ArrayCollection;
		
		//######################### DATA MEMBERS END ##########################################
		
		//############################ DATA MEMBERS GETTERS SETTERS #########################################
		public function get AppointmentsList():ArrayCollection
		{
			return m_oAppointmentsList;
		}

		public function set AppointmentsList(value:ArrayCollection):void
		{
			m_oAppointmentsList = value;
		}
		public function get StaticData():StaticDataDTO
		{
			return m_oStaticDataList;
		}
		
		public function set StaticData(value:StaticDataDTO):void
		{
			m_oStaticDataList = value;
		}

		public function get ClinicRoomList():ArrayCollection
		{
			return m_oClinicRoomList;
		}

		public function set ClinicRoomList(value:ArrayCollection):void
		{
			m_oClinicRoomList = value;
		}

		public function get SelectedRoomDTO():RoomDTO
		{
			return m_oSelectedRoomDTO;
		}

		public function set SelectedRoomDTO(value:RoomDTO):void
		{
			m_oSelectedRoomDTO = value;
		}

		public function get SelectedAppointmentDTO():AppointmentDTO
		{
			return m_oSelectedAppointmentDTO;
		}

		public function set SelectedAppointmentDTO(value:AppointmentDTO):void
		{
			m_oSelectedAppointmentDTO = value;
		}

		public function get SelectedRoomList():ArrayCollection
		{
			return m_oSelectedRoomList;
		}

		public function set SelectedRoomList(value:ArrayCollection):void
		{
			m_oSelectedRoomList = value;
		}


		//######################### DATA MEMBERS GETTERS SETTERS END ##########################################
	}
}