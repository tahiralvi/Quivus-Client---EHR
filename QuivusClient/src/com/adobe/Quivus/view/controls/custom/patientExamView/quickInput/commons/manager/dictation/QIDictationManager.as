package com.adobe.Quivus.view.controls.custom.patientExamView.quickInput.commons.manager.dictation
{
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.view.controls.custom.DictationPopup;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import valueObjects.ModuleDictationDTO;

	public class QIDictationManager
	{
		private static var impl:QIDictationManagerImpl = QIDictationManagerImpl.getInstance();
		
		public function QIDictationManager()
		{
		}
		
		public static function create(dictationDTO:ModuleDictationDTO):DictationPopup
		{
			return impl.create(dictationDTO);
		}
		
		public static function show(parent:DisplayObject, dictationPanel:DictationPopup, dictationDTO:ModuleDictationDTO, relatedDO:DisplayObject):DictationPopup
		{
			return impl.show(parent, dictationPanel, dictationDTO, relatedDO);
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