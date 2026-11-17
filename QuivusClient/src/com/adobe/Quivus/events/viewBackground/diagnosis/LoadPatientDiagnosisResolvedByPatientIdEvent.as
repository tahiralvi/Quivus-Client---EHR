package com.adobe.Quivus.events.viewBackground.diagnosis
{
	
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	
	public class LoadPatientDiagnosisResolvedByPatientIdEvent extends CairngormEvent 
	{
		public function LoadPatientDiagnosisResolvedByPatientIdEvent() 
		{
			super( AppController.LOAD_PATIENT_DIAGNOSIS_RESOLVED_BY_PATIENTID_EVENT);
			//this.visitId = visitId;
			
		}
	}
}