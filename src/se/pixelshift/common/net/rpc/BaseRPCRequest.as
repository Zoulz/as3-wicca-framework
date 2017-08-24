package se.pixelshift.common.net.rpc
{
	/**
	 * Base class implementation of a RPC request.
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
	public class BaseRPCRequest implements IRPCRequest
	{
		private var _id:String;
		private var _method:String;
		private var _params:Object;
		
		/**
		 * Sets the member values based on parameters.
		 * @param id Id of the request.
		 * @param method Method name.
		 * @param params Parameters for the method call.
		 */
		public function BaseRPCRequest(id:String, method:String, params:Array)
		{
			_id = id;
			_method = method;
			_params = params;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get params():Object
		{
			return _params;
		}

		/**
		 * @inheritDoc
		 */
		public function get method():String
		{
			return _method;
		}

		/**
		 * @inheritDoc
		 */
		public function get id():String
		{
			return _id;
		}

		/**
		 * @inheritDoc
		 */
		public function asObject():Object
		{
            if (_params == null)
            {
                _params = [ ];
            }

			if (_id == null)
			{
				return { method: _method, params: _params };
			}
			else
			{
				return { method:_method, params:_params, id:_id };
			}
		}
	}
}
