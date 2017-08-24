package se.pixelshift.common
{
	/**
	 * Interface adds disposable functionality for objects that need some kind of clean up implementation.
	 * 
	 * @author tomas.augustinovic
	 */
	public interface IDisposable
	{
		/**
		 * Implements behavior that is executed when the object is no longer in use.
		 */
		function dispose():void;
	}
}
