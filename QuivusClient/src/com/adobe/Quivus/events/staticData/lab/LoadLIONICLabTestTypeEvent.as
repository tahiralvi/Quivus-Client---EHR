package com.adobe.Quivus.events.staticData.lab {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadLIONICLabTestTypeEvent extends CairngormEvent {
		
		public var labTestCodeOrName	:String;
		public var labtestTypeID		:int;

		public function LoadLIONICLabTestTypeEvent( labTestCodeOrName:String, labtestTypeID:int) {
			super( AppController.LOAD_LIONIC_LAB_TEST_TYPE_EVENT);
			this.labTestCodeOrName 	= labTestCodeOrName;
			this.labtestTypeID 		= labtestTypeID;
			}
		}
	}