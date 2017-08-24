/**
 * Copyright Pixelshift Interactive (c) 2014 All Right Reserved.
 * @author Zoulz
 */
package se.pixelshift.wicca.modules
{
	import flash.display.DisplayObjectContainer;

	import se.pixelshift.wicca.WiccaSettings;
	import se.pixelshift.wicca.starling.*;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;

	public class WiccaStarlingModule extends WiccaModule implements IWiccaModule
	{
		private var _starling:Starling;

		public function WiccaStarlingModule(moduleName:String = "WICCA_STARLING_MODULE")
		{
			super(moduleName);
		}

		override public function start(main:DisplayObjectContainer, settings:WiccaSettings = null):void
		{
			_main = main;
			_settings = settings != null ? settings : new WiccaSettings();

			//Starling.handleLostContext = true;

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
	}
}
