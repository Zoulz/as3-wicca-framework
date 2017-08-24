/**
 * Created by Zoulz on 2014-09-06.
 */
package se.pixelshift.wicca.packages.gamestates.controller
{
	import mvcexpress.mvc.PooledCommand;

	import se.pixelshift.wicca.packages.gamestates.consts.GameStateMsg;
	import se.pixelshift.wicca.packages.gamestates.model.IGameStateModel;
	import se.pixelshift.wicca.packages.gamestates.model.vo.GameState;

	public class ExecuteEnterListCmd extends PooledCommand
	{
		[Inject] public var gsModel:IGameStateModel;

		private var _id:String;

		public function execute(params:Object):void
		{
			lock();

			_id = params.id;

			var gs:GameState = gsModel.getGameState(_id);

			if (gs && gs.enter)
			{
				gs.enter.complete.addOnce(onListComplete);
				gs.enter.run();
			}

			gs.active = true;
		}

		private function onListComplete():void
		{
			sendMessage(GameStateMsg.ENTER_LIST_COMPLETE, { id: _id });

			unlock();
		}
	}
}
