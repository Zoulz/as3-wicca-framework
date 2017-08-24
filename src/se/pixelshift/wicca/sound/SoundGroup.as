/**
 * Copyright Pixelshift Interactive (c) 2014 All Rights Reserved.
 * 2014-11-01 14:14
 * @author Zoulz
 */
package se.pixelshift.wicca.sound
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;

	import se.pixelshift.common.structs.KeyValuePair;
	import se.pixelshift.wicca.services.SoundService;

	public class SoundGroup implements ISoundGroup
	{
		private var _isMute:Boolean = false;

		private var _snds:Dictionary;
		private var _playingSounds:Dictionary;

		public function SoundGroup(snds:Vector.<KeyValuePair> = null)
		{
			_playingSounds = new Dictionary();

			//	Setup sound definitions.
			_snds = new Dictionary();
			for each (var snd:KeyValuePair in snds)
			{
				_snds[snd.key] = snd.value;
			}

			ISoundServiceHandler(SoundService.instance).soundComplete.add(onSoundComplete);
		}

		public function dispose():void
		{
			stopAllSounds();

			ISoundServiceHandler(SoundService.instance).soundComplete.remove(onSoundComplete);

			for (var key:String in _snds)
			{
				//_snds[key].close();
				_snds[key] = null;
				delete _snds[key];
			}
		}

		private function onSoundComplete(channelIndex:int):void
		{
			if (_playingSounds[channelIndex] != null)
			{
				_playingSounds[channelIndex] = null;
				delete _playingSounds[channelIndex];
			}
		}

		public function registerSound(id:String, snd:Sound):void
		{
			_snds[id] = snd;
		}

		public function unregisterSound(id:String):void
		{
			_snds[id] = null;
			delete _snds[id];
		}

		public function playSound(id:String, loops:uint = 0, sndTransform:SoundTransform = null, offset:Number = 0):int
		{
			var snd:Sound = _snds[id];
			if (snd != null)
			{
				var playingSnd:SoundInstance = new SoundInstance(snd, loops, offset, sndTransform);
				var idx:int = ISoundServiceHandler(SoundService.instance).playSound(snd, offset, loops, sndTransform);
				_playingSounds[idx] = playingSnd;
				return idx;
			}

			return -1;
		}

		public function getPlayingSound(index:int):SoundChannel
		{
			if (_playingSounds[index] != null)
			{
				return ISoundServiceHandler(SoundService.instance).channels[index];
			}

			return null;
		}

		public function stopSound(index:int):void
		{
			if (_playingSounds[index] != null)
			{
				ISoundServiceHandler(SoundService.instance).stopSound(index);
			}
		}

		public function stopAllSounds():void
		{
			for (var index:Object in _playingSounds)
			{
				stopSound(index as Number);
			}
		}

		public function pauseAllSounds():void
		{
		}

		public function resumeAllSounds():void
		{
		}

		public function set isMute(value:Boolean):void
		{
			_isMute = value;

			if (_isMute)
			{
				pauseAllSounds();
			}
			else
			{
				resumeAllSounds();
			}
		}

		public function get isMute():Boolean
		{
			return _isMute;
		}
	}
}
