/**
 * Copyright Pixelshift Interactive (c) 2014 All Rights Reserved.
 * 2014-11-01 06:35
 * @author Zoulz
 */
package se.pixelshift.wicca.assets
{
	public final class AssetURI
	{
		public static function create(id:String, group:String, category:String = null):String
		{
			if (category != null)
			{
				return [ id, group, category ].join(".");
			}
			else
			{
				return [ id, group ].join(".");
			}
		}

		public static function extractWicGroup(uri:String):String
		{
			var parts:Array = uri.split(".");
			return [ parts[1], parts[2] ].join(".");
		}

		public static function extractId(uri:String):String
		{
			var parts:Array = uri.split(".");
			return parts[0];
		}

		public static function extractGroupId(uri:String):String
		{
			var parts:Array = uri.split(".");
			return parts[1];
		}

		public static function extractCategoryId(uri:String):String
		{
			var parts:Array = uri.split(".");
			return parts[2];
		}
	}
}
