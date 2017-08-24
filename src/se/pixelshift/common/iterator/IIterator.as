/**
 * Quickspin
 * User: Tomas Augustinovic
 * Date: 2015-07-03
 * Time: 14:14
 */
package se.pixelshift.common.iterator
{
	public interface IIterator
	{
		function get hasNext():Boolean;
		function get next():*;
		function remove():*;
		function reset():void;
	}
}
