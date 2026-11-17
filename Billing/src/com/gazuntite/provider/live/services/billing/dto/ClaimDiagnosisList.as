package com.gazuntite.provider.live.services.billing.dto
{
	
	
	[Bindable]
	public class ClaimDiagnosisList
	{	
		private var m_sDiagnosis:String;
		
		public function ClaimDiagnosisList()
		{
			ClaimDiagnosis = new String();
		}
		
		public function get ClaimDiagnosis():String
		{
			return m_sDiagnosis;
		}
		
		public function set ClaimDiagnosis(value:String):void
		{
			m_sDiagnosis = value;
		}		
	}
}