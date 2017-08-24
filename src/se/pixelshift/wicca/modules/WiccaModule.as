/**
 * Created by black on 2016-01-10.
 */
package se.pixelshift.wicca.modules
{
	import flash.display.DisplayObjectContainer;

	import mvcexpress.modules.ModuleCore;

	import se.pixelshift.common.Version;
	import se.pixelshift.wicca.WiccaSettings;
	import se.pixelshift.wicca.logging.DefaultTraceLogger;
	import se.pixelshift.wicca.logging.IWiccaLogger;
	import se.pixelshift.wicca.logging.LogLevel;
	import se.pixelshift.wicca.logging.ILogger;
	import se.pixelshift.wicca.logging.Logger;
	import se.pixelshift.wicca.packages.IWiccaPackage;

	public class WiccaModule extends ModuleCore
	{
		protected var _main:DisplayObjectContainer;
		protected var _settings:WiccaSettings;
		protected var _loggers:Vector.<IWiccaLogger>;
		protected var _packages:Vector.<IWiccaPackage>;

		public function WiccaModule(moduleName:String = "WICCA_MODULE")
		{
			super(moduleName);

			_packages = new <IWiccaPackage>[];
			_loggers = new <IWiccaLogger>[];

			CONFIG::debug
			{
				_loggers = new <IWiccaLogger>[
					new DefaultTraceLogger()
				];
			}
		}

		public function start(main:DisplayObjectContainer, settings:WiccaSettings = null):void
		{
			_main = main;
			_settings = settings != null ? settings : new WiccaSettings();

			var logger:Logger = new Logger(loggers);
			proxyMap.map(logger, null, ILogger, ILogger);

			preInitialize();

			for each (var p:IWiccaPackage in packages)
			{
				p.map(mediatorMap, commandMap, proxyMap);
				logger.log(LogLevel.MESSAGE, "Registering Package: " + p.name + ", version: " + p.version.toString());
			}

			setupViews();

			postInitialize();
		}

		public function shutDown():void
		{
			for each (var p:IWiccaPackage in packages)
			{
				p.dispose();
			}
			_packages.length = 0;

			for each (var l:IWiccaLogger in loggers)
			{
				l.dispose();
			}
			_loggers.length = 0;

			proxyMap.unmap(ILogger);
		}

		protected function setupViews():void
		{
			ILogger(proxyMap.getProxy(ILogger)).log(LogLevel.WARNING, "WiccaModule.setupViews() is not overridden.");
		}

		protected function preInitialize():void
		{
			ILogger(proxyMap.getProxy(ILogger)).log(LogLevel.WARNING, "WiccaModule.preInitialize() is not overridden.");
		}

		protected function postInitialize():void
		{
			ILogger(proxyMap.getProxy(ILogger)).log(LogLevel.WARNING, "WiccaModule.postInitialize() is not overridden.");
		}

		protected function addAndMediateView(view:*):void
		{
			mediatorMap.mediate(view);
			_main.addChild(view);
		}

		public function get packages():Vector.<IWiccaPackage>
		{
			return _packages;
		}

		public function get loggers():Vector.<IWiccaLogger>
		{
			return _loggers;
		}

		public function get version():Version
		{
			return Version.fromString(CONFIG::version, true);
		}
	}
}
