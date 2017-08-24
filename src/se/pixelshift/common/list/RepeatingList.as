/**
 * Created with IntelliJ IDEA.
 * User: Tomas Augustinovic
 * Date: 2014-02-24
 * Time: 16:35
 * To change this template use File | Settings | File Templates.
 */
package se.pixelshift.common.list
{
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	/**
	 * A list that repeats over specified number of times.
	 *
	 * @author tomas.augustinovic
	 */
	public class RepeatingList implements IList
	{
		private var _repeatTimes:int;
		private var _list:Vector.<IListItem>;
		private var _currentIndex:uint;
		private var _currentIteration:uint;
		private var _isRunning:Boolean;
		private var _complete:Signal;
		private var _aborted:Signal;
		private var _itemComplete:Signal;
		private var _iterationComplete:Signal;

		public function RepeatingList(repeatTimes:int = -1)
		{
			_repeatTimes = repeatTimes;
			_currentIteration = 0;
			_isRunning = false;
			_complete = new Signal();
			_aborted = new Signal();
			_itemComplete = new Signal();
			_iterationComplete = new Signal();

			clear();
		}

		public function addItem(item:IListItem):void
		{
			if (item != null)
			{
				_list.push(item);
			}
		}

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

		public function clear():void
		{
			_list = new Vector.<IListItem>();
		}

		public function run():void
		{
			if (_list.length > 0)
			{
				_isRunning = true;
				_currentIndex = 0;
				_currentIteration = 0;
				_list[_currentIndex].execute(onItemComplete);
			}
			else
			{
				_complete.dispatch();
			}
		}

		private function onItemComplete(item:IListItem):void
		{
			item.dispose();

			_itemComplete.dispatch();

			if (_isRunning == false)
			{
				_aborted.dispatch();
				return;
			}

			_currentIndex++;
			if (_currentIndex < _list.length)
			{
				_list[_currentIndex].execute(onItemComplete);
			}
			else
			{
				_currentIteration++;
				if (_currentIteration < _repeatTimes)
				{
					_iterationComplete.dispatch();

					_currentIndex = 0;
					_list[_currentIndex].execute(onItemComplete);
				}
				else
				{
					_isRunning = false;
					_complete.dispatch();
				}
			}
		}

		public function stop():void
		{
			_isRunning = false;
			_list[_currentIndex].abort();
		}

		public function get complete():ISignal
		{
			return _complete;
		}

		public function get aborted():ISignal
		{
			return _aborted;
		}

		public function get itemComplete():ISignal
		{
			return _itemComplete;
		}

		public function get isRunning():Boolean
		{
			return _isRunning;
		}

		public function get itemCount():uint
		{
			return _list.length;
		}

		public function get repeatTimes():int
		{
			return _repeatTimes;
		}

		public function set repeatTimes(value:int):void
		{
			_repeatTimes = value;
		}

		public function get iterationComplete():ISignal
		{
			return _iterationComplete;
		}

		public function get currentIteration():uint
		{
			return _currentIteration;
		}
	}
}
