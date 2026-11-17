package com.gazuntite.provider.live.services.elab.appController
{
	import com.adobe.cairngorm.control.FrontController;
	import com.gazuntite.provider.live.services.elab.command.EnterResultCommand;
	import com.gazuntite.provider.live.services.elab.command.ListOnlyLabsCommand;
	import com.gazuntite.provider.live.services.elab.command.LoadLabResultsByClinicBranchIdCommand;
	import com.gazuntite.provider.live.services.elab.command.LoadOrderDocumentCommand;
	import com.gazuntite.provider.live.services.elab.command.LoadPatientLabOrderByClinicIdCommand;
	import com.gazuntite.provider.live.services.elab.command.LoadTestTypeByNameCommand;
	import com.gazuntite.provider.live.services.elab.command.LoadeLabsStaticDataCommand;
	import com.gazuntite.provider.live.services.elab.command.ManageLabsCommand;
	import com.gazuntite.provider.live.services.elab.command.ProcessLabOrderByCriteriaCommand;
	import com.gazuntite.provider.live.services.elab.command.ProcessLabOrderCommand;
	import com.gazuntite.provider.live.services.elab.command.ProcessLabResultByCriteriaCommand;
	import com.gazuntite.provider.live.services.elab.command.ProcessLabResultCommand;
	import com.gazuntite.provider.live.services.elab.command.SearchLabsByClinicCommand;
	import com.gazuntite.provider.live.services.elab.command.ViewResultCommand;
	import com.gazuntite.provider.live.services.elab.event.ManageLabsEvent;

	public class ELabsController extends FrontController
	{
		
		public static const LOAD_PATIENT_LAB_ORDER_BY_CLINIC_ID_EVENT 	: String 	=	"load_patient_lab_order_by_clinic_id_event";
		public static const LOAD_LAB_RESULTS_BY_CLINIC_ID_EVENT 		: String 	=	"LOAD_LAB_RESULTS_BY_CLINIC_ID_EVENT";
		public static const LOAD_SEARCH_FIELDS_EVENT 					: String 	=	"Load_Search_Fields_Event";
		public static const PROCESS_ORDER_EVENT 						: String 	=	"PROCESS_ORDER_EVENT";
		public static const PROCESS_RESULT_EVENT 						: String 	=	"PROCESS_RESULT_EVENT";
		public static const SEARCH_LABS_BY_CLINIC 						: String 	=	"SEARCH_LABS_BY_CLINIC";
		public static const LIST_ONLY_LABS 								: String 	=	"LIST_ONLY_LABS";
		public static const PROCESS_LAB_ORDER_BY_CRITERIA 				: String 	=	"PROCESS_LAB_ORDER_BY_CRITERIA";
		public static const PROCESS_LAB_RESULT_BY_CRITERIA 				: String 	=	"PROCESS_LAB_RESULT_BY_CRITERIA";
		public static const LOAD_TEST_TYPE_BY_NAME 						: String 	=	"LOAD_TEST_TYPE_BY_NAME";
		public static const Manage_ELabs 								: String 	=	"Manage_ELabs";
		public static const LOAD_ORDER_DOCUMENT 						: String 	=	"LOAD_ORDER_DOCUMENT";
		public static const ENTER_LAB_RESULT 							: String 	=	"ENTER_LAB_RESULT";
		public static const VIEW_RESULT 								: String 	=	"VIEW_RESULT";
		
		private static var m_oELabsController:ELabsController ;
		
		public static function getInstance():ELabsController 
		{
			if ( m_oELabsController == null )
				m_oELabsController = new ELabsController(new Lock());
			return m_oELabsController;
		}
		
		public function ELabsController(lock:Lock)
		{
			if(null == lock )
				throw("Can't create object. please use getInstance() method instead ... ")
				
			addCommand( LOAD_PATIENT_LAB_ORDER_BY_CLINIC_ID_EVENT, 	LoadPatientLabOrderByClinicIdCommand 	);
			addCommand( LOAD_LAB_RESULTS_BY_CLINIC_ID_EVENT, 		LoadLabResultsByClinicBranchIdCommand 	);
			addCommand( LOAD_SEARCH_FIELDS_EVENT, 					LoadeLabsStaticDataCommand 				);
			addCommand( PROCESS_ORDER_EVENT, 						ProcessLabOrderCommand 					);
			addCommand( PROCESS_RESULT_EVENT, 						ProcessLabResultCommand					);
			addCommand( SEARCH_LABS_BY_CLINIC, 						SearchLabsByClinicCommand 				);
			addCommand( LIST_ONLY_LABS, 							ListOnlyLabsCommand 					);
			addCommand( PROCESS_LAB_ORDER_BY_CRITERIA, 				ProcessLabOrderByCriteriaCommand 		);
			addCommand( PROCESS_LAB_RESULT_BY_CRITERIA,				ProcessLabResultByCriteriaCommand 		);
			addCommand( LOAD_TEST_TYPE_BY_NAME, 					LoadTestTypeByNameCommand				);
			addCommand( Manage_ELabs, 								ManageLabsCommand 						);
			addCommand( LOAD_ORDER_DOCUMENT, 						LoadOrderDocumentCommand				);
			addCommand( ENTER_LAB_RESULT, 							EnterResultCommand						);
			addCommand( VIEW_RESULT, 								ViewResultCommand						);
		}
	}
}
class Lock
{
	//Singlton Lock
}