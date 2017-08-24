/**
 * Quickspin
 * User: Tomas Augustinovic
 * Date: 2015-07-03
 * Time: 14:16
 */
package se.pixelshift.common.iterator
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	import se.pixelshift.common.iterator.IIterator;

	public class ArrayIterator implements IIterator
	{
		protected var _arr:Array;
		protected var _index:int = 0;

		public function ArrayIterator(array:Array)
		{
			if (array == null)
				throw new Error("Array cannot be null.");
			
			_arr = array;
			reset();
		}

		public function reset():void
		{
			_index = -1;
		}
		
		public function remove():*
		{
			if (_index < 0)
			{
				throw new Error("Tried to remove an element from the array before fetching the 'next' property.");
				return undefined;
			}
			
			return _arr.splice(_index--, 1)[0];
		}
		
		public function get hasNext():Boolean
		{
			return (_index < _arr.length - 1);
		}
		
		public function get next():*
		{
			if (!(_index < _arr.length - 1))
			{
				throw new Error("There is no next element in the array to iterate over.");
				return undefined;
			}
			return _arr[++_index];
		}
	}
}
