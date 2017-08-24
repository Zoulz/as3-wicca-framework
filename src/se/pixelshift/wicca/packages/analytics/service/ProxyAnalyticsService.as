/**
 * Pixelshift Interactive
 * 2016-08-20
 * ---------------------------------------------------------------------
 * @author tomas.augustinovic
 */
package se.pixelshift.wicca.packages.analytics.service
{
	import mvcexpress.mvc.Proxy;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import se.pixelshift.common.utils.ObjectUtil;

	import se.pixelshift.wicca.logging.LogLevel;
	import se.pixelshift.wicca.logging.ILogger;
	import se.pixelshift.wicca.packages.analytics.service.AnalyticsRequest;

	public class ProxyAnalyticsService extends Proxy implements IAnalyticsService
	{
		[Inject] public var logger:ILogger;

		private var _response:Signal = new Signal();

		public function ProxyAnalyticsService()
		{
		}

		public function get isEnabled():Boolean
		{
			return true;
		}

		public function get isProduction():Boolean
		{
			return false;
		}

		public function get response():ISignal
		{
			return _response;
		}

		public function call(type:String, jsonMessage:String):void
		{
			_response.dispatch(200, { response: { } });

			if (type == AnalyticsRequest.EVENT)
				logger.log(LogLevel.MESSAGE, "Analytics /v2/" + gameKey + "/events: " + ObjectUtil.toString(JSON.parse(jsonMessage)[0]));
			else
				logger.log(LogLevel.MESSAGE, "Analytics /v2/" + gameKey + "/init: " + ObjectUtil.toString(JSON.parse(jsonMessage)));

			logger.log(LogLevel.MESSAGE, "Analytics Response HTTP 200 OK");
		}

		public function set isEnabled(value:Boolean):void
		{
		}

		public function set offsetTs(value:Number):void
		{
		}

		public function get offsetTs():Number
		{
			return 0;
		}

		public function set startTs(value:Number):void
		{
		}

		public function get startTs():Number
		{
			return 0;
		}

		public function get sessionNum():int
		{
			return 0;
		}

		public function set sessionNum(value:int):void
		{
		}

		public function get sessionId():String
		{
			return "-proxy-session-";
		}

		public function get transactionNum():int
		{
			return 0;
		}

		public function set transactionNum(value:int):void
		{
		}

		public function set secretKey(value:String):void
		{
		}

		public function set gameKey(value:String):void
		{
		}

		public function set isProduction(value:Boolean):void
		{
		}

		public function get secretKey():String
		{
			return "16813a12f718bc5c620f56944e1abc3ea13ccbac";
		}

		public function get gameKey():String
		{
			return "5c6bcb5402204249437fb5a7a80a4959";
		}

		public function get osUserName():String
		{
			return "";
		}
	}
}
