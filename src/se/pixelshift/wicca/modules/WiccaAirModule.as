/**
 * Created by Zoulz on 2014-09-04.
 */
package se.pixelshift.wicca.modules
{
	import flash.display.DisplayObjectContainer;
	import flash.events.InvokeEvent;
	import flash.media.AudioDecoder;
	import flash.system.Capabilities;

	import mvcexpress.modules.ModuleCore;

	import se.pixelshift.common.Version;
	import se.pixelshift.wicca.WiccaSettings;
	import se.pixelshift.wicca.consts.WiccaModuleMsg;
	import se.pixelshift.wicca.logging.IWiccaLogger;
	import se.pixelshift.wicca.logging.LogLevel;
	import se.pixelshift.wicca.logging.TraceLogger;
	import se.pixelshift.wicca.logging.ILogger;
	import se.pixelshift.wicca.logging.Logger;
	import se.pixelshift.wicca.packages.IWiccaPackage;

	public class WiccaAirModule extends ModuleCore implements IWiccaAirModule
	{
		protected var _main:DisplayObjectContainer;
		protected var _settings:WiccaSettings;
		protected var _loggers:Vector.<IWiccaLogger>;
		protected var _packages:Vector.<IWiccaPackage>;

		public function WiccaAirModule(moduleName:String = "WICCA_MODULE")
		{
			super(moduleName);

			_packages = new <IWiccaPackage>[];
			_loggers = new <IWiccaLogger>[];

			CONFIG::debug
			{
				_loggers = new <IWiccaLogger>[
					new TraceLogger()
				];
			}
		}

		/**
		 * Return the loggers used for this app.
		 * @return
		 */
		public function get loggers():Vector.<IWiccaLogger>
		{
			return _loggers;
		}

		/**
		 * Returns the collection of packages used by this wicca app.
		 */
		public function get packages():Vector.<IWiccaPackage>
		{
			return _packages;
		}

		/**
		 * Initializes all the packages and creates the main view
		 * @param main
		 */
		public function start(main:DisplayObjectContainer, settings:WiccaSettings = null):void
		{
			_main = main;
			_settings = settings != null ? settings : new WiccaSettings();

			var logger:Logger = new Logger(loggers);
			proxyMap.map(logger, null, ILogger, ILogger);

			if (_settings.reportCapabilities)
				reportCapabilities(logger);

			preInitialize();

			for each (var p:IWiccaPackage in packages)
			{
				p.map(mediatorMap, commandMap, proxyMap);
				logger.log(LogLevel.MESSAGE, "Registering Package: " + p.name + ", version: " + p.version.toString());
			}

			setupViews();

			postInitialize();
		}

		protected function reportCapabilities(logger:ILogger):void
		{
			logger.log(LogLevel.MESSAGE, "SYSTEM CAPABILITIES");
			logger.log(LogLevel.MESSAGE, "OS:                       " + Capabilities.os);
			logger.log(LogLevel.MESSAGE, "Language:                 " + Capabilities.language);
			logger.log(LogLevel.MESSAGE, "CPU Architecture:         " + Capabilities.cpuArchitecture);
			logger.log(LogLevel.MESSAGE, "Supports x86:             " + (Capabilities.supports32BitProcesses == true ? "yes" : "no"));
			logger.log(LogLevel.MESSAGE, "Supports x64:             " + (Capabilities.supports64BitProcesses == true ? "yes" : "no"));
			logger.log(LogLevel.MESSAGE, "Player Version:           " + Capabilities.version);
			logger.log(LogLevel.MESSAGE, "Player Type:              " + Capabilities.playerType);
			logger.log(LogLevel.MESSAGE, "Debug Player:             " + (Capabilities.isDebugger == true ? "yes" : "no"));
			logger.log(LogLevel.MESSAGE, "Manufacturer:             " + Capabilities.manufacturer);
			logger.log(LogLevel.MESSAGE, "Touchscreen:              " + Capabilities.touchscreenType);
			logger.log(LogLevel.MESSAGE, "AVHardware Disabled:      " + (Capabilities.avHardwareDisable == true ? "yes" : "no"));
			logger.log(LogLevel.MESSAGE, "Supports Audio:           " + (Capabilities.hasAudio == true ? "yes" : "no"));
			logger.log(LogLevel.MESSAGE, "Supports Audio Streaming: " + (Capabilities.hasStreamingAudio == true ? "yes" : "no"));
			logger.log(LogLevel.MESSAGE, "Supports MP3 Decoding:    " + (Capabilities.hasMP3 == true ? "yes" : "no"));
			logger.log(LogLevel.MESSAGE, "Dolby Digital Audio:      " + (Capabilities.hasMultiChannelAudio(AudioDecoder.DOLBY_DIGITAL) == true ? "yes" : "no"));
			logger.log(LogLevel.MESSAGE, "Dolby Digital + Audio:    " + (Capabilities.hasMultiChannelAudio(AudioDecoder.DOLBY_DIGITAL_PLUS) == true ? "yes" : "no"));
			logger.log(LogLevel.MESSAGE, "DTS Audio:                " + (Capabilities.hasMultiChannelAudio(AudioDecoder.DTS) == true ? "yes" : "no"));
			logger.log(LogLevel.MESSAGE, "DTS Express Audio:        " + (Capabilities.hasMultiChannelAudio(AudioDecoder.DTS_EXPRESS) == true ? "yes" : "no"));
			logger.log(LogLevel.MESSAGE, "DTS HD HiRes Audio:       " + (Capabilities.hasMultiChannelAudio(AudioDecoder.DTS_HD_HIGH_RESOLUTION_AUDIO) == true ? "yes" : "no"));
			logger.log(LogLevel.MESSAGE, "DTS HD Master Audio:      " + (Capabilities.hasMultiChannelAudio(AudioDecoder.DTS_HD_MASTER_AUDIO) == true ? "yes" : "no"));
			logger.log(LogLevel.MESSAGE, "Supports Video Streaming: " + (Capabilities.hasStreamingVideo == true ? "yes" : "no"));
			logger.log(LogLevel.MESSAGE, "Supports Video Encoding:  " + (Capabilities.hasStreamingVideo == true ? "yes" : "no"));
			logger.log(LogLevel.MESSAGE, "Screen DPI:               " + Capabilities.screenDPI);
			logger.log(LogLevel.MESSAGE, "Screen Resolution:        " + Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY);
			logger.log(LogLevel.MESSAGE, "Pixel Aspect Ratio:       " + Capabilities.pixelAspectRatio);
			logger.log(LogLevel.MESSAGE, "------------------------------------------------------");
		}

		/**
		 * Adds the supplied view as a child to the main display object
		 * and mediates it.
		 * @param view
		 */
		protected function addAndMediateView(view:*):void
		{
			mediatorMap.mediate(view);
			_main.addChild(view);
		}

		protected function removeAndUnmediateView(view:*):void
		{
			mediatorMap.unmediate(view);
			_main.removeChild(view);
		}

		/**
		 * Creates and mediates all the views for this wicca app.
		 */
		protected function setupViews():void
		{
			ILogger(proxyMap.getProxy(ILogger)).log(LogLevel.WARNING, "setupViews() is not overridden.");
		}

		/**
		 * Run before initialization of the packages has begun.
		 */
		protected function preInitialize():void
		{
			ILogger(proxyMap.getProxy(ILogger)).log(LogLevel.WARNING, "preInitialize() is not overridden.");
		}

		/**
		 * Run after the packages have been initialized and everything
		 * is ready to go.
		 */
		protected function postInitialize():void
		{
			ILogger(proxyMap.getProxy(ILogger)).log(LogLevel.WARNING, "postInitialize() is not overridden.");
		}

		/**
		 * When the application is activated.
		 */
		public function activated():void
		{
			sendMessage(WiccaModuleMsg.APP_ACTIVATED);
		}

		public function closing():void
		{
			sendMessage(WiccaModuleMsg.APP_CLOSING);
		}

		/**
		 * Triggers when the application is deactivated.
		 */
		public function deactivated():void
		{
			sendMessage(WiccaModuleMsg.APP_DEACTIVATED);
		}

		/**
		 * Triggers when a remote connection is added or removed.
		 */
		public function networkChange():void
		{
			sendMessage(WiccaModuleMsg.APP_NETWORK_CHANGE);
		}

		/**
		 * Triggers when the app is invoked.
		 * @param event
		 */
		public function invoke(event:InvokeEvent):void
		{
			sendMessage(WiccaModuleMsg.APP_INVOKE);
		}

		/**
		 * User has been idle.
		 */
		public function idle():void
		{
			sendMessage(WiccaModuleMsg.APP_IDLE);
		}

		/**
		 * User is back.
		 */
		public function present():void
		{
			sendMessage(WiccaModuleMsg.APP_PRESENT);
		}

		/**
		 * Disposes all the packages.
		 */
		public function shutDown():void
		{
			for each (var p:IWiccaPackage in packages)
			{
				p.dispose();
			}

			for each (var l:IWiccaLogger in loggers)
			{
				l.dispose();
			}

			proxyMap.unmap(Logger);
		}

		/**
		 * Return current running version of Wicca.
		 */
		public function get version():Version
		{
			return Version.fromString(CONFIG::version, true);
		}

		public function resize():void
		{
			sendMessage(WiccaModuleMsg.APP_RESIZE);
		}

		public function exiting():void
		{
			sendMessage(WiccaModuleMsg.APP_EXITING);
		}
	}
}
