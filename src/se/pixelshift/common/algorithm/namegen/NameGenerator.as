/**
 * Pixelshift Interactive
 * 2016-12-06
 * ---------------------------------------------------------------------
 * @author tomas.augustinovic
 */
package se.pixelshift.common.algorithm.namegen
{
	import flash.utils.Dictionary;

	import se.pixelshift.common.utils.StringUtil;

	public class NameGenerator
	{
		public static const LAST_LETTER_CANDIDATES_MAX:int = 5;

		private var _initialized:Boolean = false;

		private var _names:Array;
		private var _sizes:Array;

		private var _letters:Dictionary;
		private var _firstLetterSamples:Array;
		private var _lastLetterSamples:Array;

		public function NameGenerator(names:Array)
		{
			this._names = names;
		}

		public function init():void
		{
			_sizes = [];
			_letters = new Dictionary();
			_firstLetterSamples = [];
			_lastLetterSamples = [];

			for (var i:uint = 0; i < _names.length; i++)
			{
				var name:Array = _names[i].split("");

				// (1) Insert size
				_sizes.push(name.length);

				// (2) Grab first letter
				_firstLetterSamples.push(name[0]);

				// (3) Grab last letter
				_lastLetterSamples.push(name[name.length - 1]);

				// (4) Process all letters
				for (var n:uint = 0; n < name.length -1; n++)
				{
					var letter:String = name[n];
					var nextLetter:String = name[n + 1];

					// Create letter if it doesn't exist
					if (!_letters[letter])
					{
						_letters[letter] = new WeightedLetter(letter);
					}

					_letters[letter].addNextLetter(nextLetter);

					// If letter was uppercase (beginning of name), also add a lowercase entry
					if (letter != letter.toLowerCase())
					{
						letter = letter.toLowerCase();

						// Create letter if it doesn't exist
						if (!_letters[letter])
						{
							_letters[letter] = new WeightedLetter(letter);
						}

						_letters[letter].addNextLetter(nextLetter);
					}
				}
			}


			for each (var weightedLetter:WeightedLetter in _letters)
			{
				// Expand letters into samples
				weightedLetter.nextLetters.expandSamples();
			}

			_initialized = true;
		}

		public function generate(amountToGenerate:uint = 1):Array
		{
			// Initialize if called for the first time
			if (!_initialized) init();

			var result:Array = [];

			for (var nameCount:uint = 0; nameCount < amountToGenerate;)
			{
				var name:Array = [];

				// Pick size
				var size:int = pickRandomElementFromArray(_sizes) as int;

				// Pick first letter
				var firstLetter:String = pickRandomElementFromArray(_firstLetterSamples);

				name.push(firstLetter);

				for (var i:int = 1; i < size - 2; i++)
				{
					// Only continue if the last letter added was non-null
					if (name[i - 1])
					{
						name.push(getRandomNextLetter(name[i - 1]));
					}
					else
					{
						break;
					}
				}

				// Attempt to find a last letter
				for (var lastLetterFits:int = 0; lastLetterFits < LAST_LETTER_CANDIDATES_MAX; lastLetterFits++)
				{
					var lastLetter:String = pickRandomElementFromArray(_lastLetterSamples);
					var intermediateLetterCandidate:String = getIntermediateLetter(name[name.length - 1], lastLetter);

					// Only attach last letter if the candidate is valid (if no candidate, the antepenultimate letter always occurs at the end)
					if (intermediateLetterCandidate)
					{
						name.push(intermediateLetterCandidate);
						name.push(lastLetter);
						break;
					}
				}

				var nameString:String = name.join("");

				// Check that the word has no triple letter sequences, and that the Levenshtein distance is kosher
				if (tripleLetterCheck(name) && checkLevenshtein(nameString))
				{
					result.push(nameString);

					// Only increase the counter if we've successfully added a name
					nameCount++
				}
			}

			return result;
		}

		private function getIntermediateLetter(letterBefore:String, letterAfter:String):String
		{
			if(letterBefore && letterAfter && _letters[letterBefore])
			{
				// First grab all letters that come after the 'letterBefore'
				var letterCandidates:Dictionary = _letters[letterBefore].nextLetters.letters;

				var bestFitLetter:String = null;
				var bestFitScore:uint = 0;

				// Step through candidates, and return best scoring letter
				for (var letter:String in letterCandidates)
				{
					var letterInNextLetters:WeightedLetter = _letters[letter];

					if (letterInNextLetters)
					{
						var weightedLetterGroup:WeightedLetterGroup = letterInNextLetters.nextLetters;
						var letterCounter:WeightedLetterCounter = weightedLetterGroup.letters[letterAfter];

						if (letterCounter)
						{
							if (letterCounter.count > bestFitScore)
							{
								bestFitLetter = letter;
								bestFitScore = letterCounter.count;
							}
						}
					}
				}

				return bestFitLetter;
			}
			else
			{
				// If any of the passed parameters were null, return null. This happens when the letterBefore has no candidates.
				return null;
			}
		}

		private function tripleLetterCheck(name:Array):Boolean
		{
			for (var i:uint = 2; i < name.length; i++)
			{
				if (name[i] == name[i - 1] && name[i] == name[i - 2])
				{
					return false;
				}
			}

			return true;
		}

		private function checkLevenshtein(name:String):Boolean
		{
			var levenshteinBias:uint = uint(name.length / 2);

			// Grab the closest matches, just for fun
			var closestName:String = "";
			var closestDistance:uint = uint.MAX_VALUE;

			for (var i:uint = 0; i < _names.length; i++)
			{
				var levenshteinDistance:uint = StringUtil.damerau(name, _names[i]);

				// This is just to get an idea of what is failing
				if (levenshteinDistance < closestDistance)
				{
					closestDistance = levenshteinDistance;
					closestName = _names[i];
				}

				if (levenshteinDistance <= levenshteinBias)
				{
					return true;
				}
			}

			return false;
		}

		private function pickRandomElementFromArray(array:Array):*
		{
			return array[Math.round(Math.random() * (array.length - 1))];
		}

		private function getRandomNextLetter(letter:String):String
		{
			var weightedLetter:WeightedLetter = _letters[letter];

			if (weightedLetter)
			{
				return pickRandomElementFromArray(weightedLetter.nextLetters.letterSamples) as String;
			}
			else
			{
				return null;
			}
		}
	}
}
