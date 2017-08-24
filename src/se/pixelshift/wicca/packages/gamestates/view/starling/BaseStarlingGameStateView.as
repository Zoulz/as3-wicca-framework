/**
 * Copyright Pixelshift Interactive (c) 2015 All Right Reserved.
 * @author black
 */
package se.pixelshift.wicca.packages.gamestates.view.starling
{
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import se.pixelshift.common.IDisposable;
	import se.pixelshift.wicca.packages.gamestates.view.IGameStateView;

	import starling.display.Sprite;

	public class BaseStarlingGameStateView extends Sprite implements IGameStateView, IDisposable
	{
		private var _created:Signal = new Signal();
		private var _activated:Signal = new Signal();
		private var _deactivated:Signal = new Signal();

		public function activated():void
		{
			_activated.dispatch();
		}

		public function deactivated():void
		{
			_deactivated.dispatch();
		}

		public function init():void
		{
			_created.dispatch();
		}

		public function get activate():ISignal
		{
			return _activated;
		}

		public function get deactivate():ISignal
		{
			return _deactivated;
		}

		public function get created():ISignal
		{
			return _created;
		}

		override public function dispose():void
		{
			_activated.removeAll();
			_deactivated.removeAll();
			_created.removeAll();
		}
	}
}
