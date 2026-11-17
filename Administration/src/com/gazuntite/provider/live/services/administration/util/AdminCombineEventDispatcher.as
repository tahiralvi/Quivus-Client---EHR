package com.gazuntite.provider.live.services.administration.util
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.provider.live.services.administration.event.locationManagement.LoadClinicRoomByStationIdEvent;
	import com.gazuntite.provider.live.services.administration.event.locationManagement.LoadPracticeDetailsEvent;
	import com.gazuntite.provider.live.services.administration.event.locationManagement.LoadSpecialityTypesEvent;
	import com.gazuntite.provider.live.services.administration.event.roleManagement.LoadRoleEvent;
	import com.gazuntite.provider.live.services.administration.event.userManagement.LoadClinicBranchUsersEvent;
	import com.gazuntite.provider.live.services.administration.model.AdminAppModelLocator;
	
	import mx.managers.CursorManager;
	
	public class AdminCombineEventDispatcher
	{
		public function AdminCombineEventDispatcher()
		{
		}
		
		public static function LoadStaticData():void
		{
			var model : AdminAppModelLocator = AdminAppModelLocator.getInstance();
			
			//******** Location managment ***** START*************
			//Load speciality Types
			var lste:LoadSpecialityTypesEvent = new LoadSpecialityTypesEvent();
			CairngormEventDispatcher.getInstance().dispatchEvent( lste );	
			
			//load practice Details 
			var lpde:LoadPracticeDetailsEvent = new LoadPracticeDetailsEvent(model.loggedInUserSelectedBranchId);
			CairngormEventDispatcher.getInstance().dispatchEvent( lpde );	
			
			//load Rooms Details 
			var lcre:LoadClinicRoomByStationIdEvent = new LoadClinicRoomByStationIdEvent(model.loggedInUserSelectedStationId);
			CairngormEventDispatcher.getInstance().dispatchEvent( lcre );	
			CursorManager.setBusyCursor();  
			
			//******** Location managment ***** END*************
			
			//Role Management
			/*var eve:LoadRoleEvent = new LoadRoleEvent();
			CairngormEventDispatcher.getInstance().dispatchEvent( eve );
			CursorManager.setBusyCursor();*/
			
			// User Managment
			/*var lcbu:LoadClinicBranchUsersEvent = new LoadClinicBranchUsersEvent();
			CairngormEventDispatcher.getInstance().dispatchEvent( lcbu );	
			CursorManager.setBusyCursor();*/
			
			// general Setting 
			/*var lgs:LoadGeneralSettingEvent = new LoadGeneralSettingEvent();
			CairngormEventDispatcher.getInstance().dispatchEvent( lgs );	
			CursorManager.setBusyCursor();*/
		}
		
	}
}