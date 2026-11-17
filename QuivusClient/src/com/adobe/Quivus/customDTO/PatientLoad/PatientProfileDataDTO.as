package com.adobe.Quivus.customDTO.PatientLoad
{
	import com.adobe.Quivus.customDTO.CommonDTO.GeneralTypeDTO;
	
	import mx.collections.ArrayCollection;

	public class PatientProfileDataDTO
	{
		private var _PatientProfileSettingList:ArrayCollection;
		private var _ImageTypeList:ArrayCollection;
		
		private var _PatientProfile:PatientProfileDTO;
		private var _PatientProfileTagged:PatientProfileTaggedDTO;
		private var _RecentPatient:RecentPatientDTO;
		
		private var _UserEmail:String;
		private var _GaxenID:String;
		
		public function PatientProfileDataDTO()
		{
			PatientProfileSettingList = new ArrayCollection();
			ImageTypeList = new ArrayCollection();
			
			PatientProfile			= new PatientProfileDTO();
			PatientProfileTagged	= new PatientProfileTaggedDTO();
			RecentPatient			= new RecentPatientDTO();
		}

		public function FromXml(x:XML):void
		{
			UserEmail		= x.@UserEmail;
			GaxenID			= x.@GaxenID;
			
			RecentPatient.FromXml(x.RecentPatient[0]);
			PatientProfileTagged.FromXml(x.PatientProfileTagged[0]);
			PatientProfile.FromXml(x.PatientProfile[0]);
			
			PatientProfileSettingList.removeAll();
			ImageTypeList.removeAll();
			
			var ProfileSetting:XMLList = x.PatientProfileSettingList.PatientProfileSettingDTO;
			for each(var child:XML in ProfileSetting)
			{
				var Setting:GeneralTypeDTO;				
				Setting.FromXML(child);				
				PatientProfileSettingList.addItem(Setting);
			}
			
			var Images:XMLList = x.ImageType.ImageTypeDTO;
			for each(var child:XML in Images)
			{
				var imageType:GeneralTypeDTO;				
				imageType.FromXML(child);				
				ImageTypeList.addItem(imageType);
			}
			
			
			
		}

		
		public function get ImageTypeList():ArrayCollection
		{
			return _ImageTypeList;
		}
		
		public function set ImageTypeList(value:ArrayCollection):void
		{
			_ImageTypeList = value;
		}
		
		public function get GaxenID():String
		{
			return _GaxenID;
		}

		public function set GaxenID(value:String):void
		{
			_GaxenID = value;
		}

		public function get UserEmail():String
		{
			return _UserEmail;
		}

		public function set UserEmail(value:String):void
		{
			_UserEmail = value;
		}

		public function get RecentPatient():RecentPatientDTO
		{
			return _RecentPatient;
		}

		public function set RecentPatient(value:RecentPatientDTO):void
		{
			_RecentPatient = value;
		}

		public function get PatientProfileTagged():PatientProfileTaggedDTO
		{
			return _PatientProfileTagged;
		}

		public function set PatientProfileTagged(value:PatientProfileTaggedDTO):void
		{
			_PatientProfileTagged = value;
		}

		public function get PatientProfile():PatientProfileDTO
		{
			return _PatientProfile;
		}

		public function set PatientProfile(value:PatientProfileDTO):void
		{
			_PatientProfile = value;
		}

		

		public function get PatientProfileSettingList():ArrayCollection
		{
			return _PatientProfileSettingList;
		}

		public function set PatientProfileSettingList(value:ArrayCollection):void
		{
			_PatientProfileSettingList = value;
		}

	}
}