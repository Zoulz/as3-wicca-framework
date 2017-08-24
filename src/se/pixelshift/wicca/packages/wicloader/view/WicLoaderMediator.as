/**
 * Created by Tomas Augustinovic on 2017-02-07.
 */
package se.pixelshift.wicca.packages.wicloader.view
{
	import mvcexpress.mvc.Mediator;

	import se.pixelshift.wicca.packages.wicloader.consts.WicLoaderMsg;

	public class WicLoaderMediator extends Mediator
	{
		[Inject] public var view:IWicLoaderView;

		override protected function onRemove():void
		{
			removeAllHandlers();
		}

		override protected function onRegister():void
		{
			addHandler(WicLoaderMsg.FILE_START, onFileStartLoading);
			addHandler(WicLoaderMsg.FILE_PROGRESS, onFileProgress);
			addHandler(WicLoaderMsg.FILE_ERROR, onFileError);
			addHandler(WicLoaderMsg.FILE_COMPLETE, onFileCompleteLoading);
			addHandler(WicLoaderMsg.COMPLETE, onLoadingComplete);
		}

		private function onLoadingComplete(params:Object):void
		{
			view.loadingComplete();
		}

		private function onFileCompleteLoading(params:Object):void
		{
			view.fileCompleteLoading();
		}

		private function onFileError(params:Object):void
		{
			view.fileError(params.msg);
		}

		private function onFileProgress(params:Object):void
		{
			view.updateProgress(params.bytesLoaded, params.bytesTotal);
		}

		private function onFileStartLoading(params:Object):void
		{
			view.fileStartLoading();
		}
	}
}
