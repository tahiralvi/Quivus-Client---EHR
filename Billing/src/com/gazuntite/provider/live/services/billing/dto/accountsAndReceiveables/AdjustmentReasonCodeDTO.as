package com.gazuntite.provider.live.services.billing.dto.accountsAndReceiveables
{
	import com.gazuntite.common.util.xml.XmlConstants;
	import com.gazuntite.common.util.xml.XmlUtils;

	public class AdjustmentReasonCodeDTO
	{
		private var _AdjustmentReasonCodeID:String;
		private var _AdjustmentReasonCode:String;
		private var _AdjustmentReasonName:String;
		private var _Description:String;
		private var _CreatedBy:String;
		private var _ModifiedBy:String;
		private var _IsDeleted:String;

		public function get AdjustmentReasonName():String
		{
			return _AdjustmentReasonName;
		}

		public function set AdjustmentReasonName(value:String):void
		{
			_AdjustmentReasonName = value;
		}

		public function FromXML(x:XML):void
		{
			AdjustmentReasonCodeID  = x.@[XmlConstants.ADJUSTMENTREASONCODEID];
			AdjustmentReasonCode  	= x.@[XmlConstants.ADJUSTMENTREASONCODE];
			Description  			= x.@[XmlConstants.DESCRIPTION];
			CreatedBy 				= x.@[XmlConstants.CREATEDBY];
			ModifiedBy 				= x.@[XmlConstants.MODIFIEDBY];
			IsDeleted 				= x.@[XmlConstants.ISDELETED];
			
			AdjustmentReasonName = AdjustmentReasonCode + " - " + Description;
			
		}
		
		public function ToXML():XML
		{
			var x:XML = XmlUtils.getNodeByTagName( "AdjustmentReasonCode" );
			
			x.@[XmlConstants.ADJUSTMENTREASONCODEID]	=		AdjustmentReasonCodeID;
			x.@[XmlConstants.ADJUSTMENTREASONCODE]		=		AdjustmentReasonCode;
			x.@[XmlConstants.DESCRIPTION]				=		Description;
			x.@[XmlConstants.CREATEDBY]					= 		CreatedBy;
			x.@[XmlConstants.MODIFIEDBY]				= 		ModifiedBy;
			x.@[XmlConstants.ISDELETED]					= 		IsDeleted;
						
			return x;
		}
		
		public function get IsDeleted():String
		{
			return _IsDeleted;
		}

		public function set IsDeleted(value:String):void
		{
			_IsDeleted = value;
		}

		public function get ModifiedBy():String
		{
			return _ModifiedBy;
		}

		public function set ModifiedBy(value:String):void
		{
			_ModifiedBy = value;
		}

		public function get CreatedBy():String
		{
			return _CreatedBy;
		}

		public function set CreatedBy(value:String):void
		{
			_CreatedBy = value;
		}

		public function get Description():String
		{
			return _Description;
		}

		public function set Description(value:String):void
		{
			_Description = value;
		}

		public function get AdjustmentReasonCode():String
		{
			return _AdjustmentReasonCode;
		}

		public function set AdjustmentReasonCode(value:String):void
		{
			_AdjustmentReasonCode = value;
		}

		public function get AdjustmentReasonCodeID():String
		{
			return _AdjustmentReasonCodeID;
		}

		public function set AdjustmentReasonCodeID(value:String):void
		{
			_AdjustmentReasonCodeID = value;
		}

	}
}