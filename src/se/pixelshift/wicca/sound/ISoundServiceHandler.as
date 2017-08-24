/**
 * Copyright Pixelshift Interactive (c) 2014 All Rights Reserved.
 * 2014-11-02 19:07
 * @author Zoulz
 */
package se.pixelshift.wicca.sound
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	import org.osflash.signals.ISignal;

	public interface ISoundServiceHandler
	{
		/**
		 * Plays the supplied sound and returns the channel index that it uses.
		 * @param snd
		 * @param offset
		 * @param loops
		 * @param transform
		 * @return
		 */
		function playSound(snd:Sound, offset:Number = 0, loops:uint = 0, transform:SoundTransform = null):int;

		/**
		 * Stop a playing sound on the supplied channel index.
		 * @param channelIndex
		 */
		function stopSound(channelIndex:int):void;

		function pauseSound(channelIndex:int):void;

		function resumeSound(channelIndex:int):void;

		/**
		 * Signals when a sound has completed playing. Channel index as parameter.
		 */
		function get soundComplete():ISignal;

		function get channels():Vector.<SoundChannel>;
	}
}
