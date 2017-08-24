package se.pixelshift.common.utils
{
	/**
	 * Collection of string utility functions.
	 * 
	 * @author tomas.augustinovic
	 */
	public final class StringUtil
	{
		private static const EMPTY:String = "";

		/**
		 * Converts a number of bytes into a formatted string.
		 * @param bytes
		 * @return
		 */
		public static function bytesToString(bytes:Number):String
		{
			var levels:Array = [ "bytes", "Kb", "MB", "GB", "TB", "PB", "EB", "ZB", "YB" ];
			var index:uint = Math.floor(Math.log(bytes) / Math.log(1024));

			return (bytes / Math.pow(1024, index)).toFixed(2) + levels[index];
		}

		public static function operatorString(num:int):String
		{
			if (num > 0)
				return "+" + num.toString();
			else if (num < 0)
				return num.toString();

			return "0";
		}

		/**
		 * Resolves the parameter placeholders {0} etc inside the given string.
		 * @param s The parameterized string.
		 * @param params Array of parameters to replace the placeholders with.
		 * @return String
		 */
		public static function resolveParameterizedString(s:String, ...params):String
		{
			if (isEmpty(s))
			{
				return EMPTY;
			}

			if (s != null && params.length > 0)
			{
				var len:uint = params.length;
				for (var i:int = 0; i < len; ++i)
				{
					var r:RegExp = new RegExp("\\{" + i + "\\}", "gi");
					s = s.replace(r, params[i]);
				}
			}
			
			return s;
		}
		
		/**
		 * Convert string to boolean.
		 * @param s string to convert.
		 * @return Boolean
		 */
		public static function toBoolean(s:String):Boolean
		{
			if (isEmpty(s))
			{
				return false;
			}

			return s.toLowerCase() === "true";
		}
		
		/**
		 * Pads a string with the specified character or substring.
		 * 
		 * @param s The string to pad.
		 * @param char The character or string to pad with.
		 * @param len How many times to pad the string.
		 * @return
		 */
		public static function padBeforeString(s:String, len:int, char:String = " "):String
		{
			if (isEmpty(s))
			{
				s = EMPTY;
			}

			if(len > 0)
			{
				for(var i:int = 0; i < len; i++)
				{
					 s = char + s;
				}
			}

			return s;
		}
		
		/**
		 * Pads a string with the specified character or substring.
		 * 
		 * @param s The string to pad.
		 * @param char The character or string to pad with.
		 * @param len How many times to pad the string.
		 * @return
		 */
		public static function padAfterString(s:String, len:int, char:String = " "):String
		{
			if (isEmpty(s))
			{
				s = EMPTY;
			}

			if(len > 0)
			{
				for(var i:int = 0; i < len; i++)
				{
					 s += char;
				}
			}

			return s;
		}
		
		/**
		 * Extracts the actual class name out of a full class name e.g. com.warden.utils::TextUtils.
		 * @param s Full class name string.
		 * @return String
		 */
		public static function extractClassName(s:String):String
		{
			if (s.indexOf("::") != -1)
				return afterLast(s, "::");
			else
				return s;
		}
		
		/**
		 * Checks if the supplied string is a valid e-mail address.
		 */
		public static function isValidEmail(emailAddress:String):Boolean
		{
			if (isEmpty(emailAddress))
			{
				return false;
			}

			var reg:RegExp = /^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)+)@(([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)){2,}\.([A-Za-z]){2,4}+$/g;
			return reg.test(emailAddress);
		}
		
		/**
		 * Determines if the supplied string is a valid URL.
		 * 
		 * @param url Url to check.
		 * @return Boolean
		 */
		public static function isValidURL(url:String):Boolean
		{
			if (isEmpty(url))
			{
				return false;
			}

			var regexp:RegExp = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;
			return regexp.test(url);
		}
		
		/**
		 * Return true is the supplied string is empty.
		 * 
		 * @param s String to check.
		 * @return Boolean
		 */
		public static function isEmpty(s:String):Boolean
		{
			if (s != null && s.length > 0)
			{
				return false;
			}
			
			return true;
		}
		
		/**
		 * Check if the string is composed of alpha numeric characters.
		 * 
		 * @param s String to check.
		 * @return Boolean
		 */
		public static function isAlphaNumeric(s:String):Boolean
		{
			if (isEmpty(s))
			{
				return false;
			}

			var reg:RegExp = new RegExp(/[^a-zA-Z 0-9]+/g);
			return !reg.test(s);
		}

		public static function trimAlphaNumeric(s:String):String
		{
			if (isEmpty(s))
			{
				return EMPTY;
			}

			var reg:RegExp = new RegExp(/[^a-zA-Z 0-9]+/g);
			return s.replace(reg, "");
		}
		
		/**
		 * Returns everything after the first occurrence of the provided character in the string.
		 * @param s String to process.
		 * @param find String to use while searching.
		 * @return String
		 */
		public static function afterFirst(s:String, find:String):String
		{
			if (s == null)
			{
				return "";
			}
			
			var idx:int = s.indexOf(find);
			if (idx == -1)
			{
				return "";
			}
			
			idx += find.length;
			
			return s.substr(idx);
		}
		
		/**
		 * Returns everything after the last occurence of the provided character in string.
		 * @param s String to process.
		 * @param find String to use while searching.
		 * @return String
		 */
		public static function afterLast(s:String, find:String):String
		{
			if (s == null)
			{
				return "";
			}
			
			var idx:int = s.lastIndexOf(find);
			
			if (idx == -1)
			{
				return "";
			}
			
			idx += find.length;
			
			return s.substr(idx);
		}
		
		/**
		 * Returns everything before the first occurrence of the provided character in the string.
		 * @param s String to process.
		 * @param find String to use while searching.
		 * @return String
		 */
		public static function beforeFirst(s:String, find:String):String
		{
			if (s == null)
			{
				return "";
			}
			
			var idx:int = s.indexOf(find);
			
        	if (idx == -1)
			{
				return "";
			}
			
        	return s.substr(0, idx);
		}
		
		/**
		 * Returns everything before the last occurrence of the provided character in the string.
		 * @param s String to process.
		 * @param find String to use while searching.
		 * @return String
		 */
		public static function beforeLast(s:String, find:String):String
		{
			if (s == null)
			{
				return "";
			}
			
			var idx:int = s.lastIndexOf(find);
			
        	if (idx == -1)
			{
				return "";
			}
			
        	return s.substr(0, idx);
		}
		
		/**
		 * Determines whether the specified string begins with the specified prefix.
		 * @param s String to analyse.
		 * @param begin String to search for.
		 * @return True if the supplied string begins with the search string.
		 */
		public static function beginsWith(s:String, begin:String):Boolean
		{
			if (isEmpty(s))
			{
				return false;
			}
			
			return s.indexOf(begin) == 0;
		}
		
		/**
		 * Returns everything after the first occurance of start and before
		 * the first occurrence of end in the string.
		 * @param s String to analyse.
		 * @param start Start string to use.
		 * @param end End string to use.
		 * @return String
		 */
		public static function between(s:String, start:String, end:String):String
		{
			var str:String = "";

			if (isEmpty(s))
			{
				return EMPTY;
			}
			
			var startIdx:int = s.indexOf(start);
			
			if (startIdx != -1)
			{
				startIdx += start.length; // RM: should we support multiple chars? (or ++startIdx);
				var endIdx:int = s.indexOf(end, startIdx);
				if (endIdx != -1)
				{
					str = s.substr(startIdx, endIdx - startIdx);
				}
			}
			
			return str;
		}
		
		/**
		 * Capitallizes the first word in a string or all words.
		 * @param s String to capitalize.
		 * @param allWords True if all words in the string should be capitalized.
		 * @return String
		 */
		public static function capitalize(s:String):String
		{
			if (isEmpty(s))
			{
				return EMPTY;
			}
			return s.charAt(0).toUpperCase() + s.substring(1);
		}
		
		/**
		 * Determines whether the specified string contains any instances of find parameter.
		 * 
		 * @param s String to check.
		 * @param find The string to look for.
		 * @return Boolean
		 */
		public static function contains(s:String, find:String):Boolean
		{
			if (isEmpty(s))
			{
				return false;
			}
			
			return s.indexOf(find) != -1;
		}
		
		/**
		 * Determines the number of times a character or sub-string appears within the string.
		 * @param s String to analyse.
		 * @param find Substring to find.
		 * @param caseSensitive True if the search should be case-sensitive.
		 * @return Number of times the substring was found.
		 */
		public static function countOf(s:String, find:String, caseSensitive:Boolean = true):uint
		{
			if (isEmpty(s))
			{
				return 0;
			}
			
			var char:String = escapePatternInternal(find);
			var flags:String = (!caseSensitive) ? 'ig' : 'g';
			
			return s.match(new RegExp(char, flags)).length;
		}
		
		/**
		 * Returns a string truncated to a specified length with optional suffix.
		 */
		public static function truncate(s:String, len:uint, suffix:String = "..."):String
		{
			if (isEmpty(s))
			{
				return EMPTY;
			}
			
			//len -= suffix.length;
			var trunc:String = s;
			
			if (trunc.length > len)
			{
				trunc = trunc.substr(0, len);
				
				if (/[^\s]/.test(s.charAt(len)))
				{
					trunc = trimRight(trunc.replace(/\w+$|\s+$/, ''));
				}
				trunc += suffix;
			}

			return trunc;
		}
		
		/**
		 * Determins the number of words in a string.
		 */
		public static function wordCount(s:String):uint
		{
			if (isEmpty(s))
			{
				return 0;
			}
			
			return s.match(/\b\w+\b/g).length;
		}
		
		/**
		 * Removes whitespace from the front (left-side) of the specified string.
		 */
		public static function trimLeft(s:String):String
		{
			if (isEmpty(s))
			{
				return EMPTY;
			}
			
			return s.replace(/^\s+/, '');
		}
		
		/**
		 * Removes whitespace from the end (right-side) of the specified string.
		 */
		public static function trimRight(s:String):String
		{
			if (isEmpty(s))
			{
				return EMPTY;
			}
			
			return s.replace(/\s+$/, '');
		}
		
		/**
		 * Removes whitespace from the front and the end of the specified
		 * string.
		 */
		public static function trim(s:String):String
		{
			if (isEmpty(s))
			{
				return EMPTY;
			}
			
			return s.replace(/^\s+|\s+$/g, '');
		}
		
		/**
		 * Swaps the casing of a string.
		 */
		public static function swapCase(s:String):String
		{
			if (isEmpty(s))
			{
				return EMPTY;
			}
			
			var len:uint = s.length;
			var ret:String = "";
			for (var i:uint = 0; i < len; i++)
			{
				ret += swapCaseInternal(s.substr(i, 1));
			}
			
			return ret;
		}
		
		/**
		 * Remove's all mark-language based tags from a string.
		 */
		public static function stripTags(s:String):String
		{
			if (isEmpty(s))
			{
				return EMPTY;
			}
			
			return s.replace(/<\/?[^>]+>/igm, '');
		}

		public static function damerau(word1:String, word2:String):uint
		{
			var levenshteinMatrix:Array = [];

			// Split to arrays for faster access
			var word1Array:Array = word1.split("");
			var word2Array:Array = word2.split("");

			// Initialize sizes
			var word1Length:uint = word1Array.length;
			var word2Length:uint = word2Array.length;

			// Generate 2D array
			for (var i:uint = 0; i <= word1Length; i++)
			{
				levenshteinMatrix.push(new Array(word2Length+1));
			}

			// Initial values for word1
			for (var i_m:uint = 0; i_m <= word1Length; i_m++)
			{
				levenshteinMatrix[i_m][0] = i_m;
			}

			// Initial values for word2
			for (var i_n:uint = 0; i_n <= word2Length; i_n++)
			{
				levenshteinMatrix[0][i_n] = i_n;
			}

			for (i_m = 1; i_m <= word1Length; i_m++)
			{
				for (i_n = 1; i_n <= word2Length; i_n++)
				{
					var cost:uint = 1;

					// The same, zero cost
					if (word1Array[i_m-1] == word2Array[i_n-1])
					{
						cost = 0;
					}

					levenshteinMatrix[i_m][i_n] = Math.min
					(
							levenshteinMatrix[i_m-1][i_n] + 1, // Deletion
							levenshteinMatrix[i_m][i_n-1] + 1, // Insertion
							levenshteinMatrix[i_m-1][i_n-1] + cost // Removal
					);

					// Test for transposition
					if (i_m > 1 && i_n > 1 && word1Array[i_m - 1] == word2Array[i_n - 2] && word1Array[i_m - 2] == word2Array[i_n - 1])
					{
						levenshteinMatrix[i_m][i_n] = Math.min
						(
								levenshteinMatrix[i_m][i_n],
								levenshteinMatrix[i_m-2][i_n-2] + cost // Transposition
						);
					}
				}
			}

			// Return the shortest path, defined by levenshteinMatrix[word1Length][word2Length];
			return levenshteinMatrix[word1Length][word2Length];
		}
		
		private static function escapePatternInternal(pattern:String):String
		{
			// RM: might expose this one, I've used it a few times already.
			return pattern.replace(/(\]|\[|\{|\}|\(|\)|\*|\+|\?|\.|\\)/g, '\\$1');
		}
		
		private static function swapCaseInternal(char:String):String
		{
			var lowChar:String = char.toLowerCase();
			var upChar:String = char.toUpperCase();
			
			switch (char)
			{
				case lowChar:
				{
					return upChar;
				}
				case upChar:
				{
					return lowChar;
				}
				default:
				{
					return char;
				}
			}
		}
	}
}
