/**
 * Copyright Pixelshift Interactive (c) 2014 All Right Reserved.
 * @author Zoulz
 */
package se.pixelshift.wicca.services
{
	import flash.utils.Dictionary;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import se.pixelshift.common.structs.KeyValuePair;
	import se.pixelshift.common.utils.ObjectUtil;
	import se.pixelshift.wicca.assets.AssetFactory;
	import se.pixelshift.wicca.assets.AssetURI;

	public final class AssetService implements IAssetService
	{
		protected var _assetGroups:Dictionary = new Dictionary();

		private var _curAssetIndex:uint = 0;
		//private var _curWicFile:WicFile;
		private var _complete:Signal = new Signal();
		private var _requestRestore:Signal = new Signal();
		private var _extractCallback:Function;

		private static var _instance:IAssetService;

		public static function get instance():IAssetService
		{
			if (_instance == null)  // TODO Should this service be a model that is injected or a singleton? Downside with making it a model is that it's not accessible to views which needs it the most.
			{
				_instance = new AssetService();
			}

			return _instance;
		}

		public function dispose():void
		{
			for (var grpName:String in _assetGroups)
			{
				deleteGroup(grpName);
			}
		}

		public function restoreLostAsset(restoreFromFile:String, restoreAssetURI:String, assetCategoryId:String):void
		{
			_requestRestore.dispatch(restoreFromFile, restoreAssetURI, assetCategoryId);
		}

		public function getAsset(uri:String):*
		{
			var group:String = AssetURI.extractWicGroup(uri);
			var id:String = AssetURI.extractId(uri);
			var asset:* = _assetGroups[group.toLowerCase()][id.toLowerCase()];

			if (asset == null)
			{
				throw new Error("'" + uri + "' Asset does not exist.");
			}

			return asset;
		}

		public function setAsset(uri:String, resource:*):void
		{
			var group:String = AssetURI.extractWicGroup(uri);
			var id:String = AssetURI.extractId(uri);

			//	Create group if it doesn't exist.
			if (_assetGroups[group.toLowerCase()] == null)
			{
				_assetGroups[group.toLowerCase()] = new Dictionary(true);
			}

			//	Set the resource.
			if (resource == null)
			{
				_assetGroups[group.toLowerCase()][id.toLowerCase()] = null;
				delete _assetGroups[group.toLowerCase()][id.toLowerCase()];

				if (ObjectUtil.dictionaryLength(_assetGroups[group.toLowerCase()]) == 0)
				{
					_assetGroups[group.toLowerCase()] = null;
					delete _assetGroups[group.toLowerCase()];
				}
			}
			else
			{
				_assetGroups[group.toLowerCase()][id.toLowerCase()] = resource;
			}
		}

		public function getAssetsByGroup(group:String):Vector.<KeyValuePair>
		{
			var ret:Vector.<KeyValuePair> = new <KeyValuePair>[];
			var grpDict:Dictionary = _assetGroups[group.toLowerCase()];
			if (grpDict != null)
			{
				for (var res:Object in grpDict)
				{
					ret.push(new KeyValuePair(res, grpDict[res]));
				}
			}
			return ret;
		}

		public function deleteGroup(group:String):void
		{
			var name:String = group.toLowerCase();

			if (_assetGroups[name] != null)
			{
				for each (var obj:Object in _assetGroups[name])
				{
					AssetFactory.disposeAsset(obj);
				}
				_assetGroups[name] = null;
				delete _assetGroups[name];
			}
		}

		/*public function extractAssetsFromWicFile(wicFile:WicFile):void
		{
			_curAssetIndex = 0;
			_curWicFile = wicFile;

			createAssetFromCurrentWicItem();
		}

		public function extractAssetFromWicFile(wicFile:WicFile, assetId:String, groupId:String, callback:Function = null):void
		{
			AssetFactory.ASSET_CREATED.addOnce(onSingleAssetCreated);

			_extractCallback = callback;
			_curWicFile = wicFile;
			_curAssetIndex = wicFile.getItemIndex(assetId, groupId);
			createAssetItem(wicFile.getItemById(assetId, groupId));
		}

		private function onSingleAssetCreated(resource:*):void
		{
			//	If group dict does not exist, create it.
			var item:IWiccaAssetData = _curWicFile.items[_curAssetIndex];
			if (_assetGroups[item.groupId.toLowerCase()] == null)
			{
				_assetGroups[item.groupId.toLowerCase()] = new Dictionary(true);
			}

			//	Add the resource to the dict.
			_assetGroups[item.groupId.toLowerCase()][item.id.toLowerCase()] = resource;

			if (_extractCallback)
				_extractCallback();
		}

		private function onAssetCreated(resource:*):void
		{
			//	If group dict does not exist, create it.
			var item:IWiccaAssetData = _curWicFile.items[_curAssetIndex];
			if (_assetGroups[item.groupId.toLowerCase()] == null)
			{
				_assetGroups[item.groupId.toLowerCase()] = new Dictionary(true);
			}

			//	Add the resource to the dict.
			_assetGroups[item.groupId.toLowerCase()][item.id.toLowerCase()] = resource;

			//	Increment asset item index.
			_curAssetIndex++;
			if (_curAssetIndex == _curWicFile.items.length)
			{
				//	All resources created.
				_curWicFile.dispose();
				_curWicFile = null;
				_complete.dispatch();
			}
			else
			{
				createAssetFromCurrentWicItem();
			}
		}

		private function createAssetFromCurrentWicItem():void
		{
			AssetFactory.ASSET_CREATED.addOnce(onAssetCreated);

			if (!createAssetItem(_curWicFile.items[_curAssetIndex]))
				onAssetCreated(null);
		}

		private function createAssetItem(item:IWiccaAssetData):Boolean
		{
			switch (item.type)
			{
				case WicAssetItemType.JPEG:
				case WicAssetItemType.PNG:
				{
					AssetFactory.createBitmapData(item);
					return true;
				}
				case WicAssetItemType.ATF:
				{
					AssetFactory.createCompressedTexture(item);
					return true;
				}
				case WicAssetItemType.MP3:
				{
					AssetFactory.createSoundFromMP3(item);
					return true;
				}
				case WicAssetItemType.XML:
				{
					AssetFactory.createXML(item);
					return true;
				}
				case WicAssetItemType.JSON:
				{
					AssetFactory.createJson(item);
					return true;
				}
				case WicAssetItemType.TEXT:
				{
					AssetFactory.createString(item);
					return true;
				}
			}

			return false;
		}*/

		public function get complete():ISignal
		{
			return _complete;
		}

		public function get requestRestore():ISignal
		{
			return _requestRestore;
		}
	}
}
