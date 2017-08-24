package se.pixelshift.common.list.items
{
    import flash.events.Event;
    import flash.events.IEventDispatcher;

    import se.pixelshift.common.list.IListItem;

    /**
	 * Listens for a flash event to be dispatched before allowing list execution to continue.
	 *
	 * @example
	 * <listing version="3.0">
	 * // Will wait for 'this' to dispatch the event TestEvent.TEST.
	 * list.addItem(new EventItem(this, TestEvent.TEST));
	 * </listing>
	 *
	 * @author tomas.augustinovic
	 */
	public class EventItem implements IListItem
	{
		private var _dispatcher:IEventDispatcher;
		private var _type:String;
		private var _callback:Function;
		private var _handler:Function;
		private var _preFunc:Function;

		/**
		 * @param dispatcher The object that will dispatch the event.
		 * @param type Type of event.
		 * @param preFunc A function that is executed when setting up the listener.
		 * @param handler Function called when the event has been invoked.
		 */
		public function EventItem(dispatcher:IEventDispatcher, type:String, preFunc:Function = null, handler:Function = null)
		{
			_dispatcher = dispatcher;
			_type = type;
			_handler = handler;
			_preFunc = preFunc;
		}

		/**
		 * Setup a listener on the dispatcher object. Execute the prefunction.
		 * @param callback Internal callback.
		 */
		public function execute(callback:Function):void
		{
			_callback = callback;
			_dispatcher.addEventListener(_type, onEventDispatched);
			if (_preFunc != null)
			{
				_preFunc();
			}
		}

		/**
		 * Executes the handler function.
		 * @param event
		 */
		private function onEventDispatched(event:Event):void
		{
			//_dispatcher.removeEventListener(_type, onEventDispatched);
			if (_handler != null)
			{
				_handler(event);
			}
			_callback(this);
		}

		/**
		 * Disposes the item.
		 */
		public function abort():void
		{
			dispose();

			_callback(this);
		}

		/**
		 * Removes event handler.
		 */
		public function dispose():void
		{
			_dispatcher.removeEventListener(_type, onEventDispatched);
		}
	}
}
