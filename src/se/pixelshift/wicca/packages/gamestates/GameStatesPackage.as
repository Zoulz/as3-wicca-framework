/**
 * Created by Zoulz on 2014-09-06.
 */
package se.pixelshift.wicca.packages.gamestates
{
	import se.pixelshift.wicca.packages.BaseWiccaPackage;
	import se.pixelshift.wicca.packages.IWiccaPackage;
	import se.pixelshift.wicca.packages.gamestates.consts.GameStateMsg;
	import se.pixelshift.wicca.packages.gamestates.controller.ExecuteEnterListCmd;
	import se.pixelshift.wicca.packages.gamestates.controller.ExecuteExitListCmd;
	import se.pixelshift.wicca.packages.gamestates.model.GameStateModel;
	import se.pixelshift.wicca.packages.gamestates.model.IGameStateModel;
	import se.pixelshift.wicca.packages.gamestates.view.GameStateHandlerMediator;
	import se.pixelshift.wicca.packages.gamestates.view.GameStateHandlerView;
	import se.pixelshift.wicca.packages.gamestates.view.IGameStateHandlerView;

	public class GameStatesPackage extends BaseWiccaPackage implements IWiccaPackage
	{
		private var _viewClass:Class;

		public function GameStatesPackage(viewClass:Class = null)
		{
			if (viewClass == null)
			{
				_viewClass = GameStateHandlerView;
			}
			else
			{
				_viewClass = viewClass;
			}
		}

		override protected function mapView():void
		{
			_mediatorMap.map(_viewClass, GameStateHandlerMediator, IGameStateHandlerView);
		}

		override protected function mapController():void
		{
			_commandMap.map(GameStateMsg.EXECUTE_ENTER_LIST, ExecuteEnterListCmd);
			_commandMap.map(GameStateMsg.EXECUTE_EXIT_LIST, ExecuteExitListCmd);
		}

		override protected function mapModel():void
		{
			_proxyMap.map(new GameStateModel(), null, IGameStateModel, IGameStateModel);
		}

		override protected function unmapView():void
		{
			_mediatorMap.unmap(_viewClass, GameStateHandlerMediator);
		}

		override protected function unmapController():void
		{
			_commandMap.unmap(GameStateMsg.ACTIVATE_STATE);
			_commandMap.unmap(GameStateMsg.DEACTIVATE_STATE);
		}

		override protected function unmapModel():void
		{
			_proxyMap.unmap(IGameStateModel);
		}

		override public function get name():String
		{
			return "Game States";
		}

		override public function get description():String
		{
			return "A package for state handling. Game states can be registered through the model and activated/deactivated by messages.";
		}
	}
}
