/**
 * Copyright Pixelshift Interactive (c) 2015 All Rights Reserved.
 * 2015-07-20 22:43
 * @author ZoulzBig
 */
package se.pixelshift.wicca.assets.assemblers
{
	import se.pixelshift.wicca.assets.AssetURI;
	import se.pixelshift.wicca.assets.IAssetAssembler;
	import se.pixelshift.wicca.assets.AssetCategoryId;
	import se.pixelshift.wicca.services.AssetService;
	import se.pixelshift.wicca.services.SoundService;
	import se.pixelshift.wicca.sound.SoundGroup;

	public class SoundGroupAssembler implements IAssetAssembler
	{
		public function assemble(groupId:String, assetId:String):void
		{
			var sndGrp:SoundGroup = new SoundGroup(AssetService.instance.getAssetsByGroup(groupId + "." + AssetCategoryId.SOUNDS));

			AssetService.instance.deleteGroup(groupId + "." + AssetCategoryId.SOUNDS);

			AssetService.instance.setAsset(AssetURI.create(assetId, groupId, AssetCategoryId.SOUNDGROUP), sndGrp);

			SoundService.instance.registerGroup(sndGrp);
		}

		public function get resultCategoryId():String
		{
			return AssetCategoryId.SOUNDGROUP;
		}
	}
}
