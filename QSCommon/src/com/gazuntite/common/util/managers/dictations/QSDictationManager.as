package com.gazuntite.common.util.managers.dictations
{
	import com.gazuntite.common.dto.dictation.ModuleDictationDTO;
	import com.gazuntite.common.view.components.dictation.DictationPopup;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	

	public class QSDictationManager
	{
		private static var impl:QSDictationManagerImpl = QSDictationManagerImpl.getInstance();
		
		public function QSDictationManager()
		{
		}
		
		public static function create(dictationDTO:ModuleDictationDTO):DictationPopup
		{
			return impl.create(dictationDTO);
		}
		
		public static function show(parent:DisplayObject, dictationPanel:DictationPopup, dictationDTO:ModuleDictationDTO, relatedDO:DisplayObject, model:Object):DictationPopup
		{
			return impl.show(parent, dictationPanel, dictationDTO, relatedDO, model);
		}
		
		public static function remove(dictationPanel:DictationPopup):void
		{
			impl.remove(dictationPanel);
		}
		
		public static function move(dictationPanel:DictationPopup, relatedDO:DisplayObject):void
		{
			impl.move(dictationPanel, relatedDO);
		}
	}
}