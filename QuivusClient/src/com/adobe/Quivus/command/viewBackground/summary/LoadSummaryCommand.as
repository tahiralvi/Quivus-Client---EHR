package com.adobe.Quivus.command.viewBackground.summary
{
	import com.adobe.Quivus.delegate.viewBackground.summary.LoadSummaryDelegate;
	import com.adobe.Quivus.events.viewBackground.summary.LoadSummaryEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.view.controls.custom.patientExamView.viewBackground.vbTabSection.SummaryViewXMLCollection;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.CursorManager;
	import mx.managers.PopUpManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.SummaryViewDTO;
	import valueObjects.SummaryViewResponseDTO;

	public class LoadSummaryCommand  implements Command
	{
		private var model :AppModelLocator = AppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadSummaryDelegate;
		
		private var callBack			: Function;
		
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
				"<PatientID>"+model.loadedPatientId+"</PatientID>" +
				"<ClinicBranchID>"+model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq+"</ClinicBranchID>"+
				"<StationIDs>";
			var i:int;
			for( i = 0; i < model.stationIdsForVB.length; i++ )
			{
				xml2send += "<int>"+model.stationIdsForVB+"</int>";
			}
			xml2send += "</StationIDs>"+
				"<isAllSelected>"+model.isAllStationSelected+"</isAllSelected>"+
				"<providerUserId>"+model.loggedInUserDTO.UserId+"</providerUserId>"+
				"<userTypeId>"+model.userSelectedRoleDTO.UserTypeRole.UserTypeId+"</userTypeId>"+
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
			
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, event.toString(), userId); 
			
		}
	}
}