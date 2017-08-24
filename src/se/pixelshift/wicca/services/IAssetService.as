/**
 * Copyright Pixelshift Interactive (c) 2014 All Right Reserved.
 * @author Zoulz
 */
package se.pixelshift.wicca.services
{
	import org.osflash.signals.ISignal;

	import se.pixelshift.common.IDisposable;
	import se.pixelshift.common.structs.KeyValuePair;

	public interface IAssetService extends IDisposable
	{
		function getAsset(s:String):*;
		function getAssetsByGroup(group:String):Vector.<KeyValuePair>;
		function setAsset(s:String, resource:*):void;
		function deleteGroup(group:String):void;
		//function extractAssetsFromWicFile(wicFile:WicFile):void;
		//function extractAssetFromWicFile(wicFile:WicFile, assetId:String, groupId:String, callback:Function = null):void;
		function restoreLostAsset(restoreFromFile:String, assetURI:String, targetAssetURI:String):void;

		function get complete():ISignal;
		function get requestRestore():ISignal;
	}
}
