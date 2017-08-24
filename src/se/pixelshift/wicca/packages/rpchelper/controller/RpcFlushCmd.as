/**
 * Created by black on 2016-01-13.
 */
package se.pixelshift.wicca.packages.rpchelper.controller
{
	import mvcexpress.mvc.Command;

	import se.pixelshift.wicca.packages.rpchelper.model.RpcHelperService;

	public class RpcFlushCmd extends Command
	{
		[Inject] public var rpcHelperService:RpcHelperService;

		public function execute(params:Object):void
		{
			rpcHelperService.flush();
		}
	}
}
