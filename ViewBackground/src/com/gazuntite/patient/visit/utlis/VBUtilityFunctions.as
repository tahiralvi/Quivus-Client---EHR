package com.gazuntite.patient.visit.utlis
{
	import com.gazuntite.common.util.QSConstants;
	import com.gazuntite.controls.custom.calendar.views.NullCalendarDescriptor;
	import com.gazuntite.patient.visit.dto.PageDTO;
	import com.gazuntite.patient.visit.model.VBModelLocator;
	import com.gazuntite.utils.UtilityFunctions;

	public class VBUtilityFunctions
	{
		public function VBUtilityFunctions()
		{
		}
		
		public static function setNoPagingAndFiltering(page:PageDTO):void
		{
			page.fromDate = QSConstants.NULL_DATE;
			page.toDate = QSConstants.NULL_DATE;
			page.pageSize = 0;
			page.lastVisitNumber = 0;
		}
		
		public static function setDefaultValues(page:PageDTO):void
		{
			var model:VBModelLocator = VBModelLocator.getInstance();
			page.fromDate = model.defaultFilterAndPaging.fromDate;
			page.toDate = model.defaultFilterAndPaging.toDate;
			page.pageSize = model.defaultFilterAndPaging.pageSize;
			page.lastVisitNumber = model.defaultFilterAndPaging.lastVisitNumber;
		}
		
		public static function getNewPageDTOWithDefaultValues():PageDTO
		{
			var page:PageDTO = new PageDTO();
			page.pageNumber = 1;
			
			setDefaultValues(page);
			
			return page;
		}
		
		public static function isNullOrEmptyPage(Page:PageDTO):Boolean
		{
			var retValue:Boolean;
			if( UtilityFunctions.IsNullOrEmpty( Page ) )
			{
				retValue = true;
			}
			else
			{
				if( UtilityFunctions.IsNullOrEmpty( Page.pageSize ) )
				{
					retValue = true;
				}
				else 
				{
					if (!isValidVisitRangeProvided(Page) && !isValidDateRangeProvided(Page))
					{
						retValue = true;
					}
				}
				
			}
			
			return retValue;
		}
		
		public static function isValidVisitRangeProvided(Page:PageDTO):Boolean
		{
			if( UtilityFunctions.IsNullOrEmpty( Page.lastVisitNumber ) )
			{
				return false;
			}
			
			return true;
		}
		
		public static function isValidDateRangeProvided(Page:PageDTO):Boolean
		{
			if( UtilityFunctions.IsNullOrEmpty( Page.fromDate ) || UtilityFunctions.IsNullOrEmpty( Page.toDate ) )
			{
				return false;
			}
			
			return true;
		}
		
		public static function getMaritalStatusId(value:String):int
		{
			switch (value)
			{
				case "Married":
					
					return QSConstants.MARRIED_MARITAL_STATUS_ID;
					
				case "Single":
					
					return QSConstants.SINGLE_MARITAL_STATUS_ID;
					
				case "Divorced":
					
					return QSConstants.DIVORCED_MARITAL_STATUS_ID;
					
				case "Widow":
					
					return QSConstants.WIDOWED_MARITAL_STATUS_ID;
			}
			
			return -1;
		}
		
		public static function getMeritalStatus(value:int):String
		{
			var status:String;
			
			switch( value )
			{
				case QSConstants.MARRIED_MARITAL_STATUS_ID:
					
					status = "Married";
					
					break;
				
				case QSConstants.SINGLE_MARITAL_STATUS_ID:
					
					status = "Single";
					
					break;
				
				case QSConstants.DIVORCED_MARITAL_STATUS_ID:
					
					status = "Divorced";
					
					break;
				
				case QSConstants.WIDOWED_MARITAL_STATUS_ID:
					
					status = "Widow";
					
					break;
			}
			
			return status;
		}
	}
}