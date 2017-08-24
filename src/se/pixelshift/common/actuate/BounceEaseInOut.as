/**
 * Copyright Pixelshift Interactive (c) 2015 All Rights Reserved.
 * 2015-07-22 21:36
 * @author ZoulzBig
 */
package se.pixelshift.common.actuate
{
	import com.eclecticdesignstudio.motion.easing.IEasing;

	public class BounceEaseInOut implements IEasing
	{
		public function calculate(k:Number):Number
		{
			if (k < 0.5)
			{
				return BounceEaseIn.ease(k * 2, 0, 1, 1) * 0.5;
			}
			else
			{
				return BounceEaseOut.ease(k * 2 - 1, 0, 1, 1) * 0.5 + 1 * 0.5;
			}
		}

		public function ease(t:Number, b:Number, c:Number, d:Number):Number
		{
			if (t < d / 2)
			{
				return BounceEaseIn.ease(t * 2, 0, c, d) * 0.5 + b;
			}
			else
			{
				return BounceEaseOut.ease(t * 2 - d, 0, c, d) * 0.5 + c * 0.5 + b;
			}
		}
	}
}
