/**
 * Quickspin
 * User: Tomas Augustinovic
 * Date: 2015-07-03
 * Time: 16:09
 */
package se.pixelshift.common.utils
{
	import flash.geom.Point;

	import se.pixelshift.common.IDisposable;

	import starling.display.DisplayObject;

	import starling.display.DisplayObjectContainer;
	import starling.display.Image;

	public class StarlingUtil
	{
		public static function flipImageHorizontal(obj:Image):void
		{
			obj.setTexCoords(0, 1, 0);
			obj.setTexCoords(1, 0, 0);
			obj.setTexCoords(2, 1, 1);
			obj.setTexCoords(3, 0, 1);
		}

		public static function flipImageVertical(obj:Image):void
		{
			obj.setTexCoords(0, 0, 1);
			obj.setTexCoords(1, 1, 1);
			obj.setTexCoords(2, 0, 0);
			obj.setTexCoords(3, 1, 0);
		}

		public static function removeAllChildren(container:DisplayObjectContainer):void
		{
			if (container == null)
			{
				return;
			}

			while (container.numChildren > 0)
			{
				container.removeChildAt(0);
			}
		}

		public static function removeAndDisposeAllChildren(container:DisplayObjectContainer):void
		{
			if (container == null)
			{
				return;
			}

			var child:*;
			while (container.numChildren > 0)
			{
				child = container.getChildAt(0);

				if (child is IDisposable)
				{
					IDisposable(child).dispose();
				}

				if (container.numChildren > 0)
				{
					//in case the only child removed itself in destroy
					container.removeChildAt(0);
				}

				if ("dispose" in child)
				{
					child.dispose();
				}
			}
		}

		public static function removeAndDisposeAllChildrenRecursive(container:DisplayObjectContainer):void
		{
			if (container == null)
			{
				return;
			}

			var child:*;
			while (container.numChildren > 0)
			{
				child = container.getChildAt(0);

				if (child is IDisposable)
				{
					IDisposable(child).dispose();
				}

				if (child is DisplayObjectContainer)
				{
					removeAndDisposeAllChildrenRecursive(child);
				}

				if (container.numChildren > 0)
				{
					//in case the only child removed itself in destroy
					container.removeChildAt(0);
				}

				if ("dispose" in child)
				{
					child.dispose();
				}
			}
		}

		public static function removeAndDisposeChild(child:DisplayObject):void
		{
			if (child == null)
			{
				return;
			}

			if (child is IDisposable)
			{
				IDisposable(child).dispose();
			}

			child.removeFromParent(true);
		}

		public static function replaceExistingClipWithNew(existingClip:DisplayObject, newClip:DisplayObject, disposeExisting:Boolean = false):void
		{
			newClip.x = existingClip.x;
			newClip.y = existingClip.y;

			newClip.scaleX = existingClip.scaleX;
			newClip.scaleY = existingClip.scaleY;

			newClip.rotation = existingClip.rotation;
			newClip.skewX = existingClip.skewX;
			newClip.skewY = existingClip.skewY;
			newClip.alpha = existingClip.alpha;

			newClip.name = existingClip.name;

			var parent:DisplayObjectContainer = existingClip.parent;
			if (parent != null)
			{
				var z:int = parent.getChildIndex(existingClip);
				parent.removeChild(existingClip);
				parent.addChildAt(newClip, z);
			}

			if (disposeExisting)
			{
				existingClip.dispose();
			}
		}

		public static function copyProperties(src:DisplayObject, dst:DisplayObject):void
		{
			dst.x = src.x;
			dst.y = src.y;
			dst.scaleX = src.scaleX;
			dst.scaleY = src.scaleY;
			dst.rotation = src.rotation;
		}
	}
}
