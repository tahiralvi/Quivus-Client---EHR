package com.adobe.Quivus.command.staticData.physical
{
	
	
	import com.adobe.Quivus.delegate.staticData.physical.LoadPhysicalStaticDataDelegate;
	import com.adobe.Quivus.events.staticData.physical.LoadPhysicalStaticDataEvent;
	import com.adobe.Quivus.events.viewBackground.physical.LoadPatientPhysicalsByPatientIdEvent;
	import com.adobe.Quivus.model.AppModelLocator;
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

	
	public class LoadPhysicalStaticDataCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		public var callForPatientData:Boolean;
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				 var delegate:LoadPhysicalStaticDataDelegate = new  LoadPhysicalStaticDataDelegate(this);
				 
				 var LE:LoadPhysicalStaticDataEvent = cgEvent as LoadPhysicalStaticDataEvent;
				 this.callForPatientData = LE.callForPatientData;
				 delegate.LoadPhysicalStaticData(LE.isMale,model.sessionDTO);
			}
		}
		
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:PatientPhysicalResponse  = re.result as PatientPhysicalResponse ;
				
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						if(resp.ResponseList!=null){
	
							model.physicalsDTOList = resp.ResponseList;
							//model.physicalsDTOListVB = new ArrayCollection( ObjectUtil.copy( resp.ResponseList.source ) as Array );
							//model.physicalsDTOListVB = new ArrayCollection(UtilityFunctions.clone(resp.ResponseList.source)  as Array);
							//clonePhysicalsDTOListToPhysicalsDTOListVB();
							if(this.callForPatientData)
							{	
								/*var lpp:LoadPatientPhysicalsByPatientIdEvent = new LoadPatientPhysicalsByPatientIdEvent();
								CairngormEventDispatcher.getInstance().dispatchEvent( lpp );
								model.vbEventCounter == model.vbEventCounter + 1;*/
							}
						}
						else
						{
							Alert.show("LoadPhysicalStaticData"+"\n"+Messages.NO_DATA_RETURNED_FROM_SERVICE.toString(),  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
						}
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("LoadPhysicalStaticData"+"\n"+resp.ResponseMessage,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadPhysicalStaticData"+"\n"+Messages.SERVICE_DIDNOT_RESPOND ,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		
		}
		public function clonePhysicalsDTOListToPhysicalsDTOListVB(  ) : void 
		{
			model.physicalsDTOListVB = new ArrayCollection();
			if(model.physicalsDTOList!=null)
			{
				var i:int;
				for(i=0;i<model.physicalsDTOList.length;i++)
				{
					var obj:PhysicalsDTO = model.physicalsDTOList.getItemAt(i) as PhysicalsDTO;
					var newOBJ:PhysicalsDTO = new PhysicalsDTO();
					
					newOBJ.PatientPhysicalID  			= obj.PatientPhysicalID;
					newOBJ.VisitID  					= obj.VisitID;
					newOBJ.PatientID  					= obj.PatientID;
					newOBJ.PhysicalMainCategoryTypeID 	= obj.PhysicalMainCategoryTypeID;
					newOBJ.PhysicalSubCategoryTypeID  	= obj.PhysicalSubCategoryTypeID;
					newOBJ.MainCategoryName  			= obj.MainCategoryName;
					newOBJ.SubCategoryName 				= obj.SubCategoryName;
					newOBJ.IsNormal  					= obj.IsNormal;								
					newOBJ.DictationID  				= obj.DictationID;
					newOBJ.Notes  						= obj.Notes;
					newOBJ.CreatedBy  					= obj.CreatedBy;
					newOBJ.CreatedAt  					= obj.CreatedAt;
					newOBJ.ModifiedBy  					= obj.ModifiedBy;
					newOBJ.ModifiedAt 					= obj.ModifiedAt;
					newOBJ.VisitDate  					= obj.VisitDate;				
					
					if(obj.children!=null)
					{
						newOBJ.children = new ArrayCollection();
						var j:int;
						for(j=0;j<obj.children.length;j++)
						{
							var childObj:PhysicalsDTO = obj.children.getItemAt(j) as PhysicalsDTO;
							var newChildOBJ:PhysicalsDTO = new PhysicalsDTO();
							
							newChildOBJ.PatientPhysicalID  			= childObj.PatientPhysicalID;
							newChildOBJ.VisitID  					= childObj.VisitID;
							newChildOBJ.PatientID  					= childObj.PatientID;
							newChildOBJ.PhysicalMainCategoryTypeID 	= childObj.PhysicalMainCategoryTypeID;
							newChildOBJ.PhysicalSubCategoryTypeID  	= childObj.PhysicalSubCategoryTypeID;
							newChildOBJ.MainCategoryName  			= childObj.MainCategoryName;
							newChildOBJ.SubCategoryName 			= childObj.SubCategoryName;
							newChildOBJ.IsNormal  					= childObj.IsNormal;								
							newChildOBJ.DictationID  				= childObj.DictationID;
							newChildOBJ.Notes  						= childObj.Notes;
							newChildOBJ.CreatedBy  					= childObj.CreatedBy;
							newChildOBJ.CreatedAt  					= childObj.CreatedAt;
							newChildOBJ.ModifiedBy  				= childObj.ModifiedBy;
							newChildOBJ.ModifiedAt 					= childObj.ModifiedAt;
							newChildOBJ.VisitDate  					= childObj.VisitDate;
							
							newOBJ.children.addItem(newChildOBJ);
						}
					}
				
					
					model.physicalsDTOListVB.addItem(newOBJ);
				}
			}				
			
		}
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadPhysicalStaticDataCommand.";
			//	Alert.show("Fault occured in LoadPhysicalStaticDataCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadPhysicalStaticDataCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}