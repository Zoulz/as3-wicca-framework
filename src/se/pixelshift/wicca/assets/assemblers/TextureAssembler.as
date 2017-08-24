/**
 * Copyright Pixelshift Interactive (c) 2015 All Rights Reserved.
 * 2015-07-20 22:37
 * @author ZoulzBig
 */
package se.pixelshift.wicca.assets.assemblers
{
	import flash.display.BitmapData;

	import se.pixelshift.common.display.AlphaMap;
	import se.pixelshift.wicca.assets.AssetURI;
	import se.pixelshift.wicca.assets.IAssetAssembler;
	import se.pixelshift.wicca.assets.AssetCategoryId;
	import se.pixelshift.wicca.services.AssetService;

	import starling.textures.Texture;

	public class TextureAssembler implements IAssetAssembler
	{
		private var _genAlphaMap:Boolean;
		private var _restoreFromFile:String;

		public function TextureAssembler(restoreFromFile:String, generateAlphaMap:Boolean = false)
		{
			_genAlphaMap = generateAlphaMap;
			_restoreFromFile = restoreFromFile;
		}

		public function assemble(groupId:String, assetId:String):void
		{
			var bmp:BitmapData = AssetService.instance.getAsset(AssetURI.create(assetId, groupId, AssetCategoryId.BITMAPS));
			var tex:Texture = Texture.fromBitmapData(bmp);
			var amap:AlphaMap;

			tex.root.onRestore = function():void
			{
				AssetService.instance.restoreLostAsset(_restoreFromFile, AssetURI.create(assetId, groupId, AssetCategoryId.BITMAPS), AssetCategoryId.TEXTURES);
			}

			if (_genAlphaMap)
			{
				amap = new AlphaMap();
				amap.fromBitmapData(bmp, bmp.rect);
			}

			//	Clean up.
			bmp.dispose();
			AssetService.instance.setAsset(AssetURI.create(assetId, groupId, AssetCategoryId.BITMAPS), null);

			//	Set new asset.
			AssetService.instance.setAsset(AssetURI.create(assetId, groupId, AssetCategoryId.TEXTURES), tex);
			if (amap != null)
			{
				AssetService.instance.setAsset(AssetURI.create(assetId, groupId, AssetCategoryId.ALPHAMAP), amap);
			}
		}

		public function get resultCategoryId():String
		{
			return AssetCategoryId.TEXTURES;
		}
	}
}
