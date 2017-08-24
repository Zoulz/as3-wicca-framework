/**
 * Created by black on 2016-01-10.
 */
package se.pixelshift.wicca.logging
{
	public class DefaultTraceLogger implements IWiccaLogger
	{
		public function log(logLevel:uint, msg:String):void
		{
			trace("[" + LogLevel.indexToString(logLevel) + "] " + msg);
		}

		public function dispose():void
		{
		}
	}
}
