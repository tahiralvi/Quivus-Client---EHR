package com.gazuntite.patient.visit.utlis
{
	import com.gazuntite.common.dto.pmh.compHistory.SocialHistoryDTO;
	import com.gazuntite.common.util.QSConstants;
	import com.gazuntite.common.view.itemEditors.SparkComboBoxItemEditor;
	import com.gazuntite.controls.extended.components.LabelComboBox;
	
	import flash.net.dns.AAAARecord;
	
	import mx.collections.ArrayCollection;
	import mx.controls.DataGrid;
	import mx.events.DataGridEvent;

	public class VBGridEditingController
	{
		private var _dataGrid:DataGrid;
		private var _sectionName:String;
		
		private var yesNoDp:ArrayCollection;
		private var maritalStatusDp:ArrayCollection;
		
		public function VBGridEditingController()
		{
			yesNoDp = new ArrayCollection(["Yes", "No"]);
			maritalStatusDp = new ArrayCollection(["Married", "Single", "Divorced", "Widow"]);
		}

		public function get dataGrid():DataGrid
		{
			return _dataGrid;
		}
		
		public function set dataGrid(value:DataGrid):void
		{
			_dataGrid = value;
		}
		
		public function get sectionName():String
		{
			return _sectionName;
		}

		public function set sectionName(value:String):void
		{
			_sectionName = value;
		}
		
		public function beginGridEdit(event:DataGridEvent):void
		{
			switch (sectionName)
			{
				case QSConstants.SOCIAL_HISTORY_MODULE_NAME:
					
					onSocialHistoryGridEditBegin(event);
					
					break;
				
				case QSConstants.FOLLOW_UP_MODULE_NAME:
					
					onFollowUpGridEditBegin(event);
					
					break;
			}
		}
		
		public function itemKeyUpGridEdit():void
		{
			
		}
		
		public function endGridEdit(event:DataGridEvent):void
		{
			switch(sectionName)
			{
				case QSConstants.SOCIAL_HISTORY_MODULE_NAME:
				{
					break;
				}
					
				default:
				{
					break;
				}
			}
		}
		
		private function onSocialHistoryGridEditBegin(event:DataGridEvent):void
		{
			var socialHistoryDTO:SocialHistoryDTO = event.itemRenderer.data as SocialHistoryDTO;
			
			if (!socialHistoryDTO)
				return;
			
			if (event.columnIndex == 2) //2 is for Status Column
			{				
				var comboEditor:SparkComboBoxItemEditor;
				
				if (dataGrid.itemEditorInstance is SparkComboBoxItemEditor)
				{
					comboEditor = SparkComboBoxItemEditor(dataGrid.itemEditorInstance);
					
					if (socialHistoryDTO.Social == "Marital" || socialHistoryDTO.Social == "Work" || socialHistoryDTO.Social == "Other")
					{
						if (socialHistoryDTO.Social == "Marital")
						{
							comboEditor.dataProvider = maritalStatusDp;
						}
						else
						{
							comboEditor.dataProvider = yesNoDp;
						}
					}
					else
					{
						comboEditor.dataProvider = yesNoDp;
					}
				}
			}
			else
			{
				if (socialHistoryDTO.Social == "Marital" || socialHistoryDTO.Social == "Work" || socialHistoryDTO.Social == "Other")
				{
					event.preventDefault();
					event.stopImmediatePropagation();
					dataGrid.destroyItemEditor();
				}
				else if (socialHistoryDTO.Status == QSConstants.STRING_NO_UI)
				{
					event.preventDefault();
					event.stopImmediatePropagation();
					dataGrid.destroyItemEditor();
				}
			}
		}//method ends
		
		private function onFollowUpGridEditBegin(event:DataGridEvent):void
		{
			if (event.columnIndex == 5) //if column is follow up nature
			{
				if (event.itemRenderer.data.IsAcute)
				{
					SparkComboBoxItemEditor(dataGrid.itemEditorInstance).id_ComboEditor.selectedIndex = 0;
				}
					
				else if (event.itemRenderer.data.IsChronic)
				{
					SparkComboBoxItemEditor(dataGrid.itemEditorInstance).id_ComboEditor.selectedIndex = 1;
				}
					
				else if (event.itemRenderer.data.IsPreventive)
				{
					SparkComboBoxItemEditor(dataGrid.itemEditorInstance).id_ComboEditor.selectedIndex = 2;
				}
			}
		}
	}//class ends
}//package ends