/**
 * Created with IntelliJ IDEA.
 * User: CureLightWounds
 * Date: 2014-02-05
 * Time: 02:44
 * To change this template use File | Settings | File Templates.
 */
package se.pixelshift.common.list.items.mvcexpress
{
    import se.pixelshift.common.list.IListItem;

    public class SendMessageItem implements IListItem
	{
		private var _type:String;
		private var _params:Object;
		private var _msgFunc:Function;

		public function SendMessageItem(sendMsgFunc:Function, type:String, params:Object = null)
		{
			_type = type;
			_params = params;
			_msgFunc = sendMsgFunc;
		}

		public function execute(callback:Function):void
		{
			_msgFunc(_type, _params);

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
