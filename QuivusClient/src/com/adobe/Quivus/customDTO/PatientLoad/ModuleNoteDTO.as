package com.adobe.Quivus.customDTO.PatientLoad
{
	public class ModuleNoteDTO
	{
		private var _IsDeleted:Boolean;
		private var _IsDirty:Boolean;
		private var _IsRecordEditable:Boolean;
		
		private var _ModuleNoteId:int;
		private var _ModuleTypeId:int;
		private var _VisitID:int;
		private var _ManagedByUserId:int;
		private var _ModifiedBy:int;
		private var _CreatedBy:int;
		
		private var _Note:String;
		private var _NoteSubject:String;
		
		private var _VisitDate:Date;
		private var _CreatedAt:Date;
		private var _ModifiedAt:Date;
		
		
		public function ModuleNoteDTO()
		{
		}
		
		public function FromXml(x:XML):void
		{
			IsDeleted				=StringToBoolean(x.@IsDeleted);
			IsDirty					=StringToBoolean(x.@IsDirty);
			IsRecordEditable		=StringToBoolean(x.@IsRecordEditable);
			
			ModuleNoteId			=x.@ModuleNoteId;
			ModuleTypeId			=x.@ModuleTypeId;
			VisitID					=x.@ModifiedBy;
			ManagedByUserId			=x.@ManagedByUserId;
			ModifiedBy				=x.@ModifiedBy;
			CreatedBy				=x.@CreatedBy;
			
			Note					=x.@Note;
			NoteSubject				=x.@NoteSubject;
			
			VisitDate				= new Date( x.@NoteSubject );
			CreatedAt				= new Date(	x.@CreatedAt);
			ModifiedAt				= new Date(	x.@ModifiedAt);
		}
		
		
		public function StringToBoolean(val:String):Boolean
		{
			if(val == "false")
				return false;
				
			else if(val =="true")
				return true;
			
			return true;
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
		
		
		public function get IsRecordEditable():Boolean
		{
			return _IsRecordEditable;
		}
		
		public function set IsRecordEditable(value:Boolean):void
		{
			_IsRecordEditable = value;
		}
		
		public function get VisitDate():Date
		{
			return _VisitDate;
		}
		
		public function set VisitDate(value:Date):void
		{
			_VisitDate = value;
		}
		
		public function get ManagedByUserId():int
		{
			return _ManagedByUserId;
		}
		
		public function set ManagedByUserId(value:int):void
		{
			_ManagedByUserId = value;
		}
		
		public function get NoteSubject():String
		{
			return _NoteSubject;
		}
		
		public function set NoteSubject(value:String):void
		{
			_NoteSubject = value;
		}
		
		public function get Note():String
		{
			return _Note;
		}
		
		public function set Note(value:String):void
		{
			_Note = value;
		}
		
		public function get VisitID():int
		{
			return _VisitID;
		}
		
		public function set VisitID(value:int):void
		{
			_VisitID = value;
		}
		
		public function get ModuleTypeId():int
		{
			return _ModuleTypeId;
		}
		
		public function set ModuleTypeId(value:int):void
		{
			_ModuleTypeId = value;
		}
		
		public function get ModuleNoteId():int
		{
			return _ModuleNoteId;
		}
		
		public function set ModuleNoteId(value:int):void
		{
			_ModuleNoteId = value;
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