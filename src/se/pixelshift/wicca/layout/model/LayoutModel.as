/**
 * Copyright Pixelshift Interactive (c) 2015 All Rights Reserved.
 * 2015-07-03 06:51
 * @author ZoulzBig
 */
package se.pixelshift.wicca.layout.model
{
	import se.pixelshift.wicca.layout.*;
	import mvcexpress.mvc.Proxy;

	public class LayoutModel extends Proxy implements ILayoutModel
	{
		private var _layouts:Vector.<ILayout>;

		public function LayoutModel()
		{
			_layouts = new <ILayout>[];
		}

		public function get layouts():Vector.<ILayout>
		{
			return _layouts;
		}

		public function set layouts(value:Vector.<ILayout>):void
		{
			_layouts = value;
		}
	}
}
