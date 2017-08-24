/**
 * Created by tomas.augustinovic on 2017-04-27.
 */
package se.pixelshift.common.structs
{
	import flash.utils.Dictionary;

	import se.pixelshift.common.errors.KeyValueMapError;
	import se.pixelshift.common.utils.ObjectUtil;

	public class KeyValueMap
	{
		private var _map:Dictionary = new Dictionary();
		private var _staticKeys:Boolean;

		public static const EMPTY:String = "__EMPTY__";

		public function KeyValueMap(useStaticKeys:Boolean = false, keys:Array = null)
		{
			_staticKeys = useStaticKeys;
			if (_staticKeys && keys != null)
			{
				for each (var key:String in keys)
				{
					_map[key] = KeyValueMap.EMPTY;
				}
			}
		}

		public function get(key:String):*
		{
			if (_staticKeys && _map[key] != null)
				return _map[key];
			else if (!_staticKeys)
			{
				if (_map[key] != null)
					return _map[key];
				else
					return KeyValueMap.EMPTY;
			}
			else
				throw new KeyValueMapError("Key does not exist.");
		}

		public function set(key:String, value:*):void
		{
			if (_staticKeys && _map[key] != null)
				_map[key] = value;
			else if (!_staticKeys)
			{
				if (_map[key] != null)
					_map[key] = value;
				else
					_map[key] = value;
			}
			else
				throw new KeyValueMapError("Key does not exist.");
		}

		public function get keys():Array
		{
			return ObjectUtil.dictionaryKeys(_map);
		}
	}
}
