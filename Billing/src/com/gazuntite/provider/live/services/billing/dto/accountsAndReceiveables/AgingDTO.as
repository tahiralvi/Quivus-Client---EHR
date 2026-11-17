package com.gazuntite.provider.live.services.billing.dto.accountsAndReceiveables
{
	import com.gazuntite.common.util.xml.XmlConstants;
	[Bindable]
	public class AgingDTO
	{
		private var _OneMonth:String;
		private var _TwoMonth:String;
		private var _ThreeMonth:String;
		private var _ThreeMonthPlus:String;
		private var _TotaAging:String;
		private var _TotalNotBilled:String;
		
		public function get TotaAging():String
		{
			return _TotaAging;
		}

		public function set TotaAging(value:String):void
		{
			_TotaAging = value;
		}

		public function get TotalNotBilled():String
		{
			return _TotalNotBilled;
		}

		public function set TotalNotBilled(value:String):void
		{
			_TotalNotBilled = value;
		}

		public function FromXML(x:XML):void
		{
			OneMonth  			= x.@[XmlConstants.ONEMONTH];			
			TwoMonth  			= x.@[XmlConstants.TWOMONTH];
			ThreeMonth 			= x.@[XmlConstants.THREEMONTH];
			ThreeMonthPlus 		= x.@[XmlConstants.THREEMONTHPLUS];
			TotalNotBilled 		= x.@[XmlConstants.TOTALNOTBILLED];
			
			TotalNotBilled = String(Number(OneMonth) + Number(TwoMonth) + Number(ThreeMonth) + Number(ThreeMonthPlus))
		}	
		
		public function get ThreeMonthPlus():String
		{
			return _ThreeMonthPlus;
		}

		public function set ThreeMonthPlus(value:String):void
		{
			_ThreeMonthPlus = value;
		}

		public function get ThreeMonth():String
		{
			return _ThreeMonth;
		}

		public function set ThreeMonth(value:String):void
		{
			_ThreeMonth = value;
		}

		public function get TwoMonth():String
		{
			return _TwoMonth;
		}

		public function set TwoMonth(value:String):void
		{
			_TwoMonth = value;
		}

		public function get OneMonth():String
		{
			return _OneMonth;
		}

		public function set OneMonth(value:String):void
		{
			_OneMonth = value;
		}

	}
}