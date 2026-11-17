package com.adobe.Quivus.customDTO.PatientLoad
{
	public class ModuleDictationDTO
	{
		private var _IsDeleted:Boolean;
		private var _IsDirty:Boolean;
		private var _ModuleDictationId:int;
		private var _VisitID:int;
		private var _VisitDate:Date;
		private var _DictationID:String;
		private var _ModuleTypeID:int;
		private var _DictationTimeStamp:Date();
		private var _ManagedByUserId:int;
		private var _ManagedByUserTypeId:int;
		private var _IsRecordEditable:Boolean;
		private var _CreatedBy:int;
		private var _CreatedAt:Date;
		private var _ModifiedBy:int;
		private var _ModifiedAt:Date;

		
		public function ModuleDictationDTO()
		{
			DictationTimeStamp = new Date();
			VisitDate = new Date();
		}

		public function get ModifiedAt():Date
		{
			return _ModifiedAt;
		}

		public function set ModifiedAt(value:Date):void
		{
			_ModifiedAt = value;
		}

		public function get ModifiedBy():int
		{
			return _ModifiedBy;
		}

		public function set ModifiedBy(value:int):void
		{
			_ModifiedBy = value;
		}

		public function get CreatedAt():Date
		{
			return _CreatedAt;
		}

		public function set CreatedAt(value:Date):void
		{
			_CreatedAt = value;
		}

		public function get CreatedBy():int
		{
			return _CreatedBy;
		}

		public function set CreatedBy(value:int):void
		{
			_CreatedBy = value;
		}

		public function FromXml(x:XML):void
		{
			IsDeleted				=x.@IsDeleted;
			IsDirty					=x.@IsDirty;
			ModuleDictationId		=x.@ModuleDictationId;
			VisitID					=new Date(x.@VisitID);
			VisitDate				=x.@VisitDate;
			DictationID				=x.@DictationID;
			ModuleTypeID			=x.@DictationID;
			DictationTimeStamp		=new Date(x.@DictationTimeStamp);
			ManagedByUserId			=x.@ManagedByUserId;
			ManagedByUserTypeId		=x.@ManagedByUserTypeId;
			IsRecordEditable		=x.@IsRecordEditable;
			CreatedBy				=x.@CreatedBy;
			CreatedAt				=new Date(x.@CreatedAt);
			ModifiedBy				=x.@ModifiedBy;
			ModifiedAt				=new Date(x.@ModifiedAt);
		}
		
		public function get IsRecordEditable():Boolean
		{
			return _IsRecordEditable;
		}

		public function set IsRecordEditable(value:Boolean):void
		{
			_IsRecordEditable = value;
		}

		public function get ManagedByUserTypeId():int
		{
			return _ManagedByUserTypeId;
		}

		public function set ManagedByUserTypeId(value:int):void
		{
			_ManagedByUserTypeId = value;
		}

		public function get ManagedByUserId():int
		{
			return _ManagedByUserId;
		}

		public function set ManagedByUserId(value:int):void
		{
			_ManagedByUserId = value;
		}

		public function get DictationTimeStamp():Date
		{
			return _DictationTimeStamp;
		}

		public function set DictationTimeStamp(value:Date):void
		{
			_DictationTimeStamp = value;
		}

		public function get ModuleTypeID():int
		{
			return _ModuleTypeID;
		}

		public function set ModuleTypeID(value:int):void
		{
			_ModuleTypeID = value;
		}

		public function get DictationID():String
		{
			return _DictationID;
		}

		public function set DictationID(value:String):void
		{
			_DictationID = value;
		}

		public function get VisitDate():Date
		{
			return _VisitDate;
		}

		public function set VisitDate(value:Date):void
		{
			_VisitDate = value;
		}

		public function get VisitID():int
		{
			return _VisitID;
		}

		public function set VisitID(value:int):void
		{
			_VisitID = value;
		}

		public function get ModuleDictationId():int
		{
			return _ModuleDictationId;
		}

		public function set ModuleDictationId(value:int):void
		{
			_ModuleDictationId = value;
		}

		public function get IsDirty():Boolean
		{
			return _IsDirty;
		}

		public function set IsDirty(value:Boolean):void
		{
			_IsDirty = value;
		}

		public function get IsDeleted():Boolean
		{
			return _IsDeleted;
		}

		public function set IsDeleted(value:Boolean):void
		{
			_IsDeleted = value;
		}

	}
}