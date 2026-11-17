package com.adobe.Quivus.command.quickInput
{
	import com.adobe.Quivus.delegate.quickInput.SaveMedicalHistoryDelegate;
	import com.adobe.Quivus.events.quickInput.SaveMedicalHistoryEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.managers.CursorManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.FamilyHistoryDTO;
	import valueObjects.MedicalHistoryDTO;
	import valueObjects.SocialHistoryAddictionDTO;

	public class SaveMedicalHistoryCommand implements Command
	{
		private var model : AppModelLocator = AppModelLocator.getInstance();
		private var delegate:SaveMedicalHistoryDelegate;
		private var responder:Responder;
		private var callBack:Function;
		
		private static const GENERAL:int = 0;
		private static const FAMILY:int = 1;
		private static const SOCIAL:int = 2;
		
		private static var module:int = GENERAL;
		
		private var LE:SaveMedicalHistoryEvent
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			CursorManager.setBusyCursor();
			
			responder = new Responder(onSuccess, onError);				
			delegate  = new SaveMedicalHistoryDelegate( responder );			
			
			LE = cgEvent as SaveMedicalHistoryEvent;
			
		 	callBack = LE.callBack;
			
			if( module == GENERAL )
			{
				if( UtilityFunctions.IsNullOrEmpty( model.medicalHistoryList ) == false )
				{
					//remove empty records before submit
					for(var i:int=0; i < model.medicalHistoryList.length; i++)
					{
						var dto:MedicalHistoryDTO = model.medicalHistoryList.getItemAt(i) as MedicalHistoryDTO;
						if( dto.IsNone == Constants.STRING_TRUE )
						{
							//do nothing, we want to save this record
						}
						else if(dto && UtilityFunctions.IsNullOrEmpty(dto.ICDCodeList))
						{
							model.medicalHistoryList.removeItemAt(i);
						}
					}
					
					delegate.SaveMedicalHistoryList(LE.medicalHistory,LE.branchId,LE.patientId);	
				}
			}
			
			if( module == FAMILY )
			{
				if( UtilityFunctions.IsNullOrEmpty( model.familyHistoryList ) == false )
				{
					//Tahir Alvi - remove empty records before submit
					for(var i:int=0; i < model.familyHistoryList.length; i++)
					{
						var famdto:FamilyHistoryDTO = model.familyHistoryList.getItemAt(i) as FamilyHistoryDTO;
						
						if( famdto.IsYesSelected == Constants.STRING_FALSE )
						{
							//do nothing, we want to save this record
						}
						else if(famdto && UtilityFunctions.IsNullOrEmpty(famdto.PatientDiseaseList))
						{
							model.familyHistoryList.removeItemAt(i);
						}
					}
					/// END
					delegate.SaveFamilyHistoryList(LE.medicalHistory,LE.branchId,LE.patientId);	
				}
			}
			
			if( module == SOCIAL )
			{
				var col:ArrayCollection = new ArrayCollection([LE.medicalHistory]); // multi-record not impl. yet. ... when done use model.socialHistoryList instead.
				delegate.SaveSocialHistoryList(col,LE.branchId,LE.patientId);
			}

			
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			CursorManager.removeBusyCursor();
			
			var xmlStr:String = event.result.toString();
			if( module == GENERAL )//General section saved sucessfully
			{
				module = FAMILY; //next save family history
				
				if( null != model.familyHistoryList && model.familyHistoryList.length > 0 )
				{
					var fhe:SaveMedicalHistoryEvent = new SaveMedicalHistoryEvent( LE.patientId, LE.branchId, model.familyHistoryList, LE.callBack );
					CairngormEventDispatcher.getInstance().dispatchEvent( fhe );
					return; // wait for success
				}
			}
			
			if( module == FAMILY )//family history saved sucessfully
			{
				module = SOCIAL;//next save social history
				
				if( null != model.socialHistoryDTO )
				{
					model.socialHistoryDTO.VisitDate = Constants.NULL_DATE;
					model.socialHistoryDTO.CreatedAt = new Date();
					model.socialHistoryDTO.ModifiedAt = Constants.NULL_DATE;
					
					setSocialHistoryNullData();
					
					var she:SaveMedicalHistoryEvent = new SaveMedicalHistoryEvent( LE.patientId, LE.branchId, model.socialHistoryDTO, LE.callBack );
					CairngormEventDispatcher.getInstance().dispatchEvent( she );
					return; // wait for success
				}
			}
			
			if( module == SOCIAL && null != callBack )
			{
				module = GENERAL;
				//Alert.show("History saved successfully \n" );  // Ticket #2228
				callBack();
			}
		}
		
		private function onError(event:FaultEvent):void
		{
			model.errorStatus = "Error in SaveMedicalHistoryCommand"
			CursorManager.removeBusyCursor();
			module = GENERAL;
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(event.message.body.toString(),"Error Save Medical History Command ",event.fault.faultString,model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert); */
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, event.toString(), userId); 
			
			
		}
		
		private function setSocialHistoryNullData():void
		{	
			if(model.socialHistoryDTO.SocialHistoryAddictionList == null)
				return;
			
			if( UtilityFunctions.IsNullOrEmpty( model.socialHistoryDTO.WorkStatusDictationID ) )
			{
				model.socialHistoryDTO.WorkStatusDictationID = Constants.GUID_FORMAT;
			}
			
			if( UtilityFunctions.IsNullOrEmpty( model.socialHistoryDTO.OtherDictationID ) )
			{
				model.socialHistoryDTO.OtherDictationID 	 = Constants.GUID_FORMAT;
			}
			
			var index:int;
			for(index = 0; model.socialHistoryDTO && index < model.socialHistoryDTO.SocialHistoryAddictionList.length && index >=0 ; index++ )
			{
				var sh:SocialHistoryAddictionDTO;
				
				sh = model.socialHistoryDTO.SocialHistoryAddictionList.getItemAt(index) as SocialHistoryAddictionDTO;
				
				if( UtilityFunctions.IsNullOrEmpty( sh.OnSet ) )
				{
					sh.OnSet = Constants.NULL_DATE.toDateString();
				}
				
				if( UtilityFunctions.IsNullOrEmpty( sh.EndDate ) )
				{
					sh.EndDate = Constants.NULL_DATE.toDateString();
				}
			}
		}
	}
}