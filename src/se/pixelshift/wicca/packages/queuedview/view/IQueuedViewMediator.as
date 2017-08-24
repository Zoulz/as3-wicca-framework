/**
 * Copyright Pixelshift Interactive (c) 2015 All Rights Reserved.
 * 2015-07-14 15:37
 * @author ZoulzBig
 */
package se.pixelshift.wicca.packages.queuedview.view
{
	import org.osflash.signals.ISignal;

	public interface IQueuedViewMediator
	{
		function get queueItemCompleted():ISignal;
	}
}
