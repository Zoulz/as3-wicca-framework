/**
 * Copyright Pixelshift Interactive (c) 2015 All Rights Reserved.
 * 2015-07-15 00:03
 * @author ZoulzBig
 */
package se.pixelshift.wicca.logging
{
	public class LogLevel
	{
		public static const MESSAGE:uint = 0;
		public static const WARNING:uint = 1;
		public static const ERROR:uint = 2;
		public static const FATAL_ERROR:uint = 3;

		public static function indexToString(logLevel:uint):String
		{
			switch (logLevel)
			{
				case MESSAGE:
					return "Message";
				case WARNING:
					return "Warning";
				case ERROR:
					return "Error";
				case FATAL_ERROR:
					return "Fatal Error";
			}

			return "";
		}
	}
}
