package com.adobe.Quivus.delegate.patientProfileCustomization
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	import com.adobe.Quivus.utils.Constants;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadPatientHistoryPopupDataDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadPatientHistoryPopupDataDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadPatientHistoryPopupData(patientId:int,  dataToLoad:String, sessionDTO:UserSessionDTO ) : void {
			
			var token:AsyncToken ;
			
			if(dataToLoad == Constants.ALLERGIES_CATEGORY_NAME)
			{
				token = service.LoadPatientAllergiesForProvide(patientId,sessionDTO);
			}
			else if(dataToLoad == Constants.DIAGNOSIS_CATEGORY_NAME)
			{
				token = service.LoadPatientDiagnosisForProvider(patientId,sessionDTO);
			}
			else if(dataToLoad == Constants.IMMUNIZATION_CATEGORY_NAME)
			{
				token = service.LoadPatientImmunizationForProvider(patientId,sessionDTO);
			}
			else if(dataToLoad == Constants.CHRONIC_MEDICATION_CATEGORY_NAME)
			{
				token = service.LoadPatientMedicationForProvider(patientId,sessionDTO);
			}
			else if(dataToLoad == Constants.INSURANCE_CATEGORY_NAME)
			{
				token = service.LoadPatientInsuranceForProvider(patientId,sessionDTO);
			}
			
			token.addResponder( command );
		}		

	}
}