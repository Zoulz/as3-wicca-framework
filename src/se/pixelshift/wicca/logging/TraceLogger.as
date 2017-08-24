/**
 * Copyright Pixelshift Interactive (c) 2015 All Rights Reserved.
 * 2015-07-15 00:04
 * @author ZoulzBig
 */
package se.pixelshift.wicca.logging
{
	import flash.globalization.DateTimeFormatter;

	public class TraceLogger implements IWiccaLogger
	{
		private var _dtf:DateTimeFormatter;

		public function TraceLogger()
		{
			_dtf = new DateTimeFormatter("en-US");
			_dtf.setDateTimePattern("[yyyy-MM-dd hh:mm:ss] ");
		}

		public function log(logLevel:uint, msg:String):void
		{
			trace(_dtf.format(new Date()) + msg);
		}

		public function dispose():void
		{
		}
	}
}
