/**
 * Created by Zoulz on 2014-09-06.
 */
package se.pixelshift.wicca.packages
{
	import mvcexpress.core.CommandMap;
	import mvcexpress.core.MediatorMap;
	import mvcexpress.core.ProxyMap;

	import se.pixelshift.common.IDisposable;
	import se.pixelshift.common.Version;

	public interface IWiccaPackage extends IDisposable
	{
		function get name():String;
		function get description():String;
		function get version():Version;

		function map(mediatorMap:MediatorMap, commandMap:CommandMap, proxyMap:ProxyMap):void;
	}
}
