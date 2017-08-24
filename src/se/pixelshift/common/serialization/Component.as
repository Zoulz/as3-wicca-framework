/**
 * Created by Tomas Augustinovic on 2017-03-31.
 */
package se.pixelshift.common.serialization
{
	import se.pixelshift.common.errors.AbstractMethodError;
	import se.pixelshift.common.utils.ReflectionUtil;

	public class Component implements IComponent
	{
		private var _parent:IEntity = null;
		private var _name:String = "";

		public function Component(name:String = "No_Name")
		{
			_name = name;
		}

		public function dispose():void
		{
		}

		public function get id():String
		{
			throw new AbstractMethodError("id getter must be implemented in subclass.");
		}

		public function objectify():Object
		{
			var variables:Vector.<String> = ReflectionUtil.getPublicVariables(this);
			var ret:Object = { id: id, name: _name };
			for each (var vari:String in variables)
			{
				ret[vari] = this[vari];
			}

			return ret;
		}

		public function assemble(obj:Object):IComponent
		{
			var prop:String;
			for (prop in obj)
			{
				if (prop != "id")
				{
					try
					{
						this[prop] = obj[prop];
					} catch(err:Error) {
						trace("Error assembling component: " + err.message);
					}
				}
			}

			return this;
		}

		public function get parent():IEntity
		{
			return _parent;
		}

		public function onAdded(entity:IEntity):void
		{
			_parent = entity;
		}

		public function onRemoved():void
		{
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function setName(value:String):IComponent
		{
			this.name = value;
			return this;
		}
	}
}
