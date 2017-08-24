/**
 * Created by Tomas Augustinovic on 2017-02-06.
 */
package se.pixelshift.wicca.packages.viewstack.view
{
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import starling.display.Sprite;

	public class StackStarlingView extends Sprite implements IStackView
	{
		private var _stack:Array = [];
		private var _unmediateSignal:Signal = new Signal();

		public function StackStarlingView()
		{
		}

		private function rearrangeViews():void
		{
			_stack.sort(function(obj:Object, obj2:Object):Number {
				return obj.index - obj2.index;
			});

			for (var i:int = 0; i < _stack.length; i++)
			{
				setChildIndex(_stack[i].view, _stack[i].index);
			}
		}

		private function getView(id:String):Object
		{
			var find:Array = _stack.filter(function(element:*, index:int, arr:Array):Boolean {
				return element.id == id;
			});

			if (find.length > 0)
				return find[0];

			return null;
		}

		public function addView(view:*, index:uint, id:String):void
		{
			if (view != null)
			{
				if (getView(id) == null)
				{
					_stack.push({view: view, index: index, id: id});
					addChild(view);
					rearrangeViews();
				}
				else
				{
					throw new Error("View already added.");
				}
			}
		}

		public function removeView(id:String):void
		{
			var o:Object = getView(id);
			if (o != null)
			{
				_stack.splice(_stack.indexOf(o), 1);
				_unmediateSignal.dispatch(o.view);
				removeChild(o.view);
				rearrangeViews();
			}
		}

		public function removeAll():void
		{
		}

		public function showView(id:String):void
		{
			var o:Object = getView(id);
			if (o != null)
			{
				o.view.visible = true;
			}
		}

		public function hideView(id:String):void
		{
			var o:Object = getView(id);
			if (o != null)
			{
				o.view.visible = false;
			}
		}

		public function setViewIndex(id:String, index:uint):void
		{
			//setChildIndex(view, index);
		}

		public function swapViewIndex(fromId:String, toId:String):void
		{
			//swapChildren(fromView, toView);
		}

		public function get view():*
		{
			return this;
		}

		public function get unmediate():ISignal
		{
			return _unmediateSignal;
		}
	}
}
