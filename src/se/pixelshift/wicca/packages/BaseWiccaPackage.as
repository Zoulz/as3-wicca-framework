/**
 * Copyright Pixelshift Interactive (c) 2015 All Rights Reserved.
 * 2015-01-11 20:08
 * @author Zoulz
 */
package se.pixelshift.wicca.packages
{
	import mvcexpress.core.CommandMap;
	import mvcexpress.core.MediatorMap;
	import mvcexpress.core.ProxyMap;

	import se.pixelshift.common.Version;

	public class BaseWiccaPackage implements IWiccaPackage
	{
		protected var _mediatorMap:MediatorMap;
		protected var _commandMap:CommandMap;
		protected var _proxyMap:ProxyMap;

		public function get name():String
		{
			throw new Error("Override method in subclass.");
		}

		public function get description():String
		{
			return "-";
		}

		public function get version():Version
		{
			return Version.fromString(CONFIG::version);
		}

		public function map(mediatorMap:MediatorMap, commandMap:CommandMap, proxyMap:ProxyMap):void
		{
			_mediatorMap = mediatorMap;
			_commandMap = commandMap;
			_proxyMap = proxyMap;

			mapView();
			mapController();
			mapModel();
		}

		protected function mapView():void
		{
		}

		protected function mapController():void
		{
		}

		protected function mapModel():void
		{
		}

		protected function unmapView():void
		{
		}

		protected function unmapController():void
		{
		}

		protected function unmapModel():void
		{
		}

		public function dispose():void
		{
			unmapView();
			unmapController();
			unmapModel();
		}
	}
}
