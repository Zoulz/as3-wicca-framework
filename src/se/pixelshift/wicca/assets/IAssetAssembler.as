/**
 * Copyright Pixelshift Interactive (c) 2015 All Rights Reserved.
 * 2015-07-20 21:28
 * @author ZoulzBig
 */
package se.pixelshift.wicca.assets
{
	public interface IAssetAssembler
	{
		function assemble(groupId:String, assetId:String):void;
		function get resultCategoryId():String;
	}
}
