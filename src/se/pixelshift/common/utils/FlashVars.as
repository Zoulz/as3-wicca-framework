package se.pixelshift.common.utils
{
	import flash.display.Stage;

	/**
	 * Object that manages flashvars.
	 */
	public class FlashVars
	{
		private var _stage:Stage;

		/**
		 * @param stage Stage instance.
		 */
		public function FlashVars(stage:Stage)
		{
			_stage = stage;
		}

		/**
		 * Return a flashvar or if not available, a default value.
		 * @param name Name of the flashvar.
		 * @param defaultValue Value to use if the flashvar is not available.
		 * @return
		 */
		public function getValue(name:String, defaultValue:* = null):*
		{
			if (_stage == null)
			{
				throw new Error("Cannot retrieve flashvar with a null reference to the stage!");
			}

			var value:String = _stage.loaderInfo.parameters[name];

			return (value == null) ? defaultValue : value;
		}
	}
}
