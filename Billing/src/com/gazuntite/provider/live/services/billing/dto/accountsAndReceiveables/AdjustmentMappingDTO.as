package com.gazuntite.provider.live.services.billing.dto.accountsAndReceiveables
{
	import com.gazuntite.common.util.xml.XmlConstants;
	import com.gazuntite.common.util.xml.XmlUtils;

	public class AdjustmentMappingDTO
	{
		private var _AdjustmentMappingID:String;
		private var _AdjustmentReasonCodeID:String;
		private var _AdjustmentGroupCodeTypeID:String;
		private var _InsOrganizationID:String;
		private var _AdjustmentMappingTypeID:String;		
		private var _InsuranceName:String;
		private var _ReasonCode:String;
		private var _ReasonDescription:String;
		private var _GroupCode:String;
		private var _GroupDescription:String;
		private var _Type:String;
		
		private var _CreatedBy:String;
		private var _ModifiedBy:String;
		private var _IsDeleted:String;
		
		private var _IsUpdated:Boolean;
				
		public function get IsUpdated():Boolean
		{
			return _IsUpdated;
		}

		public function set IsUpdated(value:Boolean):void
		{
			_IsUpdated = value;
		}

		public function get InsuranceName():String
		{
			return _InsuranceName;
		}

		public function set InsuranceName(value:String):void
		{
			_InsuranceName = value;
		}

		public function get Type():String
		{
			return _Type;
		}

		public function set Type(value:String):void
		{
			_Type = value;
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

		public function FromXML(x:XML):void
		{
			AdjustmentMappingID 			= x.@[XmlConstants.ADJUSTMENTMAPPINGID];
			AdjustmentReasonCodeID 			= x.@[XmlConstants.ADJUSTMENTREASONCODEID];
			AdjustmentGroupCodeTypeID 		= x.@[XmlConstants.ADJUSTMENTGROUPCODETYPEID];
			InsOrganizationID 				= x.@[XmlConstants.INSORGANIZATIONID];
			AdjustmentMappingTypeID 		= x.@[XmlConstants.ADJUSTMENTMAPPINGTYPEID];
			InsuranceName					= x.@[XmlConstants.INSURANCENAME];
			ReasonCode						= x.@[XmlConstants.REASONCODE];
			ReasonDescription				= x.@[XmlConstants.REASONDESCRIPTION];
			GroupCode						= x.@[XmlConstants.GROUPCODE];
			GroupDescription				= x.@[XmlConstants.GROUPDESCRIPTION];
			Type							= x.@[XmlConstants.TYPE];
			CreatedBy 						= x.@[XmlConstants.CREATEDBY];
			ModifiedBy 						= x.@[XmlConstants.MODIFIEDBY];
			IsDeleted 						= x.@[XmlConstants.ISDELETED];
			IsUpdated						= false;
		}

		public function ToXML():XML
		{
			var x:XML = XmlUtils.getNodeByTagName( "AdjustmentMapping" );
			
			x.@[XmlConstants.ADJUSTMENTMAPPINGID]		=		AdjustmentMappingID;
			x.@[XmlConstants.ADJUSTMENTREASONCODEID]	=		AdjustmentReasonCodeID;
			x.@[XmlConstants.ADJUSTMENTGROUPCODETYPEID]	=		AdjustmentGroupCodeTypeID;
			x.@[XmlConstants.INSORGANIZATIONID]			=		InsOrganizationID;
			x.@[XmlConstants.ADJUSTMENTMAPPINGTYPEID]	=		AdjustmentMappingTypeID;
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

		public function get AdjustmentMappingTypeID():String
		{
			return _AdjustmentMappingTypeID;
		}

		public function set AdjustmentMappingTypeID(value:String):void
		{
			_AdjustmentMappingTypeID = value;
		}

		public function get InsOrganizationID():String
		{
			return _InsOrganizationID;
		}

		public function set InsOrganizationID(value:String):void
		{
			_InsOrganizationID = value;
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

		public function get AdjustmentMappingID():String
		{
			return _AdjustmentMappingID;
		}

		public function set AdjustmentMappingID(value:String):void
		{
			_AdjustmentMappingID = value;
		}

	}
}