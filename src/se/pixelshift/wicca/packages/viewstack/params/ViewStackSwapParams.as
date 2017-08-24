/**
 * Created by Tomas Augustinovic on 2017-02-07.
 */
package se.pixelshift.wicca.packages.viewstack.params
{
	public class ViewStackSwapParams
	{
		public var fromView:*;
		public var toView:*;

		public function ViewStackSwapParams(from:*, to:*)
		{
			this.fromView = from;
			this.toView = to;
		}
	}
}
