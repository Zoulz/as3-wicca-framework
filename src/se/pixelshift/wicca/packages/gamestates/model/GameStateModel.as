/**
 * Created by Zoulz on 2014-09-07.
 */
package se.pixelshift.wicca.packages.gamestates.model
{
	import flash.utils.Dictionary;

	import mvcexpress.mvc.Proxy;

	import se.pixelshift.common.utils.StringUtil;
	import se.pixelshift.wicca.packages.gamestates.model.vo.GameState;

	public class GameStateModel extends Proxy implements IGameStateModel
	{
		private var _gameStates:Dictionary;

		override protected function onRegister():void
		{
			_gameStates = new Dictionary();
		}

		override protected function onRemove():void
		{

		}

		public function addGameState(id:String, gs:GameState):void
		{
			if (!StringUtil.isEmpty(id) && gs != null && _gameStates[id] == null)
			{
				_gameStates[id] = gs;
			}
		}

		public function removeGameState(id:String):void
		{
			if (!StringUtil.isEmpty(id))
			{
				_gameStates[id] = null;
			}
		}

		public function getGameState(id:String):GameState
		{
			return _gameStates[id];
		}
	}
}
