package com.adobe.Quivus.events.staticData.recommendation.procedure {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadCPTMedicalTypesEvent extends CairngormEvent {
		
		public var cptName:String	;
		public var func:Function;

		public function LoadCPTMedicalTypesEvent(cptName:String, _func:Function = null ) {
			super( AppController.LOAD_CPT_MEDICAL_TYPES_EVENT);
			this.cptName = cptName;
			this.func 		= _func;
			}
		}
	}