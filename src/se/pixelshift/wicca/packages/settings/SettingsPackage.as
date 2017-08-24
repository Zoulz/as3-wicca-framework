/**
 * Created by Tomas Augustinovic on 2017-02-07.
 */
package se.pixelshift.wicca.packages.settings
{
	import se.pixelshift.wicca.packages.BaseWiccaPackage;
	import se.pixelshift.wicca.packages.IWiccaPackage;

	public class SettingsPackage extends BaseWiccaPackage implements IWiccaPackage
	{
		private var _name:String;

		public function SettingsPackage(gameName:String)
		{
			_name = gameName;
		}

		override public function get name():String
		{
			return "Settings";
		}

		override protected function mapController():void
		{
		}

		override protected function unmapController():void
		{
		}

		override protected function mapModel():void
		{
			_proxyMap.map(new SettingsModel(_name), null, null, ISettingsModel);
		}

		override protected function unmapModel():void
		{
			_proxyMap.unmap(SettingsModel);
		}
	}
}
