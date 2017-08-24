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

	public class ProtectedIterator implements IIterator
	{
		private var _iterator:IIterator;

		public function ProtectedIterator(iterator:IIterator)
		{
			_iterator = iterator;
		}
		
		public function remove():*
		{
			throw new Error("The protected Iterator does not allow the removal of elements.");
			return null;
		}

		public function reset():void
		{
			_iterator.reset();
		}

		public function get hasNext():Boolean
		{
			return _iterator.hasNext;
		}
		
		public function get next():*
		{
			return _iterator.next;
		}
	}
}
