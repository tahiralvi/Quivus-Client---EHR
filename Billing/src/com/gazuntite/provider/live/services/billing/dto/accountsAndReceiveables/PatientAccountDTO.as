package com.gazuntite.provider.live.services.billing.dto.accountsAndReceiveables
{
	import com.gazuntite.common.util.xml.XmlConstants;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	[Bindable]
	public class PatientAccountDTO
	{
		
		private var _LastPaymentDate:String;
		private var _LastPaymentAmount:String;
		private var _LastVisitDate:String;
		private var _GlobalCoverageUntil:String;
		private var _Charges:String;
		private var _Payment:String;
		private var _Adjustment:String;
		private var _Balance:String;
		private var _PatientCarrirs:ArrayCollection;
		private var _PatientClaims:ArrayCollection;
		private var _PolicyCopay:String;
		private var _AnnualDeductible:String;
		private var _OtherAdjustment:String;
		private var _YTD:String;
			
		public function FromXML(x:XML):void
		{
			LastPaymentDate  		= x.@[XmlConstants.LASTPAYMENTDATE];
			LastPaymentAmount  		= x.@[XmlConstants.LASTPAYMENTAMOUNT];
			LastVisitDate  			= x.@[XmlConstants.LASTVISITDATE];
			GlobalCoverageUntil 	= x.@[XmlConstants.GLOBALCOVERAGEUNTIL];
			Charges 				= x.@[XmlConstants.CHARGES];
			Payment 				= x.@[XmlConstants.PAYMENT];
			Adjustment  			= x.@[XmlConstants.ADJUSTMENT];
			Balance 				= x.@[XmlConstants.BALANCE];
			PolicyCopay 			= x.@[XmlConstants.POLICYCOPAY];
			AnnualDeductible 		= x.@[XmlConstants.ANNUALDEDUCTIBLE];
			OtherAdjustment 		= x.@[XmlConstants.OTHERADJUSTMENT];
			YTD  					= x.@[XmlConstants.YTD];
				
			PatientCarrirs = new ArrayCollection();			
			var xCarriers:XMLList = x.PatientCarriers.PatientCarrier;
			for(var ic:int = 0; ic < xCarriers.length(); ic++)
			{
				var cr:AccountCarrierDTO = new AccountCarrierDTO();
				cr.FromXML( xCarriers[ic] );
				PatientCarrirs.addItem(cr);
			}
			
			PatientClaims = new ArrayCollection();			
			var xClaims:XMLList = x.PatientClaims.PatientClaim;
			for(var icl:int = 0; icl < xClaims.length(); icl++)
			{
				var cl:AccountClaimDTO = new AccountClaimDTO();
				cl.FromXML( xClaims[icl] );
				PatientClaims.addItem(cl);
			}
		}		
		
		
		public function get YTD():String
		{
			return _YTD;
		}
		
		public function set YTD(value:String):void
		{
			_YTD = value;
		}
		
		public function get OtherAdjustment():String
		{
			return _OtherAdjustment;
		}
		
		public function set OtherAdjustment(value:String):void
		{
			_OtherAdjustment = value;
		}
		
		public function get AnnualDeductible():String
		{
			return _AnnualDeductible;
		}
		
		public function set AnnualDeductible(value:String):void
		{
			_AnnualDeductible = value;
		}
		
		public function get PolicyCopay():String
		{
			return _PolicyCopay;
		}
		
		public function set PolicyCopay(value:String):void
		{
			_PolicyCopay = value;
		}
		
		public function get PatientClaims():ArrayCollection
		{
			return _PatientClaims;
		}

		public function set PatientClaims(value:ArrayCollection):void
		{
			_PatientClaims = value;
		}

		public function get PatientCarrirs():ArrayCollection
		{
			return _PatientCarrirs;
		}

		public function set PatientCarrirs(value:ArrayCollection):void
		{
			_PatientCarrirs = value;
		}

		public function get Balance():String
		{
			return _Balance;
		}

		public function set Balance(value:String):void
		{
			_Balance = value;
		}

		public function get Adjustment():String
		{
			return _Adjustment;
		}

		public function set Adjustment(value:String):void
		{
			_Adjustment = value;
		}

		public function get Payment():String
		{
			return _Payment;
		}

		public function set Payment(value:String):void
		{
			_Payment = value;
		}

		public function get Charges():String
		{
			return _Charges;
		}

		public function set Charges(value:String):void
		{
			_Charges = value;
		}

		public function get GlobalCoverageUntil():String
		{
			return _GlobalCoverageUntil;
		}

		public function set GlobalCoverageUntil(value:String):void
		{
			_GlobalCoverageUntil = value;
		}

		public function get LastVisitDate():String
		{
			return _LastVisitDate;
		}

		public function set LastVisitDate(value:String):void
		{
			if(value.indexOf("0001") > -1 || value.indexOf("1900") > -1 || value.indexOf("1901") > -1)
				_LastVisitDate = "";
			else
				_LastVisitDate = UtilityFunctions.FormatDate(value.substring(0,10) ,"MM/DD/YYYY");
		}

		public function get LastPaymentAmount():String
		{
			return _LastPaymentAmount;
		}

		public function set LastPaymentAmount(value:String):void
		{
			_LastPaymentAmount = value;
		}

		public function get LastPaymentDate():String
		{
			return _LastPaymentDate;
		}

		public function set LastPaymentDate(value:String):void
		{
			if(value.indexOf("0001") > -1 || value.indexOf("1901") > -1  || value.indexOf("1900") > -1)
				_LastPaymentDate = "";
			else
				_LastPaymentDate = UtilityFunctions.FormatDate(value.substring(0,10),"MM/DD/YYYY");
		}

	}
}