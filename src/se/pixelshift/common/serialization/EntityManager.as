/**
 * ---------------------------------------------------------------------
 * Pixelshift Interactive
 * 2016-06-19 11:34
 * ---------------------------------------------------------------------
 *
 * @author tomas.augustinovic
 */
package se.pixelshift.common.serialization
{
	import flash.utils.Dictionary;

	import se.pixelshift.common.utils.ObjectUtil;

	public final class EntityManager
	{
		private static var _objDict:Dictionary;

		/**
		 * Register the supplied IComponent class type to be used in the manager.
		 * @param componentRef Class reference of IComponent.
		 * @throws Error Object is already registered.
		 */
		public static function register(componentRef:Class):void
		{
			if (_objDict == null)
			{
				_objDict = new Dictionary();
			}

			var o:IComponent = new componentRef();
			if (_objDict[o.id] == null)
				_objDict[o.id] = componentRef;
			else
				throw new Error("Component is already registered.");
		}

		public static function registerAll(...componentRefs):void
		{
			for each (var c:Class in componentRefs)
			{
				register(c);
			}
		}

		/**
		 * Removes a registered IComponent object from the manager by it's id.
		 * @param id The identifier of the IComponent to remove.
		 * @throws Error Object with that identifier does not exist.
		 */
		public static function remove(id:String):void
		{
			if (_objDict[id] == null)
				throw new Error("Component with that identifier does not exist.");

			_objDict[id] = null;
		}

		/**
		 * Creates a IComponent from a simple object given it has the same structure as one of the
		 * registered IComponent objects.
		 * @param obj Simple object to use for the extraction.
		 * @throws Error Supplied object is NULL or has no identifier.
		 * @throws Error The corresponding typed object cannot be found. Are you sure it's registered?
		 * @return IComponent object populated through the supplied object.
		 */
		public static function extract(obj:Object, assemble:Boolean = true):IComponent
		{
			if (obj == null || obj.id == null)
			{
				throw new Error("Supplied object is NULL or has no identifier.");
			}

			for (var o:Object in _objDict)
			{
				var value:Class = _objDict[o];
				var key:String = String(o);

				if (key == obj.id)
				{
					var ret:IComponent = new value();

					if (assemble)
						ret.assemble(obj);

					return ret;
				}
			}

			throw new Error("The corresponding component cannot be found. Are you sure it's registered?");

			return null;
		}

		/**
		 * Executes the objectify method on each IComponent and returns the resulting objects as
		 * a array.
		 * @param vector Vector containing IComponent objects.
		 * @return Array containing objects.
		 */
		public static function objectifyVector(vector:*):Array
		{
			var ret:Array = [ ];
			if (ObjectUtil.isVector(vector))
			{
				for each (var obj:IComponent in vector)
				{
					ret.push(obj.objectify());
				}
			}

			return ret;
		}

		public static function extractVector(vector:Vector.<Object>, outputCls:Class):*
		{
			var ret:* = new outputCls();
			for each (var obj:Object in vector)
			{
				ret.push(extract(obj));
			}
			return ret;
		}

		public static function extractArray(array:Array, outputCls:*):*
		{
			var ret:* = new outputCls();
			for each (var obj:Object in array)
			{
				ret.push(extract(obj));
			}
			return ret;
		}
	}
}
