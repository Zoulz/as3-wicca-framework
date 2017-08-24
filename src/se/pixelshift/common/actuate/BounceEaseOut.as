/**
 * Copyright Pixelshift Interactive (c) 2015 All Rights Reserved.
 * 2015-07-22 21:35
 * @author ZoulzBig
 */
package se.pixelshift.common.actuate
{
	import com.eclecticdesignstudio.motion.easing.IEasing;

	public class BounceEaseOut implements IEasing
	{
		public function calculate(k:Number):Number
		{
			return BounceEaseOut.ease(k, 0, 1, 1);
		}

		public function ease(t:Number, b:Number, c:Number, d:Number):Number
		{
			return BounceEaseOut.ease(t, b, c, d);
		}

		public static function ease(t:Number, b:Number, c:Number, d:Number):Number
		{
			if ((t /= d) < (1 / 2.75))
			{
				return c * (7.5625 * t * t) + b;
			}
			else if (t < (2 / 2.75))
			{
				return c * (7.5625 * (t -= (1.5 / 2.75)) * t + 0.75) + b;
			}
			else if (t < (2.5 / 2.75))
			{
				return c * (7.5625 * (t -= (2.25 / 2.75)) * t + 0.9375) + b;
			}
			else
			{
				return c * (7.5625 * (t -= (2.625 / 2.75)) * t + 0.984375) + b;
			}
		}
	}
}
