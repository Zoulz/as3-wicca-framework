/**
 * Created by black on 2016-01-13.
 */
package se.pixelshift.wicca.packages.rpchelper.model
{
	import mvcexpress.mvc.Proxy;

	import se.pixelshift.common.net.rpc.json.JsonRPCService;
	import se.pixelshift.wicca.packages.rpchelper.consts.RpcHelperMsg;

	public class RpcHelperService extends Proxy
	{
		private var _service:JsonRPCService;

		override protected function onRegister():void
		{
		}

		override protected function onRemove():void
		{
			if (_service != null)
			{
				_service.complete.remove(onCallComplete);
				_service.abort();
			}
		}

		public function initialize(url:String):void
		{
			onRemove();

			_service = new JsonRPCService(url);
			_service.complete.add(onCallComplete);
		}

		private function onCallComplete(success:Boolean):void
		{
			if (!success)
			{
				trace("failed to do RPC request");
			}
		}

		public function addMethodCall(method:String, params:Array):void
		{
			_service.addMethodCall(method, params, onMethodCallCallback);
		}

		public function addNotification(method:String, params:Array):void
		{
			_service.addNotification(method, params);
		}

		public function flush():void
		{
			_service.flush();
		}

		private function onMethodCallCallback(resp:Object):void
		{
			sendMessage(RpcHelperMsg.RPC_RESPONSE, resp);
		}
	}
}
