/**
 * Created by Zoulz on 2014-09-07.
 */
package se.pixelshift.wicca.packages.gamestates.model
{
	import se.pixelshift.wicca.packages.gamestates.model.vo.GameState;

	public interface IGameStateModel
	{
		function addGameState(id:String, gs:GameState):void;
		function removeGameState(id:String):void;
		function getGameState(id:String):GameState;
	}
}
