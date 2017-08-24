/**
 * Created by Zoulz on 2014-09-07.
 */
package se.pixelshift.wicca.packages.gamestates.view
{
	import flash.display.Sprite;

	import se.pixelshift.common.list.IList;
	import se.pixelshift.common.list.List;
	import se.pixelshift.common.list.items.PropertyItem;
	import se.pixelshift.common.list.items.TweenItem;
	import se.pixelshift.common.list.items.tween.TweenData;

	public class GameStateHandlerView extends Sprite implements IGameStateHandlerView
	{
		public function GameStateHandlerView()
		{
		}

		public function addGameStateView(view:*):void
		{
			addChild(view);
		}

		public function removeGameStateView(view:*):void
		{
			removeChild(view);
		}

		public function playWipeAnimation(view:*, isWipeOutAnimation:Boolean, tweener:Class, callback:Function = null):void
		{
			var list:IList = new List(
					new PropertyItem(view, "alpha", isWipeOutAnimation ? 1 : 0),
					new TweenItem(new TweenData(view, 0.4, { alpha: isWipeOutAnimation ? 0 : 1 }), tweener)
			);

			list.complete.addOnce(callback);
			list.run();
		}
	}
}
