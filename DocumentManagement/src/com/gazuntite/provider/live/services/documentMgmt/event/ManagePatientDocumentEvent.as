package com.gazuntite.provider.live.services.documentMgmt.event {

	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.dto.PatientDocumentDTO;
	import com.gazuntite.provider.live.services.documentMgmt.appController.DMAppController;

	public class ManagePatientDocumentEvent extends CairngormEvent {
		
		public var pateintDocument 	: PatientDocumentDTO;
		public var isUpdated 		: Boolean;
		

		public function ManagePatientDocumentEvent( pateintDocument 	: PatientDocumentDTO, isUpdated:Boolean = false ) 
		{
			super( DMAppController.MANAGE_PATIENT_DOCUMENT_EVENT);
			this.pateintDocument = pateintDocument;
			this.isUpdated = isUpdated;
		}
		
		public static function convertDto( obj:Object ):PatientDocumentDTO
		{
			var myDto:PatientDocumentDTO = new PatientDocumentDTO();
			myDto.DocumentId 			= obj.DocumentId;
			myDto.DocumentName 			= obj.DocumentName;
			myDto.DocumentTypeId 		= obj.DocumentTypeId;
			myDto.DocumentTypeName 		= obj.DocumentTypeName;
			myDto.DocumentVirtualName 	= obj.DocumentVirtualName;
			myDto.IsDeleted				= obj.IsDeleted;
			
			return myDto;
		}
		}
	}