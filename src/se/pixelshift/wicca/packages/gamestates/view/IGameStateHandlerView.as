/**
 * Created by Zoulz on 2014-09-07.
 */
package se.pixelshift.wicca.packages.gamestates.view
{
	public interface IGameStateHandlerView
	{
		function addGameStateView(view:*):void;
		function removeGameStateView(view:*):void;
		function playWipeAnimation(view:*, isWipeOutAnimation:Boolean, tweener:Class, callback:Function = null):void;
	}
}
