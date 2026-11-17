package com.gazuntite.provider.live.services.administration.command.locationManagement
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.provider.live.services.administration.delegate.locationManagement.LoadSpecialityTypesDelegate;
	import com.gazuntite.provider.live.services.administration.dto.locationManagement.SpecialityTypeDTO;
	import com.gazuntite.provider.live.services.administration.event.locationManagement.LoadSpecialityTypesEvent;
	import com.gazuntite.provider.live.services.administration.model.AdminAppModelLocator;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;
	
	public class LoadSpecialityTypesCommand implements Command
	{
		private var model:AdminAppModelLocator = AdminAppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadSpecialityTypesDelegate;
		
		public function execute(event:CairngormEvent):void
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadSpecialityTypesDelegate( responder );			
			
			var LE:LoadSpecialityTypesEvent = event as LoadSpecialityTypesEvent;
			
			delegate.LoadSpecialityTypes();
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			var re:ResultEvent = event as ResultEvent;
			var op:ObjectProxy = (re.result as ObjectProxy);
			var responce:ObjectProxy  =  op.ArrayOfSpecialityType ;
			
			if(model.arrSpecialtyTypes)
			{
				model.arrSpecialtyTypes.removeAll();
				model.arrSpecialtyTypes = null;
			}
			
			model.arrSpecialtyTypes = new ArrayCollection();
			
			if(responce != null)
			{
				model.arrSpecialtyTypes = responce.SpecialityType;
			}
		}
		
		private function onError(event:FaultEvent):void
		{
			var errorStatus:String = "Fault occured in LoadSpecialityTypesCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserId )? -1:model.loggedInUserId;
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, event.toString(), userId); 
		}
	}
}