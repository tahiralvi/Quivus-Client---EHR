package com.adobe.Quivus.view.controls.custom.patientExamView.quickInput.physical.vitals
{
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.view.controls.custom.patientExamView.quickInput.PMHSectionHeader;
	import com.adobe.Quivus.view.controls.skins.buttonSeparators.buttonSeparator;
	import com.adobe.Quivus.view.controls.skins.buttonSkins.VitalsClearBtn;
	import com.adobe.quivus.skins.chrome.buttonSkins.VitalsGraphBtnSkin;
	import com.adobe.Quivus.view.controls.skins.buttonSkins.VitalsImportBtn;
	import com.adobe.quivus.skins.chrome.radioButtonSkins.englishBtnSkin;
	import com.adobe.quivus.skins.chrome.radioButtonSkins.metricBtnSkin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	import spark.components.Button;
	import spark.components.HGroup;
	import spark.components.RadioButton;
	import spark.layouts.HorizontalAlign;
	
	public class VitalsPanelHeader extends PMHSectionHeader
	{
		private static const GAP:Number = 4;
		
		private var metricBtn:RadioButton;
		private var englishBtn:RadioButton;
		private var clearBtn:Button;
		private var importVitalsBtn:Button;
		private var graphBtn:Button;
		
		[Bindable]
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function VitalsPanelHeader()
		{
			super();
			
		}
		
		private function metricClickHandler(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			event.preventDefault();
			
		}
		
		private function metricChangeHandler(event:Event):void
		{
			dispatchEvent(new VitalsHeaderEvent(VitalsHeaderEvent.METRIC_UNIT_SELECTED, true));
		}
		
		private function englishClickHandler(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			event.preventDefault();
		}
		
		private function englishChangeHandler(event:Event):void
		{
			dispatchEvent(new VitalsHeaderEvent(VitalsHeaderEvent.ENGLISH_UNIT_SELECTED, true));
		}
		
		private function clearClickHandler(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			event.preventDefault();
			dispatchEvent(new VitalsHeaderEvent(VitalsHeaderEvent.CLEAR_CLICKED, true));
		}
		
		private function importVitalsClickHandler(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			event.preventDefault();
			dispatchEvent(new VitalsHeaderEvent(VitalsHeaderEvent.IMPORT_VITALS_CLICKED, true));
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			var hGrp:HGroup = new HGroup();
			var hGrpMetric:HGroup = new HGroup();
			
			hGrpMetric.gap = 0;
			hGrp.horizontalAlign = HorizontalAlign.LEFT;
			hGrp.percentWidth = 100; 
			
			
			hGrp.addElement(new buttonSeparator())
			
			if(!graphBtn)
			{
				graphBtn = new Button();
				graphBtn.setStyle("skinClass", VitalsGraphBtnSkin);
				graphBtn.buttonMode = true;
				graphBtn.useHandCursor = true;
				graphBtn.toolTip = "View Vitals Graph";
				hGrp.addElement(graphBtn);
				hGrp.paddingTop = 1;
			}
			hGrp.addElement(new buttonSeparator())
			if (!clearBtn)
			{
				clearBtn = new Button();
				clearBtn.label = "Clear";
				clearBtn.addEventListener(MouseEvent.CLICK, clearClickHandler, false, 0, true);
				clearBtn.setStyle("skinClass", VitalsClearBtn);
				clearBtn.buttonMode = true;
				clearBtn.useHandCursor = true;
				clearBtn.toolTip = "Clear";
				hGrp.addElement(clearBtn);
				hGrp.paddingTop = 1;
			}
			hGrp.addElement(new buttonSeparator())
			if (!importVitalsBtn)
			{
				importVitalsBtn = new Button();
				importVitalsBtn.label = "import";
				importVitalsBtn.addEventListener(MouseEvent.CLICK, importVitalsClickHandler, false, 0, true);
				importVitalsBtn.setStyle("skinClass", VitalsImportBtn);
				importVitalsBtn.buttonMode = true;
				importVitalsBtn.useHandCursor = true;
				importVitalsBtn.toolTip = "Import Vitals through Device"
				importVitalsBtn.setStyle("skinClass", VitalsImportBtn);
				hGrp.addElement(importVitalsBtn);
				hGrp.paddingTop = 5;
			}
			hGrp.addElement(new buttonSeparator())
			if (!metricBtn)
			{
				metricBtn = new RadioButton();
				if(model.quickInputDTO.Physical.Vitals.IsMetricDisplaySelected)
				{
					metricBtn.selected= true;				
				}
				else
				{
					metricBtn.selected= false;					
				}
				metricBtn.label = "metric";
				metricBtn.selected = true;
				metricBtn.setStyle("skinClass", metricBtnSkin);
				metricBtn.toolTip = "Conversion Types";
				metricBtn.buttonMode = true;
				metricBtn.useHandCursor = true;
				metricBtn.addEventListener(MouseEvent.CLICK, metricClickHandler, false, 0, true);
				metricBtn.addEventListener(Event.CHANGE, metricChangeHandler, false, 0, true);
				hGrpMetric.addElement(metricBtn);
				
				
			}
			
			if (!englishBtn)
			{
				englishBtn = new RadioButton();
				if(model.quickInputDTO.Physical.Vitals.IsMetricDisplaySelected)
				{	
					englishBtn.selected= false;
				}
				else
				{	
					englishBtn.selected= true;
				}
				englishBtn.label = "english";
				englishBtn.buttonMode = true;
				englishBtn.useHandCursor = true;
				englishBtn.toolTip = "Conversion Types";
				englishBtn.setStyle("skinClass", englishBtnSkin);
				englishBtn.addEventListener(MouseEvent.CLICK, englishClickHandler, false, 0, true);
				englishBtn.addEventListener(Event.CHANGE, englishChangeHandler, false, 0, true);
				
				hGrpMetric.addElement(englishBtn);
				
				hGrp.addElement(hGrpMetric);
			}
			
			
			
			//if (numElements > 0)
			commons.addElementAt(hGrp, 0);
		}
	}
}