package com.javierjulio.mxlib.logging.targets
{
	import flash.events.SecurityErrorEvent;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	
	import mx.core.mx_internal;
	import mx.logging.targets.LineFormattedTarget;
	
	use namespace mx_internal;
	
	/**
	 * Provides a logger target that outputs to a <code>LocalConnection</code> 
	 * object, connected to the Console application.
	 */
	public class ConsoleTarget extends LineFormattedTarget
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function ConsoleTarget(connectionName:String="_mdbtrace", 
									  methodName:String="trace")
		{
			super();
			
			connection = new LocalConnection();
			connection.addEventListener(StatusEvent.STATUS, connection_statusHandler);
			connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, connection_securityErrorHandler);
			connectionName = connectionName;
			methodName = methodName;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  connection
		//----------------------------------
		
		/**
		 * The local connection object.
		 * 
		 * @default null
		 */
		protected var connection:LocalConnection;
		
		//----------------------------------
		//  connectionName
		//----------------------------------
		
		/**
		 * The name of the method that we should call on the remote connection.
		 * 
		 * @default null
		 */
		protected var connectionName:String;
		
		//----------------------------------
		//  methodName
		//----------------------------------
		
		/**
		 * The name of the connection that we should send to.
		 * 
		 * @default null
		 */
		protected var methodName:String;
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 * This method outputs the specified message directly to the method 
		 * specified (passed to the constructor) for the local connection.
		 */
		override mx_internal function internalLog(message:String):void 
		{
			connection.send(connectionName, methodName, message);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 
		 */
		protected function connection_securityErrorHandler(event:SecurityErrorEvent):void 
		{
			trace("Error: security error on ConsoleTarget's local connction");
		}
		
		/**
		 * 
		 */
		protected function connection_statusHandler(event:StatusEvent):void 
		{
			if (event.level == "error") 
				trace("Warning: ConsoleTarget send failed: " + event.code);
		}
	}
}