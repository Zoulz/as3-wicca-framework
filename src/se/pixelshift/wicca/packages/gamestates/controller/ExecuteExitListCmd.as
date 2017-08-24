/**
 * Created by Zoulz on 2014-09-06.
 */
package se.pixelshift.wicca.packages.gamestates.controller
{
	import mvcexpress.mvc.PooledCommand;

	import se.pixelshift.wicca.packages.gamestates.consts.GameStateMsg;
	import se.pixelshift.wicca.packages.gamestates.model.IGameStateModel;
	import se.pixelshift.wicca.packages.gamestates.model.vo.GameState;

	public class ExecuteExitListCmd extends PooledCommand
	{
		[Inject] public var gsModel:IGameStateModel;

		private var _id:String;

		public function execute(params:Object):void
		{
			lock();

			_id = params.id;

			var gs:GameState = gsModel.getGameState(_id);

			if (gs && gs.exit)
			{
				gs.exit.complete.addOnce(onListComplete);
				gs.exit.run();
			}

			gs.active = false;
		}

		private function onListComplete():void
		{
			sendMessage(GameStateMsg.EXIT_LIST_COMPLETE, { id: _id });

			unlock();
		}
	}
}
