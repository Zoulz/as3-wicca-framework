/**
 * Copyright Pixelshift Interactive (c) 2014 All Right Reserved.
 * @author Zoulz
 */
package se.pixelshift.common.display
{
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import se.pixelshift.common.IDisposable;

	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class TouchInteractable extends Sprite implements IDisposable
	{
		protected var _displayObject:DisplayObject;

		private var _data:Object;
		private var _touch:Touch;
		private var _isOver:Boolean = false;
		private var _isMouseDown:Boolean = false;
		private var _useButtonCursor:Boolean = true;

		private var _click:Signal = new Signal(DisplayObject, Object);
		private var _mouseDown:Signal = new Signal(DisplayObject, Object);
		private var _mouseMove:Signal = new Signal(DisplayObject, Object);
		private var _out:Signal = new Signal(DisplayObject, Object);
		private var _over:Signal = new Signal(DisplayObject, Object);

		public function TouchInteractable(displayObject:DisplayObject, data:Object = null)
		{
			_data = data;

			_displayObject = displayObject;
			_displayObject.touchable = true;
			addChild(_displayObject);
		}

		private function onVisualTouch(event:TouchEvent):void
		{
			//  Detect if the mouse has left.
			var t:Vector.<Touch> = event.getTouches(_displayObject);
			if (t.length == 0 && _isOver == true)
			{
				_isOver = false;
				_out.dispatch(_displayObject, _data);
				Mouse.cursor = MouseCursor.ARROW;
				return;
			}

			//  Detect hovering over.
			_touch = event.getTouch(_displayObject, TouchPhase.HOVER);
			if (_touch != null && _isOver == false)
			{
				_isOver = true;
				_over.dispatch(_displayObject, _data);

				if (_useButtonCursor)
					Mouse.cursor = MouseCursor.BUTTON;
			}

			//  Detect mouse down.
			_touch = event.getTouch(_displayObject, TouchPhase.BEGAN);
			if (_touch != null && _isOver == true)
			{
				_mouseDown.dispatch(_displayObject, _data);
				_isMouseDown = true;
			}

			//  Detect movement while mouse is down.
			_touch = event.getTouch(_displayObject, TouchPhase.MOVED);
			if (_touch != null && _isMouseDown)
			{
				var mX:Number = _touch.previousGlobalX - _touch.globalX;
				var mY:Number = _touch.previousGlobalY - _touch.globalY;
				_mouseMove.dispatch(_displayObject, _data, _touch.getMovement(_displayObject));
			}

			//  Detect when a click has been completed.
			_touch = event.getTouch(_displayObject, TouchPhase.ENDED);
			if (_touch != null && _isOver == true)
			{
				_isOver = false;
				_isMouseDown = false;
				_click.dispatch(_displayObject, _data);
				Mouse.cursor = MouseCursor.ARROW;
			}
		}

		public function set interactable(interactable:Boolean):void
		{
			if (interactable)
			{
				if (!_displayObject.hasEventListener(TouchEvent.TOUCH))
					_displayObject.addEventListener(TouchEvent.TOUCH, onVisualTouch);
			}
			else
			{
				if (_displayObject.hasEventListener(TouchEvent.TOUCH))
					_displayObject.removeEventListener(TouchEvent.TOUCH, onVisualTouch);
			}
		}

		public function set useButtonCursor(value:Boolean):void
		{
			_useButtonCursor = value;
		}

		public function focus():void
		{
		}

		public function unfocus():void
		{
		}

		public function get mouseDown():ISignal
		{
			return _mouseDown;
		}

		public function get mouseMove():ISignal
		{
			return _mouseMove;
		}

		public function get click():ISignal
		{
			return _click;
		}

		public function get out():ISignal
		{
			return _out;
		}

		public function get over():ISignal
		{
			return _over;
		}

		public function get data():Object
		{
			return _data;
		}

		public function set data(value:Object):void
		{
			_data = value;
		}

		public function get displayObject():DisplayObject
		{
			return _displayObject;
		}

		override public function dispose():void
		{
			removeChild(_displayObject);

			interactable = false;

			_click.removeAll();
			_out.removeAll();
			_over.removeAll();
			_mouseDown.removeAll();
		}
	}
}
