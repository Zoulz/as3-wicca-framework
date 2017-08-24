/**
 * Copyright Pixelshift Interactive (c) 2014 All Rights Reserved.
 * 2014-11-01 05:55
 * @author Zoulz
 */
package se.pixelshift.wicca.assets
{
	/**
	 * Categories of assets refer to what type of asset it is. This is actually a extension of the group name.
	 */
	public class AssetCategoryId
	{
		//	These are RAW categories, meaning they are usually loaded and then assembled into the final asset.
		public static const BITMAPS:String = "bitmaps";
		public static const META:String = "meta";
		public static const SOUNDS:String = "sounds";

		//	These are ASSEMBLED categories and are usually the result of one or more RAW assets.
		public static const TEXTURES:String = "textures";
		public static const ATLAS:String = "atlas";
		public static const FONTS:String = "fonts";
		public static const SOUNDGROUP:String = "soundgroup";
		public static const ALPHAMAP:String = "alphamap";
	}
}
