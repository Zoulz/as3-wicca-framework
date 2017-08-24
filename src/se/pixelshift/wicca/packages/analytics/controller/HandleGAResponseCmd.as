/**
 * Pixelshift Interactive
 * 2016-08-20
 * ---------------------------------------------------------------------
 * @author tomas.augustinovic
 */
package se.pixelshift.wicca.packages.analytics.controller
{
	import mvcexpress.mvc.Command;

	import se.pixelshift.wicca.packages.analytics.service.AnalyticsRequest;
	import se.pixelshift.wicca.packages.analytics.service.AnalyticsService;
	import se.pixelshift.wicca.packages.analytics.service.IAnalyticsService;

	public class HandleGAResponseCmd extends Command
	{
		[Inject] public var analyticsService:IAnalyticsService;

		public function execute(params:Object):void
		{
			if (analyticsService.isEnabled == false && String(params.response.enabled).toLowerCase() == "true")
			{
				var d:Date = new Date();
				analyticsService.isEnabled = true;
				analyticsService.startTs = parseFloat(params.response.server_ts);
				analyticsService.offsetTs = Math.round(d.time / 1000) - parseFloat(params.response.server_ts);
				if (analyticsService.offsetTs < 10)
					analyticsService.offsetTs = 0;

				analyticsService.call(AnalyticsRequest.EVENT, AnalyticsRequest.createUserEvent(analyticsService));
			}
		}
	}
}
