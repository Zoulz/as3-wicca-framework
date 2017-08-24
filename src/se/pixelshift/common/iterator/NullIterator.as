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

	public class NullIterator implements IIterator
	{
		public function remove():*
		{
			return null;
		}

		public function reset():void
		{
		}

		public function get hasNext():Boolean
		{
			return false;
		}
		
		public function get next():*
		{
			return null;
		}
	}
}
