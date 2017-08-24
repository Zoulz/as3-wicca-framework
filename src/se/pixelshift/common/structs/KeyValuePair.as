/**
 * Created by Zoulz on 2015-03-14.
 */
package se.pixelshift.common.structs
{
	public class KeyValuePair
	{
		private var _key:*;
		private var _value:*;

		public function KeyValuePair(key:*, value:*)
		{
			_key = key;
			_value = value;
		}

		public function get key():*
		{
			return _key;
		}

		public function set key(value:*):void
		{
			_key = value;
		}

		public function get value():*
		{
			return _value;
		}

		public function set value(value:*):void
		{
			_value = value;
		}
	}
}
