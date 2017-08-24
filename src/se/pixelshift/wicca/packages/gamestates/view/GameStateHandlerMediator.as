/**
 * Created by Zoulz on 2014-09-07.
 */
package se.pixelshift.wicca.packages.gamestates.view
{
	import mvcexpress.mvc.Mediator;

	import se.pixelshift.common.list.items.tween.ActuateTweener;
	import se.pixelshift.wicca.packages.gamestates.consts.GameStateMsg;
	import se.pixelshift.wicca.packages.gamestates.model.IGameStateModel;
	import se.pixelshift.wicca.packages.gamestates.model.vo.GameState;
	import se.pixelshift.wicca.packages.gamestates.params.GameStateParams;

	public class GameStateHandlerMediator extends Mediator
	{
		[Inject] public var view:IGameStateHandlerView;
		[Inject] public var gsModel:IGameStateModel;

		override protected function onRegister():void
		{
			addHandler(GameStateMsg.ACTIVATE_STATE, onActivateState);
			addHandler(GameStateMsg.DEACTIVATE_STATE, onDeactivateState);
		}

		override protected function onRemove():void
		{
			removeAllHandlers();
		}

		private function onActivateState(params:GameStateParams):void
		{
			var gs:GameState = gsModel.getGameState(params.id);

			if (gs && gs.view)
			{
				if (params.wipe != null && params.wipe == true)
				{
					view.playWipeAnimation(gs.view, false, ActuateTweener, function():void {
						view.addGameStateView(gs.view);
						mediatorMap.mediate(gs.view);
						gs.view.activated();

						sendMessage(GameStateMsg.EXECUTE_ENTER_LIST, { id: params.id });
					});
				}
				else
				{
					view.addGameStateView(gs.view);
					mediatorMap.mediate(gs.view);
					gs.view.activated();

					sendMessage(GameStateMsg.EXECUTE_ENTER_LIST, { id: params.id });
				}
			}
		}

		private function onDeactivateState(params:GameStateParams):void
		{
			var gs:GameState = gsModel.getGameState(params.id);

			if (gs && gs.view)
			{
				if (params.wipe != null && params.wipe == true)
				{
					view.playWipeAnimation(gs.view, true, ActuateTweener, function():void {
						sendMessage(GameStateMsg.EXECUTE_EXIT_LIST, { id: params.id });

						mediatorMap.unmediate(gs.view);
						view.removeGameStateView(gs.view);
					});
				}
				else
				{
					sendMessage(GameStateMsg.EXECUTE_EXIT_LIST, { id: params.id });

					mediatorMap.unmediate(gs.view);
					view.removeGameStateView(gs.view);
				}
			}
		}
	}
}
