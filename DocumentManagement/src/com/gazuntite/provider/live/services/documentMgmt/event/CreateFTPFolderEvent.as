package com.gazuntite.provider.live.services.documentMgmt.event {

	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.documentMgmt.appController.DMAppController;

	public class CreateFTPFolderEvent extends CairngormEvent {
		
		
		public var path		: String;
		public var func:Function;

		public var patientId		: int;
		
		public function CreateFTPFolderEvent(  path:String,func:Function,patientId		: int) {
			super( DMAppController.CREATE_FTP_FOLDER_EVENT);
			
			this.path = path;
			this.func = func;
			this.patientId = patientId;
			}
		}
	}