/**
 * Pixelshift Interactive
 * 2017-01-23
 * ---------------------------------------------------------------------
 * @author tomas.augustinovic
 */
package se.pixelshift.wicca.packages.wicloader.controller
{
	import mvcexpress.mvc.Command;

	import se.pixelshift.wicca.packages.wicloader.consts.WicLoaderMsg;

	import se.pixelshift.wicca.packages.wicloader.model.WicLoaderModel;

	public class LoadCmd extends Command
	{
		[Inject] public var loaderModel:WicLoaderModel;

		public function execute(params:Object):void
		{
			loaderModel.fileNames = params.fileNames;
			loaderModel.assemblers = params.assemblers;

			sendMessage(WicLoaderMsg.NEXT_WIC_FILE);
		}
	}
}
