/**
 * Pixelshift Interactive
 * 2017-01-22
 * ---------------------------------------------------------------------
 * @author tomas.augustinovic
 */
package se.pixelshift.wicca.packages.wicloader.controller
{
	import mvcexpress.mvc.Command;

	import se.pixelshift.wicca.assets.AssembleAssetItem;

	import se.pixelshift.wicca.packages.wicloader.consts.WicLoaderMsg;

	import se.pixelshift.wicca.packages.wicloader.model.WicLoaderModel;

	public class NextWicFileCmd extends Command
	{
		[Inject] public var loaderModel:WicLoaderModel;

		public function execute(params:Object):void
		{
			if (loaderModel.fileNames.length > 0)
			{
				var fileName:String = loaderModel.fileNames.shift();
				sendMessage(WicLoaderMsg.LOAD_WIC_FILE, fileName);
			}
			else
			{
				for each (var a:AssembleAssetItem in loaderModel.assemblers)
				{
					a.assembler.assemble(a.groupId, a.assetId);
				}
				loaderModel.assemblers.length = 0;

				trace("all wic files loaded");
				sendMessage(WicLoaderMsg.COMPLETE);
			}
		}
	}
}
