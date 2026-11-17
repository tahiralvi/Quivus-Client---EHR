package com.adobe.Quivus.command.viewBackground.ros
{
	import com.adobe.Quivus.delegate.viewBackground.ros.ManagePatientROSDelegate;
	import com.adobe.Quivus.events.viewBackground.ros.LoadPatientROSByPatientIdEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.common.util.exceptionAlert.QSExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class ManagePatientROSCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		private var rosList   : ArrayCollection = new ArrayCollection();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : ManagePatientROSDelegate = new ManagePatientROSDelegate( this );
				//setROSDTOToList();
				if(model.rosDTOListVB!=null)
				{				
					var i:int;
					
					
					var newList:ArrayCollection = new ArrayCollection();
					for(i=0;i<model.rosDTOListVB.length;i++)
					{
						var dto:ROSDTO = model.rosDTOListVB.getItemAt(i) as ROSDTO;
						if(dto.IsDeleted == true || dto.IsDirty == true)
						{
							dto.ModifiedBy = model.loggedInUserDTO.UserId;				
							dto.ModifiedAt = new Date();
							newList.addItem(dto);
						}
					}
					
					if(newList.length>0)
						delegate.ManagePatientROS(newList,model.sessionDTO);
				}
				
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:PatientROSResponse   = re.result as PatientROSResponse ;
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						var lpros:LoadPatientROSByPatientIdEvent = new LoadPatientROSByPatientIdEvent();
						CairngormEventDispatcher.getInstance().dispatchEvent( lpros );		
					}
					else
					{
						model.errorStatus = resp.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("ManagePatientROS"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("ManagePatientROS"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		private function setROSDTOToList():void
		{
			
			if(model.rosDTOListVB !=null && model.rosDTOListVB.length>0)
			{
				var i:int;
				for(i=0;i<model.rosDTOListVB.length;i++)
				{
					var dto:ROSDTO = model.rosDTOListVB.getItemAt(i) as ROSDTO ; 
					
					var j:int;
					for(j=0;j<dto.children.length;j++)
					{
						var child:ROSDTO = dto.children.getItemAt(j) as ROSDTO ;
						if(child.IsDirty)
						{
							rosList.addItem(child);
						}		
					}
					
					
					if(dto.PatientROSID == 0)
					{	
						dto.VisitID = model.visitId;
						dto.CreatedAt = new Date();
						dto.CreatedBy = model.loggedInUserDTO.UserId;
						
						dto.ModifiedAt = Constants.NULL_DATE;
					}
					
					if(!dto.DictationID)
					{
						dto.DictationID = Constants.GUID_FORMAT;
					}	
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in ManagePatientROSCommand.";
			//	Alert.show("Fault occured in ManagePatientROSCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in ManagePatientROSCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}