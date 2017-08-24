package se.pixelshift.common.utils
{
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;

	/**
	 * Utility class for manipulating and building displayObject filters.
	 * 
	 * @author tomas.augustinovic
	 */
	public final class FilterUtil
	{
		/**
		 * Creates a blur filter with the supplied paramaters.
		 * @param x Amount of horizontal blur factor.
		 * @param y Amount of vertical blur factor.
		 * @param quality How many times the blur will be applied.
		 * @return
		 */
		public static function createBlur(x:Number = 5, y:Number = 5, quality:int = 1):BlurFilter
		{
			return new BlurFilter(x, y, quality);
		}
		
		/**
		 * Creates a tint ColorMatrixFilter where each color component range from 0 (no color)
		 * to 1 (full color).
		 * @param r R-component.
		 * @param g G-component.
		 * @param b B-component.
		 * @param a A-component.
		 * @return
		 */
		public static function createTint(r:Number, g:Number, b:Number, a:Number = 1):ColorMatrixFilter
		{
			var m:Array = [];
			m = m.concat([ r, 0, 0, 0, 0 ]);
			m = m.concat([ 0, g, 0, 0, 0 ]);
			m = m.concat([ 0, 0, b, 0, 0 ]);
			m = m.concat([ 0, 0, 0, a, 0 ]);
			
			return new ColorMatrixFilter(m);
		}
		
		/**
		 * Creates a sepia ColorMatrixFilter.
		 * @return
		 */
		public static function createSepia():ColorMatrixFilter
		{
			return new ColorMatrixFilter([	0.3930000066757202, 0.7689999938011169, 0.1889999955892563, 0, 0, 
											0.3490000069141388, 0.6859999895095825, 0.1679999977350235, 0, 0, 
											0.2720000147819519, 0.5339999794960022, 0.1309999972581863, 0, 0, 
											0, 0, 0, 1, 0, 
											0, 0, 0, 0, 1]);
		}
		
		/**
		 * Creates a brightness ColorMatrixFilter which ranges from
		 * -100 (dark) to 100 (bright), where zero is the normal
		 * brightness.
		 * @param value Amount of brightness.
		 * @return
		 */
		public static function createBrightness(value:Number):ColorMatrixFilter
		{
			value = value * (255 / 250);
			
			var m:Array = [];
			m = m.concat([ 1, 0, 0, 0, value ]);
			m = m.concat([ 0, 1, 0, 0, value ]);
			m = m.concat([ 0, 0, 1, 0, value ]);
			m = m.concat([ 0, 0, 0, 1, 0     ]);
			
			return new ColorMatrixFilter(m);
		}
		
		/**
		 * Creates a contrast ColorMatrixFilter which ranges from
		 * -100 (no contrast) to 100 (full contrast), where zero is
		 * the normal contrast.
		 * @param value Amount of contrast.
		 * @return
		 */
		public static function createContrast(value:Number):ColorMatrixFilter
		{
			value /= 100;
			var s:Number = value + 1;
			var o:Number = 128 * (1 - s);
			
			var m:Array = [];
			m = m.concat([ s, 0, 0, 0, o ]);
			m = m.concat([ 0, s, 0, 0, o ]);
			m = m.concat([ 0, 0, s, 0, o ]);
			m = m.concat([ 0, 0, 0, 1, 0 ]);
			
			return new ColorMatrixFilter(m);
		}
		
		/**
		 * Creates a saturation ColorMatrixFilter which ranges from
		 * -100 (desaturated) to 100 (saturated), where zero is the
		 * normal saturation.
		 * @param value Amount of saturation.
		 * @return
		 */
		public static function createSaturation(value:Number):ColorMatrixFilter
		{
			const lumaR:Number = 0.212671;
			const lumaG:Number = 0.71516;
			const lumaB:Number = 0.072169;
			
			var v:Number = (value / 100) + 1;
			var i:Number = (1 - v);
			var r:Number = (i * lumaR);
			var g:Number = (i * lumaG);
			var b:Number = (i * lumaB);
			
			var m:Array = [];
			m = m.concat([ (r + v), g       , b       , 0, 0 ]);
			m = m.concat([ r      , (g + v) , b       , 0, 0 ]);
			m = m.concat([ r      , g       , (b + v) , 0, 0 ]);
			m = m.concat([ 0      , 0       , 0       , 1, 0 ]);
			
			return new ColorMatrixFilter(m);
		}
		
		/**
		 * Creates a identity ColorMatrixFilter.
		 * @return
		 */
		public static function createIdentity():ColorMatrixFilter
		{
			return new ColorMatrixFilter([	1, 0, 0, 0, 0,
											0, 1, 0, 0, 0, 
											0, 0, 1, 0, 0, 
											0, 0, 0, 1, 0,
											0, 0, 0, 0, 1 ]);
		}
	}
}
