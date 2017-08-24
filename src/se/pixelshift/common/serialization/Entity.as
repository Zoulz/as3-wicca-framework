/**
 * Created by black on 2016-05-15.
 */
package se.pixelshift.common.serialization
{
	import se.pixelshift.common.utils.ReflectionUtil;

	/**
	 * A entity is a component which can hold child components.
	 */
	public class Entity implements IEntity, IComponent
	{
		protected var _comps:Vector.<IComponent>;

		private var _parent:IEntity = null;
		private var _name:String = "";

		public function Entity(name:String = "")
		{
			this._name = name;
			_comps = new <IComponent>[];
		}

		public function dispose():void
		{
			for (var i:int = 0; i < _comps.length; i++)
			{
				_comps[i].dispose();
			}
		}

		public function hasComponent(componentType:Class):Boolean
		{
			if (_comps.length == 0)
				return false;

			return _comps.some(function(item:IComponent, index:int, vector:Vector.<IComponent>):Boolean {
				var ret:Boolean = (item is componentType);
				return ret;
			});
		}

		public function hasAnyComponentOf(...components):Boolean
		{
			if (_comps.length == 0)
				return false;

			for each (var obj:IComponent in _comps)
			{
				for each (var deco:Class in components)
				{
					if (obj is deco)
						return true;
				}
			}

			return false;
		}

		public function getComponent(componentType:Class):IComponent
		{
			var decos:Vector.<IComponent> = _comps.filter(function(item:IComponent, index:int, vector:Vector.<IComponent>):Boolean {
				if (item is componentType)
					return true;
				else
					return false;
			});

			if (decos != null && decos.length == 1)
			{
				return decos[0];
			}

			return null;
		}

		public function getComponentsOf(componentType:Class):Vector.<IComponent>
		{
			var decos:Vector.<IComponent> = _comps.filter(function(item:IComponent, index:int, vector:Vector.<IComponent>):Boolean {
				if (item is componentType)
					return true;
				else
					return false;
			});

			return decos;
		}

		public function getComponentByName(name:String):IComponent
		{
			var decos:Vector.<IComponent> = _comps.filter(function(item:IComponent, index:int, vector:Vector.<IComponent>):Boolean {
				if (item.name == name)
					return true;
				else
					return false;
			});

			if (decos != null && decos.length == 1)
			{
				return decos[0];
			}

			return null;
		}

		public function addComponent(component:IComponent):IComponent
		{
			if (component != null) // && !hasComponent(ReflectionUtil.getClassOfObject(component))
			{
				_comps.push(component);
				component.onAdded(this);
				return component;
			}

			return null;
		}

		public function removeComponent(component:IComponent):void
		{
			var idx:int = _comps.indexOf(component);
			if (idx != -1)
			{
				_comps.splice(idx, 1);
				component.onRemoved();
				component.dispose();
			}
		}

		public function removeComponentsOf(componentType:Class):void
		{
			if (hasComponent(componentType))
			{
				var comps:Vector.<IComponent> = getComponentsOf(componentType);
				for each (var c:IComponent in comps)
				{
					removeComponent(c);
				}
			}
		}

		public function get components():Vector.<IComponent>
		{
			return _comps;
		}

		public function get id():String
		{
			return "entity";
		}

		public function objectify():Object
		{
			return {
				id: id,
				comps: EntityManager.objectifyVector(_comps)
			};
		}

		public function assemble(obj:Object):IComponent
		{
			_name = obj.name;

			_comps.length = 0;
			for each (var comp:Object in obj.comps)
			{
				_comps.push(EntityManager.extract(comp));
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
