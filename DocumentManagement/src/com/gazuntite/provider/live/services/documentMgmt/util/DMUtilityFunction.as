package com.gazuntite.provider.live.services.documentMgmt.util
{
	
	import com.gazuntite.common.dto.PatientDocumentDTO;
	
	import mx.utils.ObjectProxy;

	public class DMUtilityFunction
	{
		public function DMUtilityFunction()
		{
		}
		
		public static function populatePatientDocumentDTO(patientDocDTO:PatientDocumentDTO,obj:ObjectProxy):void
		{
			
			patientDocDTO.DocumentId                = obj.DocumentId;
			
			patientDocDTO.SectionId 				= obj.SectionId;
			patientDocDTO.SectionName 				= obj.SectionName;
			
			
			//patientDocDTO.SubSectionId				= obj.SubSectionId;
			//patientDocDTO.DocumentTypeName			= obj.DocumentTypeName;
			
			patientDocDTO.CommentId					= obj.CommentId;
			patientDocDTO.CommentNote 				= obj.CommentNote;
			
			
			patientDocDTO.PatientID					= obj.PatientID;
			patientDocDTO.DocumentVirtualName		= obj.DocumentVirtualName;
			patientDocDTO.DocumentName				= obj.DocumentName;
			patientDocDTO.ServerFilePath			= obj.ServerFilePath;
			patientDocDTO.ClientFilePath			= obj.ClientFilePath;
			
			patientDocDTO.SectionId					= obj.SectionId;
			patientDocDTO.UploadedByUserId			= obj.UploadedByUserId;
			patientDocDTO.UploadedByUserTypeId		= obj.UploadedByUserTypeId;
			patientDocDTO.UploadedByClinicBranchId	= obj.UploadedByClinicBranchId;
			
			if(obj.UploadedDate!=null)
			{
				patientDocDTO.UploadedDate			= obj.UploadedDate;	
			}
			patientDocDTO.LastSeenByUserId			= obj.LastSeenByUserId;
			if(obj.LastSeenDate!=null)
			{
				patientDocDTO.LastSeenDate			= obj.LastSeenDate;
			}
			patientDocDTO.IsDocumentFileUploaded	= obj.IsDocumentFileUploaded;
			patientDocDTO.CreatedBy					= obj.CreatedBy;
			if(obj.CreatedAt!=null)
			{
				patientDocDTO.CreatedAt				= obj.CreatedAt;
			}
			if(obj.ModifiedAt!=null){
				patientDocDTO.ModifiedAt			= obj.ModifiedAt;
			}
			patientDocDTO.ModifiedBy				= obj.ModifiedBy;
			
			patientDocDTO.PatientFirstName			= obj.PatientFirstName;
			patientDocDTO.PatientLastName			= obj.PatientLastName;
			patientDocDTO.PatientMiddleName			= obj.PatientMiddleName;
			
			patientDocDTO.PatientFullName			= patientDocDTO.PatientFirstName+" "+patientDocDTO.PatientMiddleName+" "+patientDocDTO.PatientLastName;
			
			
			patientDocDTO.UploadedByUserFirstName	= obj.UploadedByUserFirstName;
			patientDocDTO.UploadedByUserLastName	= obj.UploadedByUserLastName;
			patientDocDTO.UploadedByUserMiddleName	= obj.UploadedByUserMiddleName;
			
			
			patientDocDTO.UploadedByUserFullName 	= obj.UploadedByUserFullName;
			patientDocDTO.PatientFullName 			= obj.PatientFullName;
			
			patientDocDTO.StrUploadedDate 			= obj.StrUploadedDate;
			
			/*patientDocDTO.TotalRecord  				= obj.TotalRecord ;
			patientDocDTO.FirstRecord  				= obj.FirstRecord ;
			patientDocDTO.LastRecord 	 			= obj.LastRecord ;*/
			patientDocDTO.QuivusId					= obj.QuivusId;
			patientDocDTO.GenderName				= obj.GenderName;
			
		}
	}
}