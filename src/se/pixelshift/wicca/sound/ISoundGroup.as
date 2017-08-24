/**
 * Copyright Pixelshift Interactive (c) 2014 All Rights Reserved.
 * 2014-11-02 07:54
 * @author Zoulz
 */
package se.pixelshift.wicca.sound
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	import se.pixelshift.common.IDisposable;

	public interface ISoundGroup extends IDisposable
	{
		function registerSound(id:String, snd:Sound):void;
		function unregisterSound(id:String):void;
		function playSound(id:String, loops:uint = 0, sndTransform:SoundTransform = null, offset:Number = 0):int;
		function getPlayingSound(index:int):SoundChannel;
		function stopSound(index:int):void;
		function stopAllSounds():void;
		function pauseAllSounds():void;
		function resumeAllSounds():void;

		function set isMute(value:Boolean):void;
		function get isMute():Boolean;
	}
}
