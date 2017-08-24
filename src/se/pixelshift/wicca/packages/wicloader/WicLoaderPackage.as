/**
 * Pixelshift Interactive
 * 2017-01-22
 * ---------------------------------------------------------------------
 * @author tomas.augustinovic
 */
package se.pixelshift.wicca.packages.wicloader
{
	import se.pixelshift.wicca.packages.BaseWiccaPackage;
	import se.pixelshift.wicca.packages.IWiccaPackage;
	import se.pixelshift.wicca.packages.wicloader.consts.WicLoaderMsg;
	import se.pixelshift.wicca.packages.wicloader.controller.LoadCmd;
	import se.pixelshift.wicca.packages.wicloader.controller.LoadWicFileCmd;
	import se.pixelshift.wicca.packages.wicloader.controller.NextWicFileCmd;
	import se.pixelshift.wicca.packages.wicloader.model.WicLoaderModel;

	public class WicLoaderPackage extends BaseWiccaPackage implements IWiccaPackage
	{
		private var _CompleteCmd:Class;

		public function WicLoaderPackage(CompleteCmd:Class)
		{
			_CompleteCmd = CompleteCmd;
		}

		override public function get name():String
		{
			return "Wicca File Loader";
		}

		override protected function mapView():void
		{

		}

		override protected function unmapView():void
		{

		}

		override protected function mapController():void
		{
			_commandMap.map(WicLoaderMsg.LOAD, LoadCmd);
			_commandMap.map(WicLoaderMsg.NEXT_WIC_FILE, NextWicFileCmd);
			_commandMap.map(WicLoaderMsg.LOAD_WIC_FILE, LoadWicFileCmd);
			_commandMap.map(WicLoaderMsg.COMPLETE, _CompleteCmd);
		}

		override protected function unmapController():void
		{
			_commandMap.unmap(WicLoaderMsg.LOAD);
			_commandMap.unmap(WicLoaderMsg.NEXT_WIC_FILE);
			_commandMap.unmap(WicLoaderMsg.LOAD_WIC_FILE);
			_commandMap.unmap(WicLoaderMsg.COMPLETE);
		}

		override protected function mapModel():void
		{
			_proxyMap.map(new WicLoaderModel(), null, null);
		}

		override protected function unmapModel():void
		{
			_proxyMap.unmap(WicLoaderModel);
		}
	}
}
