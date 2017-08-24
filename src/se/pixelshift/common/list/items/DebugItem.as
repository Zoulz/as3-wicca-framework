package se.pixelshift.common.list.items
{
    import se.pixelshift.common.list.IListItem;

    /**
	 * Determine if this is even needed...
	 */
	public class DebugItem implements IListItem
	{
		private var _msg:String;

		public function DebugItem(msg:String)
		{
			_msg = msg;
		}

		public function execute(callback:Function):void
		{
			trace(_msg);

			callback(this);
		}

		public function abort():void
		{
		}

		public function dispose():void
		{
		}
	}
}
