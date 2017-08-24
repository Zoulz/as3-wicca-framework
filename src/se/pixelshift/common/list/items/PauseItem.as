package se.pixelshift.common.list.items
{
    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import se.pixelshift.common.list.IListItem;

    /**
	 * Pauses the execution for a specified amount of time (in milliseconds).
	 */
	public class PauseItem implements IListItem
	{
		private var _tm:Timer;
		private var _callback:Function;
		
		/**
		 * Constructor. Sets the amount of milliseconds to pause.
		 */
		public function PauseItem(milliseconds:uint)
		{
			_tm = new Timer(milliseconds, 1);
			_tm.addEventListener(TimerEvent.TIMER, onTimerComplete);
		}

		/**
		 * Event handler for when the timer is allComplete. Stops and removes
		 * the timer and then performs the list callback.
		 * @param event TimerEvent
		 */
		private function onTimerComplete(event:TimerEvent):void
		{
			_tm.removeEventListener(TimerEvent.TIMER, onTimerComplete);
			_tm.stop();
			
			_callback(this);
		}
		
		/**
		 * Simply starts the timer.
		 */
		public function execute(callback:Function):void
		{
			_callback = callback;
			_tm.start();
		}

		/**
		 * Stops the timer and performs the callback to list.
		 */
		public function abort():void
		{
			dispose();

			_callback(this);
		}

		public function dispose():void
		{
			_tm.removeEventListener(TimerEvent.TIMER, onTimerComplete);
			_tm.stop();
		}
	}
}
