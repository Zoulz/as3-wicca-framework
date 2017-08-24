/**
 * Created by Tomas Augustinovic on 2017-02-07.
 */
package se.pixelshift.wicca.packages.settings
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	import mvcexpress.mvc.Proxy;

	public class SettingsModel extends Proxy implements ISettingsModel
	{
		private var _name:String;
		private var _settings:Object;

		public function SettingsModel(gameName:String)
		{
			_name = gameName;
		}

		override protected function onRemove():void
		{
			save();
		}

		override protected function onRegister():void
		{
			_settings = { };
			if (!load())
			{
				save();
			}
		}

		public function set(key:String, value:*):void
		{
			_settings[key] = value;
		}

		public function get(key:String):*
		{
			return _settings[key];
		}

		public function kill(key:String):void
		{
			delete _settings[key];
		}

		public function load():Boolean
		{
			var file:File = new File(File.documentsDirectory.nativePath + File.separator + _name + File.separator + "settings.json");
			if (file.exists)
			{
				var s:FileStream = new FileStream();
				s.open(file, FileMode.READ);
				_settings = JSON.parse(s.readUTFBytes(s.bytesAvailable));
				s.close();

				return true;
			}

			return false;
		}

		public function save():void
		{
			var file:File = new File(File.documentsDirectory.nativePath + File.separator + _name + File.separator + "settings.json");
			var s:FileStream = new FileStream();
			s.open(file, FileMode.WRITE);
			s.writeUTFBytes(JSON.stringify(_settings));
			s.close();
		}
	}
}
