/**
 * Pixelshift Interactive
 * 2016-08-19
 * ---------------------------------------------------------------------
 * @author tomas.augustinovic
 */
package se.pixelshift.wicca.packages.analytics.service
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	import se.pixelshift.wicca.packages.analytics.service.*;

	public class AnalyticsServiceAir extends AnalyticsService implements IAnalyticsService
	{
		private var _trackFile:File;

		override protected function onRemove():void
		{
			super.onRemove();

			var trackFS:FileStream = new FileStream();
			trackFS.open(_trackFile, FileMode.WRITE);
			trackFS.writeInt(_sessionNum);
			trackFS.writeInt(_transactionNum);
			trackFS.close();
		}

		override protected function onRegister():void
		{
			super.onRegister();

			_trackFile = File.applicationStorageDirectory.resolvePath("trackFile");
			if (_trackFile.exists)
			{
				var trackFS:FileStream = new FileStream();
				trackFS.open(_trackFile, FileMode.READ);
				_sessionNum = trackFS.readInt();
				_transactionNum = trackFS.readInt();
				trackFS.close();
			}
		}

		override public function get osUserName():String
		{
			var userDir:String = File.userDirectory.nativePath;
			return userDir.substr(userDir.lastIndexOf(File.separator) + 1);;
		}
	}
}
