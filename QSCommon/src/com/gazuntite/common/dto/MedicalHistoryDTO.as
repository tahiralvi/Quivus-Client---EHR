package com.gazuntite.common.dto
{
	import com.gazuntite.common.dto.baseDTO.common.BaseDTO;
	import com.gazuntite.common.dto.baseDTO.common.GeneralTypeDTO;
	import com.gazuntite.common.util.xml.XmlUtils;
	import com.gazuntite.utils.UtilityFunctions;
	import com.gazuntite.common.dto.assessment.diagnosis.ICDCodeDTO;

	[Bindable]
	public class MedicalHistoryDTO extends BaseDTO
	{
		private var _OnSet:String = '';
		private var _NoOfRecords:int;
		private var _IsNA:Boolean;
		private var _IsNone:Boolean;
		private var _IsRecordEditabl:Boolean;
		private var _ID:int;
		private var _ICDDTO:ICDCodeDTO;
		private var _medicalhistorytype:GeneralTypeDTO;
		private var _isActive:Boolean;

		public function MedicalHistoryDTO()
		{
			ICDDTO = new ICDCodeDTO();
			medicalhistorytype = new GeneralTypeDTO();
		}
		
		public function get isActive():Boolean
		{
			return _isActive;
		}

		public function set isActive(value:Boolean):void
		{
			_isActive = value;
		}

		public function get ICDDTO():ICDCodeDTO
		{
			return _ICDDTO;
		}

		public function set ICDDTO(value:ICDCodeDTO):void
		{
			_ICDDTO = value;
		}

		public function get medicalhistorytype():GeneralTypeDTO
		{
			return _medicalhistorytype;
		}

		public function set medicalhistorytype(value:GeneralTypeDTO):void
		{
			_medicalhistorytype = value;
		}

		public function get ID():int
		{
			return _ID;
		}

		public function set ID(value:int):void
		{
			_ID = value;
		}

		public function get IsRecordEditabl():Boolean
		{
			return _IsRecordEditabl;
		}

		public function set IsRecordEditabl(value:Boolean):void
		{
			_IsRecordEditabl = value;
		}

		public function get IsNone():Boolean
		{
			return _IsNone;
		}

		public function set IsNone(value:Boolean):void
		{
			_IsNone = value;
		}

		public function get IsNA():Boolean
		{
			return _IsNA;
		}

		public function set IsNA(value:Boolean):void
		{
			_IsNA = value;
		}


		public function get NoOfRecords():int
		{
			return _NoOfRecords;
		}

		public function set NoOfRecords(value:int):void
		{
			_NoOfRecords = value;
		}

		public function get OnSet():String
		{
			return _OnSet;
		}

		public function set OnSet(value:String):void
		{
			_OnSet = value;
		}
		
		public override function ToXML():XML
		{
			this.nodeName = "MedicalHistoryDTO";
			var x:XML = super.ToXML();
			
			x.@OnSet			= this.OnSet;
			x.@NoOfRecords		=this.NoOfRecords ;
			x.@IsActive			=this.isActive ;
			x.@IsNA				=this.IsNA ;
			x.@IsNone			=this.IsNone ;
			x.@TypeID			=this.medicalhistorytype.ID;
			x.@ID				=this.ID ;
			
			medicalhistorytype.NodeName = "Medicalhistorytype";
			
			x.appendChild (medicalhistorytype.ToXML());
			
			ICDDTO.nodename = "ICDCodeList";
			x.appendChild( ICDDTO.ToXML() );
			x.ICDCodeList.@IsActive = this.isActive;
			x.ICDCodeList.@Onset = this.OnSet;
			
			return x;
		}
		
		public override  function FromXML(x:XML):void
		{
			this.ID = x.@ID;
			this.IsDeleted  = x.@IsDeleted;
			
			var visitDate:String = x.@VisitDate;
			
			this.VisitDate = new Date(visitDate);
			
			var CreatedAt:String = x.@CreatedAt;
			
			this.CreatedAt = new Date(CreatedAt);
			this.IsNone= StringToBoolean(x.@IsNone);
			this.IsNA= StringToBoolean(x.@IsNA);
			this.PatientID= x.@PatientID;
			this.NoOfRecords= x.@NoOfRecords;
			this.OnSet=  x.@OnSet;
			this.isActive =StringToBoolean(x.@IsActive);
			
			medicalhistorytype = new GeneralTypeDTO();
			medicalhistorytype.FromXML(x.MedicalHistoryType[0]);
			
			ICDDTO = new ICDCodeDTO();
			ICDDTO.FromXML(x.ICDCodeList[0]);
		}
	}
}