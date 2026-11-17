package com.gazuntite.provider.live.services.documentMgmt.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.dto.PatientDocumentDTO;
	import com.gazuntite.provider.live.services.documentMgmt.delegat.LoadPatientDocumentByClinicIdDelegate;
	import com.gazuntite.provider.live.services.documentMgmt.delegat.ManagePatientDocumentDelegate;
	import com.gazuntite.provider.live.services.documentMgmt.event.LoadPatientDocumentByClinicIdEvent;
	import com.gazuntite.provider.live.services.documentMgmt.model.DMAppModelLocator;
	import com.gazuntite.provider.live.services.documentMgmt.util.DMConstant;
	import com.gazuntite.provider.live.services.documentMgmt.util.DMUtilityFunction;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;

	
	public class LoadPatientDocumentByClinicIdCommand  implements com.adobe.cairngorm.commands.Command {
		
		private var model 				: DMAppModelLocator = DMAppModelLocator.getInstance();
		
		private var responder			:Responder;
		private var delegate			:LoadPatientDocumentByClinicIdDelegate;
		
		public function execute( cgEvent:CairngormEvent ) : void {
			
			responder                 	= new Responder(onSuccess, onError);				
			delegate               		= new LoadPatientDocumentByClinicIdDelegate(responder);			
			
			
			
			var LE:LoadPatientDocumentByClinicIdEvent = cgEvent as LoadPatientDocumentByClinicIdEvent;
			if(LE.pageNo>0)
			{
				delegate.LoadPatientDocumentByClinicId(model.loggedInUserSelectedBranchId,LE.pageNo);
			}
			
		}
		
		
		private function onSuccess(event:ResultEvent):void
		{
			var re:ResultEvent = event as ResultEvent;
			if(re!=null && re.result!=null && re.result.PaggingResponseDTO!=null)
			{
				var dto:ObjectProxy	= re.result.PaggingResponseDTO as ObjectProxy;
				model.patientDocumentDTOList = new ArrayCollection();
				if(dto!=null)
				{
					var arr:ObjectProxy = dto.PatientDocumentsList as ObjectProxy;
					
					if( null == arr ) return;
					
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
					
					var singleObj:ObjectProxy;
					var patientDocDTO:PatientDocumentDTO
					if(array!=null)
					{
						var i:int;
						for(i=0;i<array.length;i++)
						{
							var obj:ObjectProxy = array.getItemAt(i) as ObjectProxy;
							
							patientDocDTO = new PatientDocumentDTO();
							
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
									singleObj = arr2.PatientDocumentDTO as ObjectProxy;
									
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
						singleObj = arr.PatientDocumentDTO as ObjectProxy;	
						if(singleObj!=null)
						{
							patientDocDTO = new PatientDocumentDTO();
							
							
							DMUtilityFunction.populatePatientDocumentDTO(patientDocDTO,singleObj);
							//var arr2:ObjectProxy = obj.ChildDocument as ObjectProxy;    //object is not valid/defined here --- tj 
							var arr22:ObjectProxy = singleObj.ChildDocument as ObjectProxy;
							if(arr22!=null)
							{
								var array22:ArrayCollection = arr22.PatientDocumentDTO as ArrayCollection;
								
								if(array22!=null)
								{
									var subArray22:ArrayCollection = new ArrayCollection();
									for(var m:int=0;m<array22.length;m++)
									{
										var obj22:ObjectProxy = array22.getItemAt(m) as ObjectProxy;
										var patientDocDTO22:PatientDocumentDTO = new PatientDocumentDTO();
										
										DMUtilityFunction.populatePatientDocumentDTO(patientDocDTO22,obj22);
										subArray22.addItem(patientDocDTO22);
									}
									
									patientDocDTO.ChildDocument = subArray22;
								}
								else
								{
									var singleObj2:ObjectProxy = arr22.PatientDocumentDTO as ObjectProxy;
									
									if(singleObj2!=null)
									{
										var singleDTO2:PatientDocumentDTO = new PatientDocumentDTO();
										DMUtilityFunction.populatePatientDocumentDTO(singleDTO2,singleObj2);
										var subArray3:ArrayCollection = new ArrayCollection();
										subArray3.addItem(singleDTO2);
										patientDocDTO.ChildDocument = subArray3;
									}
									
									
								}
							}
							
							
							model.patientDocumentDTOList.addItem(patientDocDTO);
						}
					}	
				
				}
			}
		}
		
		
		
		
		
		private function onError(event:FaultEvent):void
		{
			Alert.show("Received In LoadPatientDocumentByClinicIdCommand.\n"+event.toString(), DMConstant.ERROR,4, FlexGlobals.topLevelApplication.mainContainer);
		}
		
		
	}
}