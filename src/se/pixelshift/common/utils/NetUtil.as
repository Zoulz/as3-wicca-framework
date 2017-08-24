package se.pixelshift.common.utils
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	/**
	 * Utility class for networking related tasks.

	 * @author tomas.augustinovic
	 */
	public final class NetUtil
	{
		/** Opens the linked document in a new window or tab. */
		public static const URL_TARGET_BLANK:String = "_blank";
		
		/** Opens the linked document in the same frame as it was clicked (this is default). */
		public static const URL_TARGET_SELF:String = "_self";
		
		/** Opens the linked document in the parent frame. */
		public static const URL_TARGET_PARENT:String = "_parent";
		
		/** Opens the linked document in the full body of the window. */
		public static const URL_TARGET_TOP:String = "_top";

		/**
		 * Open the supplied URL in a browser window.
		 * @param url URL to open.
		 * @param target URL open target.
		 */
		public static function openURL(url:String, target:String = URL_TARGET_BLANK):void
		{
			navigateToURL(new URLRequest(url), target);
		}
	}
}
