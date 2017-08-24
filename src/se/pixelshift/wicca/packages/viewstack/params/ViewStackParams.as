/**
 * Pixelshift Interactive
 * 2017-02-06
 * ---------------------------------------------------------------------
 * @author tomas.augustinovic
 */
package se.pixelshift.wicca.packages.viewstack.params
{
	public class ViewStackParams
	{
		public var id:String;
		public var view:*;
		public var index:uint;

		public function ViewStackParams(view:*, index:uint, id:String)
		{
			this.id = id;
			this.view = view;
			this.index = index;
		}
	}
}
