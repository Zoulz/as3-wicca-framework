/**
 * Created by black on 2016-01-13.
 */
package se.pixelshift.wicca.packages.rpchelper.params
{
	public class RpcCallParams
	{
		public var method:String = "";
		public var params:Array = [ ];
		public var isNotification:Boolean = false;

		public function RpcCallParams(method:String, params:Array = null, isNotification:Boolean = false)
		{
			this.method = method;
			this.params = params;
			this.isNotification = isNotification;
		}
	}
}
