package com.gazuntite.common.command.compHistory
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.delegate.compHistory.LoadComprehensiveHistoryStaticDataDelegate;
	import com.gazuntite.common.dto.pmh.compHistory.FamilyHistoryTypeDTO;
	import com.gazuntite.common.dto.pmh.compHistory.MedicalHistoryTypeDTO;
	import com.gazuntite.common.dto.pmh.compHistory.SocialHistoryAddictionTypeDTO;
	import com.gazuntite.common.dto.pmh.compHistory.SocialHistoryMediumTypeDTO;
	import com.gazuntite.common.dto.pmh.compHistory.SocialHistoryUsageAmountTypeDTO;
	import com.gazuntite.common.event.compHistory.LoadComprehensiveHistoryStaticDataEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	public class LoadComprehensiveHistoryStaticDataCommand implements Command, IResponder
	{
		private var model:Object;
		
		public function execute(event:CairngormEvent):void
		{
			var LE:LoadComprehensiveHistoryStaticDataEvent = event as LoadComprehensiveHistoryStaticDataEvent;
			
			model = LE.model;
			
			if (model && model.hasOwnProperty("LoggedInUserId") && model.LoggedInUserId)
			{
				var delegate:LoadComprehensiveHistoryStaticDataDelegate = new  LoadComprehensiveHistoryStaticDataDelegate(this);
				delegate.LoadComprehensiveHistoryStaticData(model.LoggedInUserSessionID);
			}
		}
		
		public function result(rpcEvent:Object):void
		{
			if (model && model.hasOwnProperty("LoggedInUserId") && model.LoggedInUserId)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				if (re.result!=null)
				{
					trace(re.result.toXMLString());
					
					if (re.result.@Status=="true")
					{
						var xml:XML = re.result as XML;
						
						if (xml!=null)
						{
							var i:int = 0;
							
							var xMedicalHistoryTypeDTOList:XMLList = xml.MedicalHistory.MedicalHistoryTypeDTO;
							
							if (model.hasOwnProperty("medicalHistoryTypeDTOList"))
							{
								model.medicalHistoryTypeDTOList	= new ArrayCollection();
								
								for (i = 0; i < xMedicalHistoryTypeDTOList.length(); i++)
								{
									var dto:MedicalHistoryTypeDTO = new MedicalHistoryTypeDTO();
									
									dto.FromXML(xMedicalHistoryTypeDTOList[i]);
									
									model.medicalHistoryTypeDTOList.addItem(dto);
								}
							}
							var xFamilyHistoryTypeDTOList:XMLList =  xml.FamilyHistory.FamilyHistoryTypeDTO;
							
							if (model.hasOwnProperty("familyHistoryTypeDTOList"))
							{
								model.familyHistoryTypeDTOList = new ArrayCollection();
								
								for (i = 0; i < xFamilyHistoryTypeDTOList.length(); i++)
								{
									var fdto:FamilyHistoryTypeDTO = new FamilyHistoryTypeDTO();
									
									fdto.FromXML(xFamilyHistoryTypeDTOList[i]);
									
									model.familyHistoryTypeDTOList.addItem(fdto);
								}
							}
							
							var xSocialHistoryAddictionTypeDTOList:XMLList = xml.SocialHistoryAddiction.SocialHistoryAddictionTypeDTO;
							
							if (model.hasOwnProperty("socialHistoryAddictionTypeDTOList"))
							{
								model.socialHistoryAddictionTypeDTOList	= new ArrayCollection();
								
								for (i = 0; i < xSocialHistoryAddictionTypeDTOList.length(); i++)
								{
									var sdto:SocialHistoryAddictionTypeDTO = new SocialHistoryAddictionTypeDTO();
									
									sdto.FromXML(xSocialHistoryAddictionTypeDTOList[i]);
									
									model.socialHistoryAddictionTypeDTOList.addItem(sdto);
								}
							}
							
							var xSocialHistoryUsageAmountTypeDTOList:XMLList = xml.SocialHistoryUsage.SocialHistoryUsageAmountTypeDTO;
							
							if (model.hasOwnProperty("socialHistoryUsageAmountTypeDTOList"))
							{
								model.socialHistoryUsageAmountTypeDTOList = new ArrayCollection();
								
								for (i = 0; i < xSocialHistoryUsageAmountTypeDTOList.length(); i++)
								{
									var udto:SocialHistoryUsageAmountTypeDTO = new SocialHistoryUsageAmountTypeDTO();
									
									udto.FromXML(xSocialHistoryUsageAmountTypeDTOList[i]);
									
									model.socialHistoryUsageAmountTypeDTOList.addItem(udto);
								}
							}
							var xSocialHistoryMeduimTypeDTOList:XMLList =  xml.SocialHistoryMedium.SocialHistoryMediumTypeDTO;
							
							if (model.hasOwnProperty("socialHistoryMediumTypeDTOList"))
							{
								model.socialHistoryMediumTypeDTOList = new ArrayCollection();
								
								for (i = 0; i < xSocialHistoryMeduimTypeDTOList.length(); i++)
								{
									var mdto:SocialHistoryMediumTypeDTO = new SocialHistoryMediumTypeDTO();
									
									mdto.FromXML(xSocialHistoryMeduimTypeDTOList[i]);
									
									model.socialHistoryMediumTypeDTOList.addItem(mdto);
								}
							}
						}
						else
						{
							UtilityFunctions.ShowMessage("LoadComprehensiveHistoryStaticData \n No data returned from service.","Info");
						}
					}
				}
				else
				{
					UtilityFunctions.ShowMessage("LoadComprehensiveHistoryStaticData \n Service didnot respond.", "Info");
				}
			}
		}
		
		public function fault(rpcEvent:Object):void
		{
			var errorStatus:String = "Fault occured in LoadComprehensiveHistoryStaticDataCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.LoggedInUserId )? -1:model.LoggedInUserId;
			
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, rpcEvent.toString(), userId); 
		}
	}
}