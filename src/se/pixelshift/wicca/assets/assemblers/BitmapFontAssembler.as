/**
 * Copyright Pixelshift Interactive (c) 2015 All Rights Reserved.
 * 2015-07-20 22:41
 * @author ZoulzBig
 */
package se.pixelshift.wicca.assets.assemblers
{
	import flash.display.BitmapData;
	import flash.system.System;

	import se.pixelshift.wicca.assets.AssetURI;
	import se.pixelshift.wicca.assets.IAssetAssembler;
	import se.pixelshift.wicca.assets.AssetCategoryId;
	import se.pixelshift.wicca.services.AssetService;

	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;

	public class BitmapFontAssembler implements IAssetAssembler
	{
		private var _restoreFromFile:String;

		public function BitmapFontAssembler(restoreFromFile:String)
		{
			_restoreFromFile = restoreFromFile;
		}

		public function assemble(groupId:String, assetId:String):void
		{
			var bmp:BitmapData = AssetService.instance.getAsset(AssetURI.create(assetId, groupId, AssetCategoryId.BITMAPS));
			var xml:XML = AssetService.instance.getAsset(AssetURI.create(assetId, groupId, AssetCategoryId.META));
			var tex:Texture = Texture.fromBitmapData(bmp);
			var font:BitmapFont = new BitmapFont(tex, xml);

			tex.root.onRestore = function():void
			{
				AssetService.instance.restoreLostAsset(_restoreFromFile, AssetURI.create(assetId, groupId, AssetCategoryId.BITMAPS), AssetCategoryId.FONTS);
			}

			//	Clean up.
			bmp.dispose();
			System.disposeXML(xml);
			AssetService.instance.setAsset(AssetURI.create(assetId, groupId, AssetCategoryId.BITMAPS), null);
			AssetService.instance.setAsset(AssetURI.create(assetId, groupId, AssetCategoryId.META), null);

			TextField.registerCompositor(font, assetId);

			//	Set new asset.
			AssetService.instance.setAsset(AssetURI.create(assetId, groupId + "." + AssetCategoryId.FONTS), font);
		}

		public function get resultCategoryId():String
		{
			return AssetCategoryId.FONTS;
		}
	}
}
