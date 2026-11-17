package com.adobe.Quivus.view.controls.custom.patientExamView.viewBackground.vbTabSection
{
	import com.gazuntite.common.util.xml.XmlUtils;
	
	import mx.collections.XMLListCollection;

	[Bindable]
	public class SummaryViewXMLCollection
	{
		public var SummaryXML:XML ;
		
		public function SummaryViewXMLCollection(value:XML)
		{
			SummaryXML = value;
			Allergies 			= new XMLListCollection( XmlUtils.getChildrenByNodeName( SummaryXML, "Allergies"			) );
			PastMedicalHistory 	= new XMLListCollection( XmlUtils.getChildrenByNodeName( SummaryXML, "PastMedicalHistory"	) );
			SocialHistory	 	= new XMLListCollection( XmlUtils.getChildrenByNodeName( SummaryXML, "SocialHistory"		) );
			Immunizations	 	= new XMLListCollection( XmlUtils.getChildrenByNodeName( SummaryXML, "Immunizations"		) );
			ChronicMedication	= new XMLListCollection( XmlUtils.getChildrenByNodeName( SummaryXML, "ChronicMedication"	) );
			Vitals	 			= new XMLListCollection( XmlUtils.getChildrenByNodeName( SummaryXML, "Vitals"				) );
			CCHPI	 			= new XMLListCollection( XmlUtils.getChildrenByNodeName( SummaryXML, "CCHPI"				) );
			ROS	 				= new XMLListCollection( XmlUtils.getChildrenByNodeName( SummaryXML, "ROS"					) );
			Physical	 		= new XMLListCollection( XmlUtils.getChildrenByNodeName( SummaryXML, "Physicals"			) );
			Labs	 			= new XMLListCollection( XmlUtils.getChildrenByNodeName( SummaryXML, "Lab"					) );
			Diagnosis	 		= new XMLListCollection( XmlUtils.getChildrenByNodeName( SummaryXML, "ChronicDiagnosis"		) );
			Prescriptions	 	= new XMLListCollection( XmlUtils.getChildrenByNodeName( SummaryXML, "Prescriptions"		) );
			Procedures	 		= new XMLListCollection( XmlUtils.getChildrenByNodeName( SummaryXML, "Procedures"			) );
			Recomendation	 	= new XMLListCollection( XmlUtils.getChildrenByNodeName( SummaryXML, "Recommendations"		) );
			Followup	 		= new XMLListCollection( XmlUtils.getChildrenByNodeName( SummaryXML, "Followup"				) );
		}
		
		private var _PastMedicalHistory:XMLListCollection;

		public function get PastMedicalHistory():XMLListCollection
		{
			return _PastMedicalHistory;
		}

		public function set PastMedicalHistory(value:XMLListCollection):void
		{
			_PastMedicalHistory = value;
		}

		private var _Allergies:XMLListCollection;

		public function get Allergies():XMLListCollection
		{
			return _Allergies;
		}

		public function set Allergies(value:XMLListCollection):void
		{
			_Allergies = value;
		}

		private var _SocialHistory:XMLListCollection;

		public function get SocialHistory():XMLListCollection
		{
			return _SocialHistory;
		}

		public function set SocialHistory(value:XMLListCollection):void
		{
			_SocialHistory = value;
		}


		private var _Immunizations:XMLListCollection;

		public function get Immunizations():XMLListCollection
		{
			return _Immunizations;
		}

		public function set Immunizations(value:XMLListCollection):void
		{
			_Immunizations = value;
		}
		
		private var _ChronicMedication:XMLListCollection

		public function get ChronicMedication():XMLListCollection
		{
			return _ChronicMedication;
		}

		public function set ChronicMedication(value:XMLListCollection):void
		{
			_ChronicMedication = value;
		}

		private var _Vitals:XMLListCollection

		public function get Vitals():XMLListCollection
		{
			return _Vitals;
		}

		public function set Vitals(value:XMLListCollection):void
		{
			_Vitals = value;
		}

		private var _CCHPI:XMLListCollection

		public function get CCHPI():XMLListCollection
		{
			return _CCHPI;
		}

		public function set CCHPI(value:XMLListCollection):void
		{
			_CCHPI = value;
		}

		private var _ROS:XMLListCollection

		public function get ROS():XMLListCollection
		{
			return _ROS;
		}

		public function set ROS(value:XMLListCollection):void
		{
			_ROS = value;
		}

		private var _Physical:XMLListCollection

		public function get Physical():XMLListCollection
		{
			return _Physical;
		}

		public function set Physical(value:XMLListCollection):void
		{
			_Physical = value;
		}

		private var _Labs:XMLListCollection

		public function get Labs():XMLListCollection
		{
			return _Labs;
		}

		public function set Labs(value:XMLListCollection):void
		{
			_Labs = value;
		}

		private var _Diagnosis:XMLListCollection

		public function get Diagnosis():XMLListCollection
		{
			return _Diagnosis;
		}

		public function set Diagnosis(value:XMLListCollection):void
		{
			_Diagnosis = value;
		}

		private var _Prescriptions:XMLListCollection

		public function get Prescriptions():XMLListCollection
		{
			return _Prescriptions;
		}

		public function set Prescriptions(value:XMLListCollection):void
		{
			_Prescriptions = value;
		}

		private var _Procedures:XMLListCollection

		public function get Procedures():XMLListCollection
		{
			return _Procedures;
		}

		public function set Procedures(value:XMLListCollection):void
		{
			_Procedures = value;
		}

		private var _Recomendation:XMLListCollection

		public function get Recomendation():XMLListCollection
		{
			return _Recomendation;
		}

		public function set Recomendation(value:XMLListCollection):void
		{
			_Recomendation = value;
		}

		private var _Followup:XMLListCollection

		public function get Followup():XMLListCollection
		{
			return _Followup;
		}

		public function set Followup(value:XMLListCollection):void
		{
			_Followup = value;
		}
		

		
	}
}