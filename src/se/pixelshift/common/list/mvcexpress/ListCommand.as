/**
 * Created by Tomas Augustinovic on 2017-04-11.
 */
package se.pixelshift.common.list.mvcexpress
{
	import mvcexpress.mvc.PooledCommand;

	import se.pixelshift.common.list.IList;

	/**
	 * @example
	 * commandMap.execute(ListCommand, new List());
	 */
	public class ListCommand extends PooledCommand
	{
		public function execute(params:Object):void
		{
			lock();

			if (params is IList)
			{
				var list:IList = params as IList;
				list.complete.addOnce( onListComplete );
				list.run();
			}
			else
			{
				throw new Error("Must supply a list.");
			}
		}

		private function onListComplete():void
		{
			unlock();
		}
	}
}
