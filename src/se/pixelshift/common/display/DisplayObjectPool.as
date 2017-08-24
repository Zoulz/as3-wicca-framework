package se.pixelshift.common.display
{
	import flash.display.DisplayObject;

	/**
	 * Factory class for display objects. This can be used to reduce the amount of object creation/destruction, which gives the garbage
	 * collector less to do (which is always a good thing).
	 * 
	 * @author tomas.augustinovic
	 */
	public class DisplayObjectPool
	{
		private var _doType:Class;
		private var _usedPool:Vector.<DisplayObject>;
		private var _unusedPool:Vector.<DisplayObject>;
		
		/**
		 * @param displayObjectType Class reference to use for creation.
		 */
		public function DisplayObjectPool(displayObjectType:Class)
		{
			_doType = displayObjectType;
			_usedPool = new Vector.<DisplayObject>();
			_unusedPool = new Vector.<DisplayObject>();
		}
		
		/**
		 * Create instance of display object.
		 * @return
		 */
		public function create():DisplayObject
		{
			var obj:DisplayObject;
			
			if (_unusedPool.length > 0)
			{
				obj = _unusedPool.pop();
			}
			else
			{
				obj = new _doType();
			}
			
			_usedPool.push(obj);
			
			return obj;
		}
		
		/**
		 * Destroy a display object in the pool.
		 * @param obj Object to destroy.
		 */
		public function destroy(obj:DisplayObject):void
		{
			var idx:int = _usedPool.indexOf(obj);
			
			if (idx >= 0)
			{
				_usedPool.splice(idx, 1);
				_unusedPool.push(obj);
			}
		}
	}
}
