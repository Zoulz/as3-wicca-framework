/**
 * Quickspin
 * User: Tomas Augustinovic
 * Date: 2015-07-02
 * Time: 13:33
 */
package se.pixelshift.wicca.layout
{
	public interface ILayout
	{
		function getRootNodeByName(nodeName:String):LayoutNode
		function applyLayoutTo(displayObject:*, rootNodeName:String, nodeName:String = "", applyWidthAndHeightToTextfields:Boolean = false):void;
	}
}
