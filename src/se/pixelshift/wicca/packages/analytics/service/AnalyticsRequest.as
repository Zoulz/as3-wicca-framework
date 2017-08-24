/**
 * Pixelshift Interactive
 * 2016-08-20
 * ---------------------------------------------------------------------
 * @author tomas.augustinovic
 */
package se.pixelshift.wicca.packages.analytics.service
{
	import flash.system.Capabilities;

	import se.pixelshift.common.utils.ObjectUtil;

	public class AnalyticsRequest
	{
		private static var _platform:String = Capabilities.os.indexOf("Windows") != -1 ? "windows" :
				Capabilities.os.indexOf("Mac") != -1 ? "mac_osx" :
				Capabilities.os.indexOf("Linux") != -1 ? "linux" :
				Capabilities.os.indexOf("iPhone") != -1 ? "ios" : "unknown";

		public static const INIT:String = "init";
		public static const EVENT:String = "events";

		public static const FLOWTYPE_SINK:String = "Sink";
		public static const FLOWTYPE_SRC:String = "Source";

		protected function getOSUserName():String
		{
			return "Unknown";
		}

		public static function createInitRequest():String
		{
			return JSON.stringify({
				platform: _platform,
				os_version: Capabilities.os,
				sdk_version: "rest api v2"
			});
		}

		public static function createUserEvent(analytics:IAnalyticsService):String
		{
			var shared:Object = AnalyticsRequest.createDefaultShared(analytics.offsetTs, analytics.sessionId, analytics.sessionNum, analytics.osUserName);
			return JSON.stringify([
				ObjectUtil.mergeObjects({ category: "user"}, shared)
			]);
		}

		public static function createSessionEndEvent(analytics:IAnalyticsService):String
		{
			var d:Date = new Date();
			var shared:Object = AnalyticsRequest.createDefaultShared(analytics.offsetTs, analytics.sessionId, analytics.sessionNum, analytics.osUserName);
			return JSON.stringify([
				ObjectUtil.mergeObjects({ category: "session_end", length: Math.round(d.time / 1000) - analytics.startTs }, shared)
			]);
		}

		public static function createBusinessEvent(analytics:IAnalyticsService, eventId:String, amount:int, currency:String, cartType:String = ""):String
		{
			var shared:Object = AnalyticsRequest.createDefaultShared(analytics.offsetTs, analytics.sessionId, analytics.sessionNum, analytics.osUserName);
			return JSON.stringify([
				ObjectUtil.mergeObjects({ category: "business",
					event_id: eventId,
					amount: amount,
					currency: currency,
					transaction_num: ++analytics.transactionNum,
					cart_type: cartType,
					receipt_info: {
						receipt: "",
						store: "",
						signature: ""
					} }, shared)
			]);
		}

		public static function createResourceEvent(analytics:IAnalyticsService, eventId:String, amount:Number):String
		{
			var shared:Object = AnalyticsRequest.createDefaultShared(analytics.offsetTs, analytics.sessionId, analytics.sessionNum, analytics.osUserName);
			return JSON.stringify([
				ObjectUtil.mergeObjects({ category: "resource", event_id: eventId, amount: amount }, shared)
			]);
		}

		public static function createProgressionEvent(analytics:IAnalyticsService, eventId:String, attemptNum:int, score:int):String
		{
			var shared:Object = AnalyticsRequest.createDefaultShared(analytics.offsetTs, analytics.sessionId, analytics.sessionNum, analytics.osUserName);
			return JSON.stringify([
				ObjectUtil.mergeObjects({ category: "progression", event_id: eventId, attempt_num: attemptNum, score: score }, shared)
			]);
		}

		public static function createDesignEvent(analytics:IAnalyticsService, eventId:String, value:Number):String
		{
			var shared:Object = AnalyticsRequest.createDefaultShared(analytics.offsetTs, analytics.sessionId, analytics.sessionNum, analytics.osUserName);
			return JSON.stringify([
				ObjectUtil.mergeObjects({ category: "design", event_id: eventId, value: value }, shared)
			]);
		}

		public static function createErrorEvent(analytics:IAnalyticsService, severity:String, msg:String):String
		{
			var shared:Object = AnalyticsRequest.createDefaultShared(analytics.offsetTs, analytics.sessionId, analytics.sessionNum, analytics.osUserName);
			return JSON.stringify([
				ObjectUtil.mergeObjects({ category: "error", severity: severity, message: msg }, shared)
			]);
		}

		private static function createDefaultShared(offsetTs:Number, sessionId:String, sessionNum:int, osUserName:String):Object
		{
			var date:Date = new Date();
			var dif:Number = Math.round(date.time / 1000) - offsetTs;

			return {
				device: "unknown",
				v: 2,
				user_id: osUserName,
				client_ts: dif,
				sdk_version: "rest api v2",
				os_version: Capabilities.os.toLowerCase(),
				manufacturer: "",
				platform: _platform,
				session_id: sessionId.toLowerCase(),
				session_num: sessionNum
			};
		}

		private static function createOptionalShared():Object
		{
			return {
				limit_ad_tracking: false,
				logon_gamecenter: false,
				logon_googleplay: false,
				jailbroken: false,
				android_id: "",
				googleplus_id: "",
				facebook_id: "",
				gender: "",
				birth_year: 0,
				custom_01: "",
				custom_02: "",
				custom_03: "",
				build: "",
				engine_version: "",
				ios_idfv: "",
				connection_type: "",
				ios_idfa: "",
				google_aid: ""
			};
		}
	}
}
