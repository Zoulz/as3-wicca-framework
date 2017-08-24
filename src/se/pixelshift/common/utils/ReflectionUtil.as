package se.pixelshift.common.utils
{
    import flash.system.ApplicationDomain;
    import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * Collection of reflection related utility functions.
	 * 
	 * @author tomas.augustinovic
	 */
	public final class ReflectionUtil
	{
		public static function getClassOfObject(obj:Object):Class
		{
			return Class(getDefinitionByName(getQualifiedClassName(obj)));
		}

		/**
		 * Return the type name of the supplied object as a string.
		 * @param obj Object to process.
		 * @param nameOnly True if you only want the actual class name without the packages.
		 * @return Type name of the supplied object.
		 */
		public static function getNameOfObject(obj:*, nameOnly:Boolean = false):String
		{
			if (obj == null)
			{
				return "";
			}

			var objName:String = String(describeType(obj).@name);
			
			if (nameOnly && objName.lastIndexOf("::") != -1)
			{
				return StringUtil.extractClassName(objName);
			}
			
			return objName;
		}

		/**
		 * Returns a list of all the public variables exposed on the supplied object.
		 * @param obj
		 * @return
		 */
		public static function getPublicVariables(obj:*):Vector.<String>
		{
			var ret:Vector.<String> = new <String>[];

			var type:XML = describeType(obj);
			for each (var vari:XML in type.variable)
			{
				ret.push(String(vari.@name));
			}

			return ret;
		}
		
		/**
		 * Get name of function inside object.
		 * @param obj Object that contains the function who's name you want.
		 * @param f Function of the method inside the supplied object.
		 * @return Name of the function.
		 */
		public static function getNameOfFunction(obj:*, f:Function):String
		{
			var functionName:String = "error!";
			var type:XML = describeType(obj);

			for each (var node:XML in type.method)
			{
				if (obj[node.@name] == f)
				{
					functionName = node.@name;
					break;
				}
			}
			
			return functionName;
		}
		
		/**
		 * Determines if the supplied object implements the specified interface.
		 * @param obj Object to process.
		 * @param type Type to check for.
		 * @return True if the object implements the specified type.
		 */
		public static function isType(obj:*, type:Class):Boolean
		{
			if (obj == null || type == null)
			{
				return false;
			}
			
			var desc:XML = describeType(obj);
			var typeName:String = getQualifiedClassName(type);
			var itemDesc:XML;

			//	Check if the object extends the type.
			for each (itemDesc in desc.extendsClass)
			{
				if (itemDesc.@type.indexOf(typeName) != -1)
				{
					return true;
				}
			}

			//	Check if the object implements the type.
			for each (itemDesc in desc.implementsInterface)
			{
				if (itemDesc.@type.indexOf(typeName) != -1)
				{
					return true;
				}
			}

			//	Check if the object is the type.
			if (desc.@name == typeName)
			{
				return true;
			}
			
			return false;
		}
		
		/**
		 * Search supplied object for member variables which have metadata and
		 * return them as untyped objects in a array.
		 * @param obj Object to search.
		 * @param metaType Metadata type name to look for.
		 * @return Array containing Objects with the following definition: <b>{name, type, ref, args}</b>
		 */
		public static function findMetaData(obj:Object, metaType:String):Vector.<Object>
		{
			var objXml:XML = describeType(obj);
			var ret:Vector.<Object> = new <Object>[];
			
			for each (var vari:XML in objXml.variable)
			{
				for each (var metaData:XML in vari.metadata)
				{
					if (String(metaData.@name) == metaType)
					{
						var varName:String = String(vari.@name);
						var varType:String = String(vari.@type);
						var varRef:* = obj[varName];
						var varArgs:Vector.<Object> = new <Object>[];

						for each (var arg:XML in metaData.arg)
						{
							varArgs.push({ key: String(arg.@key), value: String(arg.@value) });
						}
						
						var obj:Object = { name: varName, type: varType, ref: varRef, args: varArgs };
						ret.push(obj);
					}
				}
			}
			
			return ret;
		}
		
		/**
		 * Extract the class definition by string representation.
		 * @param className Name of the class to get.
		 * @param appDomain ApplicationDomain to fetch the definition from.
		 * @return Class definition, or null if unable to get definition.
		 */
		public static function getClass(className:String, appDomain:ApplicationDomain = null):Class
		{
			if (appDomain == null)
			{
				appDomain = ApplicationDomain.currentDomain;
			}

			if (appDomain.hasDefinition(className))
			{
				return appDomain.getDefinition(className) as Class;
			}

			return null;
		}
		
		/**
		 * Simply return instance of class definition with parameterless constructor.
		 * @param clazz Class to instantiate.
		 * @return Instance of the supplied class.
		 */
		public static function getInstance(clazz:Class):*
		{
			return new clazz();
		}
		
		/**
		 * Return instance of the class with the supplied name. Constructor must be
		 * parameterless.
		 * @param className Name of the class to instantiate.
		 * @param appDomain Application domain that contains the class.
		 * @return Instance of the specified class.
		 */
		public static function getInstanceByName(className:String, appDomain:ApplicationDomain = null):*
		{
			var clazz:Class = getClass(className, appDomain);
			if (clazz != null)
			{
				return new clazz();
			}
			
			return null;
		}
	}
}
