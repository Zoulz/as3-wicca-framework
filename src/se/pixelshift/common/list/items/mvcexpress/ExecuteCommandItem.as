/**
 * Copyright Pixelshift Interactive (c) 2014 All Right Reserved.
 * @author Zoulz
 */
package se.pixelshift.common.list.items.mvcexpress
{
	import mvcexpress.core.CommandMap;

    import se.pixelshift.common.list.IListItem;

    public class ExecuteCommandItem implements IListItem
	{
		private var _cmdMap:CommandMap;
		private var _cmd:Class;
		private var _params:Object;

		public function ExecuteCommandItem(cmdMap:CommandMap, cmd:Class, params:Object = null)
		{
			_cmdMap = cmdMap;
			_cmd = cmd;
			_params = params;
		}

		public function execute(callback:Function):void
		{
			_cmdMap.execute(_cmd, _params);

			callback(this);
		}

		public function abort():void
		{
			//	NO-OP
		}

		public function dispose():void
		{
			//	NO-OP
		}
	}
}
