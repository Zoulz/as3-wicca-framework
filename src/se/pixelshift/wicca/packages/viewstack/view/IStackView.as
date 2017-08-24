/**
 * Created by Tomas Augustinovic on 2017-02-06.
 */
package se.pixelshift.wicca.packages.viewstack.view
{
	import org.osflash.signals.ISignal;

	public interface IStackView
	{
		function addView(view:*, index:uint, id:String):void;
		function removeView(id:String):void;
		function removeAll():void;
		function showView(id:String):void;
		function hideView(id:String):void;
		function setViewIndex(id:String, index:uint):void;
		function swapViewIndex(fromId:String, toId:String):void;

		function get view():*;
		function get unmediate():ISignal;
	}
}
