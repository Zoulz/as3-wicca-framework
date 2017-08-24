/**
 * Pixelshift Interactive
 * 2016-08-12
 * ---------------------------------------------------------------------
 * @author tomas.augustinovic
 */
package se.pixelshift.wicca.assets.assemblers
{
	import flash.display.BitmapData;

	import se.pixelshift.wicca.assets.AssetURI;
	import se.pixelshift.wicca.assets.IAssetAssembler;
	import se.pixelshift.wicca.assets.AssetCategoryId;
	import se.pixelshift.wicca.services.AssetService;

	import starling.text.BitmapFont;

	public class RestoreBitmapFontAssembler implements IAssetAssembler
	{
		public function RestoreBitmapFontAssembler()
		{
		}

		public function assemble(groupId:String, assetId:String):void
		{
			var tex:BitmapFont = AssetService.instance.getAsset(AssetURI.create(assetId, groupId, AssetCategoryId.FONTS));
			var bmp:BitmapData = AssetService.instance.getAsset(AssetURI.create(assetId, groupId, AssetCategoryId.BITMAPS));

			tex.texture.root.uploadBitmapData(bmp);

			AssetService.instance.setAsset(AssetURI.create(assetId, groupId, AssetCategoryId.BITMAPS), null);
		}

		public function get resultCategoryId():String
		{
			return "";
		}
	}
}
