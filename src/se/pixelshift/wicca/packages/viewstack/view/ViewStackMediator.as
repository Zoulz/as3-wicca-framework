/**
 * Created by Tomas Augustinovic on 2017-02-06.
 */
package se.pixelshift.wicca.packages.viewstack.view
{
	import mvcexpress.mvc.Mediator;

	import se.pixelshift.wicca.packages.viewstack.consts.ViewStackMsg;
	import se.pixelshift.wicca.packages.viewstack.params.ViewStackParams;
	import se.pixelshift.wicca.packages.viewstack.params.ViewStackSwapParams;

	public class ViewStackMediator extends Mediator
	{
		[Inject] public var view:IStackView;

		override protected function onRemove():void
		{
			view.unmediate.remove(onUnmediateView);

			removeAllHandlers();
		}

		override protected function onRegister():void
		{
			view.unmediate.add(onUnmediateView);

			addHandler(ViewStackMsg.ADD_VIEW, onAddView);
			addHandler(ViewStackMsg.REMOVE_VIEW, onRemoveView);
			addHandler(ViewStackMsg.REMOVE_ALL, onRemoveAll);
			addHandler(ViewStackMsg.SHOW_VIEW, onShowView);
			addHandler(ViewStackMsg.HIDE_VIEW, onHideView);
			addHandler(ViewStackMsg.SWAP_VIEW_INDEX, onSwapIndex);
			addHandler(ViewStackMsg.SET_VIEW_INDEX, onSetIndex);
		}

		private function onRemoveAll(params:Object):void
		{
			view.removeAll();
		}

		private function onUnmediateView(view:*):void
		{
			mediatorMap.unmediate(view);
		}

		private function onSwapIndex(params:ViewStackSwapParams):void
		{
			view.swapViewIndex(params.fromView, params.toView);
		}

		private function onSetIndex(params:ViewStackParams):void
		{
			view.setViewIndex(params.view, params.index);
		}

		private function onHideView(params:ViewStackParams):void
		{
			view.hideView(params.view);
		}

		private function onShowView(params:ViewStackParams):void
		{
			view.showView(params.view);
		}

		private function onAddView(params:ViewStackParams):void
		{
			if (mediatorMap.isMediated(params.view))
				mediatorMap.unmediate(params.view);

			view.addView(params.view, params.index, params.id);
			mediatorMap.mediate(params.view);
		}

		private function onRemoveView(params:ViewStackParams):void
		{
			view.removeView(params.id);
		}
	}
}
