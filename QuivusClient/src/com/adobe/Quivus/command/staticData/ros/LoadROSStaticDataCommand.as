package com.adobe.Quivus.command.staticData.ros
{
	
	
	import com.adobe.Quivus.delegate.staticData.ros.LoadROSStaticDataDelegate;
	import com.adobe.Quivus.events.staticData.ros.LoadROSStaticDataEvent;
	import com.adobe.Quivus.events.viewBackground.ros.LoadPatientROSByPatientIdEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.common.util.exceptionAlert.QSExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectUtil;
	
	import valueObjects.*;

	
	public class LoadROSStaticDataCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		public var callForPatientData:Boolean;
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				 var delegate:LoadROSStaticDataDelegate = new  LoadROSStaticDataDelegate(this);
				 
				 var LE:LoadROSStaticDataEvent = cgEvent as LoadROSStaticDataEvent;
				 this.callForPatientData = LE.callForPatientData;
				 delegate.LoadROSStaticData(LE.isMale,model.sessionDTO);
				
			}
		}
		
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:PatientROSResponse = re.result as PatientROSResponse;
				
				
				
				
				
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						if(resp.ResponseList!=null){
	
							model.rosDTOList = resp.ResponseList;
							//model.rosDTOListVB = new ArrayCollection( ObjectUtil.copy( resp.ResponseList.source ) as Array );
							//model.rosDTOListVB = new ArrayCollection(UtilityFunctions.clone(resp.ResponseList.source)  as Array);
							//cloneROSDTOListToROSDTOListVB();
							if(this.callForPatientData)
							{
								/*var lpros:LoadPatientROSByPatientIdEvent = new LoadPatientROSByPatientIdEvent();
								CairngormEventDispatcher.getInstance().dispatchEvent( lpros );
								model.vbEventCounter ++ ;*/
							}
						}
						else
						{
							Alert.show("LoadROSStaticData"+"\n"+Messages.NO_DATA_RETURNED_FROM_SERVICE.toString(),  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
						}
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("LoadROSStaticData"+"\n"+resp.ResponseMessage,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadROSStaticData"+"\n"+Messages.SERVICE_DIDNOT_RESPOND ,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		public function cloneROSDTOListToROSDTOListVB(  ) : void 
		{
			model.rosDTOListVB = new ArrayCollection();
			if(model.rosDTOList!=null)
			{
				var i:int;
				for(i=0;i<model.rosDTOList.length;i++)
				{
					var obj:ROSDTO = model.rosDTOList.getItemAt(i) as ROSDTO;
					var newOBJ:ROSDTO = new ROSDTO();
					
					newOBJ.PatientROSID 				= obj.PatientROSID;
					newOBJ.VisitID 						= obj.VisitID;
					newOBJ.PatientID 					= obj.PatientID;
					newOBJ.ROSMainCategoryTypeID 		= obj.ROSMainCategoryTypeID;
					newOBJ.ROSSubCategoryTypeID 		= obj.ROSSubCategoryTypeID;
					newOBJ.MainCategoryName 			= obj.MainCategoryName;
					newOBJ.SubCategoryName 				= obj.SubCategoryName;
					newOBJ.IsNormal 					= obj.IsNormal;
					newOBJ.DictationID 					= obj.DictationID;
					newOBJ.Notes 						= obj.Notes;
					newOBJ.CreatedBy 					= obj.CreatedBy;
					newOBJ.CreatedAt 					= obj.CreatedAt;
					newOBJ.ModifiedBy 					= obj.ModifiedBy;
					newOBJ.ModifiedAt 					= obj.ModifiedAt;
					newOBJ.VisitDate 					= obj.VisitDate;				
					
					if(obj.children!=null)
					{
						newOBJ.children = new ArrayCollection();
						var j:int;
						for(j=0;j<obj.children.length;j++)
						{
							var childObj:ROSDTO = obj.children.getItemAt(j) as ROSDTO;
							var newChildOBJ:ROSDTO = new ROSDTO();
							
							newChildOBJ.PatientROSID 				= childObj.PatientROSID;
							newChildOBJ.VisitID 					= childObj.VisitID;
							newChildOBJ.PatientID 					= childObj.PatientID;
							newChildOBJ.ROSMainCategoryTypeID 		= childObj.ROSMainCategoryTypeID;
							newChildOBJ.ROSSubCategoryTypeID 		= childObj.ROSSubCategoryTypeID;
							newChildOBJ.MainCategoryName 			= childObj.MainCategoryName;
							newChildOBJ.SubCategoryName 			= childObj.SubCategoryName;
							newChildOBJ.IsNormal 					= childObj.IsNormal;
							newChildOBJ.DictationID 				= childObj.DictationID;
							newChildOBJ.Notes 						= childObj.Notes;
							newChildOBJ.CreatedBy 					= childObj.CreatedBy;
							newChildOBJ.CreatedAt 					= childObj.CreatedAt;
							newChildOBJ.ModifiedBy 					= childObj.ModifiedBy;
							newChildOBJ.ModifiedAt 					= childObj.ModifiedAt;
							newChildOBJ.VisitDate 					= childObj.VisitDate;	
							
							newOBJ.children.addItem(newChildOBJ);
						}
					}
					
					model.rosDTOListVB.addItem(newOBJ);
				}
			}				
			
		}
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadROSStaticDataCommand.";
			//	Alert.show("Fault occured in LoadROSStaticDataCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadROSStaticDataCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}