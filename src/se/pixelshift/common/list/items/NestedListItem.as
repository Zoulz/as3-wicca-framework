package se.pixelshift.common.list.items
{
    import se.pixelshift.common.list.IList;
    import se.pixelshift.common.list.IListItem;

    /**
	 * Executes the supplied list.
	 */
	public class NestedListItem implements IListItem
	{
		private var _list:IList;
		private var _callback:Function;
		
		public function NestedListItem(list:IList)
		{
			_list = list;
		}
		
		public function execute(callback:Function):void
		{
			_callback = callback;
			_list.complete.addOnce(onListComplete);
			_list.run();
		}

		private function onListComplete():void
		{
			_callback(this);
		}

		public function abort():void
		{
			dispose();

			_callback(this);
		}

		public function dispose():void
		{
			if (_list.isRunning)
			{
				_list.stop();
			}
		}
	}
}
