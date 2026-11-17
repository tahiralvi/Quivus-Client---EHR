package com.gazuntite.common.util.managers.dictations
{
	import com.gazuntite.common.dto.dictation.ModuleDictationDTO;
	import com.gazuntite.common.util.QSConstants;
	import com.gazuntite.common.view.components.dictation.DictationPopup;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	[ExcludeClass]
	public class QSDictationManagerImpl
	{
		private static var _instance:QSDictationManagerImpl;
		
		public function QSDictationManagerImpl(instance:SingletonClass)
		{
			if (!instance)
				throw new Error("QIDictationManagerImpl is singleton class, you can not create its instance");
		}
		
		public static function getInstance():QSDictationManagerImpl
		{
			if (!_instance)
				_instance = new QSDictationManagerImpl(new SingletonClass());
			
			return _instance;
		}
		
		public function create(dictationDTO:ModuleDictationDTO):DictationPopup
		{
			var dictationPanel:DictationPopup
			if (dictationDTO)
			{
				dictationPanel= new DictationPopup();
				dictationPanel.width = 250;
				dictationPanel.height = 75;
				dictationPanel.HeadingLable = "DICTATION";
				
				dictationPanel.DictationID = dictationDTO.DictationID;
				dictationPanel.DictationID = dictationDTO.DictationID;
				dictationPanel.ModuleID = dictationDTO.ModuleTypeID.toString();
			}
			
			return dictationPanel;
		}
		
		public function show (parent:DisplayObject, dictationPanel:DictationPopup , dictationDTO:ModuleDictationDTO , relatedDO:DisplayObject, model:Object):DictationPopup
		{
			if (parent && dictationDTO)
			{
				if (dictationPanel && dictationPanel.isPopUpShown)
				{
					remove(dictationPanel);
				}
				
				dictationPanel = create(dictationDTO);
				dictationPanel.model = model;
				dictationPanel.ShowPopup(parent);
				
				move(dictationPanel, relatedDO);
				
				dictationPanel.id_closeBtn.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void
				{
					if(dictationDTO != null && dictationPanel.DictationID != null)
					{
						dictationDTO.DictationID = dictationPanel.DictationID;
						dictationDTO.VisitDate = QSConstants.NULL_DATE;
						dictationDTO.DictationTimeStamp = new Date();
						
						if (model.hasOwnProperty("LoggedInUserId"))
							dictationDTO.ManagedByUserId = model.LoggedInUserId;
						
						if (model.hasOwnProperty("LoggedInUserProviderTypeId"))
							dictationDTO.ManagedByUserTypeId = model.LoggedInUserProviderTypeId;
						
						trace("id_closeBtn->Click ... CALLED IN MANAGER");
						
					}
				});
				//, false, 0, true
			}
			
			return dictationPanel;
		}
		
		public function remove(dictationPanel:DictationPopup):void
		{
			if (dictationPanel)
				dictationPanel.removePopup();
		}
		
		public function move(dictationPanel:DictationPopup, relatedDO:DisplayObject):void
		{
			if (dictationPanel && relatedDO)
			{
				var xx:Number = relatedDO.x + relatedDO.width/2;
				var yy:Number = relatedDO.y + relatedDO.height;
				
				if (relatedDO.parent)
				{
					var loc:Point = relatedDO.parent.localToGlobal(new Point(xx, yy));
					
					if (loc)
					{
						loc.x -= dictationPanel.width/2;
						dictationPanel.move(loc.x, loc.y);
					}
				}
			}
		}
	}
}
class SingletonClass{}