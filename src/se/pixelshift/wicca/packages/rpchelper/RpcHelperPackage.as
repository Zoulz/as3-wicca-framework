/**
 * Created by black on 2016-01-13.
 */
package se.pixelshift.wicca.packages.rpchelper
{
	import se.pixelshift.wicca.packages.BaseWiccaPackage;
	import se.pixelshift.wicca.packages.IWiccaPackage;
	import se.pixelshift.wicca.packages.rpchelper.model.RpcHelperService;

	public class RpcHelperPackage extends BaseWiccaPackage implements IWiccaPackage
	{
		override public function get name():String
		{
			return "rpc-helper";
		}

		override public function get description():String
		{
			return "";
		}

		override protected function mapView():void
		{
			//TODO Maybe add support to show a progress indicator while it's waiting for a response. Like a spinning thingy.
		}

		override protected function mapController():void
		{
		}

		override protected function mapModel():void
		{
			_proxyMap.map(new RpcHelperService());
		}

		override protected function unmapView():void
		{
		}

		override protected function unmapController():void
		{
		}

		override protected function unmapModel():void
		{
			_proxyMap.unmap(RpcHelperService);
		}
	}
}
