package com.adobe.Quivus.events.staticData.ros {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadROSStaticDataEvent extends CairngormEvent {
		
		public var isMale:Boolean;
		public var callForPatientData:Boolean;
		
		public function LoadROSStaticDataEvent(isMale:Boolean,callForPatientData:Boolean ) {
			super( AppController.LOAD_ROS_STATIC_DATA_EVENT);
			this.isMale = isMale;
			this.callForPatientData = callForPatientData;
			}
		}
	}