/**
 * Pixelshift Interactive
 * 2016-08-20
 * ---------------------------------------------------------------------
 * @author tomas.augustinovic
 */
package se.pixelshift.wicca.packages.analytics.controller
{
	import mvcexpress.mvc.Command;

	public class HandleGAErrorCmd extends Command
	{
		public function execute(params:Object):void
		{
			trace(params.id + " - " + params.text);
		}
	}
}
