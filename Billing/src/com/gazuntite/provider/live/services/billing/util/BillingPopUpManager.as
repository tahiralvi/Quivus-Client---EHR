package com.gazuntite.provider.live.services.billing.util
{
	import com.gazuntite.common.util.QSPopUpManagerImpl;
	
	public class BillingPopUpManager
	{
		public static const BILLING_SERVICE_POPUPS:String = "Billing";	
		public static const SUPER_BILL_POPUPS:String = "Billing.SuperBill";				
		public static const CLAIM_MANAGEMENT_POPUPS:String = "Billing.ClaimManagement";
		public static const PENDING_BILLS_POPUPS:String = "Billing.PendingBills";
		public static const ACCOUNTS_POPUPS:String = "Billing.AccountsNReceiveables";
		public static const ACCOUNTS_STATEMENT_POPUPS:String = "Billing.AccountStatement";
		
		private static var impl:QSPopUpManagerImpl = QSPopUpManagerImpl.getInstance();
		
		public function BillingPopUpManager()
		{
			throw ("BillingPopUpManager is a singleton class, You can not create its instance");
		}
		
		public static function hideAllPopUps():void
		{
			impl.hideAllPopUps();
		}
		
		public static function hideAllSectionPopUps(section:String):void
		{
			impl.hideAllSectionPopUps(section);
		}
		
		public static function addPopUp(popUp:*, section:String):void
		{
			impl.addPopUp(popUp, section);
		}
		
		public static function removePopUp(popUp:*, section:String):void
		{
			impl.removePopUp(popUp, section);
		}
		
		public static function removeAllSectionPopUps(section:String):void
		{
			impl.removeAllSectionPopUps(section);
		}
		
		public static function hideAllServicePopUps(service:String):void
		{			
			impl.hideAllServicePopUps(service);
		}
		
		public static function removeAllServicePopUps(service:String):void
		{			
			impl.removeAllServicePopUps(service);
		}
	}
}