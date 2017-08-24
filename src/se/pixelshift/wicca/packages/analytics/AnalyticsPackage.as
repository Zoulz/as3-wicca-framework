/**
 * Pixelshift Interactive
 * 2016-08-19
 * ---------------------------------------------------------------------
 * @author tomas.augustinovic
 */
package se.pixelshift.wicca.packages.analytics
{
	import se.pixelshift.wicca.packages.BaseWiccaPackage;
	import se.pixelshift.wicca.packages.IWiccaPackage;
	import se.pixelshift.wicca.packages.analytics.consts.AnalyticsMsg;
	import se.pixelshift.wicca.packages.analytics.controller.HandleGAErrorCmd;
	import se.pixelshift.wicca.packages.analytics.controller.HandleGAResponseCmd;
	import se.pixelshift.wicca.packages.analytics.service.IAnalyticsService;

	public class AnalyticsPackage extends BaseWiccaPackage implements IWiccaPackage
	{
		private var _ServiceCls:Class;

		public function AnalyticsPackage(Service:Class)
		{
			_ServiceCls = Service;
		}

		override public function get name():String
		{
			return "Game Analytics Service";
		}

		override public function get description():String
		{
			return "Package that allows the game to monitor the player's interactions and submit them to a analytics framework.";
		}

		override protected function mapView():void
		{
		}

		override protected function mapController():void
		{
			_commandMap.map(AnalyticsMsg.RESPONSE, HandleGAResponseCmd);
			_commandMap.map(AnalyticsMsg.ERROR, HandleGAErrorCmd);
		}

		override protected function mapModel():void
		{
			_proxyMap.map(new _ServiceCls(), null, IAnalyticsService, null);
		}

		override protected function unmapView():void
		{
		}

		override protected function unmapController():void
		{
			_commandMap.unmap(AnalyticsMsg.RESPONSE);
			_commandMap.unmap(AnalyticsMsg.ERROR);
		}

		override protected function unmapModel():void
		{
			_proxyMap.unmap(_ServiceCls);
		}
	}
}
