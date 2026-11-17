package com.gazuntite.common.command.ccHpi
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.delegate.ccHpi.LoadAllHPIDetailTypesDelegate;
	import com.gazuntite.common.dto.physical.ccHpi.HPITypeDTO;
	import com.gazuntite.common.event.ccHpi.LoadAllHPIDetailTypesEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.common.util.exceptionAlert.QSExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import flash.display.Sprite;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	public class LoadAllHPIDetailTypesCommand  implements com.adobe.cairngorm.commands.Command, IResponder 
	{
		private var model:Object;
		
		public function execute(cgEvent:CairngormEvent):void 
		{
			var LE:LoadAllHPIDetailTypesEvent = cgEvent as LoadAllHPIDetailTypesEvent;
			
			model = LE.model;
			
			if (model && model.hasOwnProperty("LoggedInUserId") && model.LoggedInUserId)
			{
				 var delegate:LoadAllHPIDetailTypesDelegate = new  LoadAllHPIDetailTypesDelegate(this);
				 delegate.loadAllHPIDetailTypes(model.LoggedInUserSessionID);
			}
		}
		
		public function result(rpcEvent:Object):void 
		{
			if (model && model.hasOwnProperty("LoggedInUserId") && model.LoggedInUserId)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				if (re.result!=null)
				{
					if (re.result.@Status=="true")
					{
						var xml:XML = re.result.ResponseData[0];
						
						if (xml != null)
						{
							if (model.hasOwnProperty("hpiTypeDTOList"))
							{
								model.hpiTypeDTOList = new ArrayCollection();
							
								var hpiTypeList:XMLList = xml.children();
								
								for each(var x:XML in hpiTypeList)
								{
									var t:HPITypeDTO = new HPITypeDTO();
									
									t.FromXML(x);
									
									model.hpiTypeDTOList.addItem(t);
								}
							}
						}
						else
						{
							UtilityFunctions.ShowMessage("LoadAllHPIDetailTypes \n No data returned from service.","Info");
						}
					}
				}
				else
				{
					UtilityFunctions.ShowMessage("LoadAllModuleTypes \n Service didnot respond.", "Info");
				}
			}
		}
		
		public function fault(rpcEvent:Object):void 
		{
			var errorStatus:String = "Fault occured in LoadAllHPIDetailTypesCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.LoggedInUserId ) ? -1 : model.LoggedInUserId;
			
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, rpcEvent.toString(), userId); 
		}
	}
}