package se.pixelshift.common
{
    import se.pixelshift.common.utils.StringUtil;

    /**
	 * Data object containing version information.

	 * @author tomas.augustinovic
	 */
    public class Version implements IStringify
	{
		//	Version numbers.
		public var major:uint;
		public var minor:uint;
		public var revision:uint;
		public var codename:String;

		/**
		 * @param major
		 * @param minor
		 * @param revision
		 * @param codename
		 */
		public function Version(major:uint = 1, minor:uint = 0, revision:uint = 0, codename:String = "")
		{
			this.major = major;
			this.minor = minor;
			this.revision = revision;
			this.codename = codename;
		}

		/**
		 * Return version as a string representation (excluding the codename).
		 * @return
		 */
		public function toString():String
		{
			if (StringUtil.isEmpty(codename))
			{
				return major + "." + minor + "." + revision;
			}
			else
			{
				return major + "." + minor + "." + revision + "-" + codename.replace(" ", "_");
			}
		}

		/**
		 * Creates a Version object from a string representation.
		 * @param s Representation of version.
		 * @return
		 */
		public static function fromString(s:String, includingCodeName:Boolean = false):Version
		{
			if (StringUtil.isEmpty(s))
				s = "";

			var v:Version = new Version();

			var split:Array = s.split(".");
			if (split.length > 0)
			{
				v.major = parseInt(split[0]);

				if (split.length > 1)
				{
					v.minor = parseInt(split[1]);
				}

				if (split.length > 2 && split[2].indexOf("-") != -1)
				{
					var split2:Array = split[2].split("-");

					if (includingCodeName)
					{
						v.codename = split2[1];
					}

					v.revision = parseInt(split2[0]);
				}
				else if (split.length > 2)
				{
					v.revision = parseInt(split[2]);
				}
			}

			return v;
		}
	}
}
