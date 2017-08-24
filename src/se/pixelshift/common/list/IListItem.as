package se.pixelshift.common.list
{
    import se.pixelshift.common.IDisposable;

    /**
	 * Describes an item inside a list. Command pattern with the ability to abort the execution.
	 * 
	 * @author tomas.augustinovic
	 */
	public interface IListItem extends IDisposable
	{
		/**
		 * Execute the functionality of this list item.
		 * @param callback Callback function for when the item is allComplete.
		 */
		function execute(callback:Function):void;
		/**
		 * Abort running item functionality.
		 */
		function abort():void;
	}
}
