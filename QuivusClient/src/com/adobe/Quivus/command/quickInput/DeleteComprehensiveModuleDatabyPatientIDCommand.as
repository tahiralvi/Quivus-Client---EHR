package com.adobe.Quivus.command.quickInput
{
	import com.adobe.Quivus.delegate.quickInput.DeleteComprehensiveModuleDatabyPatientIDDelegate;
	import com.adobe.Quivus.events.quickInput.DeleteComprehensiveModuleDatabyPatientIDEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.rpc.IResponder;

	public class DeleteComprehensiveModuleDatabyPatientIDCommand implements Command, IResponder 
	{
		private var model : AppModelLocator = AppModelLocator.getInstance();
		private var delegate:DeleteComprehensiveModuleDatabyPatientIDDelegate;
		//private var responder:IResponder;
		private var callBack:Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			//responder = new Responder(onSuccess, onError);				
			delegate  = new DeleteComprehensiveModuleDatabyPatientIDDelegate( this );			
			
			var LE:DeleteComprehensiveModuleDatabyPatientIDEvent  = cgEvent as DeleteComprehensiveModuleDatabyPatientIDEvent;
			
			callBack = LE.callBack;
			
			delegate.DeleteComprehensiveModuleData(LE.data, LE.patientId, LE.CH_Section, LE.typeID, LE.branchId);
		}
		
		public function result(event:Object):void
		{
			var xmlStr:String = event.result.toString();
			trace(xmlStr);
			if( null != callBack )
			{
				callBack();
			}
			//Alert.show("Deleted comprehensive history module data.  \n",'Info' );
		}
		
		public function fault(event:Object):void
		{
			model.errorStatus = "Error in DeleteComprehensiveModuleDatabyPatientIDCommand" ;
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(event.message.body.toString(),"Error Save Medical History Command ",event.fault.faultString,model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert); */
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, event.toString(), userId); 
			
		}
	}
}