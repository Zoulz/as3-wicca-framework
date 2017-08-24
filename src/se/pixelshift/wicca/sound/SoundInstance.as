/**
 * Copyright Pixelshift Interactive (c) 2014 All Rights Reserved.
 * 2014-11-02 07:48
 * @author Zoulz
 */
package se.pixelshift.wicca.sound
{
	import flash.media.Sound;
	import flash.media.SoundTransform;

	public class SoundInstance
	{
		public var snd:Sound = null;
		public var loops:int = 0;
		public var offset:Number = 0;
		public var sndTransform:SoundTransform = null;

		public function SoundInstance(snd:Sound, loops:int = 0, offset:Number = 0, sndTransform:SoundTransform = null)
		{
			this.snd = snd;
			this.loops = loops;
			this.offset = offset;
			this.sndTransform = sndTransform;
		}
	}
}
