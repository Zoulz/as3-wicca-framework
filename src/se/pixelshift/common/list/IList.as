package se.pixelshift.common.list
{
	import org.osflash.signals.ISignal;

	/**
	 * Describes a list, which is a utility to help execute a chain of commands.
	 * 
	 * <pre>
	 * -----------------------------------------------------------------------------------------------------------------------------------------
	 * 
	 * Copyright (c) Tomas Augustinovic 2012-2013
	 *
	 * Licence Agreement (The MIT License)
	 *
	 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files
	 * (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge,
	 * publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do
	 * so, subject to the following conditions:
	 *
	 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
	 *
	 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
	 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
	 * FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
	 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
	 * 
	 * -----------------------------------------------------------------------------------------------------------------------------------------
	 * </pre>
	 * 
	 * @author tomas.augustinovic
	 */
	public interface IList
	{
		/**
		 * Add a list item.
		 * @param item Item to add
		 */
		function addItem(item:IListItem):void;
		/**
		 * Remove a item from list.
		 * @param item Item to remove
		 */
		function removeItem(item:IListItem):void;
		/**
		 * Clear all items from list.
		 */
		function clear():void;
		/**
		 * Start executing the items in the list.
		 */
		function run():void;
		/**
		 * Stop the list execution.
		 */
		function stop():void;
		/**
		 * Signal that is dispatched when the list have completed running.
		 */
		function get complete():ISignal;
		/**
		 * Signal dispatched if the list execution is aborted.
		 */
		function get aborted():ISignal;
		/**
		 * Signal that is dispatched when an item in the list is allComplete.
		 */
		function get itemComplete():ISignal;
		/**
		 * Returns true if the list is currently running.
		 */
		function get isRunning():Boolean;
		/**
		 * Return number of items in the list.
		 * @return
		 */
		function get itemCount():uint;
	}
}
