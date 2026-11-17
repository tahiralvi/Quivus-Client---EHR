package com.gazuntite.dataBridge.controller
{
	import com.gazuntite.provider.eprescription.services.patient.model.EPrescriptionModelLocator;
	import com.gazuntite.provider.live.services.administration.model.AdminAppModelLocator;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.documentMgmt.model.DMAppModelLocator;
	import com.gazuntite.provider.live.services.elab.model.ELabsAppModelLocator;
	import com.gazuntite.provider.live.services.scheduler.model.SchedulerModelLocator;
	import com.gazuntite.provider.live.services.waitingRoom.model.WRModelLocator;
	import com.gazuntite.provider.search.services.patient.model.SearchPatientModelLocator;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;

	public class LiveServicesController
	{
		private static var m_oControllerInstance:LiveServicesController;
		
		private var authentication:ObjectProxy;
		
		public function get Authentication():ObjectProxy
		{
			return authentication;
		}

		public function set Authentication(value:ObjectProxy):void
		{
			authentication = value;
		}

		public static function getInstance():LiveServicesController 
		{
			if ( m_oControllerInstance == null )
				m_oControllerInstance = new LiveServicesController(new Lock());
			return m_oControllerInstance;
		}
		
		public function LiveServicesController(lock:Lock) : void 
		{
			if(null == lock )
				throw("Can't create object. please use getInstance() method instead ... ")
				
			if ( m_oControllerInstance != null )
				throw new Error( "Only one LiveServicesController instance should be instantiated" );
		}
		
		
		public function updateLiveServicesModel(loggedInUserId:int, loggedInUserProviderId:int, loggedInUserProviderTypeId:int, loggedInUserSelectedBranchId:int, userSelectedPracticeName:String, stationName:String, stationId:int, authentication:ObjectProxy, userIsProvider:Boolean):void
		{
			this.Authentication = authentication;
			
			DMAppModelLocator.getInstance()			.updateModel( loggedInUserId, loggedInUserProviderId, loggedInUserProviderTypeId, loggedInUserSelectedBranchId, userSelectedPracticeName, stationName, stationId, authentication, userIsProvider);
			SearchPatientModelLocator.getInstance()	.updateModel( loggedInUserId, loggedInUserProviderId, loggedInUserProviderTypeId, loggedInUserSelectedBranchId, userSelectedPracticeName, stationName, stationId, authentication, userIsProvider);
			SchedulerModelLocator.getInstance()		.updateModel( loggedInUserId, loggedInUserProviderId, loggedInUserProviderTypeId, loggedInUserSelectedBranchId, userSelectedPracticeName, stationName, stationId, authentication, userIsProvider);
			WRModelLocator.getInstance()	.updateModel( loggedInUserId, loggedInUserProviderId, loggedInUserProviderTypeId, loggedInUserSelectedBranchId, userSelectedPracticeName, stationName, stationId, authentication, userIsProvider);
			AdminAppModelLocator.getInstance()		.updateModel( loggedInUserId, loggedInUserProviderId, loggedInUserProviderTypeId, loggedInUserSelectedBranchId, userSelectedPracticeName, stationName, stationId, authentication, userIsProvider);
			ELabsAppModelLocator.getInstance()		.updateModel( loggedInUserId, loggedInUserProviderId, loggedInUserProviderTypeId, loggedInUserSelectedBranchId, userSelectedPracticeName, stationName, stationId, authentication, userIsProvider);
			BillingModelLocator.getInstance()		.updateModel( loggedInUserId, loggedInUserProviderId, loggedInUserProviderTypeId, loggedInUserSelectedBranchId, userSelectedPracticeName, stationName, stationId, authentication, userIsProvider);
			EPrescriptionModelLocator.getInstance()	.updateModel( loggedInUserId, loggedInUserProviderId, loggedInUserProviderTypeId, loggedInUserSelectedBranchId, userSelectedPracticeName, stationName, stationId, authentication, userIsProvider);
		}
		
		public function ApplicationConfig(configXML:XML ):void
		{
			DMAppModelLocator.getInstance().ConfigXML			= configXML;
			SchedulerModelLocator.getInstance().ConfigXML		= configXML;
			WRModelLocator.getInstance().ConfigXML		= configXML;
			SearchPatientModelLocator.getInstance().ConfigXML	= configXML;
			AdminAppModelLocator.getInstance().ConfigXML		= configXML;
			BillingModelLocator.getInstance().ConfigXML			= configXML;
			
			EPrescriptionModelLocator.getInstance().ConfigXML	= configXML;
		}
		
		public function hasAnyOpenSocket():Boolean 
		{
			var dmModel:DMAppModelLocator = DMAppModelLocator.getInstance();
			return dmModel.hasAnyOpenSocket;
		}
		
		public function reinitializeOnLogOut():void
		{
			DMAppModelLocator.getInstance().resetModel();
			
		}
	}
}
class Lock
{
	//Singlton Lock
}