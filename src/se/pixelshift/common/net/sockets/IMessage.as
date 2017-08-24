/**
 * Created by black on 2015-10-15.
 */
package se.pixelshift.common.net.sockets
{
	import flash.utils.ByteArray;

	public interface IMessage
	{
		function build():ByteArray;
		function parse(msg:ByteArray):void;
	}
}
