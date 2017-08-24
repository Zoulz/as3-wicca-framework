package se.pixelshift.common.list.items
{
    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import se.pixelshift.common.list.IListItem;

    /**
	 * Asynchronous item that will wait until a certain condition is fulfilled and
	 * either executes the supplied list item and waits for it's completion, or simply
	 * allows it's parent list to continue.
	 *
	 * @example
	 * <listing version="3.0">
	 * // As long as this condition is false the list execution will remain stalled.
	 * var condition:Function = function():Boolean { return something == somethingElse; };
	 * list.addItem(new ConditionalItem(condition, new FunctionItem(runThisItemWhenConditionIsMet)));
	 * </listing>
	 *
	 * @author tomas.augustinovic
	 */
	public class ConditionalItem implements IListItem
	{
		private var _expr:Function;
		private var _timer:Timer;
		private var _callback:Function;
		private var _listItem:IListItem;

		/**
		 * @param condition Function that returns a Boolean value. True means the condition is met.
		 * @param interval Milliseconds between each condition check.
		 */
		public function ConditionalItem(condition:Function, item:IListItem = null, interval:uint = 100)
		{
			_expr = condition;
			_listItem = item;

			if (interval != 0)
			{
				_timer = new Timer(interval);
				_timer.addEventListener(TimerEvent.TIMER, onTimerTick);
			}
		}

		/**
		 * Internal timer event handler. Checks if the condition is met and if so, stops the timer and executes
		 * the callback.
		 * @param event
		 */
		private function onTimerTick(event:TimerEvent):void
		{
			if (_expr() === true)
			{
				_timer.stop();

				conditionMet();
			}
		}

		private function conditionMet():void
		{
			if (_listItem != null)
			{
				_listItem.execute(onListItemComplete);
			}
			else
			{
				_callback(this);
			}
		}

		private function onListItemComplete(item:IListItem):void
		{
			_callback(this);
		}

		/**
		 * Starts the internal timer.
		 * @param callback
		 */
		public function execute(callback:Function):void
		{
			_callback = callback;

			if (_expr() !== true)
			{
				//	Condition is true.
				if (_timer != null)
				{
					//	If a timer was created we start it and poll the condition until it's true.
					_timer.start();
				}
				else
				{
					//	If there is no timer, we just let the item execute or call back to executing list.
					conditionMet();
				}
			}
			else if (_timer == null)
			{
				//	If there is no timer created and the condition is false we need to let the list continue.
				_callback(this);
			}
		}

		/**
		 * Stops the timer and disposes the item.
		 */
		public function abort():void
		{
			_timer.stop();

			dispose();

			_callback(this);
		}

		/**
		 * Removes event listeners.
		 */
		public function dispose():void
		{
			_timer.removeEventListener(TimerEvent.TIMER, onTimerTick);
		}
	}
}
