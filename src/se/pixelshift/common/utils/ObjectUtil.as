package se.pixelshift.common.utils
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	/**
	 * Utility functions for the manipulation of objects.
	 * 
	 * @author tomas.augustinovic
	 */
	public final class ObjectUtil
	{
		/**
		 * Merge together two objects.
		 * @param obj1 First object to be merged
		 * @param obj2 Second object to be merged
		 * @return Object
		 */
		public static function mergeObjects(obj1:Object, obj2:Object):Object
		{
			var result:Object = { };
            var prop:String;
			
            for (prop in obj2)
			{
				result[prop] = obj2[prop];
            }
			
            for (prop in obj1)
			{
				result[prop] = obj1[prop];
            }
			
            return result;
		}

		public static function spliceElement(elem:*, arrayOrVector:Object):void
		{
			if (arrayOrVector.indexOf(elem) != -1)
				arrayOrVector.splice(arrayOrVector.indexOf(elem), 1);
		}

		public static function randomWeighted(a:Array):Object
		{
			var total:int = 0;
			var weights:Array = [ ];
			for each (var o:Object in a)
			{
				total += o.weight;
				weights.push(o.weight);
			}

			var rand:int = MathUtil.randomRange(0, total);
			for (var i:int = 0; i < weights.length; i++)
			{
				rand -= weights[i];
				if (rand <= 0)
					break;
			}

			return a[i];
		}

		public static function similarArrayElements(a1:Array, a2:Array):Array
		{
			var ret:Array = [ ];
			for each (var val1:* in a1)
			{
				for each (var val2:* in a2)
				{
					if (val1 == val2)
						ret.push(val1);
				}
			}

			return ret;
		}

		/**
		 * Loops over a iterable of objects and checks if a given property exists and is equal to
		 * a specified value.
		 * @param iterable
		 * @param prop
		 * @param value
		 * @return
		 */
		public static function iterableObjectProperty(iterable:*, prop:String, value:*):Boolean
		{
			if (iterable is Object || iterable is Array || isVector(iterable) || iterable is Dictionary)
			{
				for each (var elem:* in iterable)
				{
					if (elem[prop] == value)
						return true;
				}
			}
			return false;
		}

		public static function compareArrays(arr:Array, arr2:Array):Array
		{
			var ret:Array = [ ];
			var i:*;
			for each (i in arr)
			{
				if (arr2.indexOf(i) != -1 && ret.indexOf(i) == -1)
					ret.push(i);
			}

			for each (i in arr2)
			{
				if (arr.indexOf(i) != -1 && ret.indexOf(i) == -1)
					ret.push(i);
			}

			return ret;
		}

		public static function addToArrayElements(a:Array, num:int):Array
		{
			for (var i:int = 0; i < a.length; i++)
			{
				var n:int = parseInt(a[i]) + num;
				a[i] = n;
			}
			return a;
		}

		/**
		 * Convert a iterable object into a array.
		 * @param iterable Object that can be iterated, like: Vector, Dictionary, Object
		 * @return Array
		 */		
		public static function toArray(iterable:*):Array
		{
			var ret:Array = [];
			
			if (iterable is Object || iterable is Array || isVector(iterable) || iterable is Dictionary)
			{
				for each (var elem:* in iterable)
				{
					ret.push(elem);
				}
			}
			
			return ret;
		}

		/**
		 * Covert a iterable into a vector of your choosing.
		 * @param iterable Object that can be iterated, like: Array, Dictionary, Object
		 * @param vec Type of vector class to convert to.
		 * @return Vector
		 */
		public static function toVector(iterable:*, vec:*):*
		{
			var ret:* = new vec();
			if (iterable is Object || iterable is Array || iterable is Dictionary)
			{
				for each (var elem:* in iterable)
				{
					ret.push(elem);
				}
			}
			return ret;
		}

		/**
		 * Create a string list containing all the properties of the supplied object.
		 * @param obj
		 * @return
		 */
		public static function toString(obj:Object):String
		{
			var ret:Vector.<String> = new <String>[];
			for (var elem:* in obj)
			{
				ret.push(elem + "=" + obj[elem]);
			}
			return ret.join(", ");
		}
		
		/**
		 * Return a random index in a index-based iterable object (Array, Vector). A list of
		 * index exceptions can be supplied and will be ignored.
		 * @param iterable Iterable object to get random index from
		 * @param exceptions List of index exceptions to take into account for randomization
		 * @return uint
 		 */
		public static function getRandomIndex(iterable:*, exceptions:Vector.<uint> = null):uint
		{
			var rnd:uint = 0;
			
			if (iterable is Array || isVector(iterable))
			{
				while (true)
				{
					rnd = MathUtil.randomRange(0, iterable.length - 1);
					
					if (exceptions == null || exceptions.indexOf(rnd) == -1)
					{
						break;
					}
				}
			}
			
			return rnd;
		}
		
		/**
		 * Create a clone of the supplied object.
		 * @param source Object to clone
		 * @return Object
		 */
		public static function clone(source:Object):Object
		{
			var copier:ByteArray = new ByteArray();
			copier.writeObject(source);
			copier.position = 0;
			
			return copier.readObject();
		}

		/**
		 * Randomize the order of elements inside array or vector.
		 * @param arrayOrVector Array or Vector collection to use.
		 */
		public static function shuffle(arrayOrVector:Object):void
		{
			var n:int = arrayOrVector.length;
			var i:int = n;

			while (i--)
			{
				var randomIndex:int = int(Math.random() * n);
				var toMove:Object = arrayOrVector[i];
				arrayOrVector[i] = arrayOrVector[randomIndex];
				arrayOrVector[randomIndex] = toMove;
			}
		}

		public static function rotate(arrayOrVector:Object, rotation:int):Object
		{
			var n:int = arrayOrVector.length;

			rotation %= n;

			if (rotation < 0) rotation += n;

			arrayOrVector = arrayOrVector.concat(arrayOrVector.splice(0, rotation));

			return arrayOrVector;
		}

		/**
		 * Removes any duplicate elements from array or vector.
		 * @param arrayOrVector Array or Vector collection to use.
		 */
		public static function removeDuplicates(arrayOrVector:Object):Object
		{
			var result:Object = new arrayOrVector.constructor;
			var length:int = 0;

			var n:int = arrayOrVector.length;
			for (var i:int = 0; i < n; i++)
			{
				if (result.indexOf(arrayOrVector[i]) == -1)
				{
					result[length] = arrayOrVector[i];
					length++
				}
			}

			return result;
		}

		/**
		 * Return the length of a dictionary (number of items).
		 * @param dict Target dictionary.
		 * @return
		 */
		public static function dictionaryLength(dict:Dictionary):uint
		{
			var n:uint = 0;
			for (var key:* in dict)
			{
				n++;
			}
			return n;
		}

		public static function dictionaryHasValue(dict:Dictionary, value:*):*
		{
			for (var val:Object in dict)
			{
				if (dict[val] == value)
				{
					return val;
				}
			}

			return null;
		}

		public static function dictionaryHasKey(dict:Dictionary, key:*):*
		{
			for (var val:Object in dict)
			{
				if (val == key)
				{
					return dict[val];
				}
			}

			return null;
		}

		public static function dictionaryKeys(dict:Dictionary):Array
		{
			var ret:Array = [ ];
			for (var val:Object in dict)
			{
				ret.push(val as String);
			}
			return ret;
		}

		public static function isVector(vect:*):Boolean
		{
			return (getQualifiedClassName(vect).indexOf('__AS3__.vec::Vector') == 0);
		}
	}
}
