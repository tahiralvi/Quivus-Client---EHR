package com.adobe.Quivus.customDTO.PatientLoad
{
	import com.adobe.Quivus.customDTO.CommonDTO.GeneralTypeDTO;
	import com.gazuntite.utils.UtilityFunctions;

	public class PatientAllergieDTO
	{
		
		private var _IsDeleted : Boolean;
		private var _IsDirty : Boolean;
		private var _AllergyType : GeneralTypeDTO;
		private var _IsActive : String;
		private var _IsInternal : Boolean;
		private var _OnSetDate : String;
		private var _PatientHistoryAllergyId : int;
		private var _PatientId : int;
		private var _Reaction : String;

		
		public function PatientAllergieDTO()
		{
			AllergyType = new GeneralTypeDTO();
		}

		public function FromXml(x:XML):void
		{
			IsDeleted							= UtilityFunctions.StringToBoolean( x.@IsDeleted );
			IsDirty 							= UtilityFunctions.StringToBoolean( x.@IsDeleted );
			IsInternal 							= UtilityFunctions.StringToBoolean( x.@IsDeleted );
			IsActive							=x.@IsActive;
			OnSetDate							=x.@OnSetDate;
			PatientHistoryAllergyId				=x.@PatientHistoryAllergyId;
			PatientId							=x.@PatientId;
			Reaction							=x.@Reaction;
			AllergyType.FromXML(x.AllergyType);
		}
		
		public function get Reaction():String
		{
			return _Reaction;
		}

		public function set Reaction(value:String):void
		{
			_Reaction = value;
		}

		public function get PatientId():int
		{
			return _PatientId;
		}

		public function set PatientId(value:int):void
		{
			_PatientId = value;
		}

		public function get PatientHistoryAllergyId():int
		{
			return _PatientHistoryAllergyId;
		}

		public function set PatientHistoryAllergyId(value:int):void
		{
			_PatientHistoryAllergyId = value;
		}

		public function get OnSetDate():String
		{
			return _OnSetDate;
		}

		public function set OnSetDate(value:String):void
		{
			_OnSetDate = value;
		}

		public function get IsInternal():Boolean
		{
			return _IsInternal;
		}

		public function set IsInternal(value:Boolean):void
		{
			_IsInternal = value;
		}

		public function get IsActive():String
		{
			return _IsActive;
		}

		public function set IsActive(value:String):void
		{
			_IsActive = value;
		}

		public function get AllergyType():GeneralTypeDTO
		{
			return _AllergyType;
		}

		public function set AllergyType(value:GeneralTypeDTO):void
		{
			_AllergyType = value;
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