/**
 * Copyright Pixelshift Interactive (c) 2015 All Rights Reserved.
 * 2015-07-14 15:46
 * @author ZoulzBig
 */
package se.pixelshift.wicca.packages.queuedview.model
{
	import mvcexpress.mvc.Proxy;

	import se.pixelshift.wicca.packages.queuedview.consts.QueuedViewMsg;
	import se.pixelshift.wicca.packages.queuedview.view.IQueuedViewMediator;

	public class QueuedViewModel extends Proxy implements IQueuedViewModel
	{
		private var _mediators:Vector.<IQueuedViewMediator>;
		private var _queueItems:Vector.<QueuedViewItem>;
		private var _numViewsCompleted:int = 0;
		private var _queueStarted:Boolean = false;

		public function QueuedViewModel()
		{
			_mediators = new <IQueuedViewMediator>[];
			_queueItems = new <QueuedViewItem>[];
		}

		public function addMediator(mediator:IQueuedViewMediator):void
		{
			mediator.queueItemCompleted.add(onQueueItemCompleted);
			_mediators.push(mediator);
		}

		public function removeMediator(mediator:IQueuedViewMediator):void
		{
			mediator.queueItemCompleted.remove(onQueueItemCompleted);
			_mediators.splice(_mediators.indexOf(mediator), 1);
		}

		public function resetMediatorListener():void
		{
			_numViewsCompleted = _mediators.length;
		}

		private function onQueueItemCompleted():void
		{
			_numViewsCompleted--;

			if (_numViewsCompleted == 0)
			{
				sendMessage(QueuedViewMsg.NEXT_ITEM);
			}
		}

		public function get queueItems():Vector.<QueuedViewItem>
		{
			return _queueItems;
		}

		public function get queueStarted():Boolean
		{
			return _queueStarted;
		}

		public function set queueStarted(value:Boolean):void
		{
			_queueStarted = value;
		}
	}
}
