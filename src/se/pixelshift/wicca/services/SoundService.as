/**
 * Copyright Pixelshift Interactive (c) 2014 All Rights Reserved.
 * 2014-11-02 03:06
 * @author Zoulz
 */
package se.pixelshift.wicca.services
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import se.pixelshift.wicca.sound.*;

	public final class SoundService implements ISoundService, ISoundServiceHandler
	{
		private const MAX_CHANNELS:uint = 32;

		private var _channels:Vector.<SoundChannel>;
		private var _pausedSounds:Vector.<Object>;
		private var _groups:Vector.<ISoundGroup>;
		private var _soundComplete:Signal = new Signal();

		private static var _instance:ISoundService;

		public function SoundService()
		{
			_channels = new Vector.<SoundChannel>(MAX_CHANNELS, true);
			_groups = new <ISoundGroup>[];
			_pausedSounds = new <Object>[];
		}

		public function dispose():void
		{
			var len:int = _channels.length;
			for (var i:int = 0; i < len; i++)
			{
				if (_channels[i] != null)
				{
					_channels[i].stop();
					_channels[i] = null;
				}
			}

			len = _groups.length;
			for (i = 0; i < len; i++)
			{
				_groups[i].dispose();
			}
			_groups.length = 0;
		}

		public static function get instance():ISoundService
		{
			if (_instance == null)
			{
				_instance = new SoundService();
			}

			return _instance;
		}

		public function registerGroup(grp:ISoundGroup):void
		{
			if (_groups.indexOf(grp) == -1)
			{
				_groups.push(grp);
			}
		}

		public function unregisterGroup(grp:ISoundGroup):void
		{
			var idx:int = _groups.indexOf(grp);
			if (idx != -1)
			{
				grp.dispose();
				_groups.splice(idx, 1);
			}
		}

		public function stopAllSounds():void
		{

		}

		public function pauseAllSounds():void
		{

		}

		public function resumeAllSounds():void
		{

		}

		public function playSound(snd:Sound, offset:Number = 0, loops:uint = 0, transform:SoundTransform = null):int
		{
			var idx:int = getFreeChannelIndex();
			if (idx != -1)
			{
				var channel:SoundChannel = snd.play(offset, loops, transform);
				if (channel != null)
				{
					channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
					_channels[idx] = channel;
				}
				else
				{
					idx = -1;
				}
			}

			return idx;
		}

		public function stopSound(channelIndex:int):void
		{
			_channels[channelIndex].removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			_channels[channelIndex].stop();
			_channels[channelIndex] = null;
		}

		public function pauseSound(channelIndex:int):void
		{
			var pausedSound:Object = {
				pos: _channels[channelIndex].position
			};

			_pausedSounds.push(pausedSound);

			stopSound(channelIndex);
		}

		public function resumeSound(channelIndex:int):void
		{
		}

		private function onSoundComplete(event:Event):void
		{
			var channel:SoundChannel = event.currentTarget as SoundChannel;
			var idx:int = _channels.indexOf(channel);

			stopSound(idx);

			_soundComplete.dispatch(idx);
		}

		private function getFreeChannelIndex():int
		{
			return _channels.indexOf(null);
		}

		public function get soundComplete():ISignal
		{
			return _soundComplete;
		}

		public function get channels():Vector.<SoundChannel>
		{
			return _channels;
		}
	}
}
