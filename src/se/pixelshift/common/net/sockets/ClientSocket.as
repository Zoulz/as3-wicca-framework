/**
 * Created by black on 2015-10-13.
 */
package se.pixelshift.common.net.sockets
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.OutputProgressEvent;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import se.pixelshift.common.IDisposable;

	public class ClientSocket implements IDisposable
	{
		private var _sck:Socket;
		private var _host:String;
		private var _port:uint;
		private var _onConnected:Boolean = false;

		private var _connected:Signal = new Signal();
		private var _messageReceived:Signal = new Signal();

		public function ClientSocket()
		{
			_sck = new Socket();
			_sck.addEventListener(Event.CONNECT, onConnected);
			_sck.addEventListener(Event.CLOSE, onClosed);
			_sck.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
			_sck.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_sck.addEventListener(OutputProgressEvent.OUTPUT_PROGRESS, onOutputProgress);
		}

		private function onSocketData(event:ProgressEvent):void
		{
			var buf:ByteArray = new ByteArray();
			_sck.readBytes(buf, 0, _sck.bytesAvailable);

			_messageReceived.dispatch(buf);
		}

		private function onOutputProgress(event:OutputProgressEvent):void
		{
			trace("output progress");
		}

		private function onIOError(event:IOErrorEvent):void
		{
			trace("io error");
		}

		private function onConnected(event:Event):void
		{
			_onConnected = true;
			_connected.dispatch();
		}

		private function onClosed(event:Event):void
		{
			_onConnected = false;
			trace("closed");
		}

		public function connect(host:String = "127.0.0.1", port:uint = 4000):void
		{
			_host = host;
			_port = port;

			_sck.connect(host, port);
		}

		public function sendMessage(msg:IMessage):void
		{
			var data:ByteArray = msg.build();
			_sck.writeBytes(data, 0, data.length);
		}

		public function dispose():void
		{
			_sck.close();
			_sck.removeEventListener(Event.CONNECT, onConnected);
			_sck.removeEventListener(Event.CLOSE, onClosed);
			_sck.removeEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
			_sck.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_sck.removeEventListener(OutputProgressEvent.OUTPUT_PROGRESS, onOutputProgress);
		}

		public function get connected():ISignal
		{
			return _connected;
		}

		public function get messageReceived():ISignal
		{
			return _messageReceived;
		}
	}
}
