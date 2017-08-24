/**
 * Created by black on 2016-01-13.
 */
package se.pixelshift.wicca.packages.rpchelper.controller
{
	import mvcexpress.mvc.Command;

	import se.pixelshift.wicca.packages.rpchelper.model.RpcHelperService;

	import se.pixelshift.wicca.packages.rpchelper.params.RpcInitParams;

	public class RpcInitCmd extends Command
	{
		[Inject] public var rpcHelperService:RpcHelperService;

		public function execute(params:RpcInitParams):void
		{
			rpcHelperService.initialize(params.url);
		}
	}
}
