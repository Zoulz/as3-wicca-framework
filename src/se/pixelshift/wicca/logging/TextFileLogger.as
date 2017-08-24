/**
 * Copyright Pixelshift Interactive (c) 2015 All Rights Reserved.
 * 2015-07-15 09:19
 * @author ZoulzBig
 */
package se.pixelshift.wicca.logging
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.globalization.DateTimeFormatter;

	import se.pixelshift.common.IDisposable;

	public class TextFileLogger implements IWiccaLogger, IDisposable
	{
		private var _f:File;
		private var _fs:FileStream;
		private var _dtf:DateTimeFormatter;

		public function TextFileLogger()
		{
			_dtf = new DateTimeFormatter("en-US");
			_dtf.setDateTimePattern("[yyyy-MM-dd hh:mm:ss] ");

			_f = new File(File.applicationDirectory.nativePath + "\\app.log");
			_fs = new FileStream();
			_fs.open(_f, FileMode.WRITE);
		}

		public function log(logLevel:uint, msg:String):void
		{
			_fs.writeUTFBytes(_dtf.format(new Date()) + msg + File.lineEnding);
		}

		public function dispose():void
		{
			_fs.close();
		}
	}
}
