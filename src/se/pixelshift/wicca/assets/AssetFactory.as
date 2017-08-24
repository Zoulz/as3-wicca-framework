/**
 * Copyright Pixelshift Interactive (c) 2014 All Rights Reserved.
 * 2014-10-20 05:58
 * @author Zoulz
 */
package se.pixelshift.wicca.assets
{
	import com.childoftv.xlsxreader.XLSXLoader;

	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.system.System;

	import org.as3wavsound.WavSound;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import se.pixelshift.wicca.services.SoundService;
	import se.pixelshift.wicca.sound.SoundGroup;

	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public final class AssetFactory
	{
		public static const ASSET_CREATED:ISignal = new Signal();

		private static const _LOADER:Loader = new Loader();

		public static function disposeAsset(asset:*):void
		{
			if (asset is BitmapData)
			{
				BitmapData(asset).dispose();
			}
			else if (asset is SoundGroup)
			{
				SoundService.instance.unregisterGroup(asset);
				SoundGroup(asset).dispose();
			}
			else if (asset is BitmapFont)
			{
				BitmapFont(asset).dispose();
			}
			else if (asset is Texture)
			{
				Texture(asset).dispose();
			}
			else if (asset is TextureAtlas)
			{
				TextureAtlas(asset).dispose();
			}
			else if (asset is XML)
			{
				System.disposeXML(asset);
			}
			/*else if (asset is Sound)
			{
				Sound(asset).close();
			}*/
		}

		public static function createBitmapData(asset:Object):void
		{
			_LOADER.contentLoaderInfo.addEventListener(Event.INIT, onLoaderInit);
			_LOADER.loadBytes(asset.data);
		}

		public static function createCompressedTexture(asset:Object):void
		{
			var tx:Texture = Texture.fromAtfData(asset.data);
			Signal(ASSET_CREATED).dispatch(tx);
		}

		private static function onLoaderInit(event:Event):void
		{
			_LOADER.contentLoaderInfo.removeEventListener(Event.INIT, onLoaderInit);

			var bmp:BitmapData = new BitmapData(_LOADER.content.width, _LOADER.content.height, true, 0);
			bmp.draw(_LOADER.content);

			Signal(ASSET_CREATED).dispatch(bmp);
		}

		public static function createSoundFromMP3(asset:Object):void
		{
			var snd:Sound = new Sound();
			snd.loadCompressedDataFromByteArray(asset.data, asset.data.length);
			Signal(ASSET_CREATED).dispatch(snd);
		}

		public static function createSoundFromWav(asset:Object):void
		{
			var snd:WavSound = new WavSound(asset.data);
			Signal(ASSET_CREATED).dispatch(snd);
		}

		/*public static function createWic(asset:Object):void
		{
			var wic:WicFile = new WicFile();
			asset.data.position = 0;
			wic.read(asset.data);
			Signal(ASSET_CREATED).dispatch(wic);
		}*/

		public static function createXML(asset:Object):void
		{
			asset.data.position = 0;
			Signal(ASSET_CREATED).dispatch(new XML(asset.data.readUTFBytes(asset.data.length)));
		}

		public static function createXlsx(asset:Object):void
		{
			var loader:XLSXLoader = new XLSXLoader();
			loader.loadFromByteArray(asset.data);
			Signal(ASSET_CREATED).dispatch(loader);
		}

		public static function createString(asset:Object):void
		{
			asset.data.position = 0;
			Signal(ASSET_CREATED).dispatch(String(asset.data.readUTFBytes(asset.data.length)));
		}

		public static function createJson(asset:Object):void
		{
			asset.data.position = 0;
			Signal(ASSET_CREATED).dispatch(JSON.parse(asset.data.readUTFBytes(asset.data.length)));
		}
	}
}
