package com.gazuntite.dataBridge.documentMgmt
{
	import com.gazuntite.provider.live.services.documentMgmt.model.DMAppModelLocator;
	import com.gazuntite.provider.live.services.documentMgmt.util.DMQuivusCombineEventDispatcher;
	
	import mx.collections.ArrayCollection;

	public class DMController
	{
		private static var dmControllerInstance							:DMController;
		
		public function DMController() : void {
			if ( DMController.dmControllerInstance != null )
				throw new Error( "Only one DMController instance should be instantiated" );
		}
		
		public static function getInstance() : DMController {
			if ( dmControllerInstance == null )
				dmControllerInstance = new DMController();
			return dmControllerInstance;
		}
		
		public static function updateDMModel(loggedInUserId:int, loggedInUserProviderId:int,loggedInUserProviderTypeId:int,loggedInUserSelectedBranchId:int, userSelectedPracticeName:String, stationName:String):void
		{
			var dmModel:DMAppModelLocator = DMAppModelLocator.getInstance();
			
			dmModel.loggedInUserId					=loggedInUserId;
			dmModel.loggedInUserProviderId			=loggedInUserProviderId;
			dmModel.loggedInUserProviderTypeId		=loggedInUserProviderTypeId;
			dmModel.loggedInUserSelectedBranchId	=loggedInUserSelectedBranchId;
			dmModel.loggedInUserSelectedPracticeName=userSelectedPracticeName; 
			dmModel.loggedInUserSelectedStationName =stationName; 
		}
		
		public static function hasAnyOpenSocket():Boolean
		{
			var dmModel:DMAppModelLocator = DMAppModelLocator.getInstance();
			return dmModel.hasAnyOpenSocket;
		}
		
		public static function reinitializeOnLogOut():void
		{
			var dmModel:DMAppModelLocator = DMAppModelLocator.getInstance();
			
			dmModel.loggedInUserId					= undefined;
			dmModel.loggedInUserProviderId			= undefined;
			dmModel.loggedInUserProviderTypeId		= undefined;
			dmModel.loggedInUserSelectedBranchId	= undefined;
			
			dmModel.patientDocumentDTOList			= new ArrayCollection();
			
			dmModel.lProviderDTOList				= new ArrayCollection();
			
			dmModel.lPatientSearchDTOList			= new ArrayCollection();
			
			dmModel.patientSearchPageNo				= 1 ;
			dmModel.totalRecord						= 0 ;
			dmModel.firstRecord						= 0 ;
			dmModel.lastRecord						= 0 ;
			dmModel.patientDocumentTotalPageNo		= 0 ;
			dmModel.patientDocSearchPageNo			= 0;
		}
	}
}