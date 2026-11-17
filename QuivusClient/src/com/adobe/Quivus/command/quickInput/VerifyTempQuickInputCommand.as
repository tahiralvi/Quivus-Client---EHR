package com.adobe.Quivus.command.quickInput
{
	import com.adobe.Quivus.delegate.quickInput.VerifyTempQuickInputDelegate;
	import com.adobe.Quivus.events.quickInput.VerifyTempQuickInputEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.AutoSaveUtility;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QuivusCombineEventDispatcher;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.events.CloseEvent;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class VerifyTempQuickInputCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		private var func:Function;
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : VerifyTempQuickInputDelegate = new VerifyTempQuickInputDelegate( this );
				
				var LE:VerifyTempQuickInputEvent = cgEvent as VerifyTempQuickInputEvent;				
				this.func = LE.func;
				var fileName : String;				
				
				fileName =  LE.fileName;
				
				//delegate.LoadQuickInputByVisitId(LE.visitId,model.sessionDTO);
				
				delegate.VerifyTempQuickInput(fileName, model.sessionDTO);
			
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var flag:Boolean  = re.result as Boolean ;
				if(flag != false){
					if(flag)
					{	
						Alert.show(Constants.MSG_QI_BODY, 
							Constants.MSG_QI_CRASH_HEADER,
							Alert.YES | Alert.NO, FlexGlobals.topLevelApplication.mainContainer, 
							function handleAlert(event:CloseEvent):void
							{
								if (event.detail == Alert.YES)
								{	
									//QuivusCombineEventDispatcher.createVisitStaticDataLoad();
									AutoSaveUtility.loadQuickInput(func);
									
									//M if(QI != null)
									{
										//model.quickInputDTO.Visit = QI.Visit;									
										
										//model.quickInputDTO = QI;
										
										//model.visitDTO = model.quickInputDTO.Visit;
										
										/*if(func != null)
										{
											func(model.quickInputDTO.Visit.VisitDate);
										}*/
										
									}
								}
								else if( event.detail == Alert.NO)
								{
									AutoSaveUtility.deleteQuickInput();
								}
							});
					}
					
					model.tempQIExists = flag;
					
				}
				else
				{
					Alert.show("VerifyTempQuickInput"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in VerifyTempQuickInput.";
				//Alert.show("Fault occured in VerifyTempQuickInput.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in VerifyTempQuickInput ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}