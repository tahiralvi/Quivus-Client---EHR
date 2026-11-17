package com.gazuntite.provider.live.services.documentMgmt.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.dto.PatientDocumentDTO;
	import com.gazuntite.provider.live.services.documentMgmt.delegat.SearchPatientDocumentDelegate;
	import com.gazuntite.provider.live.services.documentMgmt.event.LoadPatientDocumentByClinicIdEvent;
	import com.gazuntite.provider.live.services.documentMgmt.event.SearchPatientDocumentEvent;
	import com.gazuntite.provider.live.services.documentMgmt.model.DMAppModelLocator;
	import com.gazuntite.provider.live.services.documentMgmt.util.DMConstant;
	import com.gazuntite.provider.live.services.documentMgmt.util.DMUtilityFunction;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.CursorManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;

	
	public class SearchPatientDocumentCommand  implements com.adobe.cairngorm.commands.Command {
		
		private var model 				: DMAppModelLocator = DMAppModelLocator.getInstance();
		
		private var responder			:Responder;
		private var delegate			:SearchPatientDocumentDelegate;
		
		public function execute( cgEvent:CairngormEvent ) : void {
			
			responder                 	= new Responder(onSuccess, onError);				
			delegate               		= new SearchPatientDocumentDelegate(responder);			
			
			
			
			var LE:SearchPatientDocumentEvent = cgEvent as SearchPatientDocumentEvent;
			if(LE.pageNo>0)
			{
				delegate.SearchPatientDocument(model.loggedInUserSelectedBranchId,LE.searchByFieldId,LE.searchString,LE.pageNo);
			}
			
		}
		
		
		private function onSuccess(event:ResultEvent):void
		{
			CursorManager.removeAllCursors();
			
			var re:ResultEvent = event as ResultEvent;
			if(re!=null && re.result!=null && re.result.PaggingResponseDTO!=null)
			{
				var dto:ObjectProxy	= re.result.PaggingResponseDTO as ObjectProxy;
				model.patientDocumentDTOList = new ArrayCollection();
				if(dto!=null)
				{
					var arr:ObjectProxy = dto.PatientDocumentsList as ObjectProxy;
					if( arr != null ) 
					{
						var array:ArrayCollection = arr.PatientDocumentDTO as ArrayCollection;
						
						model.totalRecord = dto.TotalRecord;
						model.firstRecord = dto.FirstRecord;
						model.lastRecord  = dto.LastRecord;
						
						if(model.totalRecord<DMConstant.PAGE_SIZE)
							model.patientDocumentTotalPageNo = 1;
						else
						{
							var num:int = model.totalRecord%DMConstant.PAGE_SIZE;
							if(num==0)
							{
								model.patientDocumentTotalPageNo = num;
							}
							else
							{
								model.patientDocumentTotalPageNo = num+1;
							}
						}
						
						if(array!=null)
						{
							var i:int;
							for(i=0;i<array.length;i++)
							{
								var obj:ObjectProxy = array.getItemAt(i) as ObjectProxy;
								
								var patientDocDTO:PatientDocumentDTO = new PatientDocumentDTO();
								
								
								DMUtilityFunction.populatePatientDocumentDTO(patientDocDTO,obj);
								
								
								
								var arr2:ObjectProxy = obj.ChildDocument as ObjectProxy;
								if(arr2!=null)
								{
									var array2:ArrayCollection = arr2.PatientDocumentDTO as ArrayCollection;
									
									if(array2!=null)
									{
										var subArray:ArrayCollection = new ArrayCollection();
										var j:int;
										for(j=0;j<array2.length;j++)
										{
											var obj2:ObjectProxy = array2.getItemAt(j) as ObjectProxy;
											var patientDocDTO2:PatientDocumentDTO = new PatientDocumentDTO();
											
											DMUtilityFunction.populatePatientDocumentDTO(patientDocDTO2,obj2);
											
											subArray.addItem(patientDocDTO2);
										}
										
										patientDocDTO.ChildDocument = subArray;
									}
									else
									{
										var singleObj:ObjectProxy = arr2.PatientDocumentDTO as ObjectProxy;
										
										if(singleObj!=null)
										{
											var singleDTO:PatientDocumentDTO = new PatientDocumentDTO();
											DMUtilityFunction.populatePatientDocumentDTO(singleDTO,singleObj);
											var subArray2:ArrayCollection = new ArrayCollection();
											subArray2.addItem(singleDTO);
											patientDocDTO.ChildDocument = subArray2;
										}
										
										
									}
								}
								
								
								model.patientDocumentDTOList.addItem(patientDocDTO);
							}
							
						}
						else
						{
							var singleObj2:ObjectProxy = arr.PatientDocumentDTO as ObjectProxy;	
							if(singleObj2!=null)
							{
								var patientDocDTO22:PatientDocumentDTO = new PatientDocumentDTO();
								
								
								DMUtilityFunction.populatePatientDocumentDTO(patientDocDTO22,singleObj2);
								var arr22:ObjectProxy = singleObj2.ChildDocument as ObjectProxy;
								if(arr22!=null)
								{
									var array23:ArrayCollection = arr22.PatientDocumentDTO as ArrayCollection;
									
									if(array23!=null)
									{
										var subArray22:ArrayCollection = new ArrayCollection();
										var n:int;
										for(n=0;n<array23.length;n++)
										{
											var obj222:ObjectProxy = array23.getItemAt(n) as ObjectProxy;
											var patientDocDTO3:PatientDocumentDTO = new PatientDocumentDTO();
											
											DMUtilityFunction.populatePatientDocumentDTO(patientDocDTO3,obj222);
											
											subArray22.addItem(patientDocDTO3);
										}
										
										patientDocDTO.ChildDocument = subArray22;
									}
									else
									{
										var singleObj22:ObjectProxy = arr22.PatientDocumentDTO as ObjectProxy;
										
										if(singleObj22!=null)
										{
											var singleDTO33:PatientDocumentDTO = new PatientDocumentDTO();
											DMUtilityFunction.populatePatientDocumentDTO(singleDTO33,singleObj22);
											var subArray234:ArrayCollection = new ArrayCollection();
											subArray234.addItem(singleDTO33);
											patientDocDTO.ChildDocument = subArray234;
										}
										
										
									}
								}
								
								
								model.patientDocumentDTOList.addItem(patientDocDTO);
							}
						}	
					}
				}
			}
		}
		
		
		
		
		
		private function onError(event:FaultEvent):void
		{
			CursorManager.removeAllCursors();
			Alert.show("Received In SearchPatientDocumentCommand.\n"+event.toString(), DMConstant.ERROR,4, FlexGlobals.topLevelApplication.mainContainer);
		}
		
		
	}
}