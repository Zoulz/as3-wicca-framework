/**
 * Copyright Pixelshift Interactive (c) 2015 All Rights Reserved.
 * 2015-07-22 21:09
 * @author ZoulzBig
 */
package se.pixelshift.common.actuate
{
	import com.eclecticdesignstudio.motion.easing.IEasing;

	final public class Bounce
	{
		static public function get easeIn():IEasing { return new BounceEaseIn(); }
		static public function get easeOut():IEasing { return new BounceEaseOut(); }
		static public function get easeInOut():IEasing { return new BounceEaseInOut(); }
	}
}
