/**
 * Copyright Pixelshift Interactive (c) 2014 All Right Reserved.
 * @author Zoulz
 */
package se.pixelshift.common.display
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import starling.utils.deg2rad;

	public class AlphaMap
	{
		private var _alphaData:Vector.<Vector.<Boolean>> = new <Vector.<Boolean>>[];
		private var _scaleFactor:Number = 0;

		/**
		 * Create alpha map based on bitmap data.
		 * @param bmp
		 * @param srcRect
		 * @param fuzziness
		 */
		public function fromBitmapData(bmp:BitmapData, srcRect:Rectangle = null, fuzziness:uint = 0, rotated:Boolean = false, scaleFactor:Number = 1):void
		{
			var tmpBmp:BitmapData;
			_alphaData.length = 0;
			_scaleFactor = scaleFactor;

			if (_scaleFactor != 1 || rotated)
			{
				tmpBmp = scaleAndRotateBitmap(bmp, _scaleFactor, rotated);
			}
			else
			{
				tmpBmp = bmp.clone();
			}

			if (srcRect == null)
			{
				srcRect = new Rectangle(0, 0, tmpBmp.width, tmpBmp.height);
			}

			for (var y:int = 0; y < srcRect.height; y++)
			{
				_alphaData.push(new Vector.<Boolean>());
				for (var x:int = 0; x < srcRect.width; x++)
				{
					var color:uint = tmpBmp.getPixel32(x, y);
					_alphaData[y].push(((color >> 24) & 0xFF) > fuzziness);
				}
			}

			tmpBmp.dispose();
		}

		private function scaleAndRotateBitmap(bmp:BitmapData, scaleFactor:Number, rotate:Boolean):BitmapData
		{
			var rect:Rectangle;
			if (rotate)
			{
				rect = new Rectangle(0, 0, bmp.height, bmp.width);
			}
			else
			{
				rect = new Rectangle(0, 0, bmp.width, bmp.height);
			}

			var ret:BitmapData = new BitmapData(Math.ceil(rect.width * scaleFactor), Math.ceil(rect.height * scaleFactor), true, 0x0);
			var mx:Matrix = new Matrix();
			if (rotate)
			{
				mx.rotate(deg2rad(-90));
				mx.translate(0, rect.height);
			}
			mx.scale(scaleFactor, scaleFactor);
			ret.draw(bmp, mx);
			return ret;
		}

		/**
		 * Creates a bitmap data object which displays the current alpha map in white against
		 * a opaque black background. Mostly for debug purposes.
		 * @return
		 */
		public function toBitmapData():BitmapData
		{
			var bmp:BitmapData = new BitmapData(_alphaData[0].length, _alphaData.length, false);
			for (var y:uint = 0; y < _alphaData.length; y++)
			{
				for (var x:uint = 0; x < _alphaData[y].length; x++)
				{
					if (_alphaData[y][x])
					{
						bmp.setPixel(x, y, 0xffffff);
					}
					else
					{
						bmp.setPixel(x, y, 0x000000);
					}
				}
			}
			return bmp;
		}

		/**
		 * Check point in alpha map.
		 * @param pt
		 * @return
		 */
		public function hitTest(pt:Point, useScaleFactor:Boolean = true):Boolean
		{
			if (useScaleFactor)
			{
				pt.x *= _scaleFactor;
				pt.y *= _scaleFactor;
			}

			return _alphaData[Math.floor(pt.y)][Math.floor(pt.x)];
		}
	}
}
