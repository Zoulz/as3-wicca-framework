/**
 * Created by black on 2016-01-13.
 */
package se.pixelshift.wicca.packages.rpchelper.controller
{
	import mvcexpress.mvc.Command;

	import se.pixelshift.wicca.packages.rpchelper.model.RpcHelperService;
	import se.pixelshift.wicca.packages.rpchelper.params.RpcCallParams;

	public class RpcCallMethodCmd extends Command
	{
		[Inject] public var rpcHelperService:RpcHelperService;

		public function execute(params:RpcCallParams):void
		{
			if (params.isNotification)
			{
				rpcHelperService.addNotification(params.method, params.params);
			}
			else
			{
				rpcHelperService.addMethodCall(params.method, params.params);
			}
		}
	}
}
