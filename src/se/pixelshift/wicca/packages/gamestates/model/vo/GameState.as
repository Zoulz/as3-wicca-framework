/**
 * Copyright Pixelshift Interactive (c) 2014 All Right Reserved.
 * @author Zoulz
 */
package se.pixelshift.wicca.packages.gamestates.model.vo
{
	import se.pixelshift.common.list.IList;
	import se.pixelshift.wicca.packages.gamestates.view.IGameStateView;

	public class GameState
	{
		public var enter:IList = null;
		public var exit:IList = null;
		public var active:Boolean = false;
		public var view:IGameStateView = null;
	}
}
