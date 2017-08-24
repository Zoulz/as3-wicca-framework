/**
 * Created by black on 2016-01-10.
 */
package se.pixelshift.wicca.modules
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;

	import se.pixelshift.wicca.WiccaSettings;
	import se.pixelshift.wicca.logging.ILogger;
	import se.pixelshift.wicca.starling.WiccaStarlingRoot;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;

	public class WiccaAirStarlingModule extends WiccaAirModule implements IWiccaAirModule
	{
		private var _starling:Starling;

		public function WiccaAirStarlingModule(moduleName:String = "WICCA_STARLING_MODULE")
		{
			super(moduleName);
		}

		override public function start(main:DisplayObjectContainer, settings:WiccaSettings = null):void
		{
			_main = main;
			_settings = settings != null ? settings : new WiccaSettings();

			_starling = new Starling(WiccaStarlingRoot, main.stage);
			_starling.addEventListener(Event.ROOT_CREATED, onStarlingRootCreated);
			_starling.start();

			CONFIG::debug
			{
				if (_settings.showStats)
					Starling.current.showStatsAt(_settings.statsHAlign, _settings.statsVAlign, _settings.statsScale);
			}
		}

		override public function shutDown():void
		{
			super.shutDown();

			_starling.stop();
			_starling.dispose();
		}

		private function onStarlingRootCreated(event:Event):void
		{
			_starling.removeEventListener(Event.ROOT_CREATED, onStarlingRootCreated);

			super.start(_main);
		}

		override protected function addAndMediateView(view:*):void
		{
			mediatorMap.mediate(view);
			Sprite(_starling.root).addChild(view);
		}

		override protected function removeAndUnmediateView(view:*):void
		{
			mediatorMap.unmediate(view);
			Sprite(_starling.root).removeChild(view);
		}

		override public function resize():void
		{
			super.resize();

			var rect:Rectangle = new Rectangle(0, 0, _main.stage.stageWidth, _main.stage.stageHeight);
			_starling.viewPort = rect;

			_starling.stage.stageWidth = 1280;
			_starling.stage.stageHeight = 720;
		}
	}
}
