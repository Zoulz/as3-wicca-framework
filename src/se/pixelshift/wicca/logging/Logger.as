/**
 * Copyright Pixelshift Interactive (c) 2015 All Rights Reserved.
 * 2015-07-15 00:14
 * @author ZoulzBig
 */
package se.pixelshift.wicca.logging
{
	import mvcexpress.mvc.Proxy;

	import se.pixelshift.common.IDisposable;
	import se.pixelshift.wicca.logging.IWiccaLogger;

	public class Logger extends Proxy implements ILogger
	{
		private var _loggers:Vector.<IWiccaLogger>;

		override protected function onRemove():void
		{
			for each (var logger:IWiccaLogger in _loggers)
			{
				if (logger is IDisposable)
					IDisposable(logger).dispose();
			}
		}

		public function Logger(loggers:Vector.<IWiccaLogger>)
		{
			_loggers = loggers;
		}

		public function log(logLevel:uint, msg:String):void
		{
			for each (var logger:IWiccaLogger in _loggers)
			{
				logger.log(logLevel, msg);
			}
		}
	}
}
