package com.adobe.Quivus.customDTO.PatientLoad
{
	public class PatientMedicalHistoryDTO
	{
		private var _IsDeleted:Boolean;
		private var _IsDirty:Boolean;
		private var _HistoryMedicalId:int;
		private var _PatientId:int;
		private var _IsActive:Boolean;
		private var _Description:String;
				
		public function PatientMedicalHistoryDTO()
		{
			
		}
		
		public function FromXml(x:XML):void
		{
			IsDeleted			=StringToBoolean(x.@IsDeleted);
			IsDirty				=StringToBoolean(x.@IsDirty);
			HistoryMedicalId	=x.@PatientHistoryMedicalId;
			PatientId			=x.@PatientId;
			IsActive			=StringToBoolean(x.@IsActive);
			Description			=x.@Description;
		}

		public function StringToBoolean(val:String):Boolean
		{		
			if(val == "false")
				return false;
				
			else if(val =="true")
				return true;
			
			return true;
		}
		
		public function get Description():String
		{
			return _Description;
		}

		public function set Description(value:String):void
		{
			_Description = value;
		}

		public function get IsActive():Boolean
		{
			return _IsActive;
		}

		public function set IsActive(value:Boolean):void
		{
			_IsActive = value;
		}

		public function get PatientId():int
		{
			return _PatientId;
		}

		public function set PatientId(value:int):void
		{
			_PatientId = value;
		}

		public function get HistoryMedicalId():int
		{
			return _HistoryMedicalId;
		}

		public function set HistoryMedicalId(value:int):void
		{
			_HistoryMedicalId = value;
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