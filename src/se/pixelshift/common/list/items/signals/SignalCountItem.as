package se.pixelshift.common.list.items.signals
{
	import org.osflash.signals.ISignal;
    import se.pixelshift.common.list.IListItem;

/**
	 * Asynchronous item that will wait until a signal has been called a specified amount of times.
	 */
	public class SignalCountItem implements IListItem
	{
		private var _signal:ISignal;
		private var _countTotal:uint;
		private var _count:uint;
		private var _callback:Function;

		public function SignalCountItem(signal:ISignal, count:uint)
		{
			_signal = signal;
			_countTotal = count;
			_count = 0;
		}

		public function execute(callback:Function):void
		{
			_callback = callback;
			_signal.add(onSignalInvoked);

			if (_countTotal == 0)
			{
				_callback(this);
			}
		}

		private function onSignalInvoked():void
		{
			_count++;
			if (_count >= _countTotal)
			{
				_callback(this);
			}
		}

		public function abort():void
		{
			dispose();

			_callback(this);
		}

		public function dispose():void
		{
			_signal.remove(onSignalInvoked);
		}

		public function set count(value:uint):void
		{
			_countTotal = value;
		}

		public function get count():uint
		{
			return _countTotal;
		}
	}
}
