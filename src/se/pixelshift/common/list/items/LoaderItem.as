package se.pixelshift.common.list.items
{
    import flash.display.Loader;
    import flash.events.Event;
    import flash.net.URLRequest;

    import se.pixelshift.common.list.IListItem;

    /**
	 * Loads something with the flash Loader object.
	 */
	public class LoaderItem implements IListItem
	{
		private var _url:URLRequest;
		private var _loader:Loader;
		private var _completeCallback:Function;
		private var _callback:Function;
		
		public function LoaderItem(url:String, completeCallback:Function = null)
		{
			_completeCallback = completeCallback;
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete);
			_url = new URLRequest(url);
		}

		private function onLoaderComplete(event:Event):void
		{
			event.target.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaderComplete);
			
			_completeCallback(event, _loader.content);
			
			_callback(this);
		}
		
		public function execute(callback:Function):void
		{
			_callback = callback;
			_loader.load(_url);
		}

		public function abort():void
		{
			_loader.close();

			dispose();

			_callback(this);
		}

		public function dispose():void
		{
			_loader.unload();
		}
	}
}
