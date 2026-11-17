package com.gazuntite.provider.live.services.billing.dto.accountsAndReceiveables
{
	import com.gazuntite.common.util.xml.XmlConstants;
	import com.gazuntite.common.util.xml.XmlUtils;

	public class ClaimAdjustmentDTO
	{
		private var _ClaimAdjustmentID:String;
		private var _ClaimPaymentID:String;
		private var _AdjustmentTypeID:String;
		private var _AdjustmentReasonCodeID:String;
		private var _AdjustmentGroupCodeTypeID:String;
		private var _AdjustmentAmount:String;
		private var _ReasonCode:String;
		private var _ReasonDescription:String;
		private var _GroupCode:String;
		private var _GroupDescription:String;		
		private var _CreatedBy:String;
		private var _ModifiedBy:String;
		private var _IsDeleted:String;

		public function get AdjustmentTypeID():String
		{
			return _AdjustmentTypeID;
		}

		public function set AdjustmentTypeID(value:String):void
		{
			_AdjustmentTypeID = value;
		}

		public function FromXML(x:XML):void
		{
			ClaimAdjustmentID  			= x.@[XmlConstants.CLAIMADJUSTMENTID];
			ClaimPaymentID  			= x.@[XmlConstants.CLAIMPAYMENTID];
			AdjustmentTypeID  			= x.@[XmlConstants.ADJUSTMENTTYPEID];
			AdjustmentReasonCodeID  	= x.@[XmlConstants.ADJUSTMENTREASONCODEID];
			AdjustmentGroupCodeTypeID  	= x.@[XmlConstants.ADJUSTMENTGROUPCODETYPEID];
			AdjustmentAmount  			= x.@[XmlConstants.ADJUSTMENTAMOUNT];
			ReasonCode  				= x.@[XmlConstants.REASONCODE];
			ReasonDescription  			= x.@[XmlConstants.REASONDESCRIPTION];
			GroupCode  					= x.@[XmlConstants.GROUPCODE];
			GroupDescription  			= x.@[XmlConstants.GROUPDESCRIPTION];			
			CreatedBy 					= x.@[XmlConstants.CREATEDBY];
			ModifiedBy 					= x.@[XmlConstants.MODIFIEDBY];
			IsDeleted 					= x.@[XmlConstants.ISDELETED];
		}
		
		public function ToXML():XML
		{
			var x:XML = XmlUtils.getNodeByTagName( "PaymentAdjustment" );
			
			x.@[XmlConstants.CLAIMADJUSTMENTID]			= ClaimAdjustmentID;
			x.@[XmlConstants.CLAIMPAYMENTID]			= ClaimPaymentID;
			x.@[XmlConstants.ADJUSTMENTTYPEID]			= AdjustmentTypeID;
			x.@[XmlConstants.ADJUSTMENTREASONCODEID]	= AdjustmentReasonCodeID;
			x.@[XmlConstants.ADJUSTMENTGROUPCODETYPEID]	= AdjustmentGroupCodeTypeID;
			x.@[XmlConstants.ADJUSTMENTAMOUNT]			= AdjustmentAmount;
			x.@[XmlConstants.REASONCODE]				= ReasonCode;
			x.@[XmlConstants.REASONDESCRIPTION]			= ReasonDescription;
			x.@[XmlConstants.GROUPCODE]					= GroupCode;
			x.@[XmlConstants.GROUPDESCRIPTION]			= GroupDescription;			
			x.@[XmlConstants.CREATEDBY]					= CreatedBy;
			x.@[XmlConstants.MODIFIEDBY]				= ModifiedBy;
			x.@[XmlConstants.ISDELETED]					= IsDeleted;
			
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

		public function get GroupDescription():String
		{
			return _GroupDescription;
		}

		public function set GroupDescription(value:String):void
		{
			_GroupDescription = value;
		}

		public function get GroupCode():String
		{
			return _GroupCode;
		}

		public function set GroupCode(value:String):void
		{
			_GroupCode = value;
		}

		public function get ReasonDescription():String
		{
			return _ReasonDescription;
		}

		public function set ReasonDescription(value:String):void
		{
			_ReasonDescription = value;
		}

		public function get ReasonCode():String
		{
			return _ReasonCode;
		}

		public function set ReasonCode(value:String):void
		{
			_ReasonCode = value;
		}

		public function get AdjustmentAmount():String
		{
			return _AdjustmentAmount;
		}

		public function set AdjustmentAmount(value:String):void
		{
			_AdjustmentAmount = String(Number(value).toFixed(2));
		}

		public function get AdjustmentGroupCodeTypeID():String
		{
			return _AdjustmentGroupCodeTypeID;
		}

		public function set AdjustmentGroupCodeTypeID(value:String):void
		{
			_AdjustmentGroupCodeTypeID = value;
		}

		public function get AdjustmentReasonCodeID():String
		{
			return _AdjustmentReasonCodeID;
		}

		public function set AdjustmentReasonCodeID(value:String):void
		{
			_AdjustmentReasonCodeID = value;
		}

		public function get ClaimPaymentID():String
		{
			return _ClaimPaymentID;
		}

		public function set ClaimPaymentID(value:String):void
		{
			_ClaimPaymentID = value;
		}

		public function get ClaimAdjustmentID():String
		{
			return _ClaimAdjustmentID;
		}

		public function set ClaimAdjustmentID(value:String):void
		{
			_ClaimAdjustmentID = value;
		}

	}
}