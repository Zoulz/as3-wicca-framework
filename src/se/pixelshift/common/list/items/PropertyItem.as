package se.pixelshift.common.list.items
{
    import se.pixelshift.common.list.IListItem;

    /**
	 * Sets the property of a object.
	 */
	public class PropertyItem implements IListItem
	{
		private var _obj:Object;
		private var _prop:String;
		private var _val:*;
		
		public function PropertyItem(obj:Object, prop:String, value:*)
		{
			_obj = obj;
			_prop = prop;
			_val = value;
		}
		
		public function execute(callback:Function):void
		{
			_obj[_prop] = _val;
			
			callback(this);
		}

		public function abort():void
		{
			//	No-op;
		}

		public function dispose():void
		{
		}
	}
}
