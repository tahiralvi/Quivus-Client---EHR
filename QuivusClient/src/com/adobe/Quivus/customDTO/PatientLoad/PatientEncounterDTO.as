package com.adobe.Quivus.customDTO.PatientLoad
{
	public class PatientEncounterDTO
	{
		private var _IsDeleted:Boolean;
		private var _IsDirty:Boolean;
		private var _VisitId:int;
		private var _VisitDate:Date;
		private var _VisitEncounterTypeName:String;
		private var _VisitProvider:String;
		private var _VisitStatus:String;
		private var _StationID:int;
		private var _OwnerUserId:int;
		private var _OwnerUserTypeId:int;
		private var _DictationID:String;
		private var _CanSignCosign:String;
		private var _PlaceOfServiceTypeID:int;
		
		public function PatientEncounterDTO()
		{
		}
		
		public function FromXml(x:XML):void
		{
			IsDeleted					=StringToBoolean(x.@IsDeleted);
			IsDirty						=StringToBoolean(x.@IsDirty);
			VisitId						=x.@VisitId;
			VisitDate					=new Date(x.@VisitDate);
			VisitEncounterTypeName		=x.@VisitEncounterTypeName;
			VisitProvider				=x.@VisitProvider;
			VisitStatus					=x.@VisitStatus;
			StationID					=x.@StationID;
			OwnerUserId					=x.@OwnerUserId;
			OwnerUserTypeId				=x.@OwnerUserTypeId;
			DictationID					=x.@DictationID;
			CanSignCosign				=x.@CanSignCosign;
			PlaceOfServiceTypeID		=x.@PlaceOfServiceTypeID;
		}
		
		public function StringToBoolean(val:String):Boolean 
		{
			if(val == "false")
				return false;
				
			else if(val =="true")
				return true;
			
			return true;
		}
		
		
		public function get PlaceOfServiceTypeID():int
		{
			return _PlaceOfServiceTypeID;
		}

		public function set PlaceOfServiceTypeID(value:int):void
		{
			_PlaceOfServiceTypeID = value;
		}

		public function get CanSignCosign():String
		{
			return _CanSignCosign;
		}

		public function set CanSignCosign(value:String):void
		{
			_CanSignCosign = value;
		}

		public function get DictationID():String
		{
			return _DictationID;
		}

		public function set DictationID(value:String):void
		{
			_DictationID = value;
		}

		public function get OwnerUserTypeId():int
		{
			return _OwnerUserTypeId;
		}

		public function set OwnerUserTypeId(value:int):void
		{
			_OwnerUserTypeId = value;
		}

		public function get OwnerUserId():int
		{
			return _OwnerUserId;
		}

		public function set OwnerUserId(value:int):void
		{
			_OwnerUserId = value;
		}

		public function get StationID():int
		{
			return _StationID;
		}

		public function set StationID(value:int):void
		{
			_StationID = value;
		}

		public function get VisitStatus():String
		{
			return _VisitStatus;
		}

		public function set VisitStatus(value:String):void
		{
			_VisitStatus = value;
		}

		public function get VisitProvider():String
		{
			return _VisitProvider;
		}

		public function set VisitProvider(value:String):void
		{
			_VisitProvider = value;
		}

		public function get VisitEncounterTypeName():String
		{
			return _VisitEncounterTypeName;
		}

		public function set VisitEncounterTypeName(value:String):void
		{
			_VisitEncounterTypeName = value;
		}

		public function get VisitDate():Date
		{
			return _VisitDate;
		}

		public function set VisitDate(value:Date):void
		{
			_VisitDate = value;
		}

		public function get VisitId():int
		{
			return _VisitId;
		}

		public function set VisitId(value:int):void
		{
			_VisitId = value;
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

