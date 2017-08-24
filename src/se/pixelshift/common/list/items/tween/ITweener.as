/**
 * Created with IntelliJ IDEA.
 * User: Tomas Augustinovic
 * Date: 2014-02-13
 * Time: 14:03
 * To change this template use File | Settings | File Templates.
 */
package se.pixelshift.common.list.items.tween
{
	import org.osflash.signals.ISignal;

	public interface ITweener
	{
		function tween(data:TweenData):void;
		function get complete():ISignal;
		function get update():ISignal;
	}
}
