package com.javierjulio.mxlib.validators
{
	import flash.events.Event;
	
	import mx.core.FlexVersion;
	import mx.core.IInvalidating;
	import mx.core.mx_internal;
	import mx.validators.ValidationResult;
	import mx.validators.Validator;
	
	use namespace mx_internal;
	
	public class ListValidator extends Validator
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
		 * @param validator The ListValidator instance.
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
		public static function validateList(validator:ListValidator, 
											value:Object, 
											baseField:String=null):Array 
		{
			var results:Array = [];
			var isValid:Boolean = false;
			
			if (value != null) 
			{
				if ((value is int && int(value) >= 0) // selectedIndex (s:List and mx:List)
					|| (value is Vector.<int> && value.length >= 1) // selectedIndices (s:List)
					|| (value is Vector.<Object> && value.length >= 1) // selectedItems (s:List)
					|| (value is Array && value.length >= 1)) // selectedIndices/selectedItems (mx:List)
				{
					isValid = true;
				}
			}
			
			// flag is false so data is invalid/required
			if (isValid == false) 
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
		public function ListValidator()
		{
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overridden properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  source
		//----------------------------------
		
		/**
		 *  @private
		 */
		override public function set source(value:Object):void
		{
			if (super.source == value) 
				return;
			
			if (value is String) 
			{
				var message:String = resourceManager.getString(
					"validators", "SAttribute", [ value ]);
				throw new Error(message);
			}
			
			// Remove the listener from the old source
			removeTriggerHandler();
			
			super.source = value;
			
			// Listen for the trigger event on the new source
			addTriggerHandler();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Override of the base class <code>doValidation()</code> method to 
		 * validate the selection in a List component.
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
				return ListValidator.validateList(this, value, null);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private function addTriggerHandler():void 
		{
			if (actualTrigger) 
				actualTrigger.addEventListener("change", triggerHandler);
		}
		
		/**
		 * @private
		 */
		private function removeTriggerHandler():void 
		{
			if (actualTrigger) 
				actualTrigger.removeEventListener("change", triggerHandler);
		}
		
		/**
		 * @private
		 */
		private function triggerHandler(event:Event):void 
		{
			validate();
			
			// Spark List component on change event sometimes doesn't have its 
			// commitProperties method called when errorString is reset to 
			// nothing to remove the error border, so force validation so the 
			// error border is removed
			if (source is IInvalidating && 
				FlexVersion.compatibilityVersion == FlexVersion.VERSION_4_0) 
			{
				IInvalidating(source).validateNow();
			}
		}
	}
}