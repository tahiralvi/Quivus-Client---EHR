package com.gazuntite.patient.visit.command.assessment.diagnosis
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.dto.assessment.diagnosis.DiagnosisDTO;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.patient.visit.delegate.assessment.diagnosis.ManagePatientDiagnosisDelegate;
	import com.gazuntite.patient.visit.event.assessment.diagnosis.LoadPatientDiagnosisByVisitIdEvent;
	import com.gazuntite.patient.visit.model.QIModelLocator;
	import com.gazuntite.patient.visit.utils.Constants;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class ManagePatientDiagnosisCommand implements Command , IResponder
	{
		[Bindable]
		private var model:QIModelLocator = QIModelLocator.getInstance();
		
		public function ManagePatientDiagnosisCommand()
		{
		}
		
		public function execute( cgEvent:CairngormEvent ):void
		{
			if(model.LoggedInUserId)
			{
				var delegate : ManagePatientDiagnosisDelegate= new ManagePatientDiagnosisDelegate( this );
				
				
				if(model.diagnosisDTOListByPatientId!=null)
				{				
					
					var i:int;
					for(i=0;i<model.diagnosisDTOListByPatientId.length;i++)
					{
						var diagnosisDTO:DiagnosisDTO = model.diagnosisDTOListByPatientId.getItemAt(i) as DiagnosisDTO;
						
						if(diagnosisDTO.VisitDate == null)
						{
							diagnosisDTO.VisitDate= Constants.NULL_DATE;
						}
						
						diagnosisDTO.ModifiedBy = model.LoggedInUserId;
						diagnosisDTO.ModifiedAt = new Date();
					}
					
					var newList:ArrayCollection = new ArrayCollection();
					var actionDate:String = UtilityFunctions.FormatDate( new Date(), "MM-DD-YYYY");
					
					for (i=0; i < model.diagnosisDTOListByPatientId.length; i++)
					{
						var diagnosisDTO:DiagnosisDTO = model.diagnosisDTOListByPatientId.getItemAt(i) as DiagnosisDTO;
						
						if (diagnosisDTO.IsDeleted == true || diagnosisDTO.IsDirty == true)
						{
							newList.addItem(diagnosisDTO);
						}
						
					}
					if (newList.length > 0)
						delegate.ManagePatientDiagnosis(newList, model.LoggedInUserId, model.VisitID , model.patientID, actionDate, model.LoggedInUserSessionID);
				}
			}
		}	
	
		public function result(rpcEvent:Object):void
		{
			if (model.LoggedInUserId)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				if (re.result.@Status == "true")
				{
					//UtilityFunctions.ShowMessage( "ManagePatientDiagnosis Saved.", "Info" )
					var lpihEvent: LoadPatientDiagnosisByVisitIdEvent = new LoadPatientDiagnosisByVisitIdEvent(); 
					CairngormEventDispatcher.getInstance().dispatchEvent( lpihEvent );
				}
					
				else
				{
					UtilityFunctions.ShowMessage("ManagePatientDiagnosis \n\t No data returned from service.\nMesage: \n\t" + re.result.@Message + "\nDetails: \n\t" + re.result.@Details ,"Info");
				}
				
			}
		}
		
		public function fault(rpcEvent:Object) : void 
		{
			var errorStatus:String = "Fault occured in ManagePatientDiagnosis.";
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.LoggedInUserId )? -1:model.LoggedInUserId;
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, rpcEvent.toString(), userId);	
		}	
	}
}