/**
 * Created by Tomas Augustinovic on 2017-02-06.
 */
package se.pixelshift.wicca.packages.viewstack.view
{
	import flash.display.Sprite;

	import org.osflash.signals.ISignal;

	public class StackView extends Sprite implements IStackView
	{
		public function StackView()
		{
		}

		public function addView(view:*, index:uint, id:String):void
		{
		}

		public function removeView(id:String):void
		{
		}

		public function showView(id:String):void
		{
		}

		public function hideView(id:String):void
		{
		}

		public function setViewIndex(id:String, index:uint):void
		{
		}

		public function swapViewIndex(fromId:String, toId:String):void
		{
		}

		public function get view():*
		{
			return null;
		}

		public function get unmediate():ISignal
		{
			return null;
		}

		public function removeAll():void
		{
		}
	}
}
