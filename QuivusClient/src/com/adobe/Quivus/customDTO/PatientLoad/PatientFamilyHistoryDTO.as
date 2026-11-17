package com.adobe.Quivus.customDTO.PatientLoad
{
	import com.gazuntite.utils.UtilityFunctions;

	public class PatientFamilyHistoryDTO
	{
		
		private var _IsDeleted : Boolean;
		private var _IsDirty : Boolean;
		private var _Description : String;
		
		private var _IsActive : String;
		private var _PatientHistoryFamilyId : int;
		private var _PatientId : int;
		
		//Need to complete it
		/*private var ICDCodeType : valueObjects.ICDCodeDTO;
		private var RelationshipType : valueObjects.RelationshipTypeDTO;*/
		
		public function PatientFamilyHistoryDTO()
		{
			
		}

		public function FromXml(x:XML):void
		{
			IsDeleted					=UtilityFunctions.StringToBoolean(x.@IsDeleted);
			IsDirty						=UtilityFunctions.StringToBoolean(x.@IsDirty);
			Description					=x.@Description;	
			IsActive					=x.@IsActive;
			PatientHistoryFamilyId		=x.@PatientHistoryFamilyId;
			PatientId					=x.@PatientId;
		}
		
		public function get PatientId():int
		{
			return _PatientId;
		}

		public function set PatientId(value:int):void
		{
			_PatientId = value;
		}

		public function get PatientHistoryFamilyId():int
		{
			return _PatientHistoryFamilyId;
		}

		public function set PatientHistoryFamilyId(value:int):void
		{
			_PatientHistoryFamilyId = value;
		}

		public function get IsActive():String
		{
			return _IsActive;
		}

		public function set IsActive(value:String):void
		{
			_IsActive = value;
		}

		public function get Description():String
		{
			return _Description;
		}

		public function set Description(value:String):void
		{
			_Description = value;
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