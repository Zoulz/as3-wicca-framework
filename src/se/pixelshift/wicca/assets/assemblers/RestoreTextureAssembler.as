/**
 * Created by Tomas Augustinovic on 2016-08-12.
 */
package se.pixelshift.wicca.assets.assemblers
{
	import flash.display.BitmapData;

	import se.pixelshift.wicca.assets.AssetURI;
	import se.pixelshift.wicca.assets.IAssetAssembler;
	import se.pixelshift.wicca.assets.AssetCategoryId;
	import se.pixelshift.wicca.services.AssetService;

	import starling.textures.Texture;

	public class RestoreTextureAssembler implements IAssetAssembler
	{
		public function RestoreTextureAssembler()
		{
		}

		public function assemble(groupId:String, assetId:String):void
		{
			var tex:Texture = AssetService.instance.getAsset(AssetURI.create(assetId, groupId, AssetCategoryId.TEXTURES));
			var bmp:BitmapData = AssetService.instance.getAsset(AssetURI.create(assetId, groupId, AssetCategoryId.BITMAPS));

			tex.root.uploadBitmapData(bmp);

			AssetService.instance.setAsset(AssetURI.create(assetId, groupId, AssetCategoryId.BITMAPS), null);
		}

		public function get resultCategoryId():String
		{
			return "";
		}
	}
}
