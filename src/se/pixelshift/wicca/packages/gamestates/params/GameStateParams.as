/**
 * Created by black on 2016-01-13.
 */
package se.pixelshift.wicca.packages.gamestates.params
{
	public class GameStateParams
	{
		public var id:String;
		public var wipe:Boolean;

		public function GameStateParams(id:String, wipe:Boolean = false)
		{
			this.id = id;
			this.wipe = wipe;
		}
	}
}
