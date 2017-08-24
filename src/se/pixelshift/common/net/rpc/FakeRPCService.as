/**
 * Created with IntelliJ IDEA.
 * User: Zoulz
 * Date: 2013-06-29
 * Time: 20:09
 * To change this template use File | Settings | File Templates.
 */
package se.pixelshift.common.net.rpc
{
	import flash.utils.Dictionary;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class FakeRPCService implements IRPCService
	{
		private var _calls:Dictionary;
		protected var _requests:Vector.<RequestItem>;
		protected var _responses:Vector.<IRPCResponse>;
		private var _complete:Signal;
		private var _currentId:int = 0;

		public function FakeRPCService(calls:Dictionary)
		{
			_calls = calls;
			_complete = new Signal();

			cleanUp();
		}

		protected function cleanUp():void
		{
			_currentId = 0;
			_responses = new Vector.<IRPCResponse>();
			_requests = new Vector.<RequestItem>();
		}

		protected function getNextId():String
		{
			return (++_currentId).toString();
		}

		public function addMethodCall(method:String, params:Array = null, callback:Function = null):void
		{
			var req:IRPCRequest = createRequest(getNextId(), method, params);
			_requests.push(new RequestItem(req, callback));
		}

		protected function createRequest(id:String, method:String, params:Array = null):IRPCRequest
		{
			return new BaseRPCRequest(id, method,params);
		}

		public function addNotification(method:String, params:Array = null):void
		{
			var req:IRPCRequest = createRequest(null, method, params);
			_requests.push(new RequestItem(req));
		}

		public function flush():void
		{
			if (_requests.length == 0)
			{
				//	If no requests then return.
				return;
			}

			for each (var reqObj:RequestItem in _requests)
			{
				reqObj.callback(_calls[reqObj.request.method]);
			}

			_complete.dispatch(true);
		}

		public function abort():void
		{
		}

		public function get complete():ISignal
		{
			return _complete;
		}
	}
}
