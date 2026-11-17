package com.adobe.Quivus.customDTO.PatientLoad
{
	import com.adobe.Quivus.customDTO.AddressBookDTO;
	import com.adobe.Quivus.customDTO.CommonDTO.GeneralTypeDTO;
	
	import valueObjects.MaritalStatusTypeDTO;

	public class PatientGurantorDTO
	{
		private var _IsDeleted 				: Boolean;
		private var _IsDirty 				: Boolean;
		private var _AddressBook 			: AddressBookDTO;
		private var _DOB 					: Date;
		private var _GenderType 			: GeneralTypeDTO;
		private var _GuarantorId 			: int;
		private var _GuarantorLastName 		: String;
		private var _GurantorFirstName 		: String;
		private var _MaritalStatusType 		: GeneralTypeDTO;
		private var _PatientId 				: int;
		private var _RecGuid 				: String;
		private var _RelationshipType 		: GeneralTypeDTO;
		private var _StatusType 			: GeneralTypeDTO;
		private var _StrDOB 				: String;
		
		public function PatientGurantorDTO()
		{
			
			AddressBook				= new AddressBookDTO();
			GenderType 				= new GeneralTypeDTO();
			MaritalStatusType		= new GeneralTypeDTO();
			RelationshipType 		= new GeneralTypeDTO();
			StatusType				= new GeneralTypeDTO();
		}
		
		public function FromXml(x:XML):void
		{
			IsDeleted 				=x.@IsDeleted;
			IsDirty 				=x.@IsDirty;	
			DOB 					=x.@DOB;				
			GuarantorId 			=x.@GuarantorId;
			GuarantorLastName 		=x.@GuarantorLastName;
			GurantorFirstName 		=x.@GurantorFirstName;		
			PatientId 				=x.@PatientId;
			RecGuid 				=x.@RecGuid;				
			StrDOB 					=x.@StrDOB;
			
			StatusType.FromXML(x.StatusType[0]);
			RelationshipType.FromXML(x.RelationshipType[0]);
			MaritalStatusType.FromXML(x.MaritalStatusType[0]);	
			GenderType.FromXML(x.GenderType[0]);
			AddressBook.FromXML(x.AddressBook[0]);				
		}
		
		
		public function StringToBoolean(val:String):Boolean  
		{
			if(val == "false")
				return false;
				
			else if(val =="true")
				return true;
			
			return true;
		}

		public function get StrDOB():String
		{
			return _StrDOB;
		}

		public function set StrDOB(value:String):void
		{
			_StrDOB = value;
		}

		public function get StatusType():GeneralTypeDTO
		{
			return _StatusType;
		}

		public function set StatusType(value:GeneralTypeDTO):void
		{
			_StatusType = value;
		}

		public function get RelationshipType():GeneralTypeDTO
		{
			return _RelationshipType;
		}

		public function set RelationshipType(value:GeneralTypeDTO):void
		{
			_RelationshipType = value;
		}

		public function get RecGuid():String
		{
			return _RecGuid;
		}

		public function set RecGuid(value:String):void
		{
			_RecGuid = value;
		}

		public function get PatientId():int
		{
			return _PatientId;
		}

		public function set PatientId(value:int):void
		{
			_PatientId = value;
		}

		public function get MaritalStatusType():GeneralTypeDTO
		{
			return _MaritalStatusType;
		}

		public function set MaritalStatusType(value:GeneralTypeDTO):void
		{
			_MaritalStatusType = value;
		}

		public function get GurantorFirstName():String
		{
			return _GurantorFirstName;
		}

		public function set GurantorFirstName(value:String):void
		{
			_GurantorFirstName = value;
		}

		public function get GuarantorLastName():String
		{
			return _GuarantorLastName;
		}

		public function set GuarantorLastName(value:String):void
		{
			_GuarantorLastName = value;
		}

		public function get GuarantorId():int
		{
			return _GuarantorId;
		}

		public function set GuarantorId(value:int):void
		{
			_GuarantorId = value;
		}

		public function get GenderType():GeneralTypeDTO
		{
			return _GenderType;
		}

		public function set GenderType(value:GeneralTypeDTO):void
		{
			_GenderType = value;
		}

		public function get DOB():Date
		{
			return _DOB;
		}

		public function set DOB(value:Date):void
		{
			_DOB = value;
		}

		public function get AddressBook():AddressBookDTO
		{
			return _AddressBook;
		}

		public function set AddressBook(value:AddressBookDTO):void
		{
			_AddressBook = value;
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