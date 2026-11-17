package com.gazuntite.provider.live.services.billing.dto.SuperBill
{
	import com.gazuntite.common.util.xml.XmlConstants;

	[Bindable]
	public class CPTMedicalTypeDTO
	{
		private var m_sCPTMedicalTypeID:String;
		private var m_sProcedureCode:String;
		private var m_sProcedureDescription:String;
		
		public function CPTMedicalTypeDTO()
		{
		}
		
		public function get CPTMedicalTypeID():String
		{
			return m_sCPTMedicalTypeID;
		}
		
		public function set CPTMedicalTypeID(value:String):void
		{
			m_sCPTMedicalTypeID = value;
		}
		
		public function get ProcedureCode():String
		{
			return m_sProcedureCode;
		}
		
		public function set ProcedureCode(value:String):void
		{
			m_sProcedureCode = value;
		}
		
		public function get ProcedureDescription():String
		{
			return m_sProcedureDescription;
		}
		
		public function set ProcedureDescription(value:String):void
		{		
			m_sProcedureDescription = value;
		}
		
		public function FromXML( x:XML ):void
		{
			CPTMedicalTypeID 							= x.@[XmlConstants.TYPMEDICALTYPEID];
			ProcedureCode 								= x.@[XmlConstants.TYPPROCEDURECODE];
			ProcedureDescription 						= x.@[XmlConstants.TYPPROCEDUREDESCRIPTION];			
		}
	}
}