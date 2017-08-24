/**
 * Copyright Pixelshift Interactive (c) 2015 All Rights Reserved.
 * 2015-07-14 15:36
 * @author ZoulzBig
 */
package se.pixelshift.wicca.packages.queuedview
{
	import se.pixelshift.wicca.packages.BaseWiccaPackage;
	import se.pixelshift.wicca.packages.IWiccaPackage;
	import se.pixelshift.wicca.packages.queuedview.consts.QueuedViewMsg;
	import se.pixelshift.wicca.packages.queuedview.controller.ExecuteQueuedViewItemsCmd;
	import se.pixelshift.wicca.packages.queuedview.controller.NextQueuedViewItemCmd;
	import se.pixelshift.wicca.packages.queuedview.model.IQueuedViewModel;
	import se.pixelshift.wicca.packages.queuedview.model.QueuedViewModel;

	public class QueuedViewPackage extends BaseWiccaPackage implements IWiccaPackage
	{
		override public function get name():String
		{
			return "Queued View";
		}

		override public function get description():String
		{
			return "Allows you to perform view related tasks in a queued up fashion.";
		}

		override protected function mapModel():void
		{
			_proxyMap.map(new QueuedViewModel(), null, null, IQueuedViewModel);
		}

		override protected function unmapModel():void
		{
			_proxyMap.unmap(QueuedViewModel);
		}

		override protected function mapController():void
		{
			_commandMap.map(QueuedViewMsg.NEXT_ITEM, NextQueuedViewItemCmd);
			_commandMap.map(QueuedViewMsg.EXECUTE_ITEMS, ExecuteQueuedViewItemsCmd);
		}

		override protected function unmapController():void
		{
			_commandMap.unmap(QueuedViewMsg.NEXT_ITEM);
			_commandMap.unmap(QueuedViewMsg.EXECUTE_ITEMS);
		}
	}
}
