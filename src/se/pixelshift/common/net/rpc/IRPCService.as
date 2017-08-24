package se.pixelshift.common.net.rpc
{
	import org.osflash.signals.ISignal;

	/**
	 * Describes a RFC service. Supports the basics of caching method/notification calls and then flushing it to the desired RPC web service
	 * that hopefully will reply with the result.
	 * 
	 * <pre>
	 * -----------------------------------------------------------------------------------------------------------------------------------------
	 * 
	 * Copyright (c) Tomas Augustinovic 2012-2013
	 *
	 * Licence Agreement (The MIT License)
	 *
	 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files
	 * (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge,
	 * publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do
	 * so, subject to the following conditions:
	 *
	 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
	 *
	 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
	 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
	 * FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
	 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
	 * 
	 * -----------------------------------------------------------------------------------------------------------------------------------------
	 * </pre>
	 * 
	 * @author tomas.augustinovic
	 */
	public interface IRPCService
	{
		/**
		 * Cache a RPC method call.
		 * @param method Name of the method.
		 * @param params Parameters to the method call.
		 * @param callback A function that will be called when the result of the method has come back.
		 */
		function addMethodCall(method:String, params:Array = null, callback:Function = null):void;
		/**
		 * Cache a RPC notification method call. Notifications do not get any reply back. They simply
		 * serve to notify the web service of something.
		 * @param method Notification method name.
		 * @param params Parameters for the method call.
		 */
		function addNotification(method:String, params:Array = null):void;
		/**
		 * Flushes the cache of method calls which means a remote call to the web service will be
		 * made at this point. When the web service responds the callback function will be invoked
		 * for each method call.
		 */
		function flush():void;
		/**
		 * Aborts the flush operation.
		 */
		function abort():void;
		/**
		 * Signal that dispatches when the flush is allComplete.
		 */
		function get complete():ISignal;
	}
}
