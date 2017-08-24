package se.pixelshift.common.net.rpc
{
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;

    import org.osflash.signals.ISignal;
    import org.osflash.signals.Signal;

    import se.pixelshift.common.errors.AbstractMethodError;

    /**
	 * Abstract class implementing barebones of a RPC service. Handles web request/response.
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
	 * @see AbstractMethodError
	 * 
	 * @author tomas.augustinovic
	 */
	public class BaseRPCService implements IRPCService
	{
		protected var _url:String;
		protected var _requests:Vector.<RequestItem>;
		protected  var _responses:Vector.<IRPCResponse>;
		
		private var _currentId:int = 0;
		private var _loader:URLLoader;
		private var _complete:Signal;
		
		/**
		 * Setup default member values.
		 * @param url URL for the remote web service to communicate with.
		 */
		public function BaseRPCService(url:String)
		{
			_url = url;
			_complete = new Signal();
			_responses = new Vector.<IRPCResponse>();
			_requests = new Vector.<RequestItem>();
			
			cleanUp();

			_loader = new URLLoader();
			_loader.dataFormat = URLLoaderDataFormat.TEXT;
			_loader.addEventListener(Event.COMPLETE, onMethodCallComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onMethodCallFailed);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onMethodCallSecurityError);
		}
		
		/**
		 * Clean up the service by resetting member variables.
		 */
		protected function cleanUp():void
		{
			_currentId = 0;
			_responses.length = 0;
			_requests.length = 0;
		}
		
		/**
		 * Return the next request id. Simply increments a counter for each call.
		 * @return String containing next id.
		 */
		protected function getNextId():String
		{
			return (++_currentId).toString();
		}
		
		/**
		 * Get request item by it's id.
		 * @param id id of item to find and return.
		 */
		protected function findRequestById(id:int):RequestItem
		{
			for each (var reqObj:RequestItem in _requests)
			{
				if (reqObj.request.id == id.toString())
				{
					return reqObj;
				}
			}
			
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function addMethodCall(method:String, params:Array = null, callback:Function = null):void
		{
			var req:IRPCRequest = createRequest(getNextId(), method, params);
			_requests.push(new RequestItem(req, callback));
		}

		/**
		 * @inheritDoc
		 */
		public function addNotification(method:String, params:Array = null):void
		{
			var req:IRPCRequest = createRequest(null, method, params);
			_requests.push(new RequestItem(req));
		}

		/**
		 * @inheritDoc
		 */
		public function flush():void
		{
			if (_requests.length == 0)
			{
				//	If no requests then return.
				return;
			}
			
			//	Create a url request.
			var req:URLRequest = new URLRequest(_url);
			var batchReqs:Array = [ ];
			
			//	Populate array of RPC request(s).
			for each (var reqObj:RequestItem in _requests)
			{
				batchReqs.push(IRPCRequest(reqObj.request).asObject());
			}

			//	Encode the request(s).
			req.data = encodeRequests(batchReqs);
			
			//	Populate URL request.
			req.method = URLRequestMethod.POST;
			req.contentType = getRequestContentType();

			//	Setup URL loader and finally load.
			_loader.load(req);
		}

		private function onMethodCallSecurityError(event:SecurityErrorEvent):void
		{
			cleanUp();

			_complete.dispatch(false);
		}
		
		/**
		 * Event handler for if a request fails. Cleans up the service and
		 * dispatches completion signal with fail-flag set.
		 */
		private function onMethodCallFailed(event:IOErrorEvent):void
		{
			cleanUp();
			
			_complete.dispatch(false);
		}
		
		/**
		 * Event handler for when a request is successful. Iterates
		 * through the resulting response.
		 */
		private function onMethodCallComplete(event:Event):void
		{
			if (_loader.data != undefined)
			{
				parseResponse(_loader.data as String);
			}
			else
			{
				trace("data was undefined!");
			}
			
			//	Loop through all the responses.
			for each (var resp:IRPCResponse in _responses)
			{
				var reqObj:Object = findRequestById(resp.id);
				var retObj:Object = resp.error != null ? { error: resp.error } : resp.result;

                reqObj.callback(retObj);
			}
			
			cleanUp();
			
			_complete.dispatch(true);
		}
		
		/**
		 * Abstract method that must be overriden in sub class. Creates a RPC response object using the
		 * initializer as data.
		 * @param initializer Data that the response object will parse to populate itself.
		 */
		protected function createResponse(initializer:Object):IRPCResponse
		{
			throw new AbstractMethodError();
		}
		
		/**
		 * Abstract method that must be overriden in sub class. Creates a RPC request object using
		 * the supplied standard parameters.
		 * @param id Id of the request.
		 * @param method Method name.
		 * @param params Parameters for the method.
		 */
		protected function createRequest(id:String, method:String, params:Array = null):IRPCRequest
		{
			throw new AbstractMethodError();
		}
		
		/**
		 * Abstract method that must be overriden in sub class. Returns a string containing the
		 * desired MIME-type the request will be posted in. <b>Example:</b> application/json
		 */
		protected function getRequestContentType():String
		{
			throw new AbstractMethodError();
		}
		
		/**
		 * Abstract method that must be overriden in sub class. Encodes the requests using the
		 * desired encoding technique (json, xml etc).
		 * @param reqs Holds the requests.
		 */
		protected function encodeRequests(reqs:Array):String
		{
			throw new AbstractMethodError();
		}
		
		/**
		 * Abstract method that must be overriden in sub class. Parse the response object using
		 * the desired decoding technique (json, xml etc).
		 * @param resp The response in string format.
		 */
		protected function parseResponse(resp:String):void
		{
			throw new AbstractMethodError();
		}

		/**
		 * @inheritDoc
		 */
		public function abort():void
		{
			if (_loader != null)
			{
				_loader.close();
			}
		}

		/**
		 * @inheritDoc
		 */
		public function get complete():ISignal
		{
			return _complete;
		}
	}
}
