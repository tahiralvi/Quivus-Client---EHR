package com.gazuntite.provider.live.services.billing.view.common.validators
{
	
	import com.gazuntite.common.util.ValidationUtils;
	import com.gazuntite.controls.extended.components.LabelComboBox;
	
	import mx.validators.ValidationResult;
	import mx.validators.Validator;
	
	public class ComboValidator extends Validator
	{
		private var _error:String;
		private var results:Array;
		
		public function ComboValidator()
		{
			super();
		}
		
		public function set error(value:String):void
		{
			_error = value;
		}
		
		override protected function doValidation(value:Object):Array
		{
			results = [];
			
			if (!ValidationUtils.isValidValueSelected(LabelComboBox(source)))
			{
				var err:ValidationResult = new ValidationResult(true, "", "", _error);
				results.push(err);
			}
			
			return results;
		}
	}
}