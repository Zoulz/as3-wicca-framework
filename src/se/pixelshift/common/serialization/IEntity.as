/**
 * Pixelshift Interactive
 * 2017-02-12
 * ---------------------------------------------------------------------
 * @author tomas.augustinovic
 */
package se.pixelshift.common.serialization
{
	public interface IEntity extends IComponent
	{
		function hasComponent(componentType:Class):Boolean;
		function hasAnyComponentOf(...components):Boolean;
		function getComponent(componentType:Class):IComponent;
		function getComponentsOf(componentType:Class):Vector.<IComponent>;
		function getComponentByName(name:String):IComponent;
		function addComponent(component:IComponent):IComponent;
		function removeComponentsOf(componentType:Class):void;
		function get components():Vector.<IComponent>;
	}
}
