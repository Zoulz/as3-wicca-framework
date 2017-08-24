/**
 * Created by black on 2016-01-06.
 */
package se.pixelshift.wicca.modules
{
	import flash.events.InvokeEvent;

	public interface IWiccaAirModule extends IWiccaModule
	{
		function closing():void;
		function exiting():void;
		function idle():void;
		function present():void;
		function deactivated():void;
		function activated():void;
		function networkChange():void;
		function invoke(event:InvokeEvent):void;
		function resize():void;
	}
}
