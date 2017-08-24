/**
 * Copyright Pixelshift Interactive (c) 2015 All Rights Reserved.
 * 2015-03-23 21:32
 * @author Zoulz
 */
package se.pixelshift.common.structs
{
	import se.pixelshift.common.*;
	import se.pixelshift.common.algorithm.prng.Dice;

	public class Span implements IStringify
	{
		private var _min:Number;
		private var _max:Number;

		public function Span(min:Number = 0, max:Number = 0)
		{
			_min = min;
			_max = max;
			checkValidity();
		}

		public static function fromArray(a:Array):Span
		{
			var ret:Span = new Span(parseFloat(a[0]), parseFloat(a[1]));
			return ret;
		}

		public static function fromString(s:String):Span
		{
			var split:Array = s.split("-");
			var ret:Span = Span.fromArray(split);
			return ret;
		}

		public static function fromObject(o:Object):Span
		{
			var ret:Span = new Span(parseFloat(o.min), parseFloat(o.max));
			return ret;
		}

		private function checkValidity():void
		{
			if (_min > _max && _max != 0)
				_min = _max;
		}

		public static function randomInString(s:String, decimals:uint = 0):Number
		{
			return Span.fromString(s).random(decimals);
		}

		public function toString():String
		{
			return _min.toString() + "-" + _max.toString();
		}

		public function toArray():Array
		{
			return [ _min, _max ];
		}

		public function toObject():Object
		{
			return { min: _min, max: _max };
		}

		public function get min():Number
		{
			return _min;
		}

		public function set min(value:Number):void
		{
			_min = value;
			checkValidity();
		}

		public function get max():Number
		{
			return _max;
		}

		public function set max(value:Number):void
		{
			_max = value;
			checkValidity();
		}

		public function random(decimals:uint = 0):Number
		{
			if (decimals == 0)
				return Dice.intRange(_min, _max);
			else
				return Dice.numberRange(_min, _max, decimals);
		}

		public function mult(span:Span):Span
		{
			_min *= span.min;
			_max *= span.max;
			return this;
		}

		public function add(span:Span):Span
		{
			_min += span.min;
			_max += span.max;
			return this;
		}

		public function sub(span:Span):Span
		{
			_min -= span.min;
			_max -= span.max;
			return this;
		}

		public function div(span:Span):Span
		{
			_min /= span.min;
			_max /= span.max;
			return this;
		}
	}
}
