/**
 * Created with IntelliJ IDEA.
 * User: Zoulz
 * Date: 2013-06-04
 * Time: 12:50
 * To change this template use File | Settings | File Templates.
 */
package se.pixelshift.common.errors
{
	public class AbstractMethodError extends Error
	{
		public function AbstractMethodError(msg:* = null, id:* = null)
		{
			super(msg, id);
		}
	}
}
