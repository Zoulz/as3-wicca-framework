/**
 * Copyright Pixelshift Interactive (c) 2014 All Right Reserved.
 * @author Zoulz
 */
package se.pixelshift.wicca.packages.gamestates.view.starling
{
	import se.pixelshift.wicca.packages.gamestates.view.*;

	import starling.display.Sprite;

	public class GameStateHandlerStarlingView extends Sprite implements IGameStateHandlerView
	{
		public function GameStateHandlerStarlingView()
		{
		}

		public function addGameStateView(view:*):void
		{
			this.addChild(view);
		}

		public function removeGameStateView(view:*):void
		{
			this.removeChild(view);
		}

		public function playWipeAnimation(view:*, isWipeOutAnimation:Boolean, tweener:Class, callback:Function = null):void
		{
			callback();		//	TODO implement wipes.
		}
	}
}
