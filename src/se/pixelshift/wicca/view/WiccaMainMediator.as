/**
 * Created by Zoulz on 2014-09-06.
 */
package se.pixelshift.wicca.view
{
	import mvcexpress.mvc.Mediator;

	public class WiccaMainMediator extends Mediator
	{
		[Inject] public var view:IWiccaMainView;

		override protected function onRemove():void
		{
		}

		override protected function onRegister():void
		{
		}
	}
}
