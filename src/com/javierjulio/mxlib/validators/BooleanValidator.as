package com.javierjulio.mxlib.validators
{
	import mx.validators.ValidationResult;
	import mx.validators.Validator;
	
	public class BooleanValidator extends Validator
	{
		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Convenience method for calling a validator. Each of the standard Flex 
		 * validators has a similar convenience method.
		 * 
		 * @param validator The BooleanValidator instance.
		 * 
		 * @param value A field to validate.
		 * 
		 * @param baseField Text representation of the subfield specified in the 
		 * <code>value</code> parameter. For example, if the <code>value</code> 
		 * parameter specifies value.mystring, the <code>baseField</code> value 
		 * is <code>"mystring"</code>.
		 * 
		 * @return An Array of ValidationResult objects, with one ValidationResult 
		 * object for each field examined by the validator.
		 * 
		 * @see mx.validators.ValidationResult
		 */
		public static function validateBoolean(validator:BooleanValidator, 
											   value:Object, 
											   baseField:String=null):Array 
		{
			var results:Array = [];
			
			var val:Boolean = (value != null) ? Boolean(value) : false;
			
			// flag is false so data is invalid/required
			if (val == false) 
			{
				results.push(new ValidationResult(true, baseField, "required", 
												validator.requiredFieldError));
				
				return results;
			}
			
			return results;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function BooleanValidator()
		{
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Override of the base class <code>doValidation()</code> method to 
		 * validate a Boolean.
		 * 
		 * <p>You do not call this method directly; Flex calls it as part of 
		 * performing a validation. If you create a custom Validator class, you 
		 * must implement this method.</p>
		 * 
		 * @param value The object to validate.
		 * 
		 * @return An array of ValidationResult objects, with one ValidationResult 
		 * object for each field examined by the validator.
		 */
		override protected function doValidation(value:Object):Array 
		{
			var results:Array = super.doValidation(value);
			
			// return if there are errors or if the required property 
			// is set to false and value length is 0
			var val:String = (value) ? String(value) : "";
			
			if (results.length > 0 || ((val.length == 0) && !required)) 
				return results;
			else 
				return BooleanValidator.validateBoolean(this, value, null);
		}
	}
}