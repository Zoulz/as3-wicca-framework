/**
 * Pixelshift Interactive
 * 2017-01-24
 * ---------------------------------------------------------------------
 * @author tomas.augustinovic
 */
package se.pixelshift.wicca.packages.wicloader.controller
{
	import deng.fzip.FZip;
	import deng.fzip.FZipErrorEvent;
	import deng.fzip.FZipEvent;
	import deng.fzip.FZipFile;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;

	import mvcexpress.mvc.PooledCommand;

	import se.pixelshift.wicca.assets.AssetFactory;
	import se.pixelshift.wicca.assets.AssetURI;
	import se.pixelshift.wicca.packages.wicloader.consts.WicLoaderMsg;
	import se.pixelshift.wicca.services.AssetService;

	public class LoadWicFileCmd extends PooledCommand
	{
		private var _fZip:FZip;
		private var _curManifestItemIndex:int;
		private var _manifest:Object;

		public function execute(fileName:String):void
		{
			lock();

			_fZip = new FZip();
			_fZip.addEventListener(FZipEvent.FILE_LOADED, onFileZipLoaded);
			_fZip.addEventListener(FZipErrorEvent.PARSE_ERROR, onParseZipError);
			_fZip.addEventListener(Event.OPEN, onStart);
			_fZip.addEventListener(Event.COMPLETE, onComplete);
			_fZip.addEventListener(ProgressEvent.PROGRESS, onProgress);
			_fZip.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_fZip.load(new URLRequest(fileName));
		}

		private function parseManifest(manifest:Object):void
		{
			_manifest = manifest;
			_curManifestItemIndex = 0;
			createNextAsset();
		}

		private function createNextAsset():void
		{
			if (_manifest.length > 0)
			{
				AssetFactory.ASSET_CREATED.addOnce(onAssetCreated);

				var item:Object = _manifest[_curManifestItemIndex];
				item.data = _fZip.getFileByName(item.filename).content;

				createAssetItem(item);
			}
			else
			{
				sendMessage(WicLoaderMsg.FILE_COMPLETE);

				assetsCreated();
			}
		}

		private function assetsCreated():void
		{
			trace("all assets created");

			_fZip.close();

			sendMessage(WicLoaderMsg.NEXT_WIC_FILE);

			unlock();
		}

		private function createAssetItem(item:Object):Boolean
		{
			trace("creating asset " + item.type);
			switch (item.type)
			{
				case "JPG":
				case "PNG":
				{
					AssetFactory.createBitmapData(item);
					return true;
				}
				case "ATF":
				{
					AssetFactory.createCompressedTexture(item);
					return true;
				}
				case "MP3":
				{
					AssetFactory.createSoundFromMP3(item);
					return true;
				}
				case "WAV":
				{
					AssetFactory.createSoundFromWav(item);
					return true;
				}
				case "XML":
				{
					AssetFactory.createXML(item);
					return true;
				}
				case "XLSX":
				{
					AssetFactory.createXlsx(item);
					return true;
				}
				case "JSON":
				{
					AssetFactory.createJson(item);
					return true;
				}
				case "TXT":
				{
					AssetFactory.createString(item);
					return true;
				}
			}

			return false;
		}

		private function onAssetCreated(resource:*):void
		{
			trace("asset created");
			var item:Object = _manifest[_curManifestItemIndex];
			AssetService.instance.setAsset(AssetURI.create(item.id, item.group, item.category), resource);

			_curManifestItemIndex++;
			if (_curManifestItemIndex < _manifest.length)
				createNextAsset();
			else
				assetsCreated();
		}

		private function onIOError(event:IOErrorEvent):void
		{
			sendMessage(WicLoaderMsg.FILE_ERROR, { msg: event.text });
			trace("io error loading zip");
		}

		private function onStart(event:Event):void
		{
			sendMessage(WicLoaderMsg.FILE_START);
			trace("load zip starting");
		}

		private function onProgress(event:ProgressEvent):void
		{
			sendMessage(WicLoaderMsg.FILE_PROGRESS, { bytesLoaded: event.bytesLoaded, bytesTotal: event.bytesTotal });
			trace("load zip progress");
		}

		private function onComplete(event:Event):void
		{
			trace("loaded zip complete");

			sendMessage(WicLoaderMsg.FILE_COMPLETE);

			var manifestZip:FZipFile = _fZip.getFileByName("manifest.json");
			if (manifestZip != null)
			{
				var manifest:Object = JSON.parse(manifestZip.getContentAsString());
				parseManifest(manifest);
			}
			else
			{
				trace("No manifest file found in wic.");
				sendMessage(WicLoaderMsg.FILE_ERROR, { msg: "WIC Asset file is corrupted." });
			}
		}

		private function onFileZipLoaded(event:FZipEvent):void
		{
			trace("getting zip file");
		}

		private function onParseZipError(event:FZipErrorEvent):void
		{
			trace("parsing error in zip");
		}
	}
}
