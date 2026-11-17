package com.gazuntite.common.command.immunization
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.delegate.immunization.LoadImmunizationStaticDataDelegate;
	import com.gazuntite.common.dto.baseDTO.common.GeneralLabelDTO;
	import com.gazuntite.common.dto.baseDTO.common.GeneralTypeDTO;
	import com.gazuntite.common.event.immunization.LoadImmunizationStaticDataEvent;
	import com.gazuntite.common.util.QSConstants;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	public class LoadImmunizationStaticDataCommand implements Command, IResponder
	{
		/**
		 * 
		 * if event is thrown from VB then model would be VBModelLocator
		 * if event is thrown from QI then model would be QIModelLocator
		 * 
		 * */
		private var model:Object;
		private var LE:LoadImmunizationStaticDataEvent;
		
		public function execute(event:CairngormEvent):void
		{
				LE = event as LoadImmunizationStaticDataEvent;
				model = LE.model;
				
				if (model && model.LoggedInUserId)
				{
					var delegate:LoadImmunizationStaticDataDelegate = new  LoadImmunizationStaticDataDelegate(this);
					delegate.LoadImmunizationStaticData(LE.searchCritera, model.LoggedInUserSelectedBranchId, LE.subSectionName, model.LoggedInUserSessionID);
				}
		}
		
		public function result(rpcEvent:Object):void
		{
			if (model && model.LoggedInUserId)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				if(re.result!=null)
				{
					trace(re.result.toXMLString());
					
					if(re.result.@Status=="true")
					{
						var xml:XML = re.result as XML;
						if(xml!=null)
						{
							populateImmunizationStaticData(xml, LE.subSectionName);
						}
					}
					else
					{
						UtilityFunctions.ShowMessage("LoadImmunicationStaticData \n No data returned from service.","Info");
					}
				}
			}
			else
			{
				UtilityFunctions.ShowMessage("LoadImmunicationStaticData \n Service didnot respond.", "Info");
			}
		}
		
		private function getLabelDTOList(xList:XMLList):ArrayCollection
		{
			var typeList:ArrayCollection = new ArrayCollection();
			
			for each (var x:XML in xList)
			{
				var dto:GeneralLabelDTO = new GeneralLabelDTO();
				dto.FromXML(x);
				typeList.addItem(dto);
			}
			
			return typeList;
		}
		
		private function populateImmunizationStaticData(xml:XML, sectionName:String):void
		{
			if (!model)
				return;
			
			switch (sectionName) 
			{
				case  QSConstants.TYPE_SELECT_TYPE:
					
					var xList:XMLList = xml.ImmunizationType.ImmunizationTypeDTO;
					var typeList:ArrayCollection = new ArrayCollection();
					
					for each (var x:XML in xList)
					{
						var dto:GeneralTypeDTO = new GeneralTypeDTO();
						dto.FromXML(x);
						typeList.addItem(dto);
					}
					
					if (model.hasOwnProperty("generalTypeDTOListForImmunizationType"))
						model.generalTypeDTOListForImmunizationType = typeList;
					
					break;
				
				case QSConstants.DOSE_SELECT_TYPE:
					
					if (model.hasOwnProperty("generalLabelDTOListForDose"))
						model.generalLabelDTOListForDose = getLabelDTOList(xml.ImmunizationDose.string);
					
					break;
				
				case QSConstants.MANUFACTURER_SELECT_TYPE:
					
					if (model.hasOwnProperty("generalLabelDTOListForManufacturer"))
						model.generalLabelDTOListForManufacturer = getLabelDTOList(xml.ImmunizationManufacturer.string);
					
					break;
				
				case QSConstants.SERIERS_SELECT_TYPE:
					
					if (model.hasOwnProperty("generalLabelDTOListForSeries"))
						model.generalLabelDTOListForSeries = getLabelDTOList(xml.ImmunizationSeriers.string);
					
					break;
				
				case QSConstants.REFUSAL_SELECT_TYPE:
					
					if (model.hasOwnProperty("generalLabelDTOListForRefusal"))
						model.generalLabelDTOListForRefusal = getLabelDTOList(xml.ImmunizationRefusal.string);
					
					break;
				
				case QSConstants.ROUT_SELECT_TYPE:
					
					if (model.hasOwnProperty("generalLabelDTOListForRoute"))
						model.generalLabelDTOListForRoute = getLabelDTOList(xml.ImmunizationRout.string);
					
					break;
				
				case QSConstants.SITE_SELECT_TYPE:
					
					if (model.hasOwnProperty("generalLabelDTOListForSite"))
						model.generalLabelDTOListForSite = getLabelDTOList(xml.ImmunizationSite.string);
					
					break;
				
				case QSConstants.LOT_SELECT_TYPE:
					
					if (model.hasOwnProperty("generalLabelDTOListForLot"))
						model.generalLabelDTOListForLot = getLabelDTOList(xml.ImmunizationLot.string);
					
					break;
			}
		}
		
		public function fault(rpcEvent:Object):void
		{
			var errorStatus:String = "Fault occured in LoadImmunicationStaticDataCommand.";
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.LoggedInUserId )? -1:model.LoggedInUserId;
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, rpcEvent.toString(), userId); 
		}
	}
}