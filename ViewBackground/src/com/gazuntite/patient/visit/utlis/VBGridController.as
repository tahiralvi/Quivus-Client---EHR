package com.gazuntite.patient.visit.utlis
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.gazuntite.skins.chrome.textInputSkins.searchTextInput;
	import com.gazuntite.common.dto.assessment.labOut.LabDTO;
	import com.gazuntite.common.event.LoadICDCodeEvent;
	import com.gazuntite.common.event.compHistory.LoadAllBloodRelationShipTypeDTOEvent;
	import com.gazuntite.common.event.immunization.LoadImmunizationStaticDataEvent;
	import com.gazuntite.common.event.immunization.ManagePatientImmunizationEvent;
	import com.gazuntite.common.event.labs.LoadInHouseLabStaticDataEvent;
	import com.gazuntite.common.event.labs.LoadLIONICLabTestTypeEvent;
	import com.gazuntite.common.event.procedure.LoadCPTMedicalTypesEvent;
	import com.gazuntite.common.event.recommendation.LoadRecommendationLinksAutoCompleteEvent;
	import com.gazuntite.common.util.QSConstants;
	import com.gazuntite.common.view.events.DataGridActionsEvent;
	import com.gazuntite.patient.visit.event.LoadPatientImmunizationsByPatientIdEvent;
	import com.gazuntite.patient.visit.model.VBModelLocator;
	import com.gazuntite.utils.UtilityFunctions;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.controls.DataGrid;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.events.DataGridEvent;

	public class VBGridController
	{
		private var _dataGrid:DataGrid;
		
		private var _saveRecordCallBack:Function;
		private var _deleteRecordCallBack:Function;
		private var _itemEditKeyUpCallBack:Function;
		private var _recordValidationCallBack:Function;
		
		private var _firstEditableColIdx:int;
		private var _firstEditablePropertyName:String;
		
		private var _sectionName:String;
		
		private var model:VBModelLocator = VBModelLocator.getInstance();
		
		private var editOrSaveIconCallBack:Function;
		
		private var vbGridEditingController:VBGridEditingController;
		
		public function VBGridController(saveCallBack:Function = null, deleteCallBack:Function = null, itemEditKeyUpCallBack:Function = null, validationCallBack:Function = null)
		{
			_saveRecordCallBack = saveCallBack;
			_deleteRecordCallBack = deleteCallBack;
			_itemEditKeyUpCallBack = itemEditKeyUpCallBack;
			_recordValidationCallBack = validationCallBack;
			
			vbGridEditingController = new VBGridEditingController();
		}

		public function get dataGrid():DataGrid
		{
			return _dataGrid;
		}

		public function set dataGrid(value:DataGrid):void
		{
			if (value != _dataGrid)
			{
				_dataGrid = value;
				
				vbGridEditingController.dataGrid = value;
				
				registerEvents();
			}
		}
		
		public function get saveRecordCallBack():Function
		{
			return _saveRecordCallBack;
		}
		
		public function set saveRecordCallBack(value:Function):void
		{
			_saveRecordCallBack = value;
		}
		
		public function get deleteRecordCallBack():Function
		{
			return _deleteRecordCallBack;
		}
		
		public function set deleteRecordCallBack(value:Function):void
		{
			_deleteRecordCallBack = value;
		}
		
		public function get itemEditKeyUpCallBack():Function
		{
			return _itemEditKeyUpCallBack;
		}
		
		public function set itemEditKeyUpCallBack(value:Function):void
		{
			_itemEditKeyUpCallBack = value;
		}
		
		public function get recordValidationCallBack():Function
		{
			return _recordValidationCallBack;
		}
		
		public function set recordValidationCallBack(value:Function):void
		{
			_recordValidationCallBack = value;
		}

		public function get firstEditableColIdx():int
		{
			return _firstEditableColIdx;
		}
		
		public function set firstEditableColIdx(value:int):void
		{
			_firstEditableColIdx = value;
		}
		
		public function get firstEditablePropertyName():String
		{
			return _firstEditablePropertyName;
		}
		
		public function set firstEditablePropertyName(value:String):void
		{
			_firstEditablePropertyName = value;
		}
		
		public function get sectionName():String
		{
			return _sectionName;
		}
		
		public function set sectionName(value:String):void
		{
			_sectionName = value;
			
			vbGridEditingController.sectionName = _sectionName;			
		}
		
		public function onImmunizationSave():void
		{
			var loadImmunization:LoadPatientImmunizationsByPatientIdEvent = new LoadPatientImmunizationsByPatientIdEvent();
			CairngormEventDispatcher.getInstance().dispatchEvent(loadImmunization);
		}
		
		private function registerEvents():void
		{
			if (!dataGrid)
				return;
			
			dataGrid.addEventListener(DataGridActionsEvent.SAVE_RECORD_CLICK, saveRecordClickHandler, false, 0, true);
			dataGrid.addEventListener(DataGridActionsEvent.EDIT_RECORD_CLICK, editRecordClickHandler, false, 0, true);
			dataGrid.addEventListener(DataGridActionsEvent.DELETE_RECORD_CLICK, deleteRecordClickHandler, false, 0, true);
			
			dataGrid.addEventListener(DataGridActionsEvent.ITEM_EDIT_KEY_UP, itemEditKeyUpHandler, false, 0, true);
			
			dataGrid.addEventListener(DataGridEvent.ITEM_EDIT_BEGIN, dataGridItemEditBeginHandler, false, 0, true);
			dataGrid.addEventListener(DataGridEvent.ITEM_EDIT_END, dataGridItemEditEndHandler, false, 0, true);
		}
		
		private function saveRecordClickHandler(event:DataGridActionsEvent):void
		{
			if (!event.data)
				return;
			
			editOrSaveIconCallBack = event.callback;
			
			if (event.data.hasOwnProperty("IsDirty") && !event.data.IsDirty)
				return;
			
			/*if (saveRecordCallBack)
				saveRecordCallBack(editOrSaveIconCallBack);*/
			
			sendManageCall();
			
			if (editOrSaveIconCallBack)
				editOrSaveIconCallBack(true);
			
			dataGrid.editable = false;	
		}
		
		private function editRecordClickHandler(event:DataGridActionsEvent):void
		{
			if (!event.data)
				return;
			
			editOrSaveIconCallBack = event.callback;
			
			if (event.data.hasOwnProperty("IsRecordEditable") && !event.data.IsRecordEditable)
			{
				event.preventDefault();
				event.stopImmediatePropagation();
				
				return;
			}
			
			var rowIndex:int = findRecordNumber(event.data);
			
			if (rowIndex < 0)
				return;
			
			if (!firstEditableColIdx || !firstEditablePropertyName)
				return;
			
			dataGrid.editable = true;
			var itemToSetInEditableMode:IListItemRenderer = dataGrid.indexToItemRenderer(rowIndex);
			var ev:DataGridEvent = new DataGridEvent(DataGridEvent.ITEM_EDIT_BEGINNING, true);
			ev.columnIndex = firstEditableColIdx;
			ev.rowIndex = rowIndex;
			ev.itemRenderer = itemToSetInEditableMode;
			ev.dataField = firstEditablePropertyName;
			dataGrid.dispatchEvent(ev);
		}
		
		private function findRecordNumber(value:Object):int
		{
			var rowIndex:int = -1;
			
			if (!value)
				return rowIndex;
			
			if (!dataGrid)
				return rowIndex;
			
			if (!dataGrid.dataProvider)
				return rowIndex;
			
			for (var i:uint=0; i < dataGrid.dataProvider.length; i++)
			{
				if (value == dataGrid.dataProvider[i])
				{
					rowIndex = i;
					break;
				}
			}
			
			if (rowIndex >= dataGrid.dataProvider.length)
				rowIndex = -1;
			
			return rowIndex;
		}
		
		private function deleteRecordClickHandler(event:DataGridActionsEvent):void
		{
			if (!event.data)
				return;
			
			if (!event.data.hasOwnProperty("IsDeleted") || !event.data.hasOwnProperty("IsDirty"))
				return;
			
			UtilityFunctions.AskMessage(  "Do you want to delete selected record", function():void
			{
				
				event.data.IsDeleted = true;
				event.data.IsDirty = true;
				
				sendManageCall();
			});
		}
		
		private function itemEditKeyUpHandler(event:DataGridActionsEvent):void
		{
			if (!event.data)
				return;
			
			var dataField:String = event.dataField;
			var searchTerm:String = event.searchString;
			
			if (!searchTerm || !dataField)
				return;
			
			if (searchTerm.length < 3 || dataField.length < 1)
				return;
			
			if (searchTerm.length % 2 == 0) // if searchTerm length is odd number then send request
				return;
			
			switch (sectionName)
			{
				case QSConstants.IMMUNIZATION_MODULE_NAME:
					
					loadImmunizationStaticData(dataField, searchTerm);
					
					break;
				
				case QSConstants.MEDICAL_HISTORY_MODULE_NAME:
				case QSConstants.FAMILY_HISTORY_MODULE_NAME:
					
					loadICDCodeData(searchTerm);
				
					break;
				
				case QSConstants.LAB_IN_MODULE_NAME:
					 
					loadInHouseLabTestTypeData(searchTerm);
					
					break;
				
				case QSConstants.DIAGNOSIS_MODULE_NAME:
					
					if (dataField == "IcdDto.IcdCodeName" || dataField == "IcdDto.IcdCodeDescription")
						loadICDCodeData(searchTerm);
					
					break;
				
				case QSConstants.PROCEDURE_MODULE_NAME:
					
					loadProcedureData(dataField, searchTerm);
					
					break;
				
				case QSConstants.LAB_OUT_MODULE_NAME:
					
					var labTestTypeId:int;
					
					if (event.data is LabDTO)
					{
						var rowData:LabDTO = event.data as LabDTO;
						labTestTypeId = rowData.LabTestType.ID;
					}
					
					loadLabOutData(dataField, searchTerm, labTestTypeId);
					
					break;
				
				case QSConstants.RECOMMENDATION_MODULE_NAME:
					
					loadRecommendationData(dataField, searchTerm);
					
					break;
			}
		}
		
		private function dataGridItemEditBeginHandler(event:DataGridEvent):void
		{
			if (event.itemRenderer.data && event.itemRenderer.data.hasOwnProperty("IsRecordEditable") && !event.itemRenderer.data.IsRecordEditable)
			{
				event.preventDefault();
				event.stopImmediatePropagation();
				dataGrid.destroyItemEditor();
				return;
			}
			
			if (editOrSaveIconCallBack)
				editOrSaveIconCallBack(false);
			
			dataGrid.createItemEditor(event.columnIndex, event.rowIndex);
			
			vbGridEditingController.beginGridEdit(event);
		}
		
		private function dataGridItemEditEndHandler(event:DataGridEvent):void
		{
			if (!dataGrid.itemEditorInstance || !dataGrid.selectedItem )
				return;
			
			var editable:Boolean = false;
			
			if (dataGrid.selectedItem.hasOwnProperty("IsRecordEditable"))
				editable = dataGrid.selectedItem.IsRecordEditable;
			
			if (!editable)
			{
				event.preventDefault();
				event.stopImmediatePropagation();
				dataGrid.destroyItemEditor();
				
				return;
			}
			
			if (recordValidationCallBack)
				recordValidationCallBack(event);
			
			dataGrid.destroyItemEditor();
			event.stopImmediatePropagation();
			event.preventDefault();
		}
		
		private function dataGridProviderChangeHandlerHandler(event:Event):void
		{
			if (!dataGrid)
				return;
			
			if (!dataGrid.dataProvider)
				return;
			
			if (!dataGrid.dataProvider.hasOwnProperty("length"))
				return;
			
			
			var recordsCount:int = dataGrid.dataProvider.length;
			
			if (recordsCount > 10)
			{
				dataGrid.rowCount = 10;
				dataGrid.verticalScrollPolicy = "on";
			}
			else
			{
				dataGrid.rowCount = dataGrid.dataProvider.length;
				dataGrid.verticalScrollPolicy = "off";
			}
		}
		
		private function sendManageCall():void
		{
			switch (sectionName)
			{
				case QSConstants.IMMUNIZATION_MODULE_NAME:
					
					model.VisitID = 0;
					
					var mpi:ManagePatientImmunizationEvent = new ManagePatientImmunizationEvent(model, onImmunizationSave);
					CairngormEventDispatcher.getInstance().dispatchEvent(mpi);
					
					break;
			}
		}
		
		private function loadImmunizationStaticData(property:String, searchTerm:String):void
		{
			var lisd:LoadImmunizationStaticDataEvent;
			
			if (property == "ImmunizationType.Name")
			{
				lisd = new LoadImmunizationStaticDataEvent(searchTerm, QSConstants.TYPE_SELECT_TYPE, QSConstants.VIEW_BACKGROUND_MODULE_NAME, model);
			}
			
			else if (property == "Dose")
			{
				lisd = new LoadImmunizationStaticDataEvent(searchTerm, QSConstants.DOSE_SELECT_TYPE, QSConstants.VIEW_BACKGROUND_MODULE_NAME, model);
			}
				
			else if (property == "LotNumber")
			{
				lisd = new LoadImmunizationStaticDataEvent(searchTerm, QSConstants.LOT_SELECT_TYPE, QSConstants.VIEW_BACKGROUND_MODULE_NAME, model);
			}
			
			if (lisd)
				CairngormEventDispatcher.getInstance().dispatchEvent(lisd);
		}
		
		private function loadComprehensiveHistoryStaticData(property:String, searchTerm:String):void
		{
			switch (property)
			{
				case "ReletionshipType.Name":
					
					var labre:LoadAllBloodRelationShipTypeDTOEvent = new LoadAllBloodRelationShipTypeDTOEvent(model);
					CairngormEventDispatcher.getInstance().dispatchEvent(labre);
					
					break;
			}
		}
		
		private function loadICDCodeData(searchTerm:String):void
		{
			var icdEvent:LoadICDCodeEvent = new LoadICDCodeEvent(searchTerm, model);
			CairngormEventDispatcher.getInstance().dispatchEvent(icdEvent);
		}
		
		private function loadInHouseLabTestTypeData(searchTerm:String):void
		{
			var lihsd:LoadInHouseLabStaticDataEvent = new LoadInHouseLabStaticDataEvent(searchTerm, model);
			CairngormEventDispatcher.getInstance().dispatchEvent(lihsd);
		}
		
		private function loadProcedureData(property:String, searchTerm:String):void
		{
			switch (property)
			{
				case "cptmedicalDTO.ProcedureCode":
				case "cptmedicalDTO.ProcedureDescription":
					
					var lcmt:LoadCPTMedicalTypesEvent = new LoadCPTMedicalTypesEvent(searchTerm, model);
					CairngormEventDispatcher.getInstance().dispatchEvent(lcmt);
					
					break;
			}
		}
		
		private function loadLabOutData(property:String, searchTerm:String, labTestTypeId:int):void
		{
			switch (property)
			{
				case "LIONICLabTestType.testNum":
				case "LIONICLabTestType.Name":
					
					var llionic:LoadLIONICLabTestTypeEvent = new LoadLIONICLabTestTypeEvent(searchTerm, labTestTypeId, model);
					CairngormEventDispatcher.getInstance().dispatchEvent(llionic);
					
					break;
			}
		}
		
		private function loadRecommendationData(property:String, searchTerm:String):void
		{
			switch (property)
			{
				case "Links":
				{
					searchTerm = UtilityFunctions.convertStringToBase64String(searchTerm);
					
					var loadLinksEv:LoadRecommendationLinksAutoCompleteEvent = new LoadRecommendationLinksAutoCompleteEvent(searchTerm, model);
					
					CairngormEventDispatcher.getInstance().dispatchEvent(loadLinksEv); 
					
					break;
				}
			}
			
		}
	}
}