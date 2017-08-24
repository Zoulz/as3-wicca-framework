/**
 * Created by Zoulz on 2014-09-04.
 */
package se.pixelshift.wicca.modules
{
	import flash.display.DisplayObjectContainer;

	import se.pixelshift.common.Version;
	import se.pixelshift.wicca.*;
	import se.pixelshift.wicca.logging.IWiccaLogger;
	import se.pixelshift.wicca.packages.IWiccaPackage;

	public interface IWiccaModule
	{
		function start(main:DisplayObjectContainer, settings:WiccaSettings = null):void;
		function shutDown():void;

		function get packages():Vector.<IWiccaPackage>;
		function get loggers():Vector.<IWiccaLogger>;
		function get version():Version;
	}
}
