package com.adobe.Quivus.command.staticData.visit
{
	import com.adobe.Quivus.delegate.staticData.visit.LoadSoapTemplatesDelegate;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.common.util.exceptionAlert.QSExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class LoadSoapTemplatesCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadSoapTemplatesDelegate = new LoadSoapTemplatesDelegate( this );
				
				delegate.LoadSoapTemplates(model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq,model.sessionDTO);
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var soapTemplateResposne:SoapTemplateResponse   = re.result as SoapTemplateResponse ;
				
				if(soapTemplateResposne!=null)
				{
					if(soapTemplateResposne.ResponseStatus)
					{
						model.soapTemplateTypeDTOList = soapTemplateResposne.SoapTemplateList;
						if(model.soapTemplateTypeDTOList!= null && model.soapTemplateTypeDTOList.length>0)
						{
							var i:int;
							for(i=0;i<model.soapTemplateTypeDTOList.length;i++)
							{
								var temp:SoapTemplateTypeDTO = model.soapTemplateTypeDTOList.getItemAt(i) as SoapTemplateTypeDTO;
								if(temp.TemplateName == Constants.GENERAL_TEMPLATE_NAME)
								{
									model.generalTemplateId = temp.SoapTemplateID;
									break;
								}
							}
						}
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(soapTemplateResposne.ResponseCode);
						if(valid)
							Alert.show("LoadSoapTemplates"+"\n"+soapTemplateResposne.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadSoapTemplates"+"\n"+Messages.SERVICE_DIDNOT_RESPOND  ,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadVisitEncounterTypesCommand.";
			//	Alert.show("Fault occured in LoadVisitEncounterTypesCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadVisitEncounterTypesCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}