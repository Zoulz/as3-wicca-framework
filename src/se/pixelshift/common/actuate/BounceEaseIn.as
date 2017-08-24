/**
 * Copyright Pixelshift Interactive (c) 2015 All Rights Reserved.
 * 2015-07-22 21:34
 * @author ZoulzBig
 */
package se.pixelshift.common.actuate
{
	import com.eclecticdesignstudio.motion.easing.IEasing;

	final public class BounceEaseIn implements IEasing
	{
		public function calculate(k:Number):Number
		{
			return BounceEaseIn.ease(k, 0, 1, 1);
		}

		public function ease(t:Number, b:Number, c:Number, d:Number):Number
		{
			return BounceEaseIn.ease(t, b, c, d);
		}

		public static function ease(t:Number, b:Number, c:Number, d:Number):Number
		{
			return c - BounceEaseOut.ease(d - t, 0, c, d) + b;
		}
	}
}
