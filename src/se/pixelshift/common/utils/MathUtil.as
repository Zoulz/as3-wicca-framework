package se.pixelshift.common.utils
{
	import flash.geom.Point;

	/**
	 * Collection of math-related static functions.
	 * 
	 * @author tomas.augustinovic
	 */
	public final class MathUtil
	{
		public static const EPSILON:Number = 0.0000000000001;
		public static const EPSILON_SQR:Number = EPSILON * EPSILON;
		public static const RADIANS_TO_DEGREES:Number = 180 / Math.PI;
		public static const DEGREES_TO_RADIANS:Number = Math.PI / 180;

		public static function abs(val:Number):Number
		{
			return val < 0 ? -val : val;
		}

		public static function round(val:Number, nrOfDecimals:uint = 0):Number
		{
			if (nrOfDecimals == 0)
			{
				return val < 0 ? int(val - 0.5) : int(val + 0.5);
			}
			else
			{
				var factor10:Number = power10(nrOfDecimals);

				val *= factor10;

				val = val < 0 ? int(val - 0.5) : int(val + 0.5);

				return val / factor10;
			}
		}

		public static function floor(val:Number):Number
		{
			return val != val ? NaN : ( val == int(val) ? val : val < 0 ? int(val - 1) : int(val) );
		}

		public static function ceil(val:Number):Number
		{
			return val != val ? NaN : ( val == int(val) ? val : val < 0 ? int(val) : int(val + 1) );
		}

		public static function constrain(val:Number, minLimit:Number, maxLimit:Number):Number
		{
			val = val > minLimit ? val : minLimit;
			val = val < maxLimit ? val : maxLimit;

			return val;
		}

		public static function isWithin(val:Number, minLimit:Number, maxLimit:Number):Boolean
		{
			return (val >= minLimit && val <= maxLimit);
		}

		public static function modulo(val:Number, modVal:Number, offset:Number = 0):Number
		{
			val -= offset;

			return ((modVal + (val % modVal)) % modVal) + offset;
		}

		public static function power10(exp:int):Number
		{
			if (exp < -10 || exp > 10)
			{
				throw new Error("Exponent must be an integer between -10 and 10");
			}

			switch (exp)
			{
				case -10:
					return 0.0000000001;
				case -9:
					return 0.000000001;
				case -8:
					return 0.00000001;
				case -7:
					return 0.0000001;
				case -6:
					return 0.000001;
				case -5:
					return 0.00001;
				case -4:
					return 0.0001;
				case -3:
					return 0.001;
				case -2:
					return 0.01;
				case -1:
					return 0.1;
				case 0:
					return 1;
				case 1:
					return 10;
				case 2:
					return 100;
				case 3:
					return 1000;
				case 4:
					return 10000;
				case 5:
					return 100000;
				case 6:
					return 1000000;
				case 7:
					return 10000000;
				case 8:
					return 100000000;
				case 9:
					return 1000000000;
				case 10:
					return 10000000000;
				default:
					return NaN;
			}
		}
		
		/**
		 * Returns true if the supplied number is even.
		 * 
		 * @param num Number to check.
		 */
		public static function isEven(num:Number):Boolean
		{
			return (num & 1) == 0;
		}
		
		/**
		 * Return the hexadecimal value of a integer color value.
		 * @param color The integer value to convert.
		 * @return Hexadecimal color value as a string.
		 */
		public static function hexColor(color:int):String
		{
			return "#" + color.toString(16);
		}
		
		/**
		 * Linear interpolation between two points.
		 * @param p1 Point one.
		 * @param p2 Point two.
		 * @param delta Delta point to get (0-1).
		 * @return Resulting point.
		 */
		public static function lerpPoint(p1:Point, p2:Point, delta:Number):Point
		{
			var ret:Point = new Point();
			ret.x = delta * (p1.x - p2.x) + p2.x;
			ret.y = delta * (p1.y - p2.y) + p2.y;
			
			return ret;
		}

		public static function invertPoint(p:Point):void
		{
			p.x = -p.x;
			p.y = -p.y;
		}

		public static function vector2D(angle:Number, length:Number):Point
		{
			return new Point(Math.cos(angle) * length, Math.sin(angle) * length);
		}

		public static function getAngle(x:Number, y:Number):Number
		{
			return Math.atan2(y, x) * RADIANS_TO_DEGREES;
		}

		public static function rotatePoint(point:Point, angle:Number):Point
		{
			var newPoint:Point = new Point();

			newPoint.x = (point.x * Math.cos(angle)) - (point.y * Math.sin(angle));
			newPoint.y = Math.sin(angle) * point.x + Math.cos(angle) * point.y;

			return newPoint;
		}

		public static function rotatePointAroundOrigin(point:Point, origin:Point, angle:Number):Point
		{
			var newPoint:Point = new Point();

			point.x -= origin.x;
			point.y -= origin.y;
			newPoint.x = (point.x * Math.cos(angle)) - (point.y * Math.sin(angle));
			newPoint.y = Math.sin(angle) * point.x + Math.cos(angle) * point.y;
			newPoint.x += origin.x;
			newPoint.y += origin.y;

			return newPoint;
		}

		public static function randomRange(min:Number, max:Number, nrOfDecimals:int = 0):Number
		{
			var returnVal:Number;

			if (nrOfDecimals == 0)
			{
				returnVal = floor(Math.random() * (max - min + 1)) + min;
			}
			else
			{
				var randomVal:Number = Math.random() * (max - min + power10(-nrOfDecimals)) + min;

				returnVal = floor(randomVal * power10(nrOfDecimals)) / power10(nrOfDecimals);
			}

			return returnVal;
		}

		public static function randomSpan(span:Number, centerVal:Number = 0, nrOfDecimals:int = 0):Number
		{
			return randomRange(centerVal - span * 0.5, centerVal + span * 0.5, nrOfDecimals);
		}

		public static function random(max:Number, nrOfDecimals:int = 0):Number
		{
			return randomRange(0, max, nrOfDecimals);
		}

		public static function randomWeighted(weightValues:Vector.<Number>):int
		{
			// Calculate sum and populate array to sort
			var sum:Number = 0;
			var sortedArray:Array = [];

			var n:int = weightValues.length;
			for (var i:int = 0; i < n; i++)
			{
				sortedArray[i] = {index: i, val: weightValues[i]};

				sum += weightValues[i];
			}

			sortedArray.sortOn("val", Array.NUMERIC);

			// Get random
			var rand:Number = Math.random() * sum;

			// Find value matching random value
			var currentSum:Number = 0;
			for (i = 0; i < n; i++)
			{
				var obj:Object = Object(sortedArray[i]);
				currentSum += obj.val;
				if (rand < currentSum) return obj.index;
			}

			return -1;
		}

		public static function randomColor():uint
		{
			return Math.random() * 0xFFFFFF;
		}

		public static function randomBoolean():Boolean
		{
			return Math.random() < 0.5;
		}

		public static function randomBit():int
		{
			return (Math.random() < 0.5) ? 0 : 1;
		}

		public static function randomSign():int
		{
			return (Math.random() < 0.5) ? -1 : 1;
		}

		public static function valueInRangeByPercent(min:Number, max:Number, percent:Number):Number
		{
			var returnVal:Number = min + (max - min) * percent;

			return returnVal;
		}

		public static function hsvToRgb(hue:Number = 0, saturation:Number = 1, lightness:Number = 0.5, alpha:Number = 1):uint
		{
			// Constrain parameters to (0 <= value <= 1)
			saturation = saturation < 0 ? 0 : saturation > 1 ? 1 : saturation;
			lightness = lightness < 0 ? 0 : lightness > 1 ? 1 : lightness;
			alpha = alpha < 0 ? 0 : alpha > 1 ? 1 : alpha;

			// Constrain and convert hue to (0 <= hue < 6)
			hue = hue % 360;
			if (hue < 0) hue += 360;
			hue /= 60;

			var C:Number = (1 - abs(2 * lightness - 1)) * saturation;
			var X:Number = C * (1 - abs((hue % 2) - 1));
			var m:Number = lightness - 0.5 * C;
			C = (C + m) * 255;
			X = (X + m) * 255;
			m *= 255;

			if (hue < 1)	return (round(alpha * 255) << 24) + (C << 16) + (X << 8) + m;
			if (hue < 2)	return (round(alpha * 255) << 24) + (X << 16) + (C << 8) + m;
			if (hue < 3)	return (round(alpha * 255) << 24) + (m << 16) + (C << 8) + X;
			if (hue < 4)	return (round(alpha * 255) << 24) + (m << 16) + (X << 8) + C;
			if (hue < 5)	return (round(alpha * 255) << 24) + (X << 16) + (m << 8) + C;
			/* hue < 6 */	return (round(alpha * 255) << 24) + (C << 16) + (m << 8) + X;
		}
	}
}
