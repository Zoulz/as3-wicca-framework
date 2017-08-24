package se.pixelshift.common.list.items.signals
{
	import org.osflash.signals.ISignal;

    import se.pixelshift.common.list.IListItem;

    /**
	 * Waits for a signal to be invoked.
	 */
	public class SignalItem implements IListItem
	{
		private var _signal:ISignal;
		private var _callback:Function;
		private var _handler:Function;
		
		/**
		 * Constructor. Save the signal reference.
		 * @param signal Signal to listen for.
		 */
		public function SignalItem(signal:ISignal, handler:Function = null)
		{
			_signal = signal;
			_handler = handler;
		}

		/**
		 * Adds a listener on the signal and when it fires we
		 * perform the list callback.
		 * @param callback Callback to list.
		 */
		public function execute(callback:Function):void
		{
			_callback = callback;
			_signal.addOnce(onSignal);
		}

		private function onSignal(...args):void
		{
			if (_handler != null)
			{
				_handler(args);
			}

			_callback(this);
		}

		/**
		 * Removes the listener from the signal and performs the
		 * list callback.
		 */
		public function abort():void
		{
			dispose();

			_callback(this);
		}

		public function dispose():void
		{
			_signal.remove(onSignal);
		}
	}
}
