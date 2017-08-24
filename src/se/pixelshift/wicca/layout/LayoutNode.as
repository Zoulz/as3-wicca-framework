/**
 * Quickspin
 * User: Tomas Augustinovic
 * Date: 2015-07-02
 * Time: 12:20
 */
package se.pixelshift.wicca.layout
{
	public class LayoutNode
	{
		public var name:String;
		public var x:int;
		public var y:int;
		public var scaleX:Number;
		public var scaleY:Number;
		public var width:int;
		public var height:int;

		private var _children:Vector.<LayoutNode>;
		private var _parentNode:LayoutNode;

		public function LayoutNode(xml:XML, parentNode:LayoutNode = null)
		{
			_parentNode = parentNode;
			_children = new <LayoutNode>[];

			name = String(xml.@name);
			x = parseInt(xml.@x);
			y = parseInt(xml.@y);
			scaleX = parseFloat(xml.@scaleX);
			scaleY = parseFloat(xml.@scaleY);
			width = parseInt(xml.@width);
			height = parseInt(xml.@height);

			var node:LayoutNode;
			for each (var xnode:XML in xml.children())
			{
				node = new LayoutNode(xnode, this);
				_children.push(node);
			}
		}

		public function findNodeByName(nodeName:String):LayoutNode
		{
			for each (var node:LayoutNode in _children)
			{
				if (node.name == nodeName)
					return node;
				else
				{
					var childNode:LayoutNode = node.findNodeByName(nodeName);
					if (childNode != null)
						return childNode;
				}
			}

			return null;
		}

		public function get parentNode():LayoutNode
		{
			return _parentNode;
		}
	}
}
