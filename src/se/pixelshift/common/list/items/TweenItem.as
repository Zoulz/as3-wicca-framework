package se.pixelshift.common.list.items
{
    import se.pixelshift.common.list.IListItem;
    import se.pixelshift.common.list.items.tween.ITweener;
    import se.pixelshift.common.list.items.tween.TweenData;

    /**
	 * Performs a tween given the supplied data.
	 *
	 * @author tomas.augustinovic
	 */
	public class TweenItem implements IListItem
	{
		private var _tweenData:TweenData;
		private var _tweener:ITweener;
		private var _callback:Function;

		public function TweenItem(tweenData:TweenData, Tweener:Class)
		{
			_tweenData = tweenData;
			_tweener = new Tweener();
		}

		public function execute(callback:Function):void
		{
			_callback = callback;
			_tweener.complete.addOnce(onComplete);

			if (_tweenData.updateCallback != null)
			{
				_tweener.update.add(onUpdate);
			}

			_tweener.tween(_tweenData);
		}

		private function onUpdate():void
		{
			_tweenData.updateCallback.apply(null, _tweenData.updateArgs);
		}

		private function onComplete():void
		{
			if (_tweenData.completeCallback != null)
			{
				_tweenData.completeCallback.apply(null, _tweenData.completeArgs);
			}

			_callback(this);
		}

		public function abort():void
		{
			dispose();

			_callback(this);
		}

		public function dispose():void
		{
			_tweener.complete.remove(onComplete);
			_tweener.update.remove(_tweenData.updateCallback);
		}
	}
}
