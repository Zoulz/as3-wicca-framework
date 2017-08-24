package se.pixelshift.common.net.rpc
{
	/**
	 * Value object holding information about a standard RPC response.
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
	public class BaseRPCResponse implements IRPCResponse
	{
		private var _id:int;
		private var _result:Object;
		private var _error:Object;
		
		/**
		 * Parses the id, result and error data from the
		 * supplied initializer object.
		 * @param data Holds raw data that will be parsed.
		 */
		public function BaseRPCResponse(data:Object)
		{
			_id = data.id;
			_result = data.result;
			_error = data.error;
		}

		/**
		 * @inheritDoc
		 */
		public function get error():Object
		{
			return _error;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get errorCode():int
		{
			return _error.code;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get errorMessage():String
		{
			return _error.message;
		}

		/**
		 * @inheritDoc
		 */
		public function get errorData():Object
		{
			return _error.data;
		}

		/**
		 * @inheritDoc
		 */
		public function get result():Object
		{
			return _result;
		}

		/**
		 * @inheritDoc
		 */
		public function get id():int
		{
			return _id;
		}
	}
}
