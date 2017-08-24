/**
 * Copyright Pixelshift Interactive (c) 2015 All Right Reserved.
 * @author black
 */
package se.pixelshift.wicca.packages.gamestates.view
{
	import flash.display.Sprite;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import se.pixelshift.common.IDisposable;

	public class BaseGameStateView extends Sprite implements IGameStateView, IDisposable
	{
		private var _activated:Signal = new Signal();
		private var _deactivated:Signal = new Signal();
		private var _created:Signal = new Signal();

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

		public function dispose():void
		{
			_activated.removeAll();
			_deactivated.removeAll();
			_created.removeAll();
		}
	}
}
