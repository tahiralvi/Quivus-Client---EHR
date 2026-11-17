package com.adobe.Quivus.command.viewBackground.document
{
	import com.adobe.Quivus.delegate.viewBackground.document.LoadSectionTypesDelegate;
	import com.adobe.Quivus.events.viewBackground.document.LoadSectionTypesEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.dto.typeDTO.DocumentSectionTypeDTO;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.common.util.exceptionAlert.QSExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;
	
	import valueObjects.SectionTypeResponse;
	
	public class LoadSectionTypesCommand implements Command, IResponder
	{
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		
		public function execute(cgEvent:CairngormEvent):void
		{
			if(model.UserLoggedIn)
			{
				var delegate : LoadSectionTypesDelegate = new LoadSectionTypesDelegate( this );
				
				var LE:LoadSectionTypesEvent = cgEvent as LoadSectionTypesEvent;
				
				
				delegate.LoadSectionTypes(model.sessionDTO);
			}
		}
		
		public function result( rpcEvent : Object):void
		{
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				model.docSectionTypeDTOList = new ArrayCollection();
				
				var resp:SectionTypeResponse  = re.result as SectionTypeResponse ;
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						model.docSectionTypeDTOList = resp.ResponseData;
						/*var arr:ObjectProxy = re.result.ArrayOfDocumentSectionTypeDTO as ObjectProxy;
						var array:ArrayCollection = arr.DocumentSectionTypeDTO as ArrayCollection;
						
						if(array!=null)
						{
							var i:int;
							for(i=0;i<array.length;i++)
							{
								var obj:ObjectProxy = array.getItemAt(i) as ObjectProxy;
								
								var documentObj:DocumentSectionTypeDTO = new DocumentSectionTypeDTO();
								
								if(model.docSectionTypeDTOList == null)
									model.docSectionTypeDTOList = new ArrayCollection();
								
								documentObj.SectionId 			= obj.SectionId;
								documentObj.SectionName 		= obj.SectionName;
								documentObj.ParentId 			= obj.ParentId;
								documentObj.OrderNo 			= obj.OrderNo;
								//dockumentObj.ChildSectionType 	= (obj.ChildSectionType as ArrayCollection);
								model.docSectionTypeDTOList.addItem(documentObj);
								var arr2:ObjectProxy = obj.ChildSectionType as ObjectProxy;
								var array2:ArrayCollection = arr2.DocumentSectionTypeDTO as ArrayCollection;
								
								if(array2!=null)
								{
									var subArray:ArrayCollection = new ArrayCollection();
									
									var j:int;
									for(j=0;j<array2.length;j++)
									{
										var obj2:ObjectProxy = array2.getItemAt(j) as ObjectProxy;
										var documentObj2:DocumentSectionTypeDTO = new DocumentSectionTypeDTO();
										
										documentObj2.SectionId 			= obj2.SectionId;
										documentObj2.SectionName 		= obj2.SectionName;
										documentObj2.ParentId 			= obj2.ParentId;
										documentObj2.OrderNo 			= obj2.OrderNo;
										
										subArray.addItem(documentObj2);
										
										if(documentObj2.SectionName=="Other")
										{
											var linerObj2:DocumentSectionTypeDTO = new DocumentSectionTypeDTO();
											
											linerObj2.SectionId 		= obj2.SectionId;
											linerObj2.SectionName 		= documentObj.SectionName +"-"+ documentObj2.SectionName;
											linerObj2.ParentId 			= obj2.ParentId;
											linerObj2.OrderNo 			= obj2.OrderNo;
											
											model.docSectionTypeDTOList.addItem(linerObj2);
										}
										else
										{
											model.docSectionTypeDTOList.addItem(documentObj2);
										}
										
									}
									
									documentObj.ChildSectionType = subArray;
								}
								
								if(model.docSectionTypeDTOList ==null)
									model.docSectionTypeDTOList = new ArrayCollection();
								
								
								model.docSectionTypeDTOList.addItem(documentObj);	
							}
						}*/
					}
					
				}else
				{
					Alert.show("LoadSectionTypes"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
			//********************************
			
			
		}
		
		public function fault(rpcEvent : Object):void
		{
			model.errorStatus = "Fault occured in LoadSectionTypesCommand.";
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(rpcEvent.toString(),"Fault occured in LoadSectionTypesCommand ","",model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert);*/
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}