/**
 * Copyright Pixelshift Interactive (c) 2015 All Rights Reserved.
 * 2015-07-14 16:25
 * @author ZoulzBig
 */
package se.pixelshift.wicca.packages.queuedview.controller
{
	import mvcexpress.mvc.Command;

	import se.pixelshift.wicca.packages.queuedview.consts.QueuedViewMsg;
	import se.pixelshift.wicca.packages.queuedview.model.QueuedViewItem;
	import se.pixelshift.wicca.packages.queuedview.model.QueuedViewModel;

	public class NextQueuedViewItemCmd extends Command
	{
		[Inject] public var queuedViewModel:QueuedViewModel;

		public function execute(params:Object):void
		{
			if (queuedViewModel.queueItems.length > 0)
			{
				queuedViewModel.resetMediatorListener();

				var item:QueuedViewItem = queuedViewModel.queueItems.shift();
				sendMessage(QueuedViewMsg.UPDATE, item);
			}
			else
			{
				queuedViewModel.queueStarted = false;
				sendMessage(QueuedViewMsg.ALL_ITEMS_COMPLETE);
				trace("All queue items complete");
			}
		}
	}
}
