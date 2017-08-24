/**
 * Pixelshift Interactive
 * 2016-08-23
 * ---------------------------------------------------------------------
 * @author tomas.augustinovic
 */
package se.pixelshift.wicca.assets
{
	import se.pixelshift.wicca.services.AssetService;

	import starling.textures.TextureAtlas;

	public class AssetUtil
	{
		public static function getTextureAtlas(idAndGroup:String, index:int = 0):TextureAtlas
		{
			return AssetService.instance.getAsset(AssetURI.create(idAndGroup + "_" + index.toString(), idAndGroup, AssetCategoryId.ATLAS));
		}
	}
}
