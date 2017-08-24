/**
 * Copyright Pixelshift Interactive (c) 2015 All Rights Reserved.
 * 2015-07-20 21:29
 * @author ZoulzBig
 */
package se.pixelshift.wicca.assets.assemblers
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.System;

	import se.pixelshift.common.display.AlphaMap;
	import se.pixelshift.wicca.assets.AssetURI;
	import se.pixelshift.wicca.assets.IAssetAssembler;
	import se.pixelshift.wicca.assets.AssetCategoryId;
	import se.pixelshift.wicca.services.AssetService;

	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class TextureAtlasAssembler implements IAssetAssembler
	{
		private var _genAlphaMap:Boolean;
		private var _alphaMapRegionNames:Vector.<String>;
		private var _alphaMapScaleFactor:Number = 1;
		private var _restoreFromFile:String;

		public function TextureAtlasAssembler(restoreFromFile:String, generateAlphaMaps:Boolean = false, alphaMapRegionNames:Vector.<String> = null, alphaMapScaleFactor:Number = 1)
		{
			_alphaMapScaleFactor = alphaMapScaleFactor;
			_genAlphaMap = generateAlphaMaps;
			_alphaMapRegionNames = alphaMapRegionNames;
			_restoreFromFile = restoreFromFile;
		}

		public function assemble(groupId:String, assetId:String):void
		{
			var bmp:BitmapData = AssetService.instance.getAsset(AssetURI.create(assetId, groupId, AssetCategoryId.BITMAPS));
			var xml:XML = AssetService.instance.getAsset(AssetURI.create(assetId, groupId, AssetCategoryId.META));
			var tex:Texture = Texture.fromBitmapData(bmp);
			var atlas:TextureAtlas = new TextureAtlas(tex, xml);
			var amap:AlphaMap;

			tex.root.onRestore = function():void
			{
				AssetService.instance.restoreLostAsset(_restoreFromFile, AssetURI.create(assetId, groupId, AssetCategoryId.BITMAPS), AssetCategoryId.ATLAS);
			}

			//	Create alpha map.
			if (_genAlphaMap && _alphaMapRegionNames != null)
			{
				for each (var region:String in _alphaMapRegionNames)
				{
					//  TODO Can't handle trimmed spritesheets unfortunately. :/
					var rectRegion:Rectangle = atlas.getRegion(region);
					var regionBmp:BitmapData = new BitmapData(rectRegion.width, rectRegion.height, true, 0x0);
					regionBmp.copyPixels(bmp, rectRegion, new Point(0, 0));

					amap = new AlphaMap();
					amap.fromBitmapData(regionBmp, null, 0, atlas.getRotation(region), _alphaMapScaleFactor);

					AssetService.instance.setAsset(AssetURI.create(assetId + "_" + region, groupId, AssetCategoryId.ALPHAMAP), amap);
				}
			}

			//	Clean up.
			bmp.dispose();
			System.disposeXML(xml);
			AssetService.instance.setAsset(AssetURI.create(assetId, groupId, AssetCategoryId.BITMAPS), null);
			AssetService.instance.setAsset(AssetURI.create(assetId, groupId, AssetCategoryId.META), null);

			//	Set new asset.
			AssetService.instance.setAsset(AssetURI.create(assetId, groupId, AssetCategoryId.ATLAS), atlas);
		}

		public function get resultCategoryId():String
		{
			return AssetCategoryId.ATLAS;
		}
	}
}
