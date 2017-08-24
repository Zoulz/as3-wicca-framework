/**
 * Copyright Pixelshift Interactive (c) 2015 All Rights Reserved.
 * 2015-07-14 15:46
 * @author ZoulzBig
 */
package se.pixelshift.wicca.packages.queuedview.model
{
	import se.pixelshift.wicca.packages.queuedview.view.IQueuedViewMediator;

	public interface IQueuedViewModel
	{
		function addMediator(mediator:IQueuedViewMediator):void;
		function removeMediator(mediator:IQueuedViewMediator):void;
	}
}
