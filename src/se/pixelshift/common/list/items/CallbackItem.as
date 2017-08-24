package se.pixelshift.common.list.items
{
    import se.pixelshift.common.list.IListItem;

    /**
	 * Item used to invoke a function that can perform async tasks while holding up the list execution until finished.
	 * Supplies a callback function as the first argument. This should be invoked once all tasks are allComplete.
	 *
	 * @example
	 * <listing version="3.0">
	 * // Add callback item like so.
	 * var test:Number = 25;
	 * list.addItem(new CallbackItem(myFunction, test));
	 *
	 * // Example of callback function.
	 * function myFunction(callback:Function, num:Number):void
	 * {
	 *  // The item is not allComplete until the supplied callback function is executed.
	 *  doAsyncTasksHere();
	 *
	 *  callback();
	 * }
	 * </listing>
	 *
	 * @author tomas.augustinovic
	 */
	public class CallbackItem implements IListItem
	{
		private var _func:Function;
		private var _args:Array;
		private var _callback:Function;

		/**
		 * @param method Callback method to invoke.
		 * @param args Arguments for the callback method.
		 */
		public function CallbackItem(method:Function, ...args)
		{
			_func = method;
			_args = args;
		}

		/**
		 * Will execute the callback method and wait for it to invoke the
		 * item's internal callback method which is appended to the list of
		 * arguments.
		 * @param callback Internal list callback function.
		 */
		public function execute(callback:Function):void
		{
			_callback = callback;
			
			//	Add callback as first argument.
			_args.unshift(onFuncCallback);
			
			//	Execute function.
			_func.apply(null, _args);
		}

		/**
		 * Internal callback function. This is passed to the user's callback.
		 */
		private function onFuncCallback():void
		{
			_callback(this);
		}

		/**
		 * Disposes the item and calls it's internal callback.
		 */
		public function abort():void
		{
			dispose();

			_callback(this);
		}

		/**
		 * @inheritDoc
		 */
		public function dispose():void
		{
		}
	}
}
