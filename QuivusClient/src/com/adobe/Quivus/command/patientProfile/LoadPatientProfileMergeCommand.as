package com.adobe.Quivus.command.patientProfile
{
	import com.adobe.Quivus.delegate.patientProfile.LoadPatientProfileMergeDelegate;
	import com.adobe.Quivus.events.patientProfile.LoadPatientProfileMergeEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class LoadPatientProfileMergeCommand implements Command
	{
		[Bindable]	private var model : AppModelLocator = AppModelLocator.getInstance();
		private var responder:Responder;
		private var delegate:LoadPatientProfileMergeDelegate;
		
		public function execute(cgEvent:CairngormEvent):void
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadPatientProfileMergeDelegate( responder );			
			
			var LE:LoadPatientProfileMergeEvent = cgEvent as LoadPatientProfileMergeEvent;
			delegate.LoadPatientProfileMerge(LE.UserID, LE.PatientID, LE.ClinicBranchID, LE.isAllSelected, LE.ShowAll, LE.UserTypeID, LE.isTemplateVisit, LE.fileName, LE.SectionNumber);
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			
		}
		
		private function onError(event:FaultEvent):void
		{
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( "Error in LoadPatientProfileMergeCommand", event.toString(), userId); 
		}
	}
}