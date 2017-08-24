package se.pixelshift.common.list
{
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	/**
	 * A list that executes all the items at once and is complete when all the items have completed.
	 * 
	 * @author tomas.augustinovic
	 */
	public class ConcurrentList implements IList
	{
		private var _list:Vector.<IListItem>;
		private var _itemsCompleteCount:uint;
		private var _isRunning:Boolean;
		private var _complete:Signal;
		private var _aborted:Signal;
		private var _itemComplete:Signal;
		
		/**
		 * Constructor. Reset variables.
		 */
		public function ConcurrentList(...args)
		{
			_isRunning = false;
			_complete = new Signal();
			_aborted = new Signal();
			_itemComplete = new Signal();
			
			clear();

			for each (var item:IListItem in args)
			{
				_list.push(item);
			}
		}
		
		/**
		 * Adds a item to the list.
		 * @param item Item to add.
		 */
		public function addItem(item:IListItem):void
		{
			if (item != null)
			{
				_list.push(item);
			}
		}

		/**
		 * Remove item from the list.
		 * @param item Item to remove.
		 */
		public function removeItem(item:IListItem):void
		{
			for (var i:int = 0; i < _list.length; i++)
			{
				if (_list[i] == item)
				{
					_list.splice(i, 1);
					break;
				}
			}
		}

		/**
		 * Clear the list items.
		 */
		public function clear():void
		{
			_list = new Vector.<IListItem>();
		}

		/**
		 * Run the list and execute the items in sequence.
		 */
		public function run():void
		{
			if (_list.length > 0)
			{
				_isRunning = true;
				_itemsCompleteCount = 0;

				for each (var item:IListItem in _list)
				{
					item.execute(onItemComplete);
				}
			}
			else
			{
				_complete.dispatch();
			}
		}
		
		/**
		 * A list item is allComplete, so dispatch signals and check
		 * if we should continue or the list is done.
		 */
		private function onItemComplete(item:IListItem):void
		{
			_itemsCompleteCount++;
			
			_itemComplete.dispatch();

			item.dispose();
			
			if (_itemsCompleteCount == _list.length || _isRunning == false)
			{
				if (_isRunning == false)
				{
					_aborted.dispatch();
				}
				else
				{
					_complete.dispatch();
				}
			}
		}

		/**
		 * Stop the list from executing.
		 */
		public function stop():void
		{
			_isRunning = false;
		}

		/**
		 * Return the signal indicating when the list is allComplete.
		 * @return ISignal
		 */
		public function get complete():ISignal
		{
			return _complete;
		}

		/**
		 * Return the signal indicating a list item is allComplete.
		 * @return ISignal
		 */
		public function get itemComplete():ISignal
		{
			return _itemComplete;
		}

		/**
		 * Return if the list is currently running.
		 * @return Boolean
		 */
		public function get isRunning():Boolean
		{
			return _isRunning;
		}

		public function get aborted():ISignal
		{
			return _aborted;
		}

		public function get itemCount():uint
		{
			return _list.length;
		}
	}
}
