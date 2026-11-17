package com.gazuntite.provider.live.services.documentMgmt.appController
{
	import com.adobe.cairngorm.control.FrontController;
	import com.gazuntite.provider.live.services.documentMgmt.command.CreateFTPFolderCommand;
	import com.gazuntite.provider.live.services.documentMgmt.command.LoadPatientDocumentByClinicIdCommand;
	import com.gazuntite.provider.live.services.documentMgmt.command.LoadProvidersCommand;
	import com.gazuntite.provider.live.services.documentMgmt.command.ManagePatientDocumentCommand;
	import com.gazuntite.provider.live.services.documentMgmt.command.SearchPatientDocumentCommand;
	import com.gazuntite.provider.live.services.documentMgmt.command.staticData.LoadDocumentSectionTypeStaticDataCommand;
	import com.gazuntite.provider.live.services.documentMgmt.command.staticData.LoadDocumentTypeStaticDataCommand;
	import com.gazuntite.provider.live.services.documentMgmt.command.staticData.LoadSearchByStaticDataListCommand;

	public class DMAppController extends FrontController {
		
		public static const LOAD_DOCUMENT_TYPE_STATIC_DATA_EVENT : String =					"LOAD_DOCUMENT_TYPE_STATIC_DATA_EVENT";
		public static const LOAD_DOCUMENT_SECTION_TYPE_STATIC_DATA_EVENT : String =			"LOAD_DOCUMENT_SECTION_TYPE_STATIC_DATA_EVENT";
		public static const LOAD_SEARCH_BY_STATIC_DATA_LIST_EVENT : String =				"LOAD_SEARCH_BY_STATIC_DATA_LIST_EVENT";
		
		
		public static const MANAGE_PATIENT_DOCUMENT_EVENT : String =						"MANAGE_PATIENT_DOCUMENT_EVENT";
		public static const LOAD_PATIENT_DOCUMENT_BY_CLINIC_ID_EVENT : String =				"LOAD_PATIENT_DOCUMENT_BY_CLINIC_ID_EVENT";
		
		public static const SEARCH_PATIENT_DOCUMENT_EVENT : String =						"SEARCH_PATIENT_DOCUMENT_EVENT";
		
		public static const CREATE_FTP_FOLDER_EVENT : String =								"CREATE_FTP_FOLDER_EVENT";
		
		
		public static const SEARCH_PATIENT_EVENT : String =									"SEARCH_PATIENT_EVENT";
		public static const LOAD_PROVIDERS_EVENT : String =									"LOAD_PROVIDERS_EVENT";
		
		private static var m_oDMAppController:DMAppController ;
		
		public static function getInstance():DMAppController 
		{
			if ( m_oDMAppController == null )
				m_oDMAppController = new DMAppController(new Lock());
			return m_oDMAppController;
		}
		
		public function DMAppController(lock:Lock)
		{
			if(null == lock )
				throw("Can't create object. please use getInstance() method instead ... ")
				
			addCommand( DMAppController.LOAD_DOCUMENT_TYPE_STATIC_DATA_EVENT, 		 LoadDocumentTypeStaticDataCommand);
			addCommand( DMAppController.LOAD_DOCUMENT_SECTION_TYPE_STATIC_DATA_EVENT,  LoadDocumentSectionTypeStaticDataCommand);
			addCommand( DMAppController.LOAD_SEARCH_BY_STATIC_DATA_LIST_EVENT,  		 LoadSearchByStaticDataListCommand);
			
			addCommand( DMAppController.SEARCH_PATIENT_DOCUMENT_EVENT,  		 		 SearchPatientDocumentCommand);
			
			
			
			addCommand( DMAppController.MANAGE_PATIENT_DOCUMENT_EVENT,  				 ManagePatientDocumentCommand);
			
			addCommand( DMAppController.LOAD_PATIENT_DOCUMENT_BY_CLINIC_ID_EVENT,  	 LoadPatientDocumentByClinicIdCommand);
			
			//addCommand( DMAppController.SEARCH_PATIENT_EVENT,  	 		             SearchPatientCommand);
			addCommand( DMAppController.LOAD_PROVIDERS_EVENT,  	 		             LoadProvidersCommand);
			
			addCommand( DMAppController.CREATE_FTP_FOLDER_EVENT,  	 		          CreateFTPFolderCommand);
		}
	}
}
class Lock
{
	//Singlton Lock
}