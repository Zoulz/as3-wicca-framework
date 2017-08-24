/**
 * Pixelshift Interactive
 * 2016-08-19
 * ---------------------------------------------------------------------
 * @author tomas.augustinovic
 */
package se.pixelshift.wicca.packages.analytics.service
{
	import com.hurlant.crypto.hash.HMAC;
	import com.hurlant.crypto.hash.SHA256;
	import com.hurlant.util.Base64;

	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;

	import mvcexpress.mvc.Proxy;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import se.pixelshift.common.algorithm.GUID;
	import se.pixelshift.common.utils.ObjectUtil;
	import se.pixelshift.wicca.logging.LogLevel;
	import se.pixelshift.wicca.logging.ILogger;
	import se.pixelshift.wicca.packages.analytics.consts.AnalyticsMsg;

	public class AnalyticsService extends Proxy implements IAnalyticsService
	{
		[Inject] public var logger:ILogger;

		protected var _loader:URLLoader;
		protected var _isBusy:Boolean = false;
		protected var _isEnabled:Boolean = false;
		protected var _httpStatus:int = 0;
		protected var _startTs:Number = 0;
		protected var _offsetTs:Number = 0;
		protected var _sessionId:String = "";
		protected var _sessionNum:int = 0;
		protected var _transactionNum:int = 0;
		protected var _url:String = "http://api.gameanalytics.com";
		protected var _gameKey:String = "5c6bcb5402204249437fb5a7a80a4959";
		protected var _secretKey:String = "16813a12f718bc5c620f56944e1abc3ea13ccbac";

		private var _response:Signal = new Signal();

		override protected function onRemove():void
		{
			_loader.removeEventListener(Event.COMPLETE, onCallComplete);
			_loader.removeEventListener(IOErrorEvent.IO_ERROR, onCallFailed);
			_loader.removeEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, onResponseStatus);
			_loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onCallSecurityError);
			_loader.close();
		}

		override protected function onRegister():void
		{
			_sessionId = GUID.create();
			_sessionNum = 1;
			_transactionNum = 1;

			_loader = new URLLoader();
			_loader.dataFormat = URLLoaderDataFormat.TEXT;
			_loader.addEventListener(Event.COMPLETE, onCallComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onCallFailed);
			_loader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, onResponseStatus);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onCallSecurityError);
		}

		private function createAuthentication(message:String):String
		{
			var secret:ByteArray = new ByteArray();
			secret.writeUTFBytes(_secretKey);

			var msg:ByteArray = new ByteArray();
			msg.writeUTFBytes(message);

			var hmac:HMAC = new HMAC(new SHA256(), 0);
			return Base64.encodeByteArray(hmac.compute(secret, msg));
		}

		public function call(type:String, jsonMessage:String):void
		{
			if (_isBusy || (_isEnabled == false && type != "init"))
				return;

			_isBusy = true;

			var request:URLRequest = new URLRequest(_url + "/v2/" + _gameKey + "/" + type);
			request.requestHeaders = [
					new URLRequestHeader("Authorization", createAuthentication(jsonMessage))
			];
			request.contentType = "application/json";
			request.data = jsonMessage;
			request.method = URLRequestMethod.POST;

			if (type == AnalyticsRequest.EVENT)
				logger.log(LogLevel.MESSAGE, "Analytics /v2/" + gameKey + "/events: " + ObjectUtil.toString(JSON.parse(jsonMessage)[0]));
			else
				logger.log(LogLevel.MESSAGE, "Analytics /v2/" + gameKey + "/init: " + ObjectUtil.toString(JSON.parse(jsonMessage)));

			_loader.load(request);
		}

		private function onResponseStatus(event:HTTPStatusEvent):void
		{
			_httpStatus = event.status;
		}

		private function onCallSecurityError(event:SecurityErrorEvent):void
		{
			_isBusy = false;
			sendMessage(AnalyticsMsg.ERROR, { id: event.errorID, text: event.text });
		}

		private function onCallFailed(event:IOErrorEvent):void
		{
			_isBusy = false;
			sendMessage(AnalyticsMsg.ERROR, { id: event.errorID, text: event.text });
		}

		private function onCallComplete(event:Event):void
		{
			_isBusy = false;
			if (_httpStatus == 200)
				sendMessage(AnalyticsMsg.RESPONSE, { response: JSON.parse(_loader.data) });
			else
				sendMessage(AnalyticsMsg.ERROR, { id: _httpStatus, text: _loader.data });

			_response.dispatch(_httpStatus, JSON.parse(_loader.data));

			logger.log(LogLevel.MESSAGE, "Analytics Response HTTP " + _httpStatus + " " + getHttpStatusString());

			_loader.data = null;
		}

		private function getHttpStatusString():String
		{
			switch (_httpStatus)
			{
				case 400:
					return "OK";
				case 401:
					return "UNAUTHORIZED";
				case 413:
					return "REQUEST ENTITY TOO LARGE";
				case 400:
					return "BAD REQUEST";
			}

			return "";
		}

		public function set isProduction(value:Boolean):void
		{
			if (value)
				_url = "http://api.gameanalytics.com";
			else
				_url = "http://sandbox-api.gameanalytics.com";
		}

		public function get isProduction():Boolean
		{
			return (_url == "http://api.gameanalytics.com");
		}

		public function set secretKey(value:String):void
		{
			_secretKey = value;
		}

		public function set gameKey(value:String):void
		{
			_gameKey = value;
		}

		public function get isEnabled():Boolean
		{
			return _isEnabled;
		}

		public function set isEnabled(value:Boolean):void
		{
			_isEnabled = value;
			if (value) _sessionNum++;
		}

		public function get offsetTs():Number
		{
			return _offsetTs;
		}

		public function set offsetTs(value:Number):void
		{
			_offsetTs = value;
		}

		public function get sessionId():String
		{
			return _sessionId;
		}

		public function get startTs():Number
		{
			return _startTs;
		}

		public function set startTs(value:Number):void
		{
			_startTs = value;
		}

		public function get response():ISignal
		{
			return _response;
		}

		public function get sessionNum():int
		{
			return _sessionNum;
		}

		public function set sessionNum(value:int):void
		{
			_sessionNum = value;
		}

		public function get transactionNum():int
		{
			return _transactionNum;
		}

		public function set transactionNum(value:int):void
		{
			_transactionNum = value;
		}

		public function get secretKey():String
		{
			return _secretKey;
		}

		public function get gameKey():String
		{
			return _gameKey;
		}

		public function get osUserName():String
		{
			return "Unknown";
		}
	}
}
