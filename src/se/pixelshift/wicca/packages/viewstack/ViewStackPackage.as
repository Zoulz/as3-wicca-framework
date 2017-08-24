/**
 * Created by Tomas Augustinovic on 2017-02-06.
 */
package se.pixelshift.wicca.packages.viewstack
{
	import se.pixelshift.wicca.packages.BaseWiccaPackage;
	import se.pixelshift.wicca.packages.IWiccaPackage;
	import se.pixelshift.wicca.packages.viewstack.view.IStackView;
	import se.pixelshift.wicca.packages.viewstack.view.ViewStackMediator;

	public class ViewStackPackage extends BaseWiccaPackage implements IWiccaPackage
	{
		private var _StackView:Class;

		public function ViewStackPackage(StackViewCls:Class)
		{
			_StackView = StackViewCls;
		}

		override public function get name():String
		{
			return "View Stack";
		}

		override public function get description():String
		{
			return "bla bla bla";
		}

		override protected function mapView():void
		{
			_mediatorMap.map(_StackView, ViewStackMediator, IStackView);
		}

		override protected function mapController():void
		{
		}

		override protected function mapModel():void
		{
		}

		override protected function unmapController():void
		{
		}

		override protected function unmapModel():void
		{
		}

		override protected function unmapView():void
		{
			_mediatorMap.unmap(_StackView, ViewStackMediator);
		}
	}
}
