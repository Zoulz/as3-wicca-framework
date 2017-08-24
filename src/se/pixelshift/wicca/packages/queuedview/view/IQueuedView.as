/**
 * Copyright Pixelshift Interactive (c) 2015 All Rights Reserved.
 * 2015-07-14 23:45
 * @author ZoulzBig
 */
package se.pixelshift.wicca.packages.queuedview.view
{
	import org.osflash.signals.ISignal;

	import se.pixelshift.wicca.packages.queuedview.model.QueuedViewItem;

	public interface IQueuedView
	{
		function get queuedViewItemHandled():ISignal;

		function handleQueuedItem(item:QueuedViewItem):void;
	}
}
