package com.adobe.Quivus.command.security
{
	import com.adobe.Quivus.delegate.security.LoadUserAcessRightDelegate;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.QuivusCombineEventDispatcher;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.common.util.exceptionAlert.QSExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;
	
	import valueObjects.*;

	public class LoadUserAccessRightCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			
			var delegate : LoadUserAcessRightDelegate = new LoadUserAcessRightDelegate( this ); 
			delegate.LoadUserAcessRight(model.loggedInUserDTO.UserId, model.userSelectedRoleDTO.UserTypeRole.UserTypeId, model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq)
			
		}
		
		public function result( rpcEvent : Object ) : void 
		{
			var re:ResultEvent = rpcEvent as ResultEvent;
			var result:ObjectProxy = re.result as ObjectProxy;
			
			if(result!=null)
			{
				var responce:ObjectProxy = result.Responce as ObjectProxy;
				
				if( responce!=null)
				{
					if(responce.ResponseStatus)
					{
						model.securityProxyObject = responce.Rights;
					}
				}
			}
		}
		
		public function fault( rpcEvent : Object ) : void 
		{
				model.errorStatus = "Fault occured in LoadUserAccessRightCommand.";
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
		}
	}
}