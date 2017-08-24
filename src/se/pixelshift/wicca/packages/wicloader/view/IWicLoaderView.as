/**
 * Created by Tomas Augustinovic on 2017-02-07.
 */
package se.pixelshift.wicca.packages.wicloader.view
{
	public interface IWicLoaderView
	{
		function loadingComplete():void;
		function fileCompleteLoading():void;
		function fileError(msg:String):void;
		function updateProgress(bytesLoaded:int, bytesTotal:int):void;
		function fileStartLoading():void;
	}
}
