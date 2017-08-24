/**
 * Pixelshift Interactive
 * 2017-01-23
 * ---------------------------------------------------------------------
 * @author tomas.augustinovic
 */
package se.pixelshift.wicca.packages.wicloader.model
{
	import mvcexpress.mvc.Proxy;

	public class WicLoaderModel extends Proxy
	{
		private var _fileNames:Array;
		private var _assemblers:Array;

		override protected function onRemove():void
		{
		}

		override protected function onRegister():void
		{
			_fileNames = [];
			_assemblers = [];
		}

		public function get fileNames():Array
		{
			return _fileNames;
		}

		public function set fileNames(value:Array):void
		{
			_fileNames = value;
		}

		public function get assemblers():Array
		{
			return _assemblers;
		}

		public function set assemblers(value:Array):void
		{
			_assemblers = value;
		}
	}
}
