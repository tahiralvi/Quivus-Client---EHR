package com.gazuntite.provider.live.services.billing.dto.accountsAndReceiveables
{
	import com.gazuntite.common.util.xml.XmlConstants;

	public class AccountCarrierDTO
	{
		private var _InsOrganizationID:String;
		private var _InsuranceTypeId:String;
		private var _CarrierName:String;
		private var _Media:String;
		private var _TotalAging:String;				
		private var _Aging:AgingDTO;
		
		public function get InsuranceTypeId():String
		{
			return _InsuranceTypeId;
		}

		public function set InsuranceTypeId(value:String):void
		{
			_InsuranceTypeId = value;
		}

		public function get InsOrganizationID():String
		{
			return _InsOrganizationID;
		}

		public function set InsOrganizationID(value:String):void
		{
			_InsOrganizationID = value;
		}

		public function FromXML(x:XML):void
		{
			InsOrganizationID  		= x.@[XmlConstants.INSORGANIZATIONID];
			InsuranceTypeId  		= x.@[XmlConstants.INSURANCETYPEID];
			CarrierName  			= x.@[XmlConstants.CARRIERNAME];
			Media  					= x.@[XmlConstants.MEDIA];
			TotalAging  			= x.@[XmlConstants.TOTALAGING];			
						
			var ag:AgingDTO = new AgingDTO();
			ag.FromXML( x.Aging[0] );
			Aging = ag;
		}	
		
		public function get Aging():AgingDTO
		{
			return _Aging;
		}

		public function set Aging(value:AgingDTO):void
		{
			_Aging = value;
		}		

		public function get TotalAging():String
		{
			return _TotalAging;
		}

		public function set TotalAging(value:String):void
		{
			_TotalAging = value;
		}

		public function get Media():String
		{
			return _Media;
		}

		public function set Media(value:String):void
		{
			_Media = value;
		}

		public function get CarrierName():String
		{
			return _CarrierName;
		}

		public function set CarrierName(value:String):void
		{
			_CarrierName = value;
		}

	}
}