/**
 * Quickspin
 * User: Tomas Augustinovic
 * Date: 2015-08-11
 * Time: 11:33
 */
package se.pixelshift.common.algorithm.prng
{
	import se.pixelshift.common.utils.MathUtil;

	public class Dice
	{
		private static var _rng:PM_PRNG = new PM_PRNG();

		public static function set seed(value:Number):void
		{
			_rng.seed = value;
		}

		public static function roll(sides:uint = 6):uint
		{
			return _rng.nextIntRange(1, sides);
		}

		public static function intRange(min:int, max:int):int
		{
			return _rng.nextIntRange(min, max);
		}

		public static function numberRange(min:Number, max:Number, decimals:uint = 0):Number
		{
			return MathUtil.round(_rng.nextDoubleRange(min, max), decimals);
		}

		public static function rollMany(num:uint, sides:uint = 6):Vector.<uint>
		{
			var ret:Vector.<uint> = new Vector.<uint>(num);
			for (var i:int = 0; i < num; i++)
			{
				ret[i] = roll(sides);
			}
			return ret;
		}

		public static function rollManyTotal(num:uint, sides:uint = 6):uint
		{
			var rolls:Vector.<uint> = rollMany(num, sides);
			var total:uint = 0;

			rolls.forEach(function(item:uint, index:int, vector:Vector.<uint>):void {
				total += item;
			});

			return total;
		}
	}
}
