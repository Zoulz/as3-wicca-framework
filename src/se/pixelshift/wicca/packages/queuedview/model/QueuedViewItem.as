/**
 * Copyright Pixelshift Interactive (c) 2015 All Rights Reserved.
 * 2015-07-14 16:20
 * @author ZoulzBig
 */
package se.pixelshift.wicca.packages.queuedview.model
{
	public class QueuedViewItem
	{
		public var type:String;
		public var params:Object;

		public function QueuedViewItem(type:String, params:Object = null)
		{
			this.type = type;
			this.params = params;
		}
	}
}
