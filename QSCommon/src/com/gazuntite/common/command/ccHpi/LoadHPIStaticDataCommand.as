package com.gazuntite.common.command.ccHpi
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.delegate.ccHpi.LoadHPIStaticDataDelegate;
	import com.gazuntite.common.event.ccHpi.LoadHPIStaticDataEvent;
	import com.gazuntite.common.util.QSConstants;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.common.util.exceptionAlert.QSExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class LoadHPIStaticDataCommand  implements Command, IResponder 
	{
		private var model:Object;
		private var sectionId : int;
		private var LE:LoadHPIStaticDataEvent;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			LE = cgEvent as LoadHPIStaticDataEvent;
			
			model = LE.model;
			sectionId = LE.sectionId;
			
			if (model && model.hasOwnProperty("LoggedInUserId") && model.LoggedInUserId)
			{
				var delegate:LoadHPIStaticDataDelegate = new  LoadHPIStaticDataDelegate(this);
				delegate.loadHPIStaticData(LE.sectionId, model.LoggedInUserSelectedBranchId, model.LoggedInUserSessionID, LE.searchString);
			}
		}
		
		public function result(rpcEvent:Object):void 
		{
			if (model && model.hasOwnProperty("LoggedInUserId") && model.LoggedInUserId)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var xml:XMLList = re.result.ResponseData;
				
				if (xml!=null)
				{
					var list:XMLList = xml.children();
					
					if (list != null)
					{
						if (LE.sectionName == QSConstants.SYMPTOM_MODULE_NAME)
						{
							model.symptom = this.getStringList(list);
						}
						else if (LE.sectionName == QSConstants.DURATION_MODULE_NAME)
						{
							model.duration = this.getStringList(list);
						}
						else if (LE.sectionName == QSConstants.EXACERBATING_MODULE_NAME)
						{
							model.exacerbating = this.getStringList(list);
						}
						else if(LE.sectionName == QSConstants.LOCATION_MODULE_NAME)
						{
							model.location = this.getStringList(list);
						}
						else if(LE.sectionName == QSConstants.MODIFYINGFACTORS_MODULE_NAME)
						{
							model.modifyingFactors = this.getStringList(list);
						}
						else if(LE.sectionName == QSConstants.PROGRESSION_MODULE_NAME)
						{
							model.progression = this.getStringList(list);
						}
						else if(LE.sectionName == QSConstants.QUALITY_MODULE_NAME)
						{
							model.quality = this.getStringList(list);
						}
						else if(LE.sectionName == QSConstants.RADIATION_MODULE_NAME)
						{
							model.radiation = this.getStringList(list);
						}
						else if(LE.sectionName == QSConstants.SEVERITY_MODULE_NAME)
						{
							model.severity = this.getStringList(list);
						}
						else if(LE.sectionName == QSConstants.CONTEXT_MODULE_NAME)
						{
							model.context = this.getStringList(list);
						}
					}
				}
				else
				{
					UtilityFunctions.ShowMessage("LoadAllModuleTypes \n Service didnot respond.", "Info");
				}
			}
		}
		
		private function getStringList(xlist:XMLList):ArrayCollection
		{
			var list:ArrayCollection = new ArrayCollection();
			
			var xxlist:XMLList = xlist.children();
			
			for each( var s:XML in xxlist )
			{
				list.addItem( s );
			}
			
			return list;
		}
		
		public function fault(rpcEvent:Object):void 
		{
			var errorStatus:String = "Fault occured in LoadHPIStaticDataCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.LoggedInUserId )? -1:model.LoggedInUserId;
			
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, rpcEvent.toString(), userId);
		}
	}
}