package com.gazuntite.patient.visit.command.summary
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.patient.visit.delegate.summary.LoadSummaryDelegate;
	import com.gazuntite.patient.visit.event.summary.LoadSummaryEvent;
	import com.gazuntite.patient.visit.model.VBModelLocator;
	import com.gazuntite.patient.visit.view.vbViews.vbTabSection.SummaryViewXMLCollection;
	import com.gazuntite.utils.UtilityFunctions;
	
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.CursorManager;
	import mx.managers.PopUpManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class LoadSummaryCommand  implements Command
	{
		private var model:VBModelLocator = VBModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadSummaryDelegate;
		
		private var callBack: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadSummaryDelegate( responder );			
			
			var LE:LoadSummaryEvent = cgEvent as LoadSummaryEvent;
			
			callBack = LE.callBack;
			/*var svdto:SummaryViewDTO 	= new SummaryViewDTO();
			svdto.ClinicBranchID 		= model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq;// LoggedInUserSelectedBranchId; , 
			svdto.PatientID 			= model.loadedPatientId;
			svdto.StationIDs 			= model.stationIdsForVB ;
			svdto.isAllSelected 		= model.isAllStationSelected;
			svdto.providerUserId 		= model.loggedInUserDTO.UserId;
			svdto.userTypeId			= model.userSelectedRoleDTO.UserTypeRole.UserTypeId;*/
			
			var xml2send:String = "<SummaryViewDTO>" +
				"<PatientID>" + model.patientID + "</PatientID>" +
				"<ClinicBranchID>" + model.LoggedInUserSelectedBranchId + "</ClinicBranchID>"+
				"<StationIDs>";
			
			var i:int;
			for (i = 0; i < model.stationIdsForVB.length; i++)
			{
				xml2send += "<int>" + model.stationIdsForVB[i] + "</int>";
			}
			
			xml2send += "</StationIDs>"+
				"<isAllSelected>" + model.isAllStationSelected + "</isAllSelected>"+
				"<providerUserId>" + model.LoggedInUserProviderId + "</providerUserId>"+
				"<userTypeId>" + model.LoggedInUserProviderTypeId + "</userTypeId>"+
				"</SummaryViewDTO>";
			
			delegate.LoadSummary( xml2send );	
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			model.lastVisitDate = '';
			model.nextAppointmentDate = '';
			var xml:XML = new XML(event.message.body.toString());
			
			if(xml.NextAppointmentDate != null)
				model.nextAppointmentDate = xml.NextAppointmentDate;
			if(xml.LastVisitDate != null)
				model.lastVisitDate = xml.LastVisitDate;
			// Show None if no date is comming
			if(model.nextAppointmentDate == '' || model.nextAppointmentDate == '1/1/1901' || model.nextAppointmentDate == '2/1/1901')
				model.nextAppointmentDate = 'None';
			if(model.lastVisitDate == '' || model.lastVisitDate == '1/1/1901'|| model.lastVisitDate == '1/1/1901')
				model.lastVisitDate = 'None';
			
			var summary:SummaryViewXMLCollection = new SummaryViewXMLCollection( event.result as XML );
			
			model.summary = summary;
			
			if( null != callBack )
				callBack();
			
		}
		
		private function onError(event:FaultEvent):void
		{
			model.errorStatus = "Fault occured in LoadSummaryCommand/LoadSummaryView";
			//Alert.show("Received In SearchPatientbyClinicIdCommand.\n" + event.toString(), PSConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
			
			
			//var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			
			var userId:int = model.LoggedInUserId;
			QSCombinedExceptionAlert.getInstance().Show(model.errorStatus, event.toString(), userId); 
			
		}
	}
}