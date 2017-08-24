/**
 * Copyright Pixelshift Interactive (c) 2015 All Rights Reserved.
 * 2015-07-01 21:00
 * @author ZoulzBig
 */
package se.pixelshift.common.display
{
	public class AspectRatio
	{
		public static const Ratio_4_3:AspectRatio = new AspectRatio("AspectRatio_4:3", 4 / 3);
		public static const Ratio_16_9:AspectRatio = new AspectRatio("AspectRatio_16:9", 16 / 9);
		public static const Ratio_16_10:AspectRatio = new AspectRatio("AspectRatio_16:10", 16 / 10);
		public static const Ratio_3_2:AspectRatio = new AspectRatio("AspectRatio_3:2", 3 / 2);
		public static const Ratio_5_3:AspectRatio = new AspectRatio("AspectRatio_5:3", 5 / 3);
		public static const Ratio_128_69:AspectRatio = new AspectRatio("AspectRatio_128:69", 128 / 69);
		public static var Ratio_Custom:AspectRatio = new AspectRatio("AspectRatio_Custom", 1);

		private var _id:String;
		private var _factor:Number;

		public function AspectRatio(id:String, factor:Number)
		{
			_id = id;
			_factor = factor;
		}

		public function getFactor():Number
		{
			return _factor;
		}

		public function toString():String
		{
			return _id;
		}

		public function isUltraWide():Boolean
		{
			return getFactor() > AspectRatio.Ratio_16_9.getFactor();
		}

		public static function calculate(width:int, height:int):AspectRatio
		{
			if (4 * height == 3 * width)
				return Ratio_4_3;
			if (16 * height == 9 * width)
				return Ratio_16_9;
			if (683 * height == 384 * width) // close to 16:9 - 1366x768 (683:384)
				return Ratio_16_9;
			if (71 * height == 40 * width) // close to 16:9 - 1136x640 (71:40)
				return Ratio_16_9;
			if (569 * height == 320 * width) // close to 16:9 - 1138x640 (569:320)
				return Ratio_16_9;
			if (427 * height == 240 * width) // close to 16:9 - 854x480 (427:240)
				return Ratio_16_9;
			if (667 * height == 375 * width) // close to 16:9 - 1334x750 (667:375)
				return Ratio_16_9;
			if (16 * height == 10 * width)
				return Ratio_16_10;
			if (3 * height == 2 * width)
				return Ratio_3_2;
			if (5 * height == 3 * width)
				return Ratio_5_3;
			if (128 * height == 69 * width) // 1024x552 - ultrawide
				return Ratio_128_69;

			AspectRatio.Ratio_Custom = new AspectRatio("AspectRatio_Custom", width / height);

			return AspectRatio.Ratio_Custom;
		}
	}
}
