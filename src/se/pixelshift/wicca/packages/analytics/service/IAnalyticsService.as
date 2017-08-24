/**
 * Pixelshift Interactive
 * 2016-08-19
 * ---------------------------------------------------------------------
 * @author tomas.augustinovic
 */
package se.pixelshift.wicca.packages.analytics.service
{
	import org.osflash.signals.ISignal;

	public interface IAnalyticsService
	{
		function call(type:String, jsonMessage:String):void;

		function get osUserName():String;
		function get isEnabled():Boolean;
		function set isEnabled(value:Boolean):void;
		function set offsetTs(value:Number):void;
		function get offsetTs():Number;
		function set startTs(value:Number):void;
		function get startTs():Number;
		function get sessionNum():int;
		function set sessionNum(value:int):void;
		function get sessionId():String;
		function get transactionNum():int;
		function set transactionNum(value:int):void;
		function set secretKey(value:String):void;
		function get secretKey():String;
		function set gameKey(value:String):void;
		function get gameKey():String;
		function get isProduction():Boolean;
		function set isProduction(value:Boolean):void;
		function get response():ISignal;
	}
}
