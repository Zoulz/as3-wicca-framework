/**
 * Copyright Pixelshift Interactive (c) 2015 All Rights Reserved.
 * 2015-07-14 16:23
 * @author ZoulzBig
 */
package se.pixelshift.wicca.packages.queuedview.controller
{
	import mvcexpress.mvc.Command;

	import se.pixelshift.wicca.packages.queuedview.model.QueuedViewModel;

	public class ExecuteQueuedViewItemsCmd extends Command
	{
		[Inject] public var queuedViewModel:QueuedViewModel;

		public function execute(params:Object):void
		{
			if (queuedViewModel.queueStarted)
			{
				trace("Last queued view run was never finished.");
			}

			queuedViewModel.queueStarted = true;
			commandMap.execute(NextQueuedViewItemCmd);
		}
	}
}
