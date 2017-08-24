/**
 * Pixelshift Interactive
 * 2017-02-06
 * ---------------------------------------------------------------------
 * @author tomas.augustinovic
 */
package se.pixelshift.wicca.assets
{
	public class AssembleAssetItem
	{
		public var assetId:String;
		public var groupId:String;
		public var assembler:IAssetAssembler;

		public function AssembleAssetItem(assetId:String, assetGroupId:String, assetAssembler:IAssetAssembler)
		{
			this.assembler = assetAssembler;
			this.assetId = assetId;
			this.groupId = assetGroupId;
		}
	}
}
