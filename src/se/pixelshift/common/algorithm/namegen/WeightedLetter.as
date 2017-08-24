/**
 * Pixelshift Interactive
 * 2016-12-06
 * ---------------------------------------------------------------------
 * @author tomas.augustinovic
 */
package se.pixelshift.common.algorithm.namegen
{
	public class WeightedLetter
	{
		public var letter:String;
		public var nextLetters:WeightedLetterGroup = new WeightedLetterGroup();

		public function WeightedLetter(letter:String)
		{
			this.letter = letter;
		}

		public function addNextLetter(letter:String):void
		{
			nextLetters.add(letter);
		}
	}
}
