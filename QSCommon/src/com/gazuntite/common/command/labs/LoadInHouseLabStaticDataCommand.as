package com.gazuntite.common.command.labs
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.delegate.labs.LoadInHouseLabStaticDataDelegate;
	import com.gazuntite.common.dto.physical.labIn.InHouseLabTestTypeDTO;
	import com.gazuntite.common.event.labs.LoadInHouseLabStaticDataEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	public class LoadInHouseLabStaticDataCommand implements Command, IResponder 
	{	
		private var model:Object;
		
		private var LE:LoadInHouseLabStaticDataEvent;
		
		private var fun : Function;
		
		public function LoadInHouseLabStaticDataCommand()
		{
		}
		
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			LE = cgEvent as LoadInHouseLabStaticDataEvent;
			
			model = LE.model;
			fun = LE.func;
			
			if (model && model.hasOwnProperty("LoggedInUserId") && model.LoggedInUserId)
			{
				var delegate:LoadInHouseLabStaticDataDelegate = new  LoadInHouseLabStaticDataDelegate(this);
				
				delegate.loadInHouseLabStaticData(LE.searchValue, model.LoggedInUserSelectedBranchId, model.LoggedInUserSessionID );
			}
		}
		
		public function result( rpcEvent : Object ):void 
		{
			if (model && model.hasOwnProperty("LoggedInUserId") && model.LoggedInUserId)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var xml:XMLList = re.result.ResponseData;
				
				if (xml!=null)
				{
					var xlist:XMLList = xml.children();
					
					if (xlist != null)
					{
						var DTOlist:ArrayCollection = new ArrayCollection();
						
						for each( var x:XML in xlist )
						{
							var t:InHouseLabTestTypeDTO = new InHouseLabTestTypeDTO();
							t.FromXML( x );
							DTOlist.addItem( t );
						}
						
						if (model.hasOwnProperty("inHouseLabTestTypeDTOList"))
							model.inHouseLabTestTypeDTOList= DTOlist;
						
						if (null != fun)
							fun();
					}
				}
				
				else
				{
					UtilityFunctions.ShowMessage("LoadInHouseLabStaticDataCommand \n Service didnot respond.", "Info");
				}
			}
		}
		
		public function fault( rpcEvent : Object ) : void 
		{
			var errorStatus:String = "Fault occured in LoadInHouseLabStaticDataCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.LoggedInUserId )? -1:model.LoggedInUserId;
			
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}