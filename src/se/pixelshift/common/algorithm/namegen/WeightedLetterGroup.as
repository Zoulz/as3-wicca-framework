/**
 * Pixelshift Interactive
 * 2016-12-06
 * ---------------------------------------------------------------------
 * @author tomas.augustinovic
 */
package se.pixelshift.common.algorithm.namegen
{
	import flash.utils.Dictionary;

	public class WeightedLetterGroup
	{
		public var letters:Dictionary = new Dictionary();
		public var letterSamples:Array = [];

		public function add(letter:String):void
		{
			if (!letters[letter])
				letters[letter] = new WeightedLetterCounter(letter);

			letters[letter].count++;
		}

		public function expandSamples():void
		{
			for each (var letter:WeightedLetterCounter in letters)
			{
				for (var i:int = 0; i < letter.count; i++)
				{
					letterSamples.push(letter.letter);
				}
			}
		}
	}
}
