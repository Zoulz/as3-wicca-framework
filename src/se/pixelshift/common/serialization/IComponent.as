/**
 * Created by black on 2016-01-19.
 */
package se.pixelshift.common.serialization
{
	import se.pixelshift.common.IDisposable;

	public interface IComponent extends IDisposable
	{
		function get id():String;
		function get name():String;
		function set name(value:String):void;
		function objectify():Object;
		function assemble(obj:Object):IComponent;
		function setName(value:String):IComponent;

		function onAdded(entity:IEntity):void;
		function onRemoved():void;

		function get parent():IEntity;
	}
}
