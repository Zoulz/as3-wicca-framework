/**
 * Quickspin
 * User: Tomas Augustinovic
 * Date: 2015-07-02
 * Time: 12:06
 */
package se.pixelshift.wicca.layout
{
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.text.TextField;

	public class StarlingLayout implements ILayout
	{
		private var _nodes:Vector.<LayoutNode>;

		public function StarlingLayout(layout:XML)
		{
			_nodes = new <LayoutNode>[];

			var node:LayoutNode;
			for each (var xnode:XML in layout.children())
			{
				node = new LayoutNode(xnode);
				_nodes.push(node);
			}
		}

		public function getRootNodeByName(nodeName:String):LayoutNode
		{
			for each (var n:LayoutNode in _nodes)
			{
				if (n.name == nodeName)
					return n;
			}

			return null;
		}

		public function applyLayoutTo(displayObject:*, rootNodeName:String, nodeName:String = "", applyWidthAndHeightToTextfields:Boolean = false):void
		{
			var container:DisplayObjectContainer = displayObject;
			var rootNode:LayoutNode = getRootNodeByName(rootNodeName);

			if (rootNode != null)
			{
				var layoutNode:LayoutNode;
				if (nodeName != "")
				{
					layoutNode = rootNode.findNodeByName(nodeName);
				}
				else
				{
					layoutNode = rootNode;
				}

				for (var i:int = 0; i < container.numChildren; i++)
				{
					process(container.getChildAt(i), layoutNode, applyWidthAndHeightToTextfields);
				}
			}
		}

		private function process(d:DisplayObject, node:LayoutNode, applyWidthAndHeightToTextfields:Boolean):void
		{
			var n:LayoutNode = node.findNodeByName(d.name);
			if (n != null)
			{
				d.x = n.x;
				d.y = n.y;
				d.scaleX = n.scaleX;
				d.scaleY = n.scaleY;
				if (d is TextField && applyWidthAndHeightToTextfields)
				{
					d.width = n.width;
					d.height = n.height;
					//TextField(d).redraw();
				}
			}
			else
			{
				trace("ERROR: Layout for object: " + d.name + " not found.");
			}
		}
	}
}
