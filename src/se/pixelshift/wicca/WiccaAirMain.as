/**
 * Created by Zoulz on 2014-09-04.
 */
package se.pixelshift.wicca
{
	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.events.InvokeEvent;
	import flash.events.KeyboardEvent;
	import flash.system.System;
	import flash.ui.Keyboard;
	import flash.utils.setTimeout;

	import se.pixelshift.wicca.modules.IWiccaAirModule;

	public class WiccaAirMain extends Sprite
	{
		protected var _isClosing:Boolean = false;
		protected var _module:IWiccaAirModule;

		public function WiccaAirMain()
		{
			if (stage == null)
			{
				addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			}
			else
			{
				onAddedToStage();
			}
		}

		private function onAddedToStage(event:Event = null):void
		{
			if (hasEventListener(Event.ADDED_TO_STAGE))
			{
				removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			}

			_module = createModule();

			if (_module)
			{
				stage.nativeWindow.addEventListener(Event.CLOSING, onAppClosing);
				NativeApplication.nativeApplication.addEventListener(Event.EXITING, onAppExit);
				NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, onAppActivate);
				NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, onAppDeactivate);
				NativeApplication.nativeApplication.addEventListener(Event.NETWORK_CHANGE, onAppNetworkChange);
				NativeApplication.nativeApplication.addEventListener(Event.USER_IDLE, onAppIdle);
				NativeApplication.nativeApplication.addEventListener(Event.USER_PRESENT, onAppPresent);
				NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, onAppInvoke);

				stage.addEventListener(Event.RESIZE, onResize);
				stage.addEventListener(KeyboardEvent.KEY_DOWN, onPreventEsc);
				stage.quality = StageQuality.LOW;

				_module.start(this);
			}
			else
			{
				throw new Error("Module is NULL.");
			}
		}

		private function onPreventEsc(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.ESCAPE)
			{
				event.preventDefault();
			}
		}

		protected function onResize(event:Event):void
		{
			_module.resize();
		}

		protected function onAppIdle(event:Event):void
		{
			_module.idle();
		}

		protected function onAppPresent(event:Event):void
		{
			_module.present();
		}

		protected function onAppDeactivate(event:Event):void
		{
			_module.deactivated();
		}

		protected function onAppActivate(event:Event):void
		{
			_module.activated();
		}

		protected function onAppNetworkChange(event:Event):void
		{
			_module.networkChange();
		}

		protected function onAppInvoke(event:InvokeEvent):void
		{
			_module.invoke(event);
		}

		private function onAppClosing(event:Event):void
		{
			_isClosing = true;
			_module.closing();
		}

		protected function onAppExit(event:Event):void
		{
			if (_isClosing)
			{
				event.preventDefault();
				_module.exiting();
				_isClosing = false;
				return;
			}

			stage.nativeWindow.removeEventListener(Event.CLOSING, onAppClosing);
			NativeApplication.nativeApplication.removeEventListener(Event.EXITING, onAppExit);
			NativeApplication.nativeApplication.removeEventListener(Event.ACTIVATE, onAppActivate);
			NativeApplication.nativeApplication.removeEventListener(Event.DEACTIVATE, onAppDeactivate);
			NativeApplication.nativeApplication.removeEventListener(Event.NETWORK_CHANGE, onAppNetworkChange);
			NativeApplication.nativeApplication.removeEventListener(Event.USER_IDLE, onAppIdle);
			NativeApplication.nativeApplication.removeEventListener(Event.USER_PRESENT, onAppPresent);
			NativeApplication.nativeApplication.removeEventListener(InvokeEvent.INVOKE, onAppInvoke);

			stage.removeEventListener(Event.RESIZE, onResize);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onPreventEsc);

			_module.shutDown();

			System.gc();
			setTimeout(System.gc, 500);
			setTimeout(System.gc, 1000);
			setTimeout(System.gc, 2000);
			setTimeout(System.gc, 4000);
			setTimeout(System.gc, 5000);
			setTimeout(System.gc, 10000);

			NativeApplication.nativeApplication.exit();
		}

		protected function createModule():IWiccaAirModule
		{
			return null;
		}

		protected function createAppSettings():WiccaSettings
		{
			return null;
		}
	}
}
